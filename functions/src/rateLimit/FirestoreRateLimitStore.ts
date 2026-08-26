import {
  createHash,
} from "node:crypto";

import {
  Firestore,
  Timestamp,
} from "firebase-admin/firestore";

import {
  TUTOR_RUNTIME_CONFIG,
} from "../config/tutorRuntimeConfig";
import {
  RateLimitResult,
  RateLimitStore,
} from "./rateLimitTypes";

interface RateLimitDocument {
  burstWindowStart: Timestamp;
  burstCount: number;
  minuteWindowStart: Timestamp;
  minuteCount: number;
  dayWindowStart: Timestamp;
  dayCount: number;
  updatedAt: Timestamp;
}

interface WindowState {
  startMs: number;
  count: number;
}

/**
 * Creates an opaque stable document id from the uid.
 *
 * @param {string} uid Authenticated Firebase uid.
 * @return {string} SHA-256 document id.
 */
function createRateLimitDocumentId(
  uid: string,
): string {
  return createHash("sha256")
    .update(uid, "utf8")
    .digest("hex");
}

/**
 * Calculates one fixed time window.
 *
 * @param {number} nowMs Current epoch time.
 * @param {number} windowMs Window duration.
 * @param {number} storedStartMs Stored window start.
 * @param {number} storedCount Stored request count.
 * @return {WindowState} Current window state.
 */
function getWindowState(
  nowMs: number,
  windowMs: number,
  storedStartMs: number,
  storedCount: number,
): WindowState {
  const currentStart =
    Math.floor(nowMs / windowMs) *
    windowMs;

  if (
    storedStartMs !== currentStart
  ) {
    return {
      startMs: currentStart,
      count: 0,
    };
  }

  return {
    startMs: storedStartMs,
    count: storedCount,
  };
}

/**
 * Returns time remaining in one fixed window.
 *
 * @param {number} nowMs Current epoch time.
 * @param {number} startMs Window start.
 * @param {number} windowMs Window duration.
 * @return {number} Milliseconds until reset.
 */
function getRetryAfterMs(
  nowMs: number,
  startMs: number,
  windowMs: number,
): number {
  return Math.max(
    1,
    startMs + windowMs - nowMs,
  );
}

/**
 * Firestore-backed transactional rate limiter.
 */
export class FirestoreRateLimitStore
implements RateLimitStore {
  /**
   * Creates the Firestore store.
   *
   * @param {Firestore} firestore Admin Firestore instance.
   */
  constructor(
    private readonly firestore: Firestore,
  ) {}

  /**
   * Atomically consumes one user request.
   *
   * @param {string} uid Authenticated Firebase uid.
   * @param {Date} now Backend time.
   * @return {Promise<RateLimitResult>} Rate limit result.
   */
  async consume(
    uid: string,
    now: Date,
  ): Promise<RateLimitResult> {
    const config =
      TUTOR_RUNTIME_CONFIG.rateLimit;

    const documentId =
      createRateLimitDocumentId(uid);

    const reference = this.firestore
      .collection("tutorRateLimits")
      .doc(documentId);

    return this.firestore.runTransaction(
      async (transaction) => {
        const snapshot =
          await transaction.get(reference);

        const nowMs = now.getTime();

        const initialStart =
          Timestamp.fromMillis(0);

        const data:
        RateLimitDocument = snapshot.exists ?
          snapshot.data() as
            RateLimitDocument :
          {
            burstWindowStart:
              initialStart,
            burstCount: 0,
            minuteWindowStart:
              initialStart,
            minuteCount: 0,
            dayWindowStart:
              initialStart,
            dayCount: 0,
            updatedAt:
              Timestamp.fromDate(now),
          };

        const burst =
          getWindowState(
            nowMs,
            config.burstWindowMs,
            data.burstWindowStart
              .toMillis(),
            data.burstCount,
          );

        const minute =
          getWindowState(
            nowMs,
            config.minuteWindowMs,
            data.minuteWindowStart
              .toMillis(),
            data.minuteCount,
          );

        const day =
          getWindowState(
            nowMs,
            config.dayWindowMs,
            data.dayWindowStart
              .toMillis(),
            data.dayCount,
          );

        if (
          burst.count >=
          config.burstMaxRequests
        ) {
          return {
            allowed: false,
            code:
              "BURST_LIMIT_EXCEEDED",
            retryAfterMs:
              getRetryAfterMs(
                nowMs,
                burst.startMs,
                config.burstWindowMs,
              ),
          };
        }

        if (
          minute.count >=
          config.minuteMaxRequests
        ) {
          return {
            allowed: false,
            code:
              "MINUTE_LIMIT_EXCEEDED",
            retryAfterMs:
              getRetryAfterMs(
                nowMs,
                minute.startMs,
                config.minuteWindowMs,
              ),
          };
        }

        if (
          day.count >=
          config.dayMaxRequests
        ) {
          return {
            allowed: false,
            code:
              "DAILY_LIMIT_EXCEEDED",
            retryAfterMs:
              getRetryAfterMs(
                nowMs,
                day.startMs,
                config.dayWindowMs,
              ),
          };
        }

        const nextBurst =
          burst.count + 1;

        const nextMinute =
          minute.count + 1;

        const nextDay =
          day.count + 1;

        const nextData:
        RateLimitDocument = {
          burstWindowStart:
            Timestamp.fromMillis(
              burst.startMs,
            ),
          burstCount: nextBurst,
          minuteWindowStart:
            Timestamp.fromMillis(
              minute.startMs,
            ),
          minuteCount: nextMinute,
          dayWindowStart:
            Timestamp.fromMillis(
              day.startMs,
            ),
          dayCount: nextDay,
          updatedAt:
            Timestamp.fromDate(now),
        };

        transaction.set(
          reference,
          nextData,
        );

        return {
          allowed: true,
          remainingMinute:
            Math.max(
              0,
              config.minuteMaxRequests -
              nextMinute,
            ),
          remainingDaily:
            Math.max(
              0,
              config.dayMaxRequests -
              nextDay,
            ),
        };
      },
    );
  }
}
