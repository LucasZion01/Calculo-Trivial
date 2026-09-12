import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('histórico do teste final é persistido localmente e no Firestore', () {
    final progress = File('lib/shared/state/app_progress.dart').readAsStringSync();
    final rules = File('firestore.rules').readAsStringSync();

    expect(progress, contains('_lastFinalTestSessionKey'));
    expect(progress, contains('_lastFinalTestSessionIds'));
    expect(progress, contains('selectFinalTestQuestionIds'));
    expect(progress, contains("'lastFinalTestSessionIds'"));
    expect(rules, contains("'lastFinalTestSessionIds'"));
    expect(
      rules,
      contains('validQuestionSessions(data.lastFinalTestSessionIds)'),
    );
  });

  test('os seis testes finais usam o serviço seguro compartilhado', () {
    const files = <String>[
      'algebra_final_test_screen.dart',
      'equations_final_test_screen.dart',
      'functions_final_test_screen.dart',
      'limits_final_test_screen.dart',
      'continuity_final_test_screen.dart',
      'derivatives_final_test_screen.dart',
    ];

    final startPattern = RegExp(r'_finalTestService\.start[A-Za-z]+FinalTest\(');
    final submitPattern = RegExp(r'_finalTestService\.submit[A-Za-z]+FinalTest\(');

    for (final file in files) {
      final source = File(
        'lib/features/exercises/presentation/$file',
      ).readAsStringSync();

      expect(
        source,
        contains('FinalTestService'),
        reason: '$file deve usar o serviço seguro compartilhado.',
      );
      expect(
        source,
        matches(startPattern),
        reason: '$file deve iniciar o teste final pelo backend confiável.',
      );
      expect(
        source,
        matches(submitPattern),
        reason: '$file deve enviar o teste final pelo backend confiável.',
      );
      expect(
        source,
        isNot(contains('FinalTestSessionBuilder.build(')),
        reason: '$file não deve voltar ao construtor local antigo.',
      );
      expect(
        source,
        isNot(contains('final unseen =')),
        reason: '$file não deve manter o seletor local antigo.',
      );
    }
  });
}
