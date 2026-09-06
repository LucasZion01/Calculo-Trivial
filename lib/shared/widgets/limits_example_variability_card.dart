import 'package:flutter/material.dart';

import 'package:calcquest/shared/theme/app_colors.dart';
import 'package:calcquest/shared/theme/app_spacing.dart';
import 'package:calcquest/shared/theme/app_typography.dart';

class LimitsExampleVariabilityCard extends StatefulWidget {
  final bool isEnglish;

  const LimitsExampleVariabilityCard({
    super.key,
    required this.isEnglish,
  });

  @override
  State<LimitsExampleVariabilityCard> createState() =>
      _LimitsExampleVariabilityCardState();
}

class _LimitsExampleVariabilityCardState
    extends State<LimitsExampleVariabilityCard> {
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
            isEnglish ? 'Vary the example, keep the structure' : 'Mude o exemplo, preserve a estrutura',
            style: AppTypography.titleMedium.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            isEnglish
                ? 'The numbers and signs can change while the same mathematical structure remains. Compare these limits before answering.'
                : 'Os números e os sinais podem mudar sem alterar a estrutura matemática central. Compare estes limites antes de responder.',
            style: AppTypography.bodyMedium,
          ),
          const SizedBox(height: AppSpacing.md),
          const _ExampleTile(
            label: 'A',
            expression: 'lim x→3 (x² − 9)/(x − 3)',
          ),
          const SizedBox(height: AppSpacing.xs),
          const _ExampleTile(
            label: 'B',
            expression: 'lim x→−2 (x² − 4)/(x + 2)',
          ),
          const SizedBox(height: AppSpacing.xs),
          const _ExampleTile(
            label: 'C',
            expression: 'lim x→2 (x² + 1)',
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            isEnglish
                ? 'Which pair has the same useful factorization structure?'
                : 'Qual par possui a mesma estrutura útil de fatoração?',
            style: AppTypography.bodyMedium.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: AppSpacing.xs),
          _ChoiceButton(
            label: 'A e B',
            selected: _selectedIndex == 0,
            onPressed: () => setState(() => _selectedIndex = 0),
          ),
          const SizedBox(height: AppSpacing.xs),
          _ChoiceButton(
            label: 'A e C',
            selected: _selectedIndex == 1,
            onPressed: () => setState(() => _selectedIndex = 1),
          ),
          const SizedBox(height: AppSpacing.xs),
          _ChoiceButton(
            label: 'B e C',
            selected: _selectedIndex == 2,
            onPressed: () => setState(() => _selectedIndex = 2),
          ),
          if (_selectedIndex != null) ...[
            const SizedBox(height: AppSpacing.sm),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppSpacing.sm),
              decoration: BoxDecoration(
                color: _selectedIndex == 0
                    ? AppColors.successLight
                    : AppColors.warningLight,
                borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
              ),
              child: Text(
                _selectedIndex == 0
                    ? (isEnglish
                        ? 'Correct. A and B both produce 0/0 by direct substitution and both use a difference of squares to expose the denominator as a common factor. The target value and sign changed, but the deep structure stayed the same.'
                        : 'Correto. A e B produzem 0/0 por substituição direta e usam diferença de quadrados para revelar no numerador o mesmo fator do denominador. O ponto de aproximação e o sinal mudaram, mas a estrutura profunda permaneceu a mesma.')
                    : (isEnglish
                        ? 'Compare the structure, not only the numbers. C can be evaluated directly at x = 2, so it does not require the same factorization step as A and B.'
                        : 'Compare a estrutura, não apenas os números. C pode ser avaliado diretamente em x = 2, portanto não exige a mesma etapa de fatoração de A e B.'),
                style: AppTypography.bodyMedium,
              ),
            ),
          ],
          const SizedBox(height: AppSpacing.sm),
          Text(
            isEnglish
                ? 'This activity develops recognition across varied examples and does not change score or progress.'
                : 'Esta atividade treina o reconhecimento em exemplos variados e não altera nota nem progresso.',
            style: AppTypography.bodySmall,
          ),
        ],
      ),
    );
  }
}

class _ExampleTile extends StatelessWidget {
  final String label;
  final String expression;

  const _ExampleTile({required this.label, required this.expression});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.selectedBackground,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label. ',
            style: AppTypography.bodyMedium.copyWith(fontWeight: FontWeight.w700),
          ),
          Expanded(child: Text(expression, style: AppTypography.bodyMedium)),
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
          backgroundColor:
              selected ? AppColors.selectedBackground : AppColors.surface,
          side: BorderSide(
            color: selected ? AppColors.primary : AppColors.border,
          ),
        ),
        child: Text(label),
      ),
    );
  }
}
