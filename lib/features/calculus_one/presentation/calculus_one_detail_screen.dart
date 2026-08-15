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
import '../../lesson/presentation/limits_lesson_screen.dart';
import '../../profile/presentation/profile_screen.dart';
import '../../statistics/presentation/statistics_screen.dart';

class CalculusOneDetailScreen extends StatelessWidget {
  const CalculusOneDetailScreen({super.key});

  void _onMenuTap(BuildContext context, int index) {
    if (index == 0) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (_) => const DashboardScreen(),
        ),
        (route) => false,
      );
      return;
    }

    if (index == 1) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (_) => const LearningPathScreen(),
        ),
        (route) => false,
      );
      return;
    }

    if (index == 2) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (_) => const StatisticsScreen(),
        ),
        (route) => false,
      );
      return;
    }

    if (index == 3) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (_) => const ProfileScreen(),
        ),
        (route) => false,
      );
    }
  }

  void _goToLimitsLesson(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const LimitsLessonScreen(),
      ),
    );
  }

  void _showContinuityMessage(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Aula de Continuidade será criada na próxima etapa.',
        ),
      ),
    );
  }

  String _moduleProgressText() {
    if (AppProgress.limitsCompleted) {
      return '33%';
    }

    return '0%';
  }

  double _moduleProgressValue() {
    if (AppProgress.limitsCompleted) {
      return 0.33;
    }

    return 0;
  }

  String _moduleProgressDescription() {
    if (AppProgress.limitsCompleted) {
      return 'Aula 1 concluída';
    }

    return 'Comece pela aula de Limites';
  }

  @override
  Widget build(BuildContext context) {
    final limitsCompleted = AppProgress.limitsCompleted;

    final limitsStatus =
        limitsCompleted ? 'Concluída' : 'Comece aqui';

    final continuityStatus =
        limitsCompleted ? 'Desbloqueada' : 'Bloqueado';

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
                'Cálculo I',
                style: AppTypography.headingMedium,
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                'Estude limites, continuidade e derivadas passo a passo.',
                style: AppTypography.bodyMedium,
              ),
              const SizedBox(height: AppSpacing.lg),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(
                  AppSpacing.cardPaddingLarge,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(
                    AppSpacing.radiusXLarge,
                  ),
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
              Text(
                'Aulas',
                style: AppTypography.titleLarge,
              ),
              const SizedBox(height: AppSpacing.sm),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.only(
                    bottom: AppSpacing.lg,
                  ),
                  children: [
                    MathCard(
                      title: 'Aula 1 — Limites',
                      subtitle:
                          'Ideia intuitiva, notação e cálculo inicial',
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
                      subtitle:
                          'Funções contínuas e pontos de descontinuidade',
                      symbol: 'C',
                      status: continuityStatus,
                      statusColor: limitsCompleted
                          ? AppColors.primary
                          : AppColors.locked,
                      state: limitsCompleted
                          ? MathCardState.normal
                          : MathCardState.locked,
                      onTap: limitsCompleted
                          ? () {
                              _showContinuityMessage(context);
                            }
                          : null,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    const MathCard(
                      title: 'Aula 3 — Derivadas',
                      subtitle:
                          'Taxa de variação e reta tangente',
                      symbol: "f'",
                      status: 'Bloqueado',
                      statusColor: AppColors.locked,
                      state: MathCardState.locked,
                      onTap: null,
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