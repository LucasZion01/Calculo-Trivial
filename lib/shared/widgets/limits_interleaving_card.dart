import 'package:flutter/material.dart';

import 'package:calcquest/shared/theme/app_colors.dart';
import 'package:calcquest/shared/theme/app_spacing.dart';
import 'package:calcquest/shared/theme/app_typography.dart';

class LimitsInterleavingCard extends StatefulWidget {
  final bool isEnglish;

  const LimitsInterleavingCard({
    super.key,
    required this.isEnglish,
  });

  @override
  State<LimitsInterleavingCard> createState() => _LimitsInterleavingCardState();
}

class _LimitsInterleavingCardState extends State<LimitsInterleavingCard> {
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
            isEnglish ? 'Choose the strategy' : 'Escolha a estratégia',
            style: AppTypography.titleMedium.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            isEnglish
                ? 'Mixing different problem types helps you practice deciding what to do, not only repeating one method.'
                : 'Misturar tipos diferentes de problema ajuda a treinar a decisão sobre o que fazer, não apenas repetir um método.',
            style: AppTypography.bodyMedium,
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            isEnglish
                ? 'For lim x→9 (√x − 3)/(x − 9), which strategy is the best next step?'
                : 'Para lim x→9 (√x − 3)/(x − 9), qual é a melhor estratégia para o próximo passo?',
            style: AppTypography.bodyLarge.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: AppSpacing.sm),
          _ChoiceButton(
            label: isEnglish ? 'Direct substitution and stop' : 'Substituição direta e encerrar',
            selected: _selectedIndex == 0,
            onPressed: () => setState(() => _selectedIndex = 0),
          ),
          const SizedBox(height: AppSpacing.xs),
          _ChoiceButton(
            label: isEnglish ? 'Factor a difference of squares' : 'Fatorar uma diferença de quadrados',
            selected: _selectedIndex == 1,
            onPressed: () => setState(() => _selectedIndex = 1),
          ),
          const SizedBox(height: AppSpacing.xs),
          _ChoiceButton(
            label: isEnglish ? 'Rationalize with the conjugate' : 'Racionalizar com o conjugado',
            selected: _selectedIndex == 2,
            onPressed: () => setState(() => _selectedIndex = 2),
          ),
          if (_selectedIndex != null) ...[
            const SizedBox(height: AppSpacing.sm),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppSpacing.sm),
              decoration: BoxDecoration(
                color: _selectedIndex == 2
                    ? AppColors.successLight
                    : AppColors.warningLight,
                borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
              ),
              child: Text(
                _selectedIndex == 2
                    ? (isEnglish
                        ? 'Correct. Direct substitution exposes 0/0, but the radical points to the conjugate. Rationalizing transforms the numerator and reveals a factor related to x − 9.'
                        : 'Correto. A substituição direta revela 0/0, mas a presença da raiz aponta para o conjugado. A racionalização transforma o numerador e revela um fator relacionado a x − 9.')
                    : (isEnglish
                        ? 'Use the form of the expression to choose the method. A radical difference usually suggests the conjugate, while polynomial differences may suggest factoring.'
                        : 'Use a forma da expressão para escolher o método. Uma diferença com raiz costuma sugerir o conjugado, enquanto diferenças polinomiais podem sugerir fatoração.'),
                style: AppTypography.bodyMedium,
              ),
            ),
          ],
          const SizedBox(height: AppSpacing.sm),
          Text(
            isEnglish
                ? 'This mixed practice is for learning only and does not change score or progress.'
                : 'Esta prática intercalada serve apenas para aprendizagem e não altera nota nem progresso.',
            style: AppTypography.bodySmall,
          ),
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
