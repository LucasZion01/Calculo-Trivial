import {
  createHash,
} from "node:crypto";

import {
  Auth,
} from "firebase-admin/auth";
import {
  DocumentData,
  DocumentReference,
  Firestore,
  QueryDocumentSnapshot,
} from "firebase-admin/firestore";
import {
  HttpsError,
} from "firebase-functions/v2/https";

export interface AccountDeletionExecutor {
  delete(uid: string): Promise<void>;
}

interface DeleteAccountRequest {
  authUid: string | null;
  data: unknown;
}

/**
 * Produces the same pseudonymous owner key used by Tutor collections.
 *
 * @param {string} uid Authenticated Firebase user id.
 * @return {string} Stable SHA-256 owner key.
 */
export function createTutorOwnerHash(
  uid: string,
): string {
  return createHash("sha256")
    .update(uid, "utf8")
    .digest("hex");
}

/**
 * Deletes every backend-owned record associated with one account.
 *
 * Authentication is deleted last so a transient Firestore failure can be
 * retried by the still-authenticated user.
 */
export class FirebaseAccountDeletionService
implements AccountDeletionExecutor {
  /**
   * Creates the account deletion service.
   *
   * @param {Firestore} firestore Admin Firestore instance.
   * @param {Auth} auth Admin Authentication instance.
   */
  constructor(
    private readonly firestore: Firestore,
    private readonly auth: Auth,
  ) {}

  /**
   * Deletes user data and then the Firebase Authentication account.
   *
   * @param {string} uid Authenticated Firebase user id.
   * @return {Promise<void>} Completion promise.
   */
  async delete(
    uid: string,
  ): Promise<void> {
    const ownerHash =
      createTutorOwnerHash(uid);

    const [
      sessions,
      idempotencyRecords,
    ] = await Promise.all([
      this.firestore
        .collection("tutorSessions")
        .where("uid", "==", uid)
        .get(),
      this.firestore
        .collection("tutorIdempotency")
        .where(
          "ownerHash",
          "==",
          ownerHash,
        )
        .get(),
    ]);

    await this.deleteSnapshots([
      ...sessions.docs,
      ...idempotencyRecords.docs,
    ]);

    await Promise.all([
      this.firestore.recursiveDelete(
        this.firestore
          .collection("users")
          .doc(uid),
      ),
      this.firestore
        .collection("tutorRateLimits")
        .doc(ownerHash)
        .delete(),
    ]);

    await this.auth.deleteUser(uid);
  }

  /**
   * Deletes query results in bounded Firestore batches.
   *
   * @param {QueryDocumentSnapshot<DocumentData>[]} snapshots Documents.
   * @return {Promise<void>} Completion promise.
   */
  private async deleteSnapshots(
    snapshots:
      QueryDocumentSnapshot<
        DocumentData
      >[],
  ): Promise<void> {
    const maximumBatchSize = 400;

    for (
      let offset = 0;
      offset < snapshots.length;
      offset += maximumBatchSize
    ) {
      const batch =
        this.firestore.batch();

      for (
        const snapshot of
          snapshots.slice(
            offset,
            offset + maximumBatchSize,
          )
      ) {
        batch.delete(
          snapshot.ref as
            DocumentReference<
              DocumentData
            >,
        );
      }

      await batch.commit();
    }
  }
}

/**
 * Validates one callable account-deletion request.
 *
 * @param {DeleteAccountRequest} request Public callable request.
 * @param {AccountDeletionExecutor} executor Backend deletion service.
 * @return {Promise<object>} Public success envelope.
 */
export async function handleDeleteAccount(
  request: DeleteAccountRequest,
  executor:
    AccountDeletionExecutor,
): Promise<{
  status: "ok";
}> {
  if (!request.authUid) {
    throw new HttpsError(
      "unauthenticated",
      "Faça login para excluir a conta.",
    );
  }

  if (hasUnexpectedData(request.data)) {
    throw new HttpsError(
      "invalid-argument",
      "A solicitação não é válida.",
    );
  }

  try {
    await executor.delete(
      request.authUid,
    );

    return {
      status: "ok",
    };
  } catch {
    throw new HttpsError(
      "internal",
      "Não foi possível excluir a conta. Tente novamente.",
    );
  }
}

/**
 * Account deletion accepts no client-controlled fields.
 *
 * @param {unknown} data Callable data.
 * @return {boolean} True when the payload is not empty.
 */
function hasUnexpectedData(
  data: unknown,
): boolean {
  if (
    data === null ||
    data === undefined
  ) {
    return false;
  }

  if (
    typeof data !== "object" ||
    Array.isArray(data)
  ) {
    return true;
  }

  return (
    Object.keys(data).length >
    0
  );
}
