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
import '../../lesson/presentation/continuity_lesson_screen.dart';
import '../../lesson/presentation/derivatives_lesson_screen.dart';
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
    ).push(MaterialPageRoute(builder: (_) => const ContinuityLessonScreen()));
  }

  void _goToDerivativesLesson(BuildContext context) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => const DerivativesLessonScreen()));
  }

  String _moduleProgressText() {
    if (AppProgress.derivativesCompleted) {
      return '100%';
    }

    if (AppProgress.continuityCompleted) {
      return '66%';
    }

    if (AppProgress.limitsCompleted) {
      return '33%';
    }

    return '0%';
  }

  double _moduleProgressValue() {
    if (AppProgress.derivativesCompleted) {
      return 1;
    }

    if (AppProgress.continuityCompleted) {
      return 0.66;
    }

    if (AppProgress.limitsCompleted) {
      return 0.33;
    }

    return 0;
  }

  String _moduleProgressDescription() {
    if (AppProgress.derivativesCompleted) {
      return 'Módulo Cálculo I concluído';
    }

    if (AppProgress.continuityCompleted) {
      return 'Aulas 1 e 2 concluídas';
    }

    if (AppProgress.limitsCompleted) {
      return 'Aula 1 concluída';
    }

    return 'Comece pela aula de Limites';
  }

  @override
  Widget build(BuildContext context) {
    final limitsCompleted = AppProgress.limitsCompleted;
    final continuityCompleted = AppProgress.continuityCompleted;
    final derivativesCompleted = AppProgress.derivativesCompleted;

    final limitsStatus = limitsCompleted ? 'Concluída' : 'Comece aqui';

    final continuityStatus = continuityCompleted
        ? 'Concluída'
        : limitsCompleted
        ? 'Desbloqueada'
        : 'Bloqueado';

    final derivativesStatus = derivativesCompleted
        ? 'Concluída'
        : continuityCompleted
        ? 'Desbloqueada'
        : 'Bloqueado';

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
              Text('Cálculo I', style: AppTypography.headingMedium),
              const SizedBox(height: AppSpacing.xs),
              Text(
                'Estude limites, continuidade e derivadas passo a passo.',
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
                      'Progresso do módulo',
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
                      _moduleProgressDescription(),
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.primaryLight,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              Text('Aulas', style: AppTypography.titleLarge),
              const SizedBox(height: AppSpacing.sm),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.only(bottom: AppSpacing.lg),
                  children: [
                    MathCard(
                      title: 'Unidade 1 — Limites',
                      subtitle: '7 aulas • teoria, técnicas e aplicações',
                      symbol: 'lim',
                      status: limitsStatus,
                      statusColor: limitsCompleted
                          ? AppColors.success
                          : AppColors.primary,
                      state: limitsCompleted
                          ? MathCardState.completed
                          : MathCardState.normal,
                      onTap: () {
                        _goToLimitsLesson(context);
                      },
                    ),
                    const SizedBox(height: AppSpacing.md),
                    MathCard(
                      title: 'Aula 2 — Continuidade',
                      subtitle: 'Funções contínuas e pontos de descontinuidade',
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
                          ? () {
                              _goToContinuityLesson(context);
                            }
                          : null,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    MathCard(
                      title: 'Aula 3 — Derivadas',
                      subtitle: 'Taxa de variação e reta tangente',
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
                          ? () {
                              _goToDerivativesLesson(context);
                            }
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
        onTap: (index) {
          _onMenuTap(context, index);
        },
      ),
    );
  }
}
