import assert from "node:assert/strict";
import test from "node:test";

import {
  TUTOR_RUNTIME_CONFIG,
} from "../config/tutorRuntimeConfig";
import {
  RateLimitService,
} from "./RateLimitService";
import {
  RateLimitResult,
  RateLimitStore,
} from "./rateLimitTypes";

interface UserCounters {
  burstStart: number;
  burstCount: number;
  minuteStart: number;
  minuteCount: number;
  dayStart: number;
  dayCount: number;
}

/**
 * In-memory store used only for unit tests.
 */
class MemoryRateLimitStore
implements RateLimitStore {
  private readonly counters =
    new Map<string, UserCounters>();

  /**
   * Consumes one request.
   *
   * @param {string} uid User identifier.
   * @param {Date} now Backend time.
   * @return {Promise<RateLimitResult>} Result.
   */
  async consume(
    uid: string,
    now: Date,
  ): Promise<RateLimitResult> {
    const config =
      TUTOR_RUNTIME_CONFIG.rateLimit;

    const nowMs =
      now.getTime();

    const existing =
      this.counters.get(uid) ?? {
        burstStart: -1,
        burstCount: 0,
        minuteStart: -1,
        minuteCount: 0,
        dayStart: -1,
        dayCount: 0,
      };

    const burstStart =
      Math.floor(
        nowMs /
        config.burstWindowMs,
      ) *
      config.burstWindowMs;

    const minuteStart =
      Math.floor(
        nowMs /
        config.minuteWindowMs,
      ) *
      config.minuteWindowMs;

    const dayStart =
      Math.floor(
        nowMs /
        config.dayWindowMs,
      ) *
      config.dayWindowMs;

    const burstCount =
      existing.burstStart ===
      burstStart ?
        existing.burstCount :
        0;

    const minuteCount =
      existing.minuteStart ===
      minuteStart ?
        existing.minuteCount :
        0;

    const dayCount =
      existing.dayStart ===
      dayStart ?
        existing.dayCount :
        0;

    if (
      burstCount >=
      config.burstMaxRequests
    ) {
      return {
        allowed: false,
        code:
          "BURST_LIMIT_EXCEEDED",
        retryAfterMs:
          burstStart +
          config.burstWindowMs -
          nowMs,
      };
    }

    if (
      minuteCount >=
      config.minuteMaxRequests
    ) {
      return {
        allowed: false,
        code:
          "MINUTE_LIMIT_EXCEEDED",
        retryAfterMs:
          minuteStart +
          config.minuteWindowMs -
          nowMs,
      };
    }

    if (
      dayCount >=
      config.dayMaxRequests
    ) {
      return {
        allowed: false,
        code:
          "DAILY_LIMIT_EXCEEDED",
        retryAfterMs:
          dayStart +
          config.dayWindowMs -
          nowMs,
      };
    }

    const next = {
      burstStart,
      burstCount:
        burstCount + 1,
      minuteStart,
      minuteCount:
        minuteCount + 1,
      dayStart,
      dayCount:
        dayCount + 1,
    };

    this.counters.set(
      uid,
      next,
    );

    return {
      allowed: true,
      remainingMinute:
        config.minuteMaxRequests -
        next.minuteCount,
      remainingDaily:
        config.dayMaxRequests -
        next.dayCount,
    };
  }
}

test("runtime limits match production contract", () => {
  const config =
    TUTOR_RUNTIME_CONFIG;

  assert.equal(
    config.rateLimit
      .minuteMaxRequests,
    10,
  );

  assert.equal(
    config.rateLimit
      .dayMaxRequests,
    100,
  );

  assert.equal(
    config.function.minInstances,
    0,
  );

  assert.equal(
    config.function.maxInstances,
    3,
  );

  assert.equal(
    config.function.concurrency,
    5,
  );

  assert.equal(
    config.function.timeoutSeconds,
    30,
  );

  assert.equal(
    config.gemini.timeoutMs,
    15_000,
  );

  assert.equal(
    config.gemini
      .maxRawResponseBytes,
    16 * 1024,
  );
});

test("allows normal authenticated usage", async () => {
  const service =
    new RateLimitService(
      new MemoryRateLimitStore(),
    );

  const result =
    await service.consume(
      "uid_a",
      new Date(
        "2026-08-26T12:00:00Z",
      ),
    );

  assert.equal(
    result.allowed,
    true,
  );
});

