import 'package:flutter_test/flutter_test.dart';

import 'package:calcquest/shared/domain/factoring_diagnostic.dart';

void main() {
  test('sinaliza possível lacuna e preserva quais pré-requisitos falharam', () {
    final result = evaluateFactoringDiagnostic([true, false, false]);

    expect(result.correctAnswers, 1);
    expect(result.totalQuestions, 3);
    expect(result.outcome, FactoringDiagnosticOutcome.prerequisiteSignal);
    expect(
      result.prerequisitesToReview,
      [
        FactoringPrerequisite.commonFactorCancellation,
        FactoringPrerequisite.indeterminateFormInterpretation,
      ],
    );
  });

  test('evidência mista aponta somente o pré-requisito não confirmado', () {
    final result = evaluateFactoringDiagnostic([true, true, false]);

    expect(result.outcome, FactoringDiagnosticOutcome.mixedEvidence);
    expect(
      result.prerequisitesToReview,
      [FactoringPrerequisite.indeterminateFormInterpretation],
    );
  });

  test('não inventa causa quando os três pré-requisitos estão corretos', () {
    final result = evaluateFactoringDiagnostic([true, true, true]);

    expect(result.outcome, FactoringDiagnosticOutcome.inconclusive);
    expect(result.prerequisitesToReview, isEmpty);
  });

  test('amostra incompleta não atribui pré-requisito específico', () {
    final result = evaluateFactoringDiagnostic([false, false]);

    expect(result.outcome, FactoringDiagnosticOutcome.inconclusive);
    expect(result.prerequisitesToReview, isEmpty);
  });
}
