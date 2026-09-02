import {
  createHash,
  randomBytes,
} from "node:crypto";

import {
  Firestore,
  Timestamp,
} from "firebase-admin/firestore";

import {
  createTutorOwnerHash,
} from "../account/accountDeletion";
import {
  tutorBackendResponseSchema,
} from "../contracts/responseSchemas";
import {
  TutorBackendResponse,
} from "../contracts/types";
import {
  IDEMPOTENCY_TTL_MS,
  IdempotencyClaim,
  IdempotencyClaimResult,
  IdempotencyKey,
  IdempotencyStore,
} from "./idempotencyTypes";

interface IdempotencyDocument {
  ownerHash: string;
  status: "processing" | "completed";
  claimToken: string;
  createdAt: Timestamp;
  updatedAt: Timestamp;
  expiresAt: Timestamp;
  response?: TutorBackendResponse;
}

/**
 * Builds a deterministic opaque record id.
 *
 * @param {IdempotencyKey} key Logical idempotency key.
 * @return {string} SHA-256 record id.
 */
function createRecordId(
  key: IdempotencyKey,
): string {
  return createHash("sha256")
    .update(
      `${key.uid}:${key.clientRequestId}`,
      "utf8",
    )
    .digest("hex");
}

/**
 * Creates an unpredictable ownership token.
 *
 * @return {string} New claim token.
 */
function createClaimToken(): string {
  return randomBytes(24)
    .toString("base64url");
}

/**
 * Firestore-backed idempotency store.
 */
export class FirestoreIdempotencyStore
implements IdempotencyStore {
  /**
   * Creates the Firestore implementation.
   *
   * @param {Firestore} firestore Admin Firestore instance.
   */
  constructor(
    private readonly firestore: Firestore,
  ) {}

  /**
   * Atomically acquires or reuses an idempotency record.
   *
   * @param {IdempotencyKey} key Logical key.
   * @param {Date} now Backend time.
   * @return {Promise<IdempotencyClaimResult>} Claim result.
   */
  async claim(
    key: IdempotencyKey,
    now: Date,
  ): Promise<IdempotencyClaimResult> {
    const recordId =
      createRecordId(key);

    const reference =
      this.firestore
        .collection(
          "tutorIdempotency",
        )
        .doc(recordId);

    return this.firestore
      .runTransaction(
        async (transaction) => {
          const snapshot =
            await transaction.get(
              reference,
            );

          if (snapshot.exists) {
            const data =
              snapshot.data() as
              IdempotencyDocument;

            const expired =
              data.expiresAt
                .toMillis() <=
              now.getTime();

            if (!expired) {
              if (
                data.status ===
                  "completed" &&
                data.response
              ) {
                const response =
                  tutorBackendResponseSchema
                    .parse(
                      data.response,
                    );

                return {
                  status: "completed",
                  response,
                };
              }

              return {
                status:
                  "processing",
              };
            }
          }

          const claimToken =
            createClaimToken();

          const expiresAt =
            new Date(
              now.getTime() +
              IDEMPOTENCY_TTL_MS,
            );

          const document:
          IdempotencyDocument = {
            ownerHash:
              createTutorOwnerHash(
                key.uid,
              ),
            status: "processing",
            claimToken,
            createdAt:
              Timestamp.fromDate(
                now,
              ),
            updatedAt:
              Timestamp.fromDate(
                now,
              ),
            expiresAt:
              Timestamp.fromDate(
                expiresAt,
              ),
          };

          transaction.set(
            reference,
            document,
          );

          return {
            status: "acquired",
            claim: {
              recordId,
              claimToken,
              expiresAt,
            },
          };
        },
      );
  }

  /**
   * Atomically stores a completed response.
   *
   * @param {IdempotencyClaim} claim Claim ownership.
   * @param {TutorBackendResponse} response Public response.
   * @param {Date} now Backend time.
   * @return {Promise<void>} Completion promise.
   */
  async complete(
    claim: IdempotencyClaim,
    response: TutorBackendResponse,
    now: Date,
  ): Promise<void> {
    const validatedResponse =
      tutorBackendResponseSchema
        .parse(response);

    const reference =
      this.firestore
        .collection(
          "tutorIdempotency",
        )
        .doc(claim.recordId);

    await this.firestore
      .runTransaction(
        async (transaction) => {
          const snapshot =
            await transaction.get(
              reference,
            );

          if (!snapshot.exists) {
            throw new Error(
              "Idempotency record not found",
            );
          }

          const data =
            snapshot.data() as
            IdempotencyDocument;

          if (
            data.status !==
              "processing" ||
            data.claimToken !==
              claim.claimToken
          ) {
            throw new Error(
              "Idempotency claim is not valid",
            );
          }

          transaction.update(
            reference,
            {
              status:
                "completed",
              response:
                validatedResponse,
              updatedAt:
                Timestamp.fromDate(
                  now,
                ),
            },
          );
        },
      );
  }

  /**
   * Releases a processing claim after a failed request.
   *
   * A completed response is never deleted. An old claim token can never
   * delete a newer replacement record.
   *
   * @param {IdempotencyClaim} claim Claim ownership.
   * @return {Promise<void>} Completion promise.
   */
  async abandon(
    claim: IdempotencyClaim,
  ): Promise<void> {
    const reference =
      this.firestore
        .collection(
          "tutorIdempotency",
        )
        .doc(claim.recordId);

    await this.firestore
      .runTransaction(
        async (transaction) => {
          const snapshot =
            await transaction.get(
              reference,
            );

          if (!snapshot.exists) {
            return;
          }

          const data =
            snapshot.data() as
            IdempotencyDocument;

          if (
            data.status ===
            "completed"
          ) {
            return;
          }

          if (
            data.claimToken !==
            claim.claimToken
          ) {
            throw new Error(
              "Idempotency claim is not valid",
            );
          }

          transaction.delete(
            reference,
          );
        },
      );
  }
}