test("limits burst traffic", async () => {
  const service =
    new RateLimitService(
      new MemoryRateLimitStore(),
    );

  const start =
    new Date(
      "2026-08-26T12:00:00Z",
    );

  const max =
    TUTOR_RUNTIME_CONFIG
      .rateLimit
      .burstMaxRequests;

  for (
    let index = 0;
    index < max;
    index += 1
  ) {
    const result =
      await service.consume(
        "uid_a",
        start,
      );

    assert.equal(
      result.allowed,
      true,
    );
  }

  const blocked =
    await service.consume(
      "uid_a",
      start,
    );

  assert.equal(
    blocked.allowed,
    false,
  );

  if (!blocked.allowed) {
    assert.equal(
      blocked.code,
      "BURST_LIMIT_EXCEEDED",
    );

    assert.equal(
      blocked.retryAfterMs,
      5000,
    );
  }
});

test("burst window resets", async () => {
  const service =
    new RateLimitService(
      new MemoryRateLimitStore(),
    );

  const start =
    new Date(
      "2026-08-26T12:00:00Z",
    );

  const max =
    TUTOR_RUNTIME_CONFIG
      .rateLimit
      .burstMaxRequests;

  for (
    let index = 0;
    index < max;
    index += 1
  ) {
    await service.consume(
      "uid_a",
      start,
    );
  }

  const result =
    await service.consume(
      "uid_a",
      new Date(
        start.getTime() + 5000,
      ),
    );

  assert.equal(
    result.allowed,
    true,
  );
});

test("limits ten requests per minute", async () => {
  const service =
    new RateLimitService(
      new MemoryRateLimitStore(),
    );

  const start =
    new Date(
      "2026-08-26T12:00:00Z",
    );

  for (
    let index = 0;
    index < 10;
    index += 1
  ) {
    const requestTime =
      new Date(
        start.getTime() +
        index * 5000,
      );

    const result =
      await service.consume(
        "uid_a",
        requestTime,
      );

    assert.equal(
      result.allowed,
      true,
    );
  }

  const blocked =
    await service.consume(
      "uid_a",
      new Date(
        start.getTime() +
        50_000,
      ),
    );

  assert.equal(
    blocked.allowed,
    false,
  );

  if (!blocked.allowed) {
    assert.equal(
      blocked.code,
      "MINUTE_LIMIT_EXCEEDED",
    );
  }
});

test("minute window resets", async () => {
  const service =
    new RateLimitService(
      new MemoryRateLimitStore(),
    );

  const start =
    new Date(
      "2026-08-26T12:00:00Z",
    );

  for (
    let index = 0;
    index < 10;
    index += 1
  ) {
    await service.consume(
      "uid_a",
      new Date(
        start.getTime() +
        index * 5000,
      ),
    );
  }

  const result =
    await service.consume(
      "uid_a",
      new Date(
        start.getTime() +
        60_000,
      ),
    );

  assert.equal(
    result.allowed,
    true,
  );
});

test("different users have independent limits", async () => {
  const service =
    new RateLimitService(
      new MemoryRateLimitStore(),
    );

  const now =
    new Date(
      "2026-08-26T12:00:00Z",
    );

  const max =
    TUTOR_RUNTIME_CONFIG
      .rateLimit
      .burstMaxRequests;

  for (
    let index = 0;
    index < max;
    index += 1
  ) {
    await service.consume(
      "uid_a",
      now,
    );
  }

  const otherUser =
    await service.consume(
      "uid_b",
      now,
    );

  assert.equal(
    otherUser.allowed,
    true,
  );
});

test("enforces daily limit", async () => {
  const service =
    new RateLimitService(
      new MemoryRateLimitStore(),
    );

  const start =
    new Date(
      "2026-08-26T00:00:00Z",
    );

  for (
    let index = 0;
    index < 100;
    index += 1
  ) {
    const requestTime =
      new Date(
        start.getTime() +
        index * 60_000,
      );

    const result =
      await service.consume(
        "uid_a",
        requestTime,
      );

    assert.equal(
      result.allowed,
      true,
    );
  }

  const blocked =
    await service.consume(
      "uid_a",
      new Date(
        start.getTime() +
        100 * 60_000,
      ),
    );

  assert.equal(
    blocked.allowed,
    false,
  );

  if (!blocked.allowed) {
    assert.equal(
      blocked.code,
      "DAILY_LIMIT_EXCEEDED",
    );
  }
});
