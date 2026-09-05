import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:calcquest/l10n/app_localizations.dart';
import 'package:calcquest/shared/data/mock_exercise_data.dart';
import 'package:calcquest/shared/widgets/exercise_answer_feedback.dart';

const exercise = ExerciseData(
  id: 'feedback-test',
  title: 'Questão de teste',
  statement: 'Simplifique (12x³y²) / (3xy).',
  correctOptionId: 'b',
  explanation:
      'Dividimos os coeficientes e subtraímos expoentes de bases iguais. O resultado é 4x²y.',
  contentLessonId: 'algebra-04-potencias',
  skill: 'Dividir monômios',
  difficulty: ExerciseDifficulty.intermediate,
  options: <ExerciseOptionData>[
    ExerciseOptionData(id: 'a', text: '4x³y'),
    ExerciseOptionData(id: 'b', text: '4x²y'),
  ],
);

Widget buildLocalizedFeedback({
  required bool isCorrect,
  required String selectedAnswer,
}) {
  return MaterialApp(
    locale: const Locale('pt'),
    supportedLocales: const [Locale('pt'), Locale('en')],
    localizationsDelegates: const [
      AppLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    home: Scaffold(
      body: ExerciseAnswerFeedbackContent(
        exercise: exercise,
        isCorrect: isCorrect,
        selectedAnswer: selectedAnswer,
        correctAnswer: '4x²y',
        isLastExercise: false,
        onContinue: () {},
      ),
    ),
  );
}

void main() {
  testWidgets('erro usa pista matemática sem revelar solução', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      buildLocalizedFeedback(isCorrect: false, selectedAnswer: '4x³y'),
    );

    expect(find.text('Primeira pista'), findsOneWidget);
    expect(
      find.textContaining('divida os coeficientes numéricos'),
      findsOneWidget,
    );
    expect(find.text('Resposta correta: 4x²y'), findsNothing);
    expect(find.text(exercise.explanation), findsNothing);

    final nextHintButton = find.text('Mostrar próxima pista');
    await tester.ensureVisible(nextHintButton);
    await tester.tap(nextHintButton);
    await tester.pump();

    expect(find.text('Próximo passo'), findsOneWidget);
    expect(
      find.textContaining('subtraia o expoente do denominador'),
      findsOneWidget,
    );
    expect(find.text('Resposta correta: 4x²y'), findsNothing);
    expect(find.text(exercise.explanation), findsNothing);

    final solutionButton = find.text('Mostrar solução');
    await tester.ensureVisible(solutionButton);
    await tester.tap(solutionButton);
    await tester.pump();

    expect(find.text('Resposta correta: 4x²y'), findsOneWidget);
    expect(find.text(exercise.explanation), findsOneWidget);
    expect(find.text('Reflexão rápida'), findsOneWidget);
    expect(find.text('Qual foi a ideia decisiva nesta questão?'), findsOneWidget);
    expect(find.text('Dividir monômios'), findsOneWidget);

    final skillOption = find.text('Dividir monômios');
    await tester.ensureVisible(skillOption);
    await tester.tap(skillOption);
    await tester.pump();

    expect(
      find.text('Isso. Essa foi a ideia matemática central.'),
      findsOneWidget,
    );
    expect(find.text('Continuar praticando'), findsOneWidget);
  });

  testWidgets('acerto mantém explicação direta sem reflexão extra', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      buildLocalizedFeedback(isCorrect: true, selectedAnswer: '4x²y'),
    );

    expect(find.text('Boa análise!'), findsOneWidget);
    expect(find.text(exercise.explanation), findsOneWidget);
    expect(find.text('Primeira pista'), findsNothing);
    expect(find.text('Mostrar próxima pista'), findsNothing);
    expect(find.text('Reflexão rápida'), findsNothing);
    expect(find.text('Continuar praticando'), findsOneWidget);
  });
}
