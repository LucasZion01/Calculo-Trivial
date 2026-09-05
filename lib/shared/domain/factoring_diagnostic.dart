enum FactoringDiagnosticOutcome {
  prerequisiteSignal,
  mixedEvidence,
  inconclusive,
}

enum FactoringPrerequisite {
  differenceOfSquares,
  commonFactorCancellation,
  indeterminateFormInterpretation,
}

const factoringPrerequisites = <FactoringPrerequisite>[
  FactoringPrerequisite.differenceOfSquares,
  FactoringPrerequisite.commonFactorCancellation,
  FactoringPrerequisite.indeterminateFormInterpretation,
];

class FactoringDiagnosticResult {
  final int correctAnswers;
  final int totalQuestions;
  final FactoringDiagnosticOutcome outcome;
  final List<FactoringPrerequisite> prerequisitesToReview;

  const FactoringDiagnosticResult({
    required this.correctAnswers,
    required this.totalQuestions,
    required this.outcome,
    required this.prerequisitesToReview,
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

  final prerequisitesToReview = values.length < factoringPrerequisites.length
      ? const <FactoringPrerequisite>[]
      : <FactoringPrerequisite>[
          for (var index = 0; index < factoringPrerequisites.length; index++)
            if (!values[index]) factoringPrerequisites[index],
        ];

  return FactoringDiagnosticResult(
    correctAnswers: correctAnswers,
    totalQuestions: values.length,
    outcome: outcome,
    prerequisitesToReview: prerequisitesToReview,
  );
}
