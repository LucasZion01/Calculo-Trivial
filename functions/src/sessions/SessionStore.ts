import {
  SessionMutationResult,
  TutorSession,
} from "./sessionTypes";

export interface SessionStore {
  create(
    session: TutorSession,
  ): Promise<void>;

  advanceHintAtomically(
    sessionId: string,
    uid: string,
    expectedContext: TutorSession["context"],
    now: Date,
  ): Promise<SessionMutationResult>;

  touchAtomically(
    sessionId: string,
    uid: string,
    expectedContext: TutorSession["context"],
    now: Date,
  ): Promise<SessionMutationResult>;
}
