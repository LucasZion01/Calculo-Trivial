enum LearningCardTone { neutral, information, success, warning }

enum LessonVisual {
  route,
  compare,
  notation,
  calculate,
  transform,
  table,
  graph,
  warning,
  infinity,
  engineering,
  checklist,
  idea,
}

class CourseLessonData {
  final String id;
  final String topicId;
  final String trailTitle;
  final String eyebrow;
  final String title;
  final String description;
  final String duration;
  final String objective;
  final String symbol;
  final List<LessonSectionData> sections;
  final LessonCheckData check;
  final List<String> takeaways;
  final String closing;

  const CourseLessonData({
    required this.id,
    required this.topicId,
    required this.trailTitle,
    required this.eyebrow,
    required this.title,
    required this.description,
    required this.duration,
    required this.objective,
    required this.symbol,
    required this.sections,
    required this.check,
    required this.takeaways,
    required this.closing,
  });
}

class LessonSectionData {
  final String number;
  final String title;
  final String? subtitle;
  final List<LessonBlockData> blocks;

  const LessonSectionData({
    required this.number,
    required this.title,
    this.subtitle,
    required this.blocks,
  });
}

sealed class LessonBlockData {
  const LessonBlockData();
}

class ConceptBlockData extends LessonBlockData {
  final LessonVisual visual;
  final String title;
  final String content;
  final String? emphasis;
  final LearningCardTone tone;

  const ConceptBlockData({
    required this.visual,
    required this.title,
    required this.content,
    this.emphasis,
    this.tone = LearningCardTone.neutral,
  });
}

class WorkedExampleBlockData extends LessonBlockData {
  final String title;
  final String problem;
  final List<String> steps;
  final String result;
  final String interpretation;

  const WorkedExampleBlockData({
    required this.title,
    required this.problem,
    required this.steps,
    required this.result,
    required this.interpretation,
  });
}

class LessonCheckData {
  final String question;
  final List<String> choices;
  final int correctIndex;
  final String explanation;

  const LessonCheckData({
    required this.question,
    required this.choices,
    required this.correctIndex,
    required this.explanation,
  });
}
