import 'package:flutter/material.dart';

import 'package:calcquest/shared/domain/factoring_diagnostic.dart';
import 'package:calcquest/shared/theme/app_colors.dart';
import 'package:calcquest/shared/theme/app_spacing.dart';
import 'package:calcquest/shared/theme/app_typography.dart';
import 'package:calcquest/shared/widgets/primary_button.dart';

class FactoringDiagnosticScreen extends StatefulWidget {
  final String sourceSkill;

  const FactoringDiagnosticScreen({
    super.key,
    required this.sourceSkill,
  });

  @override
  State<FactoringDiagnosticScreen> createState() =>
      _FactoringDiagnosticScreenState();
}

class _DiagnosticQuestion {
  final String prompt;
  final List<String> choices;
  final int correctIndex;

  const _DiagnosticQuestion({
    required this.prompt,
    required this.choices,
    required this.correctIndex,
  });
}

class _FactoringDiagnosticScreenState extends State<FactoringDiagnosticScreen> {
  final List<int?> _answers = List<int?>.filled(3, null);
  FactoringDiagnosticResult? _result;

  bool get _isEnglish =>
      Localizations.localeOf(context).languageCode.toLowerCase() == 'en';

  List<_DiagnosticQuestion> get _questions => _isEnglish
      ? const [
          _DiagnosticQuestion(
            prompt: 'How do you factor x² − 9?',
            choices: ['(x − 3)(x + 3)', '(x − 9)(x + 1)', '(x − 3)²'],
            correctIndex: 0,
          ),
          _DiagnosticQuestion(
            prompt:
                'For x ≠ 3, what remains after simplifying (x − 3)(x + 3)/(x − 3)?',
            choices: ['x − 3', 'x + 3', '1'],
            correctIndex: 1,
          ),
          _DiagnosticQuestion(
            prompt: 'What does the form 0/0 tell you in a limit?',
            choices: [
              'The limit is zero',
              'The limit does not exist',
              'The current form is indeterminate and should be transformed',
            ],
            correctIndex: 2,
          ),
        ]
      : const [
          _DiagnosticQuestion(
            prompt: 'Como fatorar x² − 9?',
            choices: ['(x − 3)(x + 3)', '(x − 9)(x + 1)', '(x − 3)²'],
            correctIndex: 0,
          ),
          _DiagnosticQuestion(
            prompt:
                'Para x ≠ 3, o que resta ao simplificar (x − 3)(x + 3)/(x − 3)?',
            choices: ['x − 3', 'x + 3', '1'],
            correctIndex: 1,
          ),
          _DiagnosticQuestion(
            prompt: 'O que a forma 0/0 informa em um limite?',
            choices: [
              'O limite é zero',
              'O limite não existe',
              'A forma atual é indeterminada e precisa ser transformada',
            ],
            correctIndex: 2,
          ),
        ];

  bool get _canSubmit => _answers.every((answer) => answer != null);

  void _submit() {
    if (!_canSubmit) return;

    final questions = _questions;
    final correctness = <bool>[
      for (var index = 0; index < questions.length; index++)
        _answers[index] == questions[index].correctIndex,
    ];

    setState(() {
      _result = evaluateFactoringDiagnostic(correctness);
    });
  }

  String _resultTitle(FactoringDiagnosticOutcome outcome) {
    return switch (outcome) {
      FactoringDiagnosticOutcome.prerequisiteSignal => _isEnglish
          ? 'There are signs that a prerequisite deserves review'
          : 'Há indícios de que um pré-requisito merece revisão',
      FactoringDiagnosticOutcome.mixedEvidence => _isEnglish
          ? 'The evidence is mixed'
          : 'A evidência ficou mista',
      FactoringDiagnosticOutcome.inconclusive => _isEnglish
          ? 'The result is inconclusive'
          : 'O resultado é inconclusivo',
    };
  }

