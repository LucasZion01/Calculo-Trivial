import 'package:flutter/material.dart';

import 'package:calcquest/shared/theme/app_colors.dart';
import 'package:calcquest/shared/theme/app_spacing.dart';
import 'package:calcquest/shared/theme/app_typography.dart';

class LimitsStrategyComparisonCard extends StatefulWidget {
  final bool isEnglish;

  const LimitsStrategyComparisonCard({
    super.key,
    required this.isEnglish,
  });

  @override
  State<LimitsStrategyComparisonCard> createState() =>
      _LimitsStrategyComparisonCardState();
}

class _LimitsStrategyComparisonCardState
    extends State<LimitsStrategyComparisonCard> {
  int? _selectedIndex;

  @override
  Widget build(BuildContext context) {
    final isEnglish = widget.isEnglish;

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
            isEnglish ? 'Compare strategies' : 'Compare estratégias',
            style: AppTypography.titleMedium.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            isEnglish
                ? 'For lim x→2 (x² − 4)/(x − 2), compare the two approaches before choosing.'
                : 'Para lim x→2 (x² − 4)/(x − 2), compare as duas abordagens antes de escolher.',
            style: AppTypography.bodyMedium,
          ),
          const SizedBox(height: AppSpacing.md),
          _StrategyPanel(
            title: isEnglish ? 'Strategy A — direct substitution' : 'Estratégia A — substituição direta',
            body: isEnglish
                ? 'Substitute x = 2 immediately: (4 − 4)/(2 − 2) = 0/0. This reveals an indeterminate form, but it does not finish the problem.'
                : 'Substitua x = 2 imediatamente: (4 − 4)/(2 − 2) = 0/0. Isso revela uma forma indeterminada, mas não conclui o problema.',
          ),
          const SizedBox(height: AppSpacing.sm),
          _StrategyPanel(
            title: isEnglish ? 'Strategy B — factor first' : 'Estratégia B — fatorar primeiro',
            body: isEnglish
                ? 'Factor x² − 4 = (x − 2)(x + 2), cancel the common factor for x ≠ 2, then evaluate x + 2 at 2.'
                : 'Fatore x² − 4 = (x − 2)(x + 2), cancele o fator comum para x ≠ 2 e então avalie x + 2 em 2.',
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            isEnglish
                ? 'Which statement best compares the strategies?'
                : 'Qual afirmação compara melhor as estratégias?',
            style: AppTypography.bodyMedium.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: AppSpacing.xs),
          _ChoiceButton(
            label: isEnglish
                ? 'A is enough because 0/0 means the limit is zero.'
                : 'A é suficiente porque 0/0 significa que o limite é zero.',
            selected: _selectedIndex == 0,
            onPressed: () => setState(() => _selectedIndex = 0),
          ),
          const SizedBox(height: AppSpacing.xs),
          _ChoiceButton(
            label: isEnglish
                ? 'A diagnoses the obstacle; B is the useful next strategy because factoring removes the common factor.'
                : 'A diagnostica o obstáculo; B é a estratégia útil em seguida porque a fatoração remove o fator comum.',
            selected: _selectedIndex == 1,
            onPressed: () => setState(() => _selectedIndex = 1),
          ),
          const SizedBox(height: AppSpacing.xs),
          _ChoiceButton(
            label: isEnglish
                ? 'B is always better than direct substitution for every limit.'
                : 'B é sempre melhor que a substituição direta em qualquer limite.',
            selected: _selectedIndex == 2,
            onPressed: () => setState(() => _selectedIndex = 2),
          ),
          if (_selectedIndex != null) ...[
            const SizedBox(height: AppSpacing.sm),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppSpacing.sm),
              decoration: BoxDecoration(
                color: _selectedIndex == 1
                    ? AppColors.successLight
                    : AppColors.warningLight,
                borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
              ),
              child: Text(
                _selectedIndex == 1
                    ? (isEnglish
                        ? 'Correct. Direct substitution is useful first because it exposes 0/0. The factorization strategy is then chosen because it transforms the expression into an equivalent form that can be evaluated.'
                        : 'Correto. A substituição direta é útil primeiro porque revela 0/0. Depois, escolhemos a fatoração porque ela transforma a expressão em uma forma equivalente que pode ser avaliada.')
                    : (isEnglish
                        ? 'Review the role of each strategy: direct substitution can diagnose an indeterminate form, while factoring is useful when it exposes a removable common factor.'
                        : 'Revise o papel de cada estratégia: a substituição direta pode diagnosticar uma forma indeterminada, enquanto a fatoração é útil quando revela um fator comum removível.'),
                style: AppTypography.bodyMedium,
              ),
            ),
          ],
          const SizedBox(height: AppSpacing.sm),
          Text(
            isEnglish
                ? 'This comparison is for learning only and does not change score or progress.'
                : 'Esta comparação serve apenas para aprendizagem e não altera nota nem progresso.',
            style: AppTypography.bodySmall,
          ),
        ],
      ),
    );
  }
}

class _StrategyPanel extends StatelessWidget {
  final String title;
  final String body;

  const _StrategyPanel({required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.selectedBackground,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTypography.bodyMedium.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: AppSpacing.xxs),
          Text(body, style: AppTypography.bodyMedium),
        ],
      ),
    );
  }
}

class _ChoiceButton extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onPressed;

  const _ChoiceButton({
    required this.label,
    required this.selected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          alignment: Alignment.centerLeft,
          foregroundColor: AppColors.textPrimary,
          backgroundColor: selected ? AppColors.selectedBackground : AppColors.surface,
          side: BorderSide(color: selected ? AppColors.primary : AppColors.border),
        ),
        child: Text(label),
      ),
    );
  }
}
