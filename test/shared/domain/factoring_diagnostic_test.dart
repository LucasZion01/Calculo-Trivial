import 'package:flutter_test/flutter_test.dart';

import 'package:calcquest/shared/domain/factoring_diagnostic.dart';

void main() {
  test('sinaliza possível lacuna de pré-requisito com até um acerto', () {
    final result = evaluateFactoringDiagnostic([true, false, false]);

    expect(result.correctAnswers, 1);
    expect(result.totalQuestions, 3);
    expect(result.outcome, FactoringDiagnosticOutcome.prerequisiteSignal);
  });

  test('mantém evidência mista com dois acertos', () {
    final result = evaluateFactoringDiagnostic([true, true, false]);

    expect(result.outcome, FactoringDiagnosticOutcome.mixedEvidence);
  });

  test('não inventa causa quando os três pré-requisitos estão corretos', () {
    final result = evaluateFactoringDiagnostic([true, true, true]);

    expect(result.outcome, FactoringDiagnosticOutcome.inconclusive);
  });

  test('amostra incompleta também é inconclusiva', () {
    final result = evaluateFactoringDiagnostic([false, false]);

    expect(result.outcome, FactoringDiagnosticOutcome.inconclusive);
  });
}
