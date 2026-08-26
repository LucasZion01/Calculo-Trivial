import {
  LessonContent,
  TutorQuestion,
} from "./contentTypes";
import {
  ContentRepository,
} from "./ContentRepository";

/**
 * Local in-memory implementation of the content repository.
 */
export class LocalContentRepository
implements ContentRepository {
  private readonly lessonsById:
  ReadonlyMap<string, LessonContent>;

  /**
   * Creates a repository backed by local immutable content.
   *
   * @param {LessonContent[]} lessons Lesson catalog.
   */
  constructor(
    lessons: readonly LessonContent[],
  ) {
    this.lessonsById = new Map(
      lessons.map((lesson) => [
        lesson.lessonId,
        lesson,
      ]),
    );
  }

  /**
   * Returns one lesson by id.
   *
   * @param {string} lessonId Lesson identifier.
   * @return {Promise<LessonContent|null>} Lesson or null.
   */
  async getLesson(
    lessonId: string,
  ): Promise<LessonContent | null> {
    return this.lessonsById.get(lessonId) ?? null;
  }

  /**
   * Returns one question only when it belongs to the lesson.
   *
   * @param {string} lessonId Lesson identifier.
   * @param {string} questionId Question identifier.
   * @return {Promise<TutorQuestion|null>} Question or null.
   */
  async getQuestion(
    lessonId: string,
    questionId: string,
  ): Promise<TutorQuestion | null> {
    const lesson = await this.getLesson(lessonId);

    if (!lesson) {
      return null;
    }

    return lesson.questions.find(
      (question) => question.questionId === questionId,
    ) ?? null;
  }

  /**
   * Checks whether a question belongs to a lesson.
   *
   * @param {string} lessonId Lesson identifier.
   * @param {string} questionId Question identifier.
   * @return {Promise<boolean>} True when association exists.
   */
  async questionBelongsToLesson(
    lessonId: string,
    questionId: string,
  ): Promise<boolean> {
    return (
      await this.getQuestion(
        lessonId,
        questionId,
      )
    ) !== null;
  }
}
