import 'package:flutter/material.dart';

import 'package:calcquest/shared/domain/factoring_diagnostic.dart';
import 'package:calcquest/shared/theme/app_colors.dart';
import 'package:calcquest/shared/theme/app_spacing.dart';
import 'package:calcquest/shared/theme/app_typography.dart';
import 'package:calcquest/shared/widgets/primary_button.dart';

class FactoringPrerequisiteMicrolessonScreen extends StatelessWidget {
  final List<FactoringPrerequisite> prerequisites;

  const FactoringPrerequisiteMicrolessonScreen({
    super.key,
    required this.prerequisites,
  });

  @override
  Widget build(BuildContext context) {
    final isEnglish =
        Localizations.localeOf(context).languageCode.toLowerCase() == 'en';

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: Text(isEnglish ? 'Prerequisite review' : 'Revisão de pré-requisitos'),
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
              isEnglish ? 'Quick prerequisite lesson' : 'Microlição de pré-requisito',
              style: AppTypography.headingMedium,
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              isEnglish
                  ? 'Review only the points suggested by the short diagnostic. This lesson does not change your score or progress.'
                  : 'Revise somente os pontos sugeridos pelo diagnóstico curto. Esta microlição não altera sua nota nem seu progresso.',
              style: AppTypography.bodyMedium,
            ),
            const SizedBox(height: AppSpacing.lg),
            for (final prerequisite in prerequisites) ...[
              _PrerequisiteLessonCard(
                prerequisite: prerequisite,
                isEnglish: isEnglish,
              ),
              const SizedBox(height: AppSpacing.md),
            ],
            _EquivalentQuestionCard(isEnglish: isEnglish),
            const SizedBox(height: AppSpacing.md),
            Text(
              isEnglish
                  ? 'The equivalent question checks whether you can apply the reviewed idea in a new example. It still does not change your score or progress.'
                  : 'A questão equivalente verifica se você consegue aplicar a ideia revisada em um novo exemplo. Ela também não altera sua nota nem seu progresso.',
              style: AppTypography.bodySmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.lg),
            PrimaryButton(
              text: isEnglish ? 'Back to diagnostic' : 'Voltar ao diagnóstico',
              icon: Icons.arrow_back_rounded,
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );
  }
}

class _EquivalentQuestionCard extends StatefulWidget {
  final bool isEnglish;

  const _EquivalentQuestionCard({required this.isEnglish});

  @override
  State<_EquivalentQuestionCard> createState() => _EquivalentQuestionCardState();
}

class _EquivalentQuestionCardState extends State<_EquivalentQuestionCard> {
  int? _selectedIndex;

  bool get _answered => _selectedIndex != null;
  bool get _isCorrect => _selectedIndex == 2;

  @override
  Widget build(BuildContext context) {
    final choices = widget.isEnglish
        ? const ['0', '5', '10']
        : const ['0', '5', '10'];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.cardPaddingLarge),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
        border: Border.all(color: AppColors.primary),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.isEnglish ? 'Equivalent question' : 'Questão equivalente',
            style: AppTypography.titleMedium.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            widget.isEnglish
                ? 'Evaluate: lim x→5 (x² − 25)/(x − 5)'
                : 'Calcule: lim x→5 (x² − 25)/(x − 5)',
            style: AppTypography.bodyLarge,
          ),
          const SizedBox(height: AppSpacing.sm),
          for (var index = 0; index < choices.length; index++) ...[
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: _answered
                    ? null
                    : () => setState(() => _selectedIndex = index),
                style: OutlinedButton.styleFrom(
                  alignment: Alignment.centerLeft,
                  foregroundColor: AppColors.textPrimary,
                  disabledForegroundColor: AppColors.textPrimary,
                  backgroundColor: _choiceBackground(index),
                  side: BorderSide(color: _choiceBorder(index)),
                ),
                child: Text(choices[index]),
              ),
            ),
            if (index < choices.length - 1)
              const SizedBox(height: AppSpacing.xs),
          ],
          if (_answered) ...[
            const SizedBox(height: AppSpacing.sm),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppSpacing.sm),
              decoration: BoxDecoration(
                color: _isCorrect
                    ? AppColors.successLight
                    : AppColors.warningLight,
                borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
              ),
              child: Text(
                _isCorrect
                    ? (widget.isEnglish
                        ? 'Correct. Factor x² − 25 = (x − 5)(x + 5), cancel the common factor for x ≠ 5, and evaluate x + 5 at 5: 10.'
                        : 'Correto. Fatore x² − 25 = (x − 5)(x + 5), cancele o fator comum para x ≠ 5 e avalie x + 5 em 5: 10.')
                    : (widget.isEnglish
                        ? 'Review the same sequence: 0/0 is indeterminate, factor the difference of squares, cancel the common factor, then evaluate again.'
                        : 'Retome a mesma sequência: 0/0 é indeterminado, fatore a diferença de quadrados, cancele o fator comum e só depois avalie novamente.'),
                style: AppTypography.bodyMedium,
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                onPressed: () => setState(() => _selectedIndex = null),
                icon: const Icon(Icons.refresh_rounded),
                label: Text(widget.isEnglish ? 'Try again' : 'Tentar novamente'),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Color _choiceBorder(int index) {
    if (!_answered) return AppColors.border;
    if (index == 2) return AppColors.success;
    if (_selectedIndex == index) return AppColors.warning;
    return AppColors.border;
  }

  Color _choiceBackground(int index) {
    if (!_answered) return AppColors.surface;
    if (index == 2) return AppColors.successLight;
    if (_selectedIndex == index) return AppColors.warningLight;
    return AppColors.surface;
  }
}

