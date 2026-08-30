import 'package:flutter/material.dart';

import 'package:calcquest/shared/domain/course_lesson_data.dart';
import 'package:calcquest/shared/theme/app_colors.dart';
import 'package:calcquest/shared/theme/app_spacing.dart';
import 'package:calcquest/shared/theme/app_typography.dart';


class LessonHeroCard extends StatelessWidget {
  final String eyebrow;
  final String title;
  final String description;
  final String duration;
  final String objective;
  final String symbol;

  const LessonHeroCard({
    super.key,
    required this.eyebrow,
    required this.title,
    required this.description,
    required this.duration,
    required this.objective,
    required this.symbol,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      header: true,
      label: '$eyebrow. $title. $description',
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppColors.navyLight, AppColors.primaryDark],
          ),
          borderRadius: BorderRadius.circular(AppSpacing.radiusXXLarge),
          boxShadow: const [
            BoxShadow(
              color: AppColors.shadow,
              blurRadius: 18,
              offset: Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    eyebrow.toUpperCase(),
                    style: AppTypography.labelSmall.copyWith(
                      color: AppColors.secondaryLight,
                      letterSpacing: 1.1,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.sm,
                    vertical: AppSpacing.xs,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.white.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(
                      AppSpacing.radiusXLarge,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.schedule_rounded,
                        size: AppSpacing.iconSmall,
                        color: AppColors.white,
                      ),
                      const SizedBox(width: AppSpacing.xxs),
                      Text(
                        duration,
                        style: AppTypography.labelSmall.copyWith(
                          color: AppColors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 58,
                  height: 58,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.white.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(
                      AppSpacing.radiusLarge,
                    ),
                    border: Border.all(
                      color: AppColors.white.withValues(alpha: 0.18),
                    ),
                  ),
                  child: Text(
                    symbol,
                    style: AppTypography.headingSmall.copyWith(
                      color: AppColors.white,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: AppTypography.headingMedium.copyWith(
                          color: AppColors.white,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        description,
                        style: AppTypography.bodyMedium.copyWith(
                          color: AppColors.primaryLight,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: AppColors.white.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.flag_outlined,
                    size: AppSpacing.iconMedium,
                    color: AppColors.secondaryLight,
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Text(
                      'Ao final, você será capaz de $objective.',
                      style: AppTypography.bodyMedium.copyWith(
                        color: AppColors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LessonSectionHeader extends StatelessWidget {
  final String number;
  final String title;
  final String? subtitle;

  const LessonSectionHeader({
    super.key,
    required this.number,
    required this.title,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      header: true,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
            child: Text(
              number,
              style: AppTypography.labelMedium.copyWith(
                color: AppColors.white,
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTypography.titleLarge),
                if (subtitle != null) ...[
                  const SizedBox(height: AppSpacing.xxs),
                  Text(subtitle!, style: AppTypography.bodySmall),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class LessonConceptCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String content;
  final String? emphasis;
  final LearningCardTone tone;

  const LessonConceptCard({
    super.key,
    required this.icon,
    required this.title,
    required this.content,
    this.emphasis,
    this.tone = LearningCardTone.neutral,
  });

  Color get _accent {
    switch (tone) {
      case LearningCardTone.information:
        return AppColors.info;
      case LearningCardTone.success:
        return AppColors.success;
      case LearningCardTone.warning:
        return AppColors.warningDark;
      case LearningCardTone.neutral:
        return AppColors.primary;
    }
  }

  Color get _softBackground {
    switch (tone) {
      case LearningCardTone.information:
        return AppColors.infoLight;
      case LearningCardTone.success:
        return AppColors.successLight;
      case LearningCardTone.warning:
        return AppColors.warningLight;
      case LearningCardTone.neutral:
        return AppColors.selectedBackground;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AppSpacing.cardPaddingLarge),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
          border: Border.all(color: AppColors.border),
          boxShadow: const [
            BoxShadow(
              color: AppColors.shadow,
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 42,
                  height: 42,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: _softBackground,
                    borderRadius: BorderRadius.circular(
                      AppSpacing.radiusMedium,
                    ),
                  ),
                  child: Icon(icon, color: _accent),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(child: Text(title, style: AppTypography.titleMedium)),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(content, style: AppTypography.bodyLarge),
            if (emphasis != null) ...[
              const SizedBox(height: AppSpacing.sm),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(AppSpacing.sm),
                decoration: BoxDecoration(
                  color: _softBackground,
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
                  border: Border(left: BorderSide(color: _accent, width: 4)),
                ),
                child: Text(
                  emphasis!,
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class WorkedExampleCard extends StatelessWidget {
  final String title;
  final String problem;
  final List<String> steps;
  final String result;
  final String interpretation;

  const WorkedExampleCard({
    super.key,
    required this.title,
    required this.problem,
    required this.steps,
    required this.result,
    required this.interpretation,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      label: 'Exemplo resolvido: $title',
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          color: AppColors.navyLight,
          borderRadius: BorderRadius.circular(AppSpacing.radiusXXLarge),
          boxShadow: const [
            BoxShadow(
              color: AppColors.shadow,
              blurRadius: 16,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'EXEMPLO RESOLVIDO',
              style: AppTypography.labelSmall.copyWith(
                color: AppColors.secondaryLight,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              title,
              style: AppTypography.titleLarge.copyWith(color: AppColors.white),
            ),
            const SizedBox(height: AppSpacing.md),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: AppColors.white.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
              ),
              child: Text(
                problem,
                textAlign: TextAlign.center,
                style: AppTypography.headingSmall.copyWith(
                  color: AppColors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            for (var index = 0; index < steps.length; index++) ...[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 26,
                    height: 26,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '${index + 1}',
                      style: AppTypography.labelSmall.copyWith(
                        color: AppColors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Text(
                        steps[index],
                        style: AppTypography.bodyMedium.copyWith(
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              if (index < steps.length - 1)
                const SizedBox(height: AppSpacing.sm),
            ],
            const SizedBox(height: AppSpacing.md),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: AppColors.successLight,
                borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
              ),
              child: Text(
                result,
                style: AppTypography.titleMedium.copyWith(
                  color: AppColors.successDark,
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              interpretation,
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.primaryLight,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LessonCheckCard extends StatefulWidget {
  final String question;
  final List<String> choices;
  final int correctIndex;
  final String explanation;

  const LessonCheckCard({
    super.key,
    required this.question,
    required this.choices,
    required this.correctIndex,
    required this.explanation,
  });

  @override
  State<LessonCheckCard> createState() => _LessonCheckCardState();
}

class _LessonCheckCardState extends State<LessonCheckCard> {
  int? _selectedIndex;

  bool get _answered => _selectedIndex != null;
  bool get _isCorrect => _selectedIndex == widget.correctIndex;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      label: 'Cheque seu entendimento',
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AppSpacing.cardPaddingLarge),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
          border: Border.all(
            color: _answered
                ? (_isCorrect ? AppColors.success : AppColors.warning)
                : AppColors.border,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.psychology_alt_outlined,
                  color: AppColors.primary,
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(
                    'Cheque seu entendimento',
                    style: AppTypography.titleMedium,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(widget.question, style: AppTypography.bodyLarge),
            const SizedBox(height: AppSpacing.md),
            for (var index = 0; index < widget.choices.length; index++) ...[
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: _answered
                      ? null
                      : () => setState(() => _selectedIndex = index),
                  style: OutlinedButton.styleFrom(
                    alignment: Alignment.centerLeft,
                    foregroundColor: AppColors.textPrimary,
                    disabledForegroundColor: AppColors.textPrimary,
                    backgroundColor: _choiceBackground(index),
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                      vertical: AppSpacing.sm,
                    ),
                    side: BorderSide(color: _choiceBorder(index)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        AppSpacing.radiusMedium,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          widget.choices[index],
                          style: AppTypography.bodyMedium,
                        ),
                      ),
                      if (_answered && index == widget.correctIndex)
                        const Icon(
                          Icons.check_circle_rounded,
                          color: AppColors.success,
                        )
                      else if (_answered && _selectedIndex == index)
                        const Icon(
                          Icons.info_rounded,
                          color: AppColors.warningDark,
                        ),
                    ],
                  ),
                ),
              ),
              if (index < widget.choices.length - 1)
                const SizedBox(height: AppSpacing.xs),
            ],
            if (_answered) ...[
              const SizedBox(height: AppSpacing.md),
              Semantics(
                liveRegion: true,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(AppSpacing.sm),
                  decoration: BoxDecoration(
                    color: _isCorrect
                        ? AppColors.successLight
                        : AppColors.warningLight,
                    borderRadius: BorderRadius.circular(
                      AppSpacing.radiusMedium,
                    ),
                  ),
                  child: Text(
                    _isCorrect
                        ? 'Muito bem! ${widget.explanation}'
                        : 'Quase! ${widget.explanation}',
                    style: AppTypography.bodyMedium.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton.icon(
                  onPressed: () => setState(() => _selectedIndex = null),
                  icon: const Icon(Icons.refresh_rounded),
                  label: const Text('Responder novamente'),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Color _choiceBorder(int index) {
    if (!_answered) {
      return _selectedIndex == index ? AppColors.primary : AppColors.border;
    }
    if (index == widget.correctIndex) return AppColors.success;
    if (_selectedIndex == index) return AppColors.warning;
    return AppColors.border;
  }

  Color _choiceBackground(int index) {
    if (!_answered) {
      return _selectedIndex == index
          ? AppColors.selectedBackground
          : AppColors.surface;
    }
    if (index == widget.correctIndex) return AppColors.successLight;
    if (_selectedIndex == index) return AppColors.warningLight;
    return AppColors.surface;
  }
}

class LessonTakeawaysCard extends StatelessWidget {
  final List<String> items;

  const LessonTakeawaysCard({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.cardPaddingLarge),
      decoration: BoxDecoration(
        color: AppColors.selectedBackground,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
        border: Border.all(color: AppColors.primaryLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Antes de praticar, leve isto com você:',
            style: AppTypography.titleMedium,
          ),
          const SizedBox(height: AppSpacing.sm),
          for (var index = 0; index < items.length; index++) ...[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 2),
                  child: Icon(
                    Icons.check_circle_outline_rounded,
                    size: AppSpacing.iconMedium,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(items[index], style: AppTypography.bodyMedium),
                ),
              ],
            ),
            if (index < items.length - 1)
              const SizedBox(height: AppSpacing.xs),
          ],
        ],
      ),
    );
  }
}
