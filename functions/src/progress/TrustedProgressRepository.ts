export interface TrustedProgressRepository {
  getReviewTopics(
    uid: string,
  ): Promise<readonly string[]>;
}
