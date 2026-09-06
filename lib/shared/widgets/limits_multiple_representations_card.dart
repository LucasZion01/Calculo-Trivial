import 'package:flutter/material.dart';

import 'package:calcquest/shared/theme/app_colors.dart';
import 'package:calcquest/shared/theme/app_spacing.dart';
import 'package:calcquest/shared/theme/app_typography.dart';

class LimitsMultipleRepresentationsCard extends StatefulWidget {
  final bool isEnglish;

  const LimitsMultipleRepresentationsCard({
    super.key,
    required this.isEnglish,
  });

  @override
  State<LimitsMultipleRepresentationsCard> createState() =>
      _LimitsMultipleRepresentationsCardState();
}

class _LimitsMultipleRepresentationsCardState
    extends State<LimitsMultipleRepresentationsCard> {
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
            isEnglish
                ? 'Same limit, different representations'
                : 'Mesmo limite, representações diferentes',
            style: AppTypography.titleMedium.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            isEnglish
                ? 'Connect the algebraic expression, nearby numerical values, and the behavior they describe.'
                : 'Conecte a expressão algébrica, os valores numéricos próximos e o comportamento que eles descrevem.',
            style: AppTypography.bodyMedium,
          ),
          const SizedBox(height: AppSpacing.md),
          _RepresentationPanel(
            title: isEnglish ? 'Algebraic' : 'Algébrica',
            child: Text(
              'lim x→2 (x² − 4)/(x − 2)',
              style: AppTypography.bodyMedium.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          _RepresentationPanel(
            title: isEnglish ? 'Numerical table' : 'Tabela numérica',
            child: const _LimitTable(),
          ),
          const SizedBox(height: AppSpacing.sm),
          _RepresentationPanel(
            title: isEnglish ? 'Behavior' : 'Comportamento',
            child: Text(
              isEnglish
                  ? 'As x approaches 2 from both sides, the function values approach the same number.'
                  : 'Quando x se aproxima de 2 pelos dois lados, os valores da função se aproximam do mesmo número.',
              style: AppTypography.bodyMedium,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            isEnglish
                ? 'Which conclusion is supported by all three representations?'
                : 'Qual conclusão é sustentada pelas três representações?',
            style: AppTypography.bodyMedium.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          _ChoiceButton(
            label: isEnglish
                ? 'The limit is 4, even though direct substitution gives 0/0.'
                : 'O limite é 4, embora a substituição direta produza 0/0.',
            selected: _selectedIndex == 0,
            onPressed: () => setState(() => _selectedIndex = 0),
          ),
          const SizedBox(height: AppSpacing.xs),
          _ChoiceButton(
            label: isEnglish
                ? 'The limit is 0 because the numerator and denominator both become zero.'
                : 'O limite é 0 porque numerador e denominador ficam iguais a zero.',
            selected: _selectedIndex == 1,
            onPressed: () => setState(() => _selectedIndex = 1),
          ),
          const SizedBox(height: AppSpacing.xs),
          _ChoiceButton(
            label: isEnglish
                ? 'The limit does not exist because the expression is undefined at x = 2.'
                : 'O limite não existe porque a expressão não está definida em x = 2.',
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
                        ? 'Correct. Algebraically, x² − 4 = (x − 2)(x + 2), so for x ≠ 2 the expression equals x + 2. The table approaches 4 from both sides, matching the same limiting behavior.'
                        : 'Correto. Algebricamente, x² − 4 = (x − 2)(x + 2), então para x ≠ 2 a expressão equivale a x + 2. A tabela se aproxima de 4 pelos dois lados, confirmando o mesmo comportamento do limite.')
                    : (isEnglish
                        ? 'Separate the value at x = 2 from the behavior near x = 2. The algebraic simplification and the nearby numerical values both indicate the same limiting value.'
                        : 'Separe o valor em x = 2 do comportamento próximo de x = 2. A simplificação algébrica e os valores numéricos próximos indicam o mesmo valor-limite.'),
                style: AppTypography.bodyMedium,
              ),
            ),
          ],
          const SizedBox(height: AppSpacing.sm),
          Text(
            isEnglish
                ? 'This activity connects representations and does not change score or progress.'
                : 'Esta atividade conecta representações e não altera nota nem progresso.',
            style: AppTypography.bodySmall,
          ),
        ],
      ),
    );
  }
}

class _RepresentationPanel extends StatelessWidget {
  final String title;
  final Widget child;

  const _RepresentationPanel({
    required this.title,
    required this.child,
  });

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
            style: AppTypography.labelMedium.copyWith(
              fontWeight: FontWeight.w700,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          child,
        ],
      ),
    );
  }
}

class _LimitTable extends StatelessWidget {
  const _LimitTable();

  @override
  Widget build(BuildContext context) {
    const rows = <(String, String)>[
      ('1.9', '3.9'),
      ('1.99', '3.99'),
      ('2.01', '4.01'),
      ('2.1', '4.1'),
    ];

    return Table(
      columnWidths: const <int, TableColumnWidth>{
        0: FlexColumnWidth(),
        1: FlexColumnWidth(),
      },
      children: [
        TableRow(
          children: [
            Text(
              'x',
              style: AppTypography.labelMedium.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              'f(x)',
              style: AppTypography.labelMedium.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        for (final row in rows)
          TableRow(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: AppSpacing.xs),
                child: Text(row.$1, style: AppTypography.bodySmall),
              ),
              Padding(
                padding: const EdgeInsets.only(top: AppSpacing.xs),
                child: Text(row.$2, style: AppTypography.bodySmall),
              ),
            ],
          ),
      ],
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
