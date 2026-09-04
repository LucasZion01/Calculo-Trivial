import 'package:flutter/material.dart';

import 'package:calcquest/l10n/app_localizations.dart';
import 'package:calcquest/shared/data/mock_learning_data.dart';
import 'package:calcquest/shared/state/app_progress.dart';
import 'package:calcquest/shared/theme/app_colors.dart';
import 'package:calcquest/shared/theme/app_spacing.dart';
import 'package:calcquest/shared/theme/app_typography.dart';
import 'package:calcquest/shared/widgets/app_bottom_navigation_bar.dart';
import 'package:calcquest/shared/widgets/app_progress_bar.dart';
import 'package:calcquest/shared/widgets/math_card.dart';

import '../../dashboard/presentation/dashboard_screen.dart';
import '../../learning_path/presentation/learning_path_screen.dart';
import '../../lesson/presentation/algebra_course_screen.dart';
import '../../lesson/presentation/equations_course_screen.dart';
import '../../lesson/presentation/functions_lesson_screen.dart';
import '../../profile/presentation/profile_screen.dart';
import '../../statistics/presentation/statistics_screen.dart';

class ModuleDetailScreen extends StatelessWidget {
  const ModuleDetailScreen({super.key});

  void _onMenuTap(BuildContext context, int index) {
    if (index == 0) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const DashboardScreen()),
        (route) => false,
      );
      return;
    }

    if (index == 1) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const LearningPathScreen()),
        (route) => false,
      );
      return;
    }

    if (index == 2) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const StatisticsScreen()),
        (route) => false,
      );
      return;
    }

    if (index == 3) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const ProfileScreen()),
        (route) => false,
      );
    }
  }

  void _goToLesson(BuildContext context) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => const AlgebraCourseScreen()));
  }

  void _goToEquationsLesson(BuildContext context) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => const EquationsCourseScreen()));
  }

  void _goToFunctionsLesson(BuildContext context) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => const FunctionsLessonScreen()));
  }

  int _completedLessons() {
    int completed = 0;
    if (AppProgress.algebraFundamentalCompleted) completed++;
    if (AppProgress.equationsAndInequationsCompleted) completed++;
    if (AppProgress.functionsCompleted) completed++;
    return completed;
  }

  double _moduleProgressValue() => _completedLessons() / 3;

  String _moduleProgressDescription(AppLocalizations l10n) {
    if (AppProgress.functionsCompleted) return l10n.moduleDetailCompleted;
    if (AppProgress.equationsAndInequationsCompleted) {
      return l10n.moduleDetailLessonTwoCompleted;
    }
    if (AppProgress.algebraFundamentalCompleted) {
      return l10n.moduleDetailLessonOneCompleted;
    }
    return l10n.moduleDetailStartFirstLesson;
  }

  String _getLessonStatus(LessonData lesson, AppLocalizations l10n) {
    if (lesson.id == 'algebra-fundamental' &&
        AppProgress.algebraFundamentalCompleted) {
      return l10n.completed;
    }

    if (lesson.id == 'equacoes-inequacoes' &&
        AppProgress.equationsAndInequationsCompleted) {
      return l10n.completed;
    }

    if (lesson.id == 'equacoes-inequacoes' &&
        AppProgress.algebraFundamentalCompleted) {
      return l10n.moduleDetailLessonUnlocked;
    }

    if (lesson.id == 'funcoes' && AppProgress.functionsCompleted) {
      return l10n.completed;
    }

    if (lesson.id == 'funcoes' &&
        AppProgress.equationsAndInequationsCompleted) {
      return l10n.moduleDetailLessonUnlocked;
    }

    return lesson.isUnlocked ? l10n.available : l10n.locked;
  }

  String _lessonTitle(LessonData lesson, AppLocalizations l10n) {
    switch (lesson.id) {
      case 'algebra-fundamental':
        return l10n.moduleDetailAlgebraTitle;
      case 'equacoes-inequacoes':
        return l10n.moduleDetailEquationsTitle;
      case 'funcoes':
        return l10n.moduleDetailFunctionsTitle;
      default:
        return lesson.title;
    }
  }

  String _lessonSubtitle(LessonData lesson, AppLocalizations l10n) {
    switch (lesson.id) {
      case 'algebra-fundamental':
        return l10n.moduleDetailAlgebraSubtitle;
      case 'equacoes-inequacoes':
        return l10n.moduleDetailEquationsSubtitle;
      case 'funcoes':
        return l10n.moduleDetailFunctionsSubtitle;
      default:
        return lesson.subtitle;
    }
  }

  bool _isLessonUnlocked(LessonData lesson) {
    if (lesson.id == 'algebra-fundamental') return true;
    if (lesson.id == 'equacoes-inequacoes' &&
        AppProgress.algebraFundamentalCompleted) {
      return true;
    }
    if (lesson.id == 'funcoes' &&
        AppProgress.equationsAndInequationsCompleted) {
      return true;
    }
    return lesson.isUnlocked;
  }

  bool _isLessonCompleted(LessonData lesson) {
    if (lesson.id == 'algebra-fundamental') {
      return AppProgress.algebraFundamentalCompleted;
    }
    if (lesson.id == 'equacoes-inequacoes') {
      return AppProgress.equationsAndInequationsCompleted;
    }
    if (lesson.id == 'funcoes') return AppProgress.functionsCompleted;
    return false;
  }

  Color _getLessonStatusColor(LessonData lesson) {
    if (_isLessonCompleted(lesson)) return AppColors.success;
    if (_isLessonUnlocked(lesson)) return AppColors.primary;
    return AppColors.locked;
  }

  MathCardState _getLessonCardState(LessonData lesson) {
    if (_isLessonCompleted(lesson)) return MathCardState.completed;
    if (_isLessonUnlocked(lesson)) return MathCardState.normal;
    return MathCardState.locked;
  }

  void _handleLessonTap(BuildContext context, LessonData lesson) {
    if (lesson.id == 'algebra-fundamental') {
      _goToLesson(context);
      return;
    }

    if (lesson.id == 'equacoes-inequacoes' &&
        AppProgress.algebraFundamentalCompleted) {
      _goToEquationsLesson(context);
      return;
    }

    if (lesson.id == 'funcoes' &&
        AppProgress.equationsAndInequationsCompleted) {
      _goToFunctionsLesson(context);
    }
  }

  Widget _buildProgressCard({
    required AppLocalizations l10n,
    required double progress,
  }) {
    final completed = _completedLessons();
    final moduleCompleted = progress >= 1;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.cardPaddingLarge),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(AppSpacing.radiusXLarge),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 16,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: progress),
        duration: const Duration(milliseconds: 750),
        curve: Curves.easeOutCubic,
        builder: (context, value, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      l10n.moduleProgress,
                      style: AppTypography.bodyMedium.copyWith(
                        color: AppColors.primaryLight,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.sm,
                      vertical: AppSpacing.xs,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.white.withValues(alpha: 0.14),
                      borderRadius: BorderRadius.circular(
                        AppSpacing.radiusMedium,
                      ),
                    ),
                    child: Text(
                      '$completed/3',
                      style: AppTypography.labelMedium.copyWith(
                        color: AppColors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                '${(value * 100).round()}%',
                style: AppTypography.displayLarge.copyWith(
                  color: AppColors.white,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              AppProgressBar(
                value: value,
                state: moduleCompleted
                    ? AppProgressBarState.success
                    : AppProgressBarState.normal,
                height: 8,
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                _moduleProgressDescription(l10n),
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.primaryLight,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _animatedLessonCard({
    required BuildContext context,
    required LessonData lesson,
    required AppLocalizations l10n,
    required int index,
  }) {
    final isUnlocked = _isLessonUnlocked(lesson);

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: Duration(milliseconds: 380 + (index * 120)),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(18 * (1 - value), 0),
            child: child,
          ),
        );
      },
      child: MathCard(
        title: _lessonTitle(lesson, l10n),
        subtitle: _lessonSubtitle(lesson, l10n),
        symbol: lesson.symbol,
        status: _getLessonStatus(lesson, l10n),
        statusColor: _getLessonStatusColor(lesson),
        state: _getLessonCardState(lesson),
        onTap: isUnlocked ? () => _handleLessonTap(context, lesson) : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final module = mockModules.first;
    final progress = _moduleProgressValue();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.screenHorizontal,
            AppSpacing.screenTop,
            AppSpacing.screenHorizontal,
            0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0, end: 1),
                duration: const Duration(milliseconds: 320),
                builder: (context, value, child) {
                  return Opacity(opacity: value, child: child);
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.mathematicalFoundations,
                      style: AppTypography.headingMedium,
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      l10n.moduleDetailSubtitle,
                      style: AppTypography.bodyMedium,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              _buildProgressCard(l10n: l10n, progress: progress),
              const SizedBox(height: AppSpacing.lg),
              Row(
                children: [
                  Text(l10n.lessons, style: AppTypography.titleLarge),
                  const Spacer(),
                  Icon(
                    progress >= 1
                        ? Icons.verified_rounded
                        : Icons.route_rounded,
                    color: progress >= 1 ? AppColors.success : AppColors.primary,
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.only(bottom: AppSpacing.lg),
                  itemCount: module.lessons.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: AppSpacing.md),
                  itemBuilder: (context, index) {
                    final lesson = module.lessons[index];
                    return _animatedLessonCard(
                      context: context,
                      lesson: lesson,
                      l10n: l10n,
                      index: index,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: AppBottomNavigationBar(
        currentIndex: 1,
        onTap: (index) => _onMenuTap(context, index),
      ),
    );
  }
}
