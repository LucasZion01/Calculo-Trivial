enum FactoringDiagnosticOutcome {
  prerequisiteSignal,
  mixedEvidence,
  inconclusive,
}

class FactoringDiagnosticResult {
  final int correctAnswers;
  final int totalQuestions;
  final FactoringDiagnosticOutcome outcome;

  const FactoringDiagnosticResult({
    required this.correctAnswers,
    required this.totalQuestions,
    required this.outcome,
  });
}

FactoringDiagnosticResult evaluateFactoringDiagnostic(
  Iterable<bool> answers,
) {
  final values = answers.toList(growable: false);
  final correctAnswers = values.where((answer) => answer).length;

  final outcome = switch ((correctAnswers, values.length)) {
    (_, < 3) => FactoringDiagnosticOutcome.inconclusive,
    (0 || 1, _) => FactoringDiagnosticOutcome.prerequisiteSignal,
    (2, _) => FactoringDiagnosticOutcome.mixedEvidence,
    _ => FactoringDiagnosticOutcome.inconclusive,
  };

  return FactoringDiagnosticResult(
    correctAnswers: correctAnswers,
    totalQuestions: values.length,
    outcome: outcome,
  );
}
