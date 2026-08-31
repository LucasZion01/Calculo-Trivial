import 'package:flutter/widgets.dart';

class LessonUiText {
  final String back;
  final String objectivePrefix;
  final String solvedExample;
  final String checkUnderstanding;
  final String correctPrefix;
  final String almostPrefix;
  final String answerAgain;
  final String takeawaysTitle;
  final String completeLesson;
  final String completeAndContinue;

  const LessonUiText._({
    required this.back,
    required this.objectivePrefix,
    required this.solvedExample,
    required this.checkUnderstanding,
    required this.correctPrefix,
    required this.almostPrefix,
    required this.answerAgain,
    required this.takeawaysTitle,
    required this.completeLesson,
    required this.completeAndContinue,
  });

  factory LessonUiText.of(BuildContext context) {
    return forLocale(Localizations.localeOf(context));
  }

  factory LessonUiText.forLocale(Locale locale) {
    if (locale.languageCode == 'en') {
      return const LessonUiText._(
        back: 'Back',
        objectivePrefix: 'By the end, you will be able to',
        solvedExample: 'WORKED EXAMPLE',
        checkUnderstanding: 'Check your understanding',
        correctPrefix: 'Well done!',
        almostPrefix: 'Almost there!',
        answerAgain: 'Try again',
        takeawaysTitle: 'Before practicing, keep this in mind:',
        completeLesson: 'Complete lesson',
        completeAndContinue: 'Complete and continue',
      );
    }

    return const LessonUiText._(
      back: 'Voltar',
      objectivePrefix: 'Ao final, você será capaz de',
      solvedExample: 'EXEMPLO RESOLVIDO',
      checkUnderstanding: 'Cheque seu entendimento',
      correctPrefix: 'Muito bem!',
      almostPrefix: 'Quase!',
      answerAgain: 'Responder novamente',
      takeawaysTitle: 'Antes de praticar, leve isto com você:',
      completeLesson: 'Concluir aula',
      completeAndContinue: 'Concluir e continuar',
    );
  }

  String solvedExampleSemantics(String title) => '$solvedExample: $title';

  String objective(String objective) => '$objectivePrefix $objective.';

  String feedback({
    required bool isCorrect,
    required String explanation,
  }) {
    return '${isCorrect ? correctPrefix : almostPrefix} $explanation';
  }
}
