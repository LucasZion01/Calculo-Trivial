import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:calcquest/features/exercise_review/presentation/exercise_review_screen.dart';
import 'package:calcquest/features/result/presentation/result_screen.dart';
import 'package:calcquest/l10n/app_localizations.dart';
import 'package:calcquest/shared/domain/exercise_review_item.dart';
import 'package:calcquest/shared/domain/exercise_session_result.dart';

const reviewItem = ExerciseReviewItem(
  questionId: 'q1',
  statement: 'Quanto é 2 + 2?',
  selectedAnswer: '5',
  correctAnswer: '4',
  explanation: 'Somamos duas unidades a outras duas unidades.',
);

Widget buildLocalizedApp(Widget home) {
  return MaterialApp(
    locale: const Locale('pt'),
    supportedLocales: const [Locale('pt'), Locale('en')],
    localizationsDelegates: const [
      AppLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    home: home,
  );
}

void main() {
  testWidgets('resultado aprovado exige revisão antes da recompensa', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      buildLocalizedApp(
        const ResultScreen(
          totalQuestions: 10,
          correctAnswers: 8,
          xpEarned: 60,
          goldEarned: 25,
          reviewItems: <ExerciseReviewItem>[reviewItem],
        ),
      ),
    );

    await tester.pump();

    expect(find.text('Objetivo atingido!'), findsOneWidget);
    expect(find.text('Revisar 1 erro'), findsOneWidget);
    expect(find.text('Receber recompensa'), findsNothing);
  });

  testWidgets('resultado reprovado não mostra recompensa', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      buildLocalizedApp(
        const ResultScreen(
          totalQuestions: 10,
          correctAnswers: 7,
          xpEarned: 60,
          goldEarned: 25,
          reviewItems: <ExerciseReviewItem>[reviewItem],
        ),
      ),
    );

    await tester.pump();

    expect(find.text('Continue praticando'), findsOneWidget);
    expect(find.text('Revisar 1 erro'), findsOneWidget);
    expect(find.text('XP ganho'), findsNothing);
    expect(find.text('Ouro ganho'), findsNothing);
  });

  testWidgets('revisão mostra resposta escolhida, correta e explicação', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      buildLocalizedApp(
        ExerciseReviewScreen(
          reviewItems: const <ExerciseReviewItem>[reviewItem],
          completedLessonId: 'algebra-fundamental',
          result: const ExerciseSessionResult(
            totalQuestions: 10,
            correctAnswers: 8,
            configuredXp: 60,
            configuredGold: 25,
          ),
        ),
      ),
    );

    await tester.pump();

    expect(find.text('Sua resposta'), findsOneWidget);
    expect(find.text('5'), findsOneWidget);
    expect(find.text('Resposta correta'), findsOneWidget);
    expect(find.text('4'), findsOneWidget);
    expect(
      find.text('Somamos duas unidades a outras duas unidades.'),
      findsOneWidget,
    );
    expect(
      find.text('Sua nota não será alterada durante a revisão.'),
      findsOneWidget,
    );
  });
}
