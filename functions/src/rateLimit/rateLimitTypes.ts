export type RateLimitCode =
  | "BURST_LIMIT_EXCEEDED"
  | "MINUTE_LIMIT_EXCEEDED"
  | "DAILY_LIMIT_EXCEEDED";

export type RateLimitResult =
  | {
    allowed: true;
    remainingMinute: number;
    remainingDaily: number;
  }
  | {
    allowed: false;
    code: RateLimitCode;
    retryAfterMs: number;
  };

export interface RateLimitStore {
  consume(
    uid: string,
    now: Date,
  ): Promise<RateLimitResult>;
}
