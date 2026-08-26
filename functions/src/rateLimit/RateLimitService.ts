import {
  RateLimitResult,
  RateLimitStore,
} from "./rateLimitTypes";

/**
 * Coordinates per-user tutor usage limits.
 */
export class RateLimitService {
  /**
   * Creates the rate limit service.
   *
   * @param {RateLimitStore} store Rate limit persistence.
   */
  constructor(
    private readonly store: RateLimitStore,
  ) {}

  /**
   * Consumes one authenticated tutor request.
   *
   * @param {string} uid Authenticated Firebase uid.
   * @param {Date} now Backend time.
   * @return {Promise<RateLimitResult>} Rate limit result.
   */
  async consume(
    uid: string,
    now: Date = new Date(),
  ): Promise<RateLimitResult> {
    return this.store.consume(
      uid,
      now,
    );
  }
}
