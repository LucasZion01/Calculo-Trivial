import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('fontes não contêm sequências comuns de texto UTF-8 corrompido', () {
    final suspiciousSequences = <String>[
      String.fromCharCodes([0x00C3, 0x0192]),
      String.fromCharCodes([0x00E2, 0x2020]),
      String.fromCharCodes([0x00C2, 0x00B2]),
      String.fromCharCodes([0x00C3, 0x00A7]),
      String.fromCharCodes([0x00C3, 0x00A3]),
    ];

    final roots = <Directory>[Directory('lib'), Directory('functions/src')];
    final violations = <String>[];

    for (final root in roots) {
      if (!root.existsSync()) continue;

      for (final entity in root.listSync(recursive: true)) {
        if (entity is! File) continue;
        if (!entity.path.endsWith('.dart') &&
            !entity.path.endsWith('.ts')) {
          continue;
        }

        final source = entity.readAsStringSync();
        for (final sequence in suspiciousSequences) {
          if (source.contains(sequence)) {
            violations.add(
              '${entity.path} contém a sequência U+${sequence.runes.map((rune) => rune.toRadixString(16).toUpperCase()).join(' U+')}',
            );
          }
        }
      }
    }

    expect(
      violations,
      isEmpty,
      reason:
          'Foram encontradas sequências típicas de mojibake:\n${violations.join('\n')}',
    );
  });
}
