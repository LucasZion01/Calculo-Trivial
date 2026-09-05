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

  test('os seis testes finais usam o seletor persistente compartilhado', () {
    const files = <String>[
      'algebra_final_test_screen.dart',
      'equations_final_test_screen.dart',
      'functions_final_test_screen.dart',
      'limits_final_test_screen.dart',
      'continuity_final_test_screen.dart',
      'derivatives_final_test_screen.dart',
    ];

    for (final file in files) {
      final source = File(
        'lib/features/exercises/presentation/$file',
      ).readAsStringSync();

      expect(
        source,
        contains('FinalTestSessionBuilder.build('),
        reason: '$file deve usar o histórico persistente do teste final.',
      );
      expect(
        source,
        isNot(contains('final unseen =')),
        reason: '$file não deve manter o seletor local antigo.',
      );
    }
  });
}
