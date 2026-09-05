import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:calcquest/features/lesson/presentation/course_lesson_screen.dart';
import 'package:calcquest/l10n/app_localizations.dart';
import 'package:calcquest/shared/domain/course_lesson_data.dart';

void main() {
  const lesson = CourseLessonData(
    id: 'teste-01',
    topicId: 'teste',
    trailTitle: 'Trilha de teste',
    eyebrow: 'Aula de teste',
    title: 'Conclusão protegida',
    description: 'Uma aula curta para testar o bloqueio.',
    duration: '2 min',
    objective: 'responder à checagem antes de avançar',
    symbol: '✓',
    sections: <LessonSectionData>[],
    check: LessonCheckData(
      question: 'Qual alternativa você escolhe?',
      choices: <String>['Resposta incorreta', 'Resposta correta'],
      correctIndex: 1,
      explanation: 'Qualquer resposta registra a interação mínima exigida.',
    ),
    takeaways: <String>['Responder vem antes de avançar.'],
    closing: 'Fim da aula.',
  );

  testWidgets('não conclui antes da checagem e libera após qualquer resposta', (
    tester,
  ) async {
    var completions = 0;

    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('pt'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: CourseLessonScreen(
          lesson: lesson,
          actionLabel: 'Próxima aula',
          onComplete: () async {
            completions++;
          },
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Próxima aula'));
    await tester.pump();
    expect(completions, 0);

    final wrongAnswer = find.text('Resposta incorreta');
    await tester.ensureVisible(wrongAnswer);
    await tester.tap(wrongAnswer);
    await tester.pump();

    await tester.tap(find.text('Próxima aula'));
    await tester.pumpAndSettle();

    expect(completions, 1);
  });
}
