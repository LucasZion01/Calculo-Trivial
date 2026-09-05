import 'package:flutter/material.dart';

import 'package:calcquest/shared/theme/app_colors.dart';
import 'package:calcquest/shared/theme/app_spacing.dart';
import 'package:calcquest/shared/theme/app_typography.dart';

class GuidedFactoringPracticeCard extends StatefulWidget {
  final bool isEnglish;

  const GuidedFactoringPracticeCard({
    super.key,
    required this.isEnglish,
  });

  @override
  State<GuidedFactoringPracticeCard> createState() =>
      _GuidedFactoringPracticeCardState();
}

class _GuidedFactoringPracticeCardState
    extends State<GuidedFactoringPracticeCard> {
  int? _selectedIndex;

  static const _correctIndex = 1;

  List<String> get _choices => widget.isEnglish
      ? const [
          '(x − 4)(x + 1)',
          '(x − 4)(x + 4)',
          '(x − 2)(x + 2)',
        ]
      : const [
          '(x − 4)(x + 1)',
          '(x − 4)(x + 4)',
          '(x − 2)(x + 2)',
        ];

  @override
  Widget build(BuildContext context) {
    final answered = _selectedIndex != null;
    final isCorrect = _selectedIndex == _correctIndex;

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
            widget.isEnglish ? 'GUIDED PRACTICE' : 'PRÁTICA GUIADA',
            style: AppTypography.labelSmall.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            widget.isEnglish
                ? 'Complete the missing factoring step'
                : 'Complete a etapa de fatoração que falta',
            style: AppTypography.titleMedium,
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            widget.isEnglish
                ? 'Consider lim x→4 (x² − 16)/(x − 4). Direct substitution gives 0/0. Before simplifying, how should the numerator be factored?'
                : 'Considere lim x→4 (x² − 16)/(x − 4). A substituição direta produz 0/0. Antes de simplificar, como o numerador deve ser fatorado?',
            style: AppTypography.bodyMedium,
          ),
          const SizedBox(height: AppSpacing.md),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppSpacing.cardPadding),
            decoration: BoxDecoration(
              color: AppColors.surfaceSecondary,
              borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
            ),
            child: Text(
              widget.isEnglish
                  ? 'Already given: recognize 0/0 → factor the numerator → simplify the common factor → substitute again.'
                  : 'Já fornecido: reconheça 0/0 → fatore o numerador → simplifique o fator comum → substitua novamente.',
              style: AppTypography.bodyMedium,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          for (var index = 0; index < _choices.length; index++) ...[
            _ChoiceTile(
              text: _choices[index],
              selected: _selectedIndex == index,
              enabled: !answered,
              onTap: () => setState(() => _selectedIndex = index),
            ),
            if (index < _choices.length - 1)
              const SizedBox(height: AppSpacing.sm),
          ],
          if (answered) ...[
            const SizedBox(height: AppSpacing.md),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppSpacing.cardPadding),
              decoration: BoxDecoration(
                color: isCorrect
                    ? AppColors.successLight
                    : AppColors.errorLight,
                borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
              ),
              child: Text(
                isCorrect
                    ? (widget.isEnglish
                        ? 'Correct. x² − 16 is a difference of squares: (x − 4)(x + 4). The factor x − 4 can then be simplified for x ≠ 4.'
                        : 'Correto. x² − 16 é uma diferença de quadrados: (x − 4)(x + 4). Depois, o fator x − 4 pode ser simplificado para x ≠ 4.')
                    : (widget.isEnglish
                        ? 'Review the difference-of-squares pattern a² − b² = (a − b)(a + b). Here, 16 = 4².'
                        : 'Revise o padrão da diferença de quadrados a² − b² = (a − b)(a + b). Aqui, 16 = 4².'),
                style: AppTypography.bodyMedium.copyWith(
                  color: isCorrect ? AppColors.successDark : AppColors.error,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _ChoiceTile extends StatelessWidget {
  final String text;
  final bool selected;
  final bool enabled;
  final VoidCallback onTap;

  const _ChoiceTile({
    required this.text,
    required this.selected,
    required this.enabled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: enabled ? onTap : null,
      borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AppSpacing.cardPadding),
        decoration: BoxDecoration(
          color: selected ? AppColors.selectedBackground : AppColors.background,
          borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
          border: Border.all(
            color: selected ? AppColors.primary : AppColors.border,
          ),
        ),
        child: Text(text, style: AppTypography.bodyMedium),
      ),
    );
  }
}