  String _resultBody(FactoringDiagnosticResult result) {
    return switch (result.outcome) {
      FactoringDiagnosticOutcome.prerequisiteSignal => _isEnglish
          ? 'Factoring, canceling common factors, or interpreting 0/0 may be contributing to the difficulty. Review these prerequisites before trying an equivalent limit again.'
          : 'Fatoração, cancelamento de fatores comuns ou interpretação de 0/0 podem estar contribuindo para a dificuldade. Revise esses pré-requisitos antes de tentar um limite equivalente novamente.',
      FactoringDiagnosticOutcome.mixedEvidence => _isEnglish
          ? 'Some prerequisites appear stable and another may still need review. This short check is not enough to identify a single cause with confidence.'
          : 'Alguns pré-requisitos parecem estáveis e outro ainda pode precisar de revisão. Este diagnóstico curto não é suficiente para apontar uma causa única com segurança.',
      FactoringDiagnosticOutcome.inconclusive => _isEnglish
          ? 'These prerequisite questions did not confirm a clear gap. The original difficulty may involve strategy selection, attention, or another factor not measured here.'
          : 'Estas questões de pré-requisito não confirmaram uma lacuna clara. A dificuldade original pode envolver escolha de estratégia, atenção ou outro fator que este piloto não mede.',
    };
  }

  Widget _buildQuestion(int index, _DiagnosticQuestion question) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.cardPaddingLarge),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${_isEnglish ? 'Question' : 'Questão'} ${index + 1}',
            style: AppTypography.labelMedium.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(question.prompt, style: AppTypography.titleMedium),
          const SizedBox(height: AppSpacing.sm),
          AbsorbPointer(
            absorbing: _result != null,
            child: RadioGroup<int>(
              groupValue: _answers[index],
              onChanged: (value) {
                if (_result != null) return;
                setState(() => _answers[index] = value);
              },
              child: Column(
                children: [
                  for (var choiceIndex = 0;
                      choiceIndex < question.choices.length;
                      choiceIndex++)
                    RadioListTile<int>(
                      value: choiceIndex,
                      contentPadding: EdgeInsets.zero,
                      title: Text(question.choices[choiceIndex]),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResult(FactoringDiagnosticResult result) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.cardPaddingLarge),
      decoration: BoxDecoration(
        color: AppColors.selectedBackground,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
        border: Border.all(color: AppColors.primary),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _resultTitle(result.outcome),
            style: AppTypography.titleMedium.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            '${result.correctAnswers}/${result.totalQuestions} ${_isEnglish ? 'prerequisite questions answered correctly.' : 'questões de pré-requisito respondidas corretamente.'}',
            style: AppTypography.bodyMedium,
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(_resultBody(result), style: AppTypography.bodyMedium),
          const SizedBox(height: AppSpacing.sm),
          Text(
            _isEnglish
                ? 'This is a study hypothesis, not a grade or a definitive diagnosis.'
                : 'Isto é uma hipótese de estudo, não uma nota nem um diagnóstico definitivo.',
            style: AppTypography.bodySmall,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final result = _result;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: Text(_isEnglish ? 'Check prerequisites' : 'Investigar dificuldade'),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.screenHorizontal,
            AppSpacing.md,
            AppSpacing.screenHorizontal,
            AppSpacing.lg,
          ),
          children: [
            Text(
              _isEnglish
                  ? 'Short diagnostic: factoring in limits'
                  : 'Diagnóstico curto: fatoração em limites',
              style: AppTypography.headingMedium,
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              _isEnglish
                  ? 'The recent pattern suggests reviewing “${widget.sourceSkill}”. Answer three prerequisite questions. Nothing here changes your score or progress.'
                  : 'O padrão recente sugere revisar “${widget.sourceSkill}”. Responda três questões de pré-requisito. Nada aqui altera sua nota ou progresso.',
              style: AppTypography.bodyMedium,
            ),
            const SizedBox(height: AppSpacing.lg),
            for (var index = 0; index < _questions.length; index++) ...[
              _buildQuestion(index, _questions[index]),
              const SizedBox(height: AppSpacing.md),
            ],
            if (result != null) ...[
              _buildResult(result),
              const SizedBox(height: AppSpacing.lg),
              PrimaryButton(
                text: _isEnglish ? 'Close' : 'Fechar',
                icon: Icons.close_rounded,
                onPressed: () => Navigator.of(context).pop(),
              ),
            ] else
              PrimaryButton(
                text: _isEnglish ? 'View result' : 'Ver resultado',
                icon: Icons.fact_check_outlined,
                onPressed: _canSubmit ? _submit : null,
              ),
          ],
        ),
      ),
    );
  }
}
