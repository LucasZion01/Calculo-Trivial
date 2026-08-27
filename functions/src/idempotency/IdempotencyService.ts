import {
  TutorBackendResponse,
} from "../contracts/types";
import {
  IdempotencyClaim,
  IdempotencyClaimResult,
  IdempotencyKey,
  IdempotencyStore,
} from "./idempotencyTypes";

/**
 * Coordinates idempotent tutor requests.
 */
export class IdempotencyService {
  /**
   * Creates the service.
   *
   * @param {IdempotencyStore} store Persistence implementation.
   */
  constructor(
    private readonly store: IdempotencyStore,
  ) {}

  /**
   * Claims one logical request.
   *
   * @param {IdempotencyKey} key Authenticated request key.
   * @param {Date} now Backend time.
   * @return {Promise<IdempotencyClaimResult>} Claim result.
   */
  async claim(
    key: IdempotencyKey,
    now: Date = new Date(),
  ): Promise<IdempotencyClaimResult> {
    return this.store.claim(
      key,
      now,
    );
  }

  /**
   * Stores the final public response.
   *
   * @param {IdempotencyClaim} claim Previously acquired claim.
   * @param {TutorBackendResponse} response Public response.
   * @param {Date} now Backend time.
   * @return {Promise<void>} Completion promise.
   */
  async complete(
    claim: IdempotencyClaim,
    response: TutorBackendResponse,
    now: Date = new Date(),
  ): Promise<void> {
    await this.store.complete(
      claim,
      response,
      now,
    );
  }

  /**
   * Releases a processing claim after an unsuccessful request.
   *
   * Completed responses are never removed by this operation.
   *
   * @param {IdempotencyClaim} claim Previously acquired claim.
   * @return {Promise<void>} Completion promise.
   */
  async abandon(
    claim: IdempotencyClaim,
  ): Promise<void> {
    await this.store.abandon(
      claim,
    );
  }
}
