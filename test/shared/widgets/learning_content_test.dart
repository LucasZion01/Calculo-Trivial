import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:calcquest/l10n/app_localizations.dart';
import 'package:calcquest/shared/localization/lesson_ui_text.dart';
import 'package:calcquest/shared/widgets/learning_content.dart';

void main() {
  testWidgets('cartão de checagem explica erro e permite nova tentativa', (
    tester,
  ) async {
    const locale = Locale('pt');
    final uiText = LessonUiText.forLocale(locale);

    await tester.pumpWidget(
      const MaterialApp(
        locale: locale,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: SingleChildScrollView(
            child: LessonCheckCard(
              question: 'O que significa 0/0 em um limite?',
              choices: [
                'O limite é zero.',
                'A expressão precisa de nova análise.',
              ],
              correctIndex: 1,
              explanation: 'A forma 0/0 é indeterminada.',
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text(uiText.checkUnderstanding), findsOneWidget);

    await tester.tap(find.text('O limite é zero.'));
    await tester.pump();

    expect(find.textContaining(uiText.almostPrefix), findsOneWidget);
    expect(find.textContaining('indeterminada'), findsOneWidget);

    await tester.tap(find.text(uiText.answerAgain));
    await tester.pump();

    await tester.tap(find.text('A expressão precisa de nova análise.'));
    await tester.pump();

    expect(find.textContaining(uiText.correctPrefix), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('cabeçalho de aula apresenta objetivo e duração', (tester) async {
    const locale = Locale('pt');
    final uiText = LessonUiText.forLocale(locale);

    await tester.pumpWidget(
      const MaterialApp(
        locale: locale,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: LessonHeroCard(
            eyebrow: 'Aula 1',
            title: 'Limites',
            description: 'Entenda aproximações.',
            duration: '10 min',
            objective: 'interpretar um limite',
            symbol: 'lim',
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Limites'), findsOneWidget);
    expect(find.text('10 min'), findsOneWidget);
    expect(
      find.text(uiText.objective('interpretar um limite')),
      findsOneWidget,
    );
    expect(tester.takeException(), isNull);
  });
}
