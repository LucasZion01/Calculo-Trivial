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
            Text(
              isEnglish
                  ? 'After reviewing, return to the diagnostic. An equivalent question will be added in the next pedagogical step.'
                  : 'Depois da revisão, volte ao diagnóstico. Uma questão equivalente será adicionada na próxima etapa pedagógica.',
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
