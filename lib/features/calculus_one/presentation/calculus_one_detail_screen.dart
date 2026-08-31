import 'package:flutter/material.dart';

import 'package:calcquest/shared/state/app_progress.dart';
import 'package:calcquest/shared/theme/app_colors.dart';
import 'package:calcquest/shared/theme/app_spacing.dart';
import 'package:calcquest/shared/theme/app_typography.dart';
import 'package:calcquest/shared/widgets/app_bottom_navigation_bar.dart';
import 'package:calcquest/shared/widgets/app_progress_bar.dart';
import 'package:calcquest/shared/widgets/math_card.dart';

import '../../dashboard/presentation/dashboard_screen.dart';
import '../../learning_path/presentation/learning_path_screen.dart';
import '../../lesson/presentation/continuity_course_screen.dart';
import '../../lesson/presentation/derivatives_course_screen.dart';
import '../../lesson/presentation/limits_course_screen.dart';
import '../../profile/presentation/profile_screen.dart';
import '../../statistics/presentation/statistics_screen.dart';

class CalculusOneDetailScreen extends StatelessWidget {
  const CalculusOneDetailScreen({super.key});

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

  void _goToLimitsLesson(BuildContext context) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => const LimitsCourseScreen()));
  }

  void _goToContinuityLesson(BuildContext context) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => const ContinuityCourseScreen()));
  }

  void _goToDerivativesLesson(BuildContext context) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => const DerivativesCourseScreen()));
  }

  String _moduleProgressText() {
    if (AppProgress.derivativesCompleted) return '100%';
    if (AppProgress.continuityCompleted) return '66%';
    if (AppProgress.limitsCompleted) return '33%';
    return '0%';
  }

  double _moduleProgressValue() {
    if (AppProgress.derivativesCompleted) return 1;
    if (AppProgress.continuityCompleted) return 0.66;
    if (AppProgress.limitsCompleted) return 0.33;
    return 0;
  }

  String _moduleProgressDescription(bool isEnglish) {
    if (AppProgress.derivativesCompleted) {
      return isEnglish
          ? 'Calculus I module completed'
          : 'Módulo Cálculo I concluído';
    }

    if (AppProgress.continuityCompleted) {
      return isEnglish ? 'Lessons 1 and 2 completed' : 'Aulas 1 e 2 concluídas';
    }

    if (AppProgress.limitsCompleted) {
      return isEnglish ? 'Lesson 1 completed' : 'Aula 1 concluída';
    }

    return isEnglish ? 'Start with Limits' : 'Comece pela aula de Limites';
  }

  @override
  Widget build(BuildContext context) {
    final isEnglish = Localizations.localeOf(context).languageCode == 'en';
    final limitsCompleted = AppProgress.limitsCompleted;
    final continuityCompleted = AppProgress.continuityCompleted;
    final derivativesCompleted = AppProgress.derivativesCompleted;

    final limitsStatus = limitsCompleted
        ? (isEnglish ? 'Completed' : 'Concluída')
        : (isEnglish ? 'Start here' : 'Comece aqui');

    final continuityStatus = continuityCompleted
        ? (isEnglish ? 'Completed' : 'Concluída')
        : limitsCompleted
        ? (isEnglish ? 'Unlocked' : 'Desbloqueada')
        : (isEnglish ? 'Locked' : 'Bloqueado');

    final derivativesStatus = derivativesCompleted
        ? (isEnglish ? 'Completed' : 'Concluída')
        : continuityCompleted
        ? (isEnglish ? 'Unlocked' : 'Desbloqueada')
        : (isEnglish ? 'Locked' : 'Bloqueado');

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
              Text(
                isEnglish ? 'Calculus I' : 'Cálculo I',
                style: AppTypography.headingMedium,
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                isEnglish
                    ? 'Study limits, continuity, and derivatives step by step.'
                    : 'Estude limites, continuidade e derivadas passo a passo.',
                style: AppTypography.bodyMedium,
              ),
              const SizedBox(height: AppSpacing.lg),
              Container(
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
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isEnglish ? 'Module progress' : 'Progresso do módulo',
                      style: AppTypography.bodyMedium.copyWith(
                        color: AppColors.primaryLight,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      _moduleProgressText(),
                      style: AppTypography.displayLarge.copyWith(
                        color: AppColors.white,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    AppProgressBar(
                      value: progress,
                      state: progress >= 1
                          ? AppProgressBarState.success
                          : AppProgressBarState.normal,
                      height: 8,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      _moduleProgressDescription(isEnglish),
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.primaryLight,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(
                isEnglish ? 'Lessons' : 'Aulas',
                style: AppTypography.titleLarge,
              ),
              const SizedBox(height: AppSpacing.sm),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.only(bottom: AppSpacing.lg),
                  children: [
                    MathCard(
                      title: isEnglish ? 'Unit 1 — Limits' : 'Unidade 1 — Limites',
                      subtitle: isEnglish
                          ? '8 lessons • theory, techniques, and applications'
                          : '8 aulas • teoria, técnicas e aplicações',
                      symbol: 'lim',
                      status: limitsStatus,
                      statusColor: limitsCompleted
                          ? AppColors.success
                          : AppColors.primary,
                      state: limitsCompleted
                          ? MathCardState.completed
                          : MathCardState.normal,
                      onTap: () => _goToLimitsLesson(context),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    MathCard(
                      title: isEnglish
                          ? 'Unit 2 — Continuity'
                          : 'Unidade 2 — Continuidade',
                      subtitle: isEnglish
                          ? '7 lessons • definition, discontinuities, and applications'
                          : '7 aulas • definição, rupturas e aplicações',
                      symbol: 'C',
                      status: continuityStatus,
                      statusColor: limitsCompleted
                          ? continuityCompleted
                                ? AppColors.success
                                : AppColors.primary
                          : AppColors.locked,
                      state: limitsCompleted
                          ? continuityCompleted
                                ? MathCardState.completed
                                : MathCardState.normal
                          : MathCardState.locked,
                      onTap: limitsCompleted
                          ? () => _goToContinuityLesson(context)
                          : null,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    MathCard(
                      title: isEnglish
                          ? 'Unit 3 — Derivatives'
                          : 'Unidade 3 — Derivadas',
                      subtitle: isEnglish
                          ? '8 lessons • rules, interpretation, and applications'
                          : '8 aulas • regras, interpretação e aplicações',
                      symbol: "f'",
                      status: derivativesStatus,
                      statusColor: continuityCompleted
                          ? derivativesCompleted
                                ? AppColors.success
                                : AppColors.primary
                          : AppColors.locked,
                      state: continuityCompleted
                          ? derivativesCompleted
                                ? MathCardState.completed
                                : MathCardState.normal
                          : MathCardState.locked,
                      onTap: continuityCompleted
                          ? () => _goToDerivativesLesson(context)
                          : null,
                    ),
                  ],
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
