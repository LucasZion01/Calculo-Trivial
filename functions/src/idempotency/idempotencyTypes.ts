import {
  TutorBackendResponse,
} from "../contracts/types";

export const IDEMPOTENCY_TTL_MS =
  24 * 60 * 60 * 1000;

export interface IdempotencyKey {
  uid: string;
  clientRequestId: string;
}

export interface IdempotencyClaim {
  recordId: string;
  claimToken: string;
  expiresAt: Date;
}

export type IdempotencyClaimResult =
  | {
    status: "acquired";
    claim: IdempotencyClaim;
  }
  | {
    status: "completed";
    response: TutorBackendResponse;
  }
  | {
    status: "processing";
  };

export interface IdempotencyStore {
  claim(
    key: IdempotencyKey,
    now: Date,
  ): Promise<IdempotencyClaimResult>;

  complete(
    claim: IdempotencyClaim,
    response: TutorBackendResponse,
    now: Date,
  ): Promise<void>;
}
