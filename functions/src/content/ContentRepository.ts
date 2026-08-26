import {
  LessonContent,
  TutorQuestion,
} from "./contentTypes";

export interface ContentRepository {
  getLesson(
    lessonId: string,
  ): Promise<LessonContent | null>;

  getQuestion(
    lessonId: string,
    questionId: string,
  ): Promise<TutorQuestion | null>;

  questionBelongsToLesson(
    lessonId: string,
    questionId: string,
  ): Promise<boolean>;
}
