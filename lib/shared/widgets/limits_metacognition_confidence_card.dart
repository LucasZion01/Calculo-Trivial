import 'package:flutter/material.dart';

import 'package:calcquest/shared/theme/app_colors.dart';
import 'package:calcquest/shared/theme/app_spacing.dart';
import 'package:calcquest/shared/theme/app_typography.dart';

class LimitsMetacognitionConfidenceCard extends StatefulWidget {
  final bool isEnglish;

  const LimitsMetacognitionConfidenceCard({
    super.key,
    required this.isEnglish,
  });

  @override
  State<LimitsMetacognitionConfidenceCard> createState() =>
      _LimitsMetacognitionConfidenceCardState();
}

class _LimitsMetacognitionConfidenceCardState
    extends State<LimitsMetacognitionConfidenceCard> {
  int? _confidenceIndex;
  int? _strategyIndex;

  bool get _isCorrect => _strategyIndex == 2;

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
            isEnglish ? 'Check your confidence' : 'Cheque sua confiança',
            style: AppTypography.titleMedium.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            isEnglish
                ? 'Before answering, estimate how confident you are that you can choose the right strategy.'
                : 'Antes de responder, estime o quanto você confia que consegue escolher a estratégia adequada.',
            style: AppTypography.bodyMedium,
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            'lim x→4 (√x − 2)/(x − 4)',
            style: AppTypography.bodyMedium.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            isEnglish ? 'How confident are you?' : 'Qual é sua confiança?',
            style: AppTypography.bodyMedium.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Wrap(
            spacing: AppSpacing.xs,
            runSpacing: AppSpacing.xs,
            children: [
              _ConfidenceChip(
                label: isEnglish ? 'Low' : 'Baixa',
                selected: _confidenceIndex == 0,
                onPressed: () => setState(() {
                  _confidenceIndex = 0;
                  _strategyIndex = null;
                }),
              ),
              _ConfidenceChip(
                label: isEnglish ? 'Medium' : 'Média',
                selected: _confidenceIndex == 1,
                onPressed: () => setState(() {
                  _confidenceIndex = 1;
                  _strategyIndex = null;
                }),
              ),
              _ConfidenceChip(
                label: isEnglish ? 'High' : 'Alta',
                selected: _confidenceIndex == 2,
                onPressed: () => setState(() {
                  _confidenceIndex = 2;
                  _strategyIndex = null;
                }),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            isEnglish
                ? 'Which strategy should you try first after seeing 0/0?'
                : 'Qual estratégia você deve tentar primeiro após obter 0/0?',
            style: AppTypography.bodyMedium.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          _ChoiceButton(
            label: isEnglish ? 'Direct substitution again' : 'Substituição direta novamente',
            enabled: _confidenceIndex != null,
            selected: _strategyIndex == 0,
            onPressed: () => setState(() => _strategyIndex = 0),
          ),
          const SizedBox(height: AppSpacing.xs),
          _ChoiceButton(
            label: isEnglish ? 'Polynomial factorization' : 'Fatoração polinomial',
            enabled: _confidenceIndex != null,
            selected: _strategyIndex == 1,
            onPressed: () => setState(() => _strategyIndex = 1),
          ),
          const SizedBox(height: AppSpacing.xs),
          _ChoiceButton(
            label: isEnglish ? 'Rationalize with the conjugate' : 'Racionalizar com o conjugado',
            enabled: _confidenceIndex != null,
            selected: _strategyIndex == 2,
            onPressed: () => setState(() => _strategyIndex = 2),
          ),
          if (_strategyIndex != null) ...[
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
                _feedback(isEnglish),
                style: AppTypography.bodyMedium,
              ),
            ),
          ],
          const SizedBox(height: AppSpacing.sm),
          Text(
            isEnglish
                ? 'Confidence is a prediction, not a grade. Use the comparison between confidence and result to improve your self-assessment.'
                : 'Confiança é uma previsão, não uma nota. Use a comparação entre confiança e resultado para melhorar sua autoavaliação.',
            style: AppTypography.bodySmall,
          ),
        ],
      ),
    );
  }

  String _feedback(bool isEnglish) {
    if (_isCorrect) {
      if (_confidenceIndex == 0) {
        return isEnglish
            ? 'Correct. Your result was stronger than your initial confidence. Notice the useful cue: a radical producing 0/0 often suggests testing the conjugate.'
            : 'Correto. Seu resultado foi melhor que sua confiança inicial. Observe a pista útil: quando um radical produz 0/0, vale testar o conjugado.';
      }

      if (_confidenceIndex == 2) {
        return isEnglish
            ? 'Correct and well calibrated. Your high confidence matched this result. Keep basing confidence on mathematical cues, not familiarity alone.'
            : 'Correto e bem calibrado. Sua confiança alta combinou com este resultado. Continue baseando a confiança em pistas matemáticas, não apenas em familiaridade.';
      }

      return isEnglish
          ? 'Correct. Your confidence and result are reasonably aligned. The radical and the 0/0 form are the key cues for choosing the conjugate.'
          : 'Correto. Sua confiança e o resultado estão razoavelmente alinhados. O radical e a forma 0/0 são as pistas centrais para escolher o conjugado.';
    }

    if (_confidenceIndex == 2) {
      return isEnglish
          ? 'Your confidence was high, but this attempt was not correct. Recheck which visible feature of the expression should guide the strategy choice before increasing confidence.'
          : 'Sua confiança estava alta, mas esta tentativa não foi correta. Reavalie qual característica visível da expressão deve orientar a escolha da estratégia antes de aumentar a confiança.';
    }

    return isEnglish
        ? 'This attempt was not correct. Compare the expression with the strategies you know and identify the cue that distinguishes a radical case from a polynomial factorization case.'
        : 'Esta tentativa não foi correta. Compare a expressão com as estratégias que você conhece e identifique a pista que diferencia um caso com radical de um caso de fatoração polinomial.';
  }
}

class _ConfidenceChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onPressed;

  const _ConfidenceChip({
    required this.label,
    required this.selected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(label),
      selected: selected,
      onSelected: (_) => onPressed(),
    );
  }
}

class _ChoiceButton extends StatelessWidget {
  final String label;
  final bool enabled;
  final bool selected;
  final VoidCallback onPressed;

  const _ChoiceButton({
    required this.label,
    required this.enabled,
    required this.selected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: enabled ? onPressed : null,
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