class _PrerequisiteLessonCard extends StatelessWidget {
  final FactoringPrerequisite prerequisite;
  final bool isEnglish;

  const _PrerequisiteLessonCard({
    required this.prerequisite,
    required this.isEnglish,
  });

  @override
  Widget build(BuildContext context) {
    final content = _content(prerequisite, isEnglish);

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
            content.title,
            style: AppTypography.titleMedium.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(content.explanation, style: AppTypography.bodyMedium),
          const SizedBox(height: AppSpacing.sm),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppSpacing.sm),
            decoration: BoxDecoration(
              color: AppColors.selectedBackground,
              borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
            ),
            child: Text(content.example, style: AppTypography.bodyMedium),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            content.checkpoint,
            style: AppTypography.bodySmall.copyWith(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

class _PrerequisiteLessonContent {
  final String title;
  final String explanation;
  final String example;
  final String checkpoint;

  const _PrerequisiteLessonContent({
    required this.title,
    required this.explanation,
    required this.example,
    required this.checkpoint,
  });
}

_PrerequisiteLessonContent _content(
  FactoringPrerequisite prerequisite,
  bool isEnglish,
) {
  return switch (prerequisite) {
    FactoringPrerequisite.differenceOfSquares => isEnglish
        ? const _PrerequisiteLessonContent(
            title: 'Difference of squares',
            explanation:
                'When an expression has the form a² − b², it factors as (a − b)(a + b). Recognizing this pattern can expose a factor that cancels in an algebraic limit.',
            example: 'x² − 9 = x² − 3² = (x − 3)(x + 3).',
            checkpoint: 'Checkpoint: identify the two squares before multiplying anything.',
          )
        : const _PrerequisiteLessonContent(
            title: 'Diferença de quadrados',
            explanation:
                'Quando uma expressão tem a forma a² − b², ela pode ser fatorada como (a − b)(a + b). Reconhecer esse padrão pode revelar um fator que será cancelado em um limite algébrico.',
            example: 'x² − 9 = x² − 3² = (x − 3)(x + 3).',
            checkpoint: 'Cheque: identifique os dois quadrados antes de multiplicar qualquer coisa.',
          ),
    FactoringPrerequisite.commonFactorCancellation => isEnglish
        ? const _PrerequisiteLessonContent(
            title: 'Cancel common factors, not terms',
            explanation:
                'Cancellation is valid only for a common multiplicative factor. First factor the expression; then cancel the identical factor, respecting the original restriction.',
            example:
                '(x − 3)(x + 3)/(x − 3) = x + 3, for x ≠ 3.',
            checkpoint: 'Checkpoint: ask whether the repeated expression is multiplying the whole numerator and denominator.',
          )
        : const _PrerequisiteLessonContent(
            title: 'Cancele fatores comuns, não termos',
            explanation:
                'O cancelamento só é válido para um fator multiplicativo comum. Primeiro fatore a expressão; depois cancele o fator idêntico, preservando a restrição original.',
            example:
                '(x − 3)(x + 3)/(x − 3) = x + 3, para x ≠ 3.',
            checkpoint: 'Cheque: confirme se a expressão repetida multiplica todo o numerador e o denominador.',
          ),
    FactoringPrerequisite.indeterminateFormInterpretation => isEnglish
        ? const _PrerequisiteLessonContent(
            title: '0/0 is a signal to transform the expression',
            explanation:
                'Obtaining 0/0 by direct substitution does not mean the limit is zero or nonexistent. It is an indeterminate form that tells you to transform the expression before evaluating the limit again.',
            example:
                'If direct substitution gives 0/0, try factoring, simplifying, rationalizing, or another valid transformation.',
            checkpoint: 'Checkpoint: treat 0/0 as a diagnostic signal, not as the final answer.',
          )
        : const _PrerequisiteLessonContent(
            title: '0/0 é um sinal para transformar a expressão',
            explanation:
                'Obter 0/0 por substituição direta não significa que o limite seja zero nem que não exista. É uma forma indeterminada que indica a necessidade de transformar a expressão antes de avaliar novamente.',
            example:
                'Se a substituição direta produz 0/0, tente fatorar, simplificar, racionalizar ou aplicar outra transformação válida.',
            checkpoint: 'Cheque: trate 0/0 como sinal de análise, não como resposta final.',
          ),
  };
}
