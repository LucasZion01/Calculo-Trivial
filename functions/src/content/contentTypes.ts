export interface ContentReferenceKey {
  sourceId: string;
  sectionId: string;
}

export interface ContentOption {
  id: string;
  text: string;
}

export interface TutorQuestion {
  contentVersion: string;
  lessonId: string;
  questionId: string;
  subject: string;
  statement: string;
  options: readonly ContentOption[];
  correctOptionId: string;
  originalExplanation: string;
  references: readonly ContentReferenceKey[];
}

export interface LessonContent {
  contentVersion: string;
  lessonId: string;
  subject: string;
  questions: readonly TutorQuestion[];
}
