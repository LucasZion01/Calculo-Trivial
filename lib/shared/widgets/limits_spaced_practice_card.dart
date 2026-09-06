import 'package:flutter/material.dart';

import 'package:calcquest/shared/services/limits_spaced_practice_tracker.dart';
import 'package:calcquest/shared/theme/app_colors.dart';
import 'package:calcquest/shared/theme/app_spacing.dart';
import 'package:calcquest/shared/theme/app_typography.dart';

class LimitsSpacedPracticeCard extends StatefulWidget {
  final bool isEnglish;

  const LimitsSpacedPracticeCard({
    super.key,
    required this.isEnglish,
  });

  @override
  State<LimitsSpacedPracticeCard> createState() =>
      _LimitsSpacedPracticeCardState();
}

class _LimitsSpacedPracticeCardState extends State<LimitsSpacedPracticeCard> {
  LimitsSpacedPracticeState? _state;
  int? _selectedIndex;
  bool _loading = true;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final state = await LimitsSpacedPracticeTracker.loadOrCreate();
    if (!mounted) return;
    setState(() {
      _state = state;
      _loading = false;
    });
  }

  Future<void> _answer(int index) async {
    if (_saving) return;

    setState(() => _selectedIndex = index);

    if (index != 2) return;

    setState(() => _saving = true);
    final next = await LimitsSpacedPracticeTracker.completeReview();
    if (!mounted) return;
    setState(() {
      _state = next;
      _saving = false;
    });
  }

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
      child: _loading
          ? const Center(child: CircularProgressIndicator())
          : _buildContent(isEnglish),
    );
  }

  Widget _buildContent(bool isEnglish) {
    final state = _state!;
    final now = DateTime.now();
    final due = state.isDue(now);

    if (!due) {
      final days = state.nextDueAt.difference(now).inHours <= 24
          ? 1
          : (state.nextDueAt.difference(now).inHours / 24).ceil();

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isEnglish ? 'Spaced practice' : 'Prática espaçada',
            style: AppTypography.titleMedium.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            state.stage == 0
                ? (isEnglish
                    ? 'Your first review was scheduled for tomorrow. Returning after a delay helps test what remains available without immediate repetition.'
                    : 'Sua primeira revisão foi programada para amanhã. Voltar depois de um intervalo ajuda a verificar o que permaneceu disponível sem repetição imediata.')
                : (isEnglish
                    ? 'Review completed. The next retrieval is scheduled after another interval.'
                    : 'Revisão concluída. A próxima recuperação foi programada após um novo intervalo.'),
            style: AppTypography.bodyMedium,
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            isEnglish
                ? 'Next review in about $days day${days == 1 ? '' : 's'}.'
                : 'Próxima revisão em aproximadamente $days dia${days == 1 ? '' : 's'}.',
            style: AppTypography.bodySmall.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            isEnglish
                ? 'The schedule is stored only on this device/account scope in this first version.'
                : 'Nesta primeira versão, a agenda fica armazenada apenas neste dispositivo/escopo de conta.',
            style: AppTypography.bodySmall,
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          isEnglish ? 'Spaced review due' : 'Revisão espaçada disponível',
          style: AppTypography.titleMedium.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          isEnglish
              ? 'Without reopening the worked example, evaluate: lim x→6 (x² − 36)/(x − 6)'
              : 'Sem reabrir o exemplo resolvido, calcule: lim x→6 (x² − 36)/(x − 6)',
          style: AppTypography.bodyMedium,
        ),
        const SizedBox(height: AppSpacing.sm),
        for (var index = 0; index < 3; index++) ...[
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: _saving ? null : () => _answer(index),
              style: OutlinedButton.styleFrom(
                alignment: Alignment.centerLeft,
                foregroundColor: AppColors.textPrimary,
                backgroundColor: _selectedIndex == index
                    ? AppColors.selectedBackground
                    : AppColors.surface,
                side: BorderSide(
                  color: _selectedIndex == index
                      ? AppColors.primary
                      : AppColors.border,
                ),
              ),
              child: Text(const ['0', '6', '12'][index]),
            ),
          ),
          if (index < 2) const SizedBox(height: AppSpacing.xs),
        ],
        if (_selectedIndex != null) ...[
          const SizedBox(height: AppSpacing.sm),
          Text(
            _selectedIndex == 2
                ? (isEnglish
                    ? 'Correct. The delayed retrieval succeeded; a new review interval has been scheduled.'
                    : 'Correto. A recuperação após o intervalo funcionou; um novo intervalo de revisão foi programado.')
                : (isEnglish
                    ? 'Try to recover the structure: x² − 36 is a difference of squares. Factor before evaluating again.'
                    : 'Tente recuperar a estrutura: x² − 36 é uma diferença de quadrados. Fatore antes de avaliar novamente.'),
            style: AppTypography.bodyMedium,
          ),
        ],
        const SizedBox(height: AppSpacing.xs),
        Text(
          isEnglish
              ? 'This review does not change score, XP, or course progress.'
              : 'Esta revisão não altera nota, XP nem progresso do curso.',
          style: AppTypography.bodySmall,
        ),
      ],
    );
  }
}
