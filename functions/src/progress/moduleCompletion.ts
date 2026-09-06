import {
  FieldValue,
  Firestore,
} from "firebase-admin/firestore";
import {
  HttpsError,
} from "firebase-functions/v2/https";

const MODULE_REWARDS = {
  "algebra-fundamental": {
    xp: 60,
    gold: 25,
    flag: "algebraFundamentalCompleted",
  },
  "equacoes-inequacoes": {
    xp: 70,
    gold: 30,
    flag: "equationsAndInequationsCompleted",
  },
  "funcoes": {
    xp: 80,
    gold: 35,
    flag: "functionsCompleted",
  },
  "limites": {
    xp: 90,
    gold: 40,
    flag: "limitsCompleted",
  },
  "continuidade": {
    xp: 100,
    gold: 45,
    flag: "continuityCompleted",
  },
  "derivadas": {
    xp: 110,
    gold: 50,
    flag: "derivativesCompleted",
  },
} as const;

type ModuleId = keyof typeof MODULE_REWARDS;

/**
 * Input accepted by the module completion handler.
 */
export interface CompleteModuleInput {
  authUid: string | null;
  data: unknown;
}

/**
 * Result returned after processing a module completion.
 */
export interface CompleteModuleResult {
  moduleId: ModuleId;
  alreadyCompleted: boolean;
  xpAwarded: number;
  goldAwarded: number;
}

/**
 * Validated module completion request.
 */
interface ParsedRequest {
  moduleId: ModuleId;
  requestId: string;
}

/**
 * Validates and parses a module completion request.
 *
 * @param {unknown} data Raw callable request payload.
 * @return {ParsedRequest} Validated request.
 */
function parseRequest(
  data: unknown,
): ParsedRequest {
  if (
    typeof data !== "object" ||
    data === null ||
    Array.isArray(data)
  ) {
    throw new HttpsError(
      "invalid-argument",
      "Invalid request.",
    );
  }

  const raw =
    data as Record<string, unknown>;

  const allowedKeys =
    new Set([
      "moduleId",
      "requestId",
    ]);

  for (const key of Object.keys(raw)) {
    if (!allowedKeys.has(key)) {
      throw new HttpsError(
        "invalid-argument",
        "Invalid request.",
      );
    }
  }

  if (
    typeof raw.moduleId !== "string" ||
    !(raw.moduleId in MODULE_REWARDS)
  ) {
    throw new HttpsError(
      "invalid-argument",
      "Invalid module.",
    );
  }

  if (
    typeof raw.requestId !== "string" ||
    !/^[0-9a-f]{8}-[0-9a-f]{4}-4[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$/i
      .test(raw.requestId)
  ) {
    throw new HttpsError(
      "invalid-argument",
      "Invalid request.",
    );
  }

  return {
    moduleId:
      raw.moduleId as ModuleId,
    requestId:
      raw.requestId,
  };
}

/**
 * Persists trusted module completion and reward data.
 */
export class ModuleCompletionService {
  // eslint-disable-next-line require-jsdoc
  constructor(
    private readonly firestore:
    Firestore,
  ) {}

  // eslint-disable-next-line require-jsdoc
  async complete(
    uid: string,
    moduleId: ModuleId,
    requestId: string,
  ): Promise<CompleteModuleResult> {
    const progressRef =
      this.firestore
        .collection("users")
        .doc(uid)
        .collection("progress")
        .doc("current");

    const eventRef =
      this.firestore
        .collection("users")
        .doc(uid)
        .collection("progress_events")
        .doc(requestId);

    const reward =
      MODULE_REWARDS[moduleId];

    return this.firestore.runTransaction(
      async (transaction) => {
        const [
          progressSnapshot,
          eventSnapshot,
        ] = await Promise.all([
          transaction.get(progressRef),
          transaction.get(eventRef),
        ]);

        if (eventSnapshot.exists) {
          const eventData =
            eventSnapshot.data();

          if (
            eventData?.moduleId !== moduleId
          ) {
            throw new HttpsError(
              "already-exists",
              "Request already used.",
            );
          }

          return {
            moduleId,
            alreadyCompleted: true,
            xpAwarded: 0,
            goldAwarded: 0,
          };
        }

        const current =
          progressSnapshot.data() ?? {};

        const currentCompleted =
          Array.isArray(
            current.completedLessonIds,
          ) ?
            current.completedLessonIds
              .filter(
                (value): value is string =>
                  typeof value === "string",
              ) :
            [];

        if (
          currentCompleted.includes(
            moduleId,
          )
        ) {
          transaction.create(
            eventRef,
            {
              moduleId,
              createdAt:
                FieldValue.serverTimestamp(),
            },
          );

          return {
            moduleId,
            alreadyCompleted: true,
            xpAwarded: 0,
            goldAwarded: 0,
          };
        }

        const nextCompleted = [
          ...currentCompleted,
          moduleId,
        ];

        const nextXp =
          calculateTotalXp(
            nextCompleted,
          );

        const nextGold =
          calculateTotalGold(
            nextCompleted,
          );

        transaction.set(
          progressRef,
          {
            completedLessonIds:
              nextCompleted,
            [reward.flag]: true,
            totalXp: nextXp,
            totalGold: nextGold,
            updatedAt:
              FieldValue.serverTimestamp(),
          },
          {
            merge: true,
          },
        );

        transaction.create(
          eventRef,
          {
            moduleId,
            createdAt:
              FieldValue.serverTimestamp(),
          },
        );

        return {
          moduleId,
          alreadyCompleted: false,
          xpAwarded: reward.xp,
          goldAwarded: reward.gold,
        };
      },
    );
  }
}

/**
 * Calculates the canonical XP total for completed modules.
 *
 * @param {string[]} modules Completed module identifiers.
 * @return {number} Canonical XP total.
 */
function calculateTotalXp(
  modules: string[],
): number {
  let total = 0;

  for (const moduleId of modules) {
    if (moduleId in MODULE_REWARDS) {
      total +=
        MODULE_REWARDS[
          moduleId as ModuleId
        ].xp;
    }
  }

  return total;
}

/**
 * Calculates the canonical gold total for completed modules.
 *
 * @param {string[]} modules Completed module identifiers.
 * @return {number} Canonical gold total.
 */
function calculateTotalGold(
  modules: string[],
): number {
  let total = 0;

  for (const moduleId of modules) {
    if (moduleId in MODULE_REWARDS) {
      total +=
        MODULE_REWARDS[
          moduleId as ModuleId
        ].gold;
    }
  }

  return total;
}

/**
 * Handles an authenticated module completion request.
 *
 * @param {CompleteModuleInput} input Callable request input.
 * @param {ModuleCompletionService} service Completion service.
 * @return {Promise<CompleteModuleResult>} Completion result.
 */
export async function handleCompleteModule(
  input: CompleteModuleInput,
  service: ModuleCompletionService,
): Promise<CompleteModuleResult> {
  if (!input.authUid) {
    throw new HttpsError(
      "unauthenticated",
      "Authentication required.",
    );
  }

  const parsed =
    parseRequest(input.data);

  return service.complete(
    input.authUid,
    parsed.moduleId,
    parsed.requestId,
  );
}
