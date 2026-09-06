import 'package:flutter/material.dart';

import 'package:calcquest/shared/theme/app_colors.dart';
import 'package:calcquest/shared/theme/app_spacing.dart';
import 'package:calcquest/shared/theme/app_typography.dart';

class LimitsProgressiveScaffoldingCard extends StatefulWidget {
  final bool isEnglish;

  const LimitsProgressiveScaffoldingCard({
    super.key,
    required this.isEnglish,
  });

  @override
  State<LimitsProgressiveScaffoldingCard> createState() =>
      _LimitsProgressiveScaffoldingCardState();
}

class _LimitsProgressiveScaffoldingCardState
    extends State<LimitsProgressiveScaffoldingCard> {
  int _supportLevel = 0;

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
            isEnglish ? 'Progressive support' : 'Suporte progressivo',
            style: AppTypography.titleMedium.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            isEnglish
                ? 'Try to decide the next move before asking for help. Reveal only the amount of support you need.'
                : 'Tente decidir o próximo passo antes de pedir ajuda. Revele somente o nível de suporte de que precisar.',
            style: AppTypography.bodyMedium,
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            'lim x→4 (x² − 16)/(x − 4)',
            style: AppTypography.bodyLarge.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: AppSpacing.md),
          if (_supportLevel == 0)
            Text(
              isEnglish
                  ? 'What would you try first? Think before revealing a hint.'
                  : 'O que você tentaria primeiro? Pense antes de revelar uma pista.',
              style: AppTypography.bodyMedium,
            ),
          if (_supportLevel >= 1) ...[
            _SupportBox(
              title: isEnglish ? 'Hint 1' : 'Pista 1',
              body: isEnglish
                  ? 'Direct substitution gives 0/0. Treat that as a signal that the expression needs to be transformed.'
                  : 'A substituição direta produz 0/0. Trate isso como um sinal de que a expressão precisa ser transformada.',
            ),
          ],
          if (_supportLevel >= 2) ...[
            const SizedBox(height: AppSpacing.sm),
            _SupportBox(
              title: isEnglish ? 'Hint 2' : 'Pista 2',
              body: isEnglish
                  ? 'Look at x² − 16 as a difference of squares: x² − 4².'
                  : 'Observe x² − 16 como uma diferença de quadrados: x² − 4².',
            ),
          ],
          if (_supportLevel >= 3) ...[
            const SizedBox(height: AppSpacing.sm),
            _SupportBox(
              title: isEnglish ? 'Worked next step' : 'Próximo passo mostrado',
              body: isEnglish
                  ? 'Factor: x² − 16 = (x − 4)(x + 4). Then cancel the common factor for x ≠ 4 and continue on your own.'
                  : 'Fatore: x² − 16 = (x − 4)(x + 4). Depois cancele o fator comum para x ≠ 4 e continue por conta própria.',
            ),
          ],
          const SizedBox(height: AppSpacing.md),
          if (_supportLevel < 3)
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () => setState(() => _supportLevel++),
                icon: const Icon(Icons.lightbulb_outline_rounded),
                label: Text(
                  switch (_supportLevel) {
                    0 => isEnglish ? 'Reveal first hint' : 'Revelar primeira pista',
                    1 => isEnglish ? 'I need another hint' : 'Preciso de outra pista',
                    _ => isEnglish ? 'Show the next step' : 'Mostrar o próximo passo',
                  },
                ),
              ),
            ),
          if (_supportLevel == 3)
            Text(
              isEnglish
                  ? 'The support stops before the final value so you still complete the reasoning.'
                  : 'O suporte termina antes do valor final para que você ainda conclua o raciocínio.',
              style: AppTypography.bodySmall.copyWith(fontWeight: FontWeight.w600),
            ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            isEnglish
                ? 'This support is optional and does not change score or progress.'
                : 'Este suporte é opcional e não altera nota nem progresso.',
            style: AppTypography.bodySmall,
          ),
        ],
      ),
    );
  }
}

class _SupportBox extends StatelessWidget {
  final String title;
  final String body;

  const _SupportBox({required this.title, required this.body});

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
