import {
  FieldValue,
  Firestore,
} from "firebase-admin/firestore";

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

export type ModuleId =
  keyof typeof MODULE_REWARDS;

/**
 * Result of a trusted module completion.
 */
export interface ModuleCompletionResult {
  moduleId: ModuleId;
  alreadyCompleted: boolean;
  xpAwarded: number;
  goldAwarded: number;
}

/**
 * Persists rewards only after another trusted backend service
 * has verified that the user passed the module final test.
 *
 * This service is intentionally not a callable handler.
 */
export class ModuleCompletionService {
  // eslint-disable-next-line require-jsdoc
  constructor(
    private readonly firestore:
    Firestore,
  ) {}

  /**
   * Awards canonical progress after a verified pass.
   *
   * The request ID must originate from a trusted backend
   * operation, such as a validated final-test session ID.
   *
   * @param {string} uid Authenticated user identifier.
   * @param {ModuleId} moduleId Trusted module identifier.
   * @param {string} requestId Trusted idempotency identifier.
   * @return {Promise<ModuleCompletionResult>} Completion result.
   */
  // eslint-disable-next-line require-jsdoc
  async awardAfterVerifiedPass(
    uid: string,
    moduleId: ModuleId,
    requestId: string,
  ): Promise<ModuleCompletionResult> {
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
            eventData?.moduleId !==
            moduleId
          ) {
            throw new Error(
              "Trusted request already used.",
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
 * Calculates canonical XP from trusted completed modules.
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
 * Calculates canonical gold from trusted completed modules.
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
