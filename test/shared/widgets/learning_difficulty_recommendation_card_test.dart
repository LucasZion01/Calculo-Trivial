import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:calcquest/shared/domain/learning_difficulty_diagnosis.dart';
import 'package:calcquest/shared/widgets/learning_difficulty_recommendation_card.dart';

void main() {
  const evidence = LearningDifficultyEvidence(
    moduleId: 'funcoes',
    contentLessonId: 'funcoes',
    skill: 'Domínio de funções',
    attempts: 4,
    errors: 3,
    finalTestAttempts: 2,
    finalTestErrors: 1,
  );

  testWidgets('shows a cautious review suggestion in Portuguese', (tester) async {
    var reviewPressed = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(
            child: LearningDifficultyRecommendationCard(
              evidence: evidence,
              isEnglish: false,
              onReview: () => reviewPressed = true,
            ),
          ),
        ),
      ),
    );

    expect(find.text('Pode valer a pena revisar'), findsOneWidget);
    expect(find.text('Domínio de funções'), findsOneWidget);
    expect(
      find.textContaining('não uma nota nem uma prova de aprendizagem'),
      findsOneWidget,
    );
    expect(find.text('Investigar dificuldade'), findsNothing);

    await tester.tap(find.text('Revisar conteúdo recomendado'));
    expect(reviewPressed, isTrue);
  });

  testWidgets('shows optional investigation action when provided', (tester) async {
    var investigatePressed = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(
            child: LearningDifficultyRecommendationCard(
              evidence: const LearningDifficultyEvidence(
                moduleId: 'limites',
                contentLessonId: 'limites-04-fatoracao',
                skill: 'Diferença de quadrados',
                attempts: 4,
                errors: 3,
                finalTestAttempts: 2,
                finalTestErrors: 1,
              ),
              isEnglish: false,
              onReview: () {},
              onInvestigate: () => investigatePressed = true,
            ),
          ),
        ),
      ),
    );

    expect(find.text('Investigar dificuldade'), findsOneWidget);
    await tester.tap(find.text('Investigar dificuldade'));
    expect(investigatePressed, isTrue);
  });

  testWidgets('shows the equivalent conservative copy in English', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(
            child: LearningDifficultyRecommendationCard(
              evidence: evidence,
              isEnglish: true,
              onReview: () {},
            ),
          ),
        ),
      ),
    );

    expect(find.text('It may be worth reviewing'), findsOneWidget);
    expect(find.textContaining('not a grade or proof of learning'), findsOneWidget);
    expect(find.text('Review recommended content'), findsOneWidget);
  });
}
