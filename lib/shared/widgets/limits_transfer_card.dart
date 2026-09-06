import 'package:flutter/material.dart';

import 'package:calcquest/shared/theme/app_colors.dart';
import 'package:calcquest/shared/theme/app_spacing.dart';
import 'package:calcquest/shared/theme/app_typography.dart';

class LimitsTransferCard extends StatefulWidget {
  final bool isEnglish;

  const LimitsTransferCard({
    super.key,
    required this.isEnglish,
  });

  @override
  State<LimitsTransferCard> createState() => _LimitsTransferCardState();
}

class _LimitsTransferCardState extends State<LimitsTransferCard> {
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
            isEnglish ? 'Apply it in a new context' : 'Aplique em um novo contexto',
            style: AppTypography.titleMedium.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            isEnglish
                ? 'An engineering model uses G(u) = (u² − 25)/(u − 5), for u ≠ 5. To estimate the behavior of G near u = 5, which reasoning transfers from the limit lessons?'
                : 'Um modelo de engenharia usa G(u) = (u² − 25)/(u − 5), para u ≠ 5. Para estimar o comportamento de G perto de u = 5, qual raciocínio aprendido em limites deve ser transferido para este contexto?',
            style: AppTypography.bodyMedium,
          ),
          const SizedBox(height: AppSpacing.md),
          _ChoiceButton(
            label: isEnglish
                ? 'Conclude that G approaches zero because direct substitution gives 0/0.'
                : 'Concluir que G se aproxima de zero porque a substituição direta produz 0/0.',
            selected: _selectedIndex == 0,
            onPressed: () => setState(() => _selectedIndex = 0),
          ),
          const SizedBox(height: AppSpacing.xs),
          _ChoiceButton(
            label: isEnglish
                ? 'Factor u² − 25, cancel the common factor for u ≠ 5, and analyze the equivalent expression near 5.'
                : 'Fatorar u² − 25, cancelar o fator comum para u ≠ 5 e analisar a expressão equivalente perto de 5.',
            selected: _selectedIndex == 1,
            onPressed: () => setState(() => _selectedIndex = 1),
          ),
          const SizedBox(height: AppSpacing.xs),
          _ChoiceButton(
            label: isEnglish
                ? 'Use the conjugate because every indeterminate form requires rationalization.'
                : 'Usar o conjugado porque toda forma indeterminada exige racionalização.',
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
                        ? 'Correct. The context changed, but the mathematical structure did not. The transferable cue is the difference of squares together with a removable common factor.'
                        : 'Correto. O contexto mudou, mas a estrutura matemática não. A pista transferível é a diferença de quadrados combinada com um fator comum removível.')
                    : (isEnglish
                        ? 'Focus on the mathematical structure rather than the story. Direct substitution diagnoses 0/0, and rationalization is mainly useful when radicals create the obstacle.'
                        : 'Concentre-se na estrutura matemática, não apenas no contexto. A substituição direta diagnostica 0/0, e a racionalização é útil principalmente quando radicais criam o obstáculo.'),
                style: AppTypography.bodyMedium,
              ),
            ),
          ],
          const SizedBox(height: AppSpacing.sm),
          Text(
            isEnglish
                ? 'This activity checks transfer to a new context and does not change score or progress.'
                : 'Esta atividade verifica transferência para um novo contexto e não altera nota nem progresso.',
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
