import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:calcquest/shared/state/app_progress.dart';
import 'package:calcquest/shared/theme/app_colors.dart';
import 'package:calcquest/shared/theme/app_spacing.dart';
import 'package:calcquest/shared/theme/app_typography.dart';
import 'package:calcquest/shared/widgets/app_bottom_navigation_bar.dart';
import 'package:calcquest/shared/widgets/app_icon.dart';
import 'package:calcquest/shared/widgets/app_progress_bar.dart';
import 'package:calcquest/shared/widgets/primary_button.dart';

import '../../learning_path/presentation/learning_path_screen.dart';
import '../../profile/presentation/profile_screen.dart';
import '../../statistics/presentation/statistics_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  static const int _availableLessonCount = 5;

  void _onMenuTap(BuildContext context, int index) {
    if (index == 0) {
      return;
    }

    if (index == 1) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const LearningPathScreen()),
      );
      return;
    }

    if (index == 2) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const StatisticsScreen()),
      );
      return;
    }

    if (index == 3) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const ProfileScreen()),
      );
    }
  }

  String _firstName() {
    final user = FirebaseAuth.instance.currentUser;
    final displayName = user?.displayName?.trim();

    if (displayName != null && displayName.isNotEmpty) {
      return displayName.split(RegExp(r'\s+')).first;
    }

    final email = user?.email?.trim();

    if (email != null && email.isNotEmpty) {
      return email.split('@').first;
    }

    return 'Estudante';
  }

  int _levelFromXp(int xp) {
    return (xp ~/ 250) + 1;
  }

  double _progressValue() {
    final completedLessons = AppProgress.completedLessonIds.length;

    final value = completedLessons / _availableLessonCount;

    return value.clamp(0.0, 1.0).toDouble();
  }

  String _progressText(double progress) {
    return '${(progress * 100).round()}%';
  }

  String _lastLesson() {
    if (AppProgress.continuityCompleted) {
      return 'Continuidade concluída';
    }

    if (AppProgress.limitsCompleted) {
      return 'Limites concluído';
    }

    if (AppProgress.functionsCompleted) {
      return 'Fundamentos Matemáticos concluído';
    }

    if (AppProgress.equationsAndInequationsCompleted) {
      return 'Equações e Inequações concluída';
    }

    if (AppProgress.algebraFundamentalCompleted) {
      return 'Álgebra Fundamental concluída';
    }

    return 'Comece sua primeira aula';
  }

  String _nextMission() {
    if (AppProgress.continuityCompleted) {
      return 'Próxima etapa: estudar Derivadas.';
    }

    if (AppProgress.limitsCompleted) {
      return 'Próxima etapa: estudar Continuidade.';
    }

    if (AppProgress.functionsCompleted) {
      return 'Inicie Cálculo I com a aula de Limites.';
    }

    if (AppProgress.equationsAndInequationsCompleted) {
      return 'Continue com Aula 3 — Funções.';
    }

    if (AppProgress.algebraFundamentalCompleted) {
      return 'Continue com Equações e Inequações.';
    }

    return 'Avance na trilha de Fundamentos Matemáticos.';
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.cardPadding),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
          border: Border.all(color: AppColors.border),
          boxShadow: const [
            BoxShadow(
              color: AppColors.shadow,
              blurRadius: 12,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          children: [
            AppIcon(
              icon: icon,
              size: AppIconSize.large,
              color: AppColors.primary,
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(value, style: AppTypography.titleLarge),
            const SizedBox(height: AppSpacing.xxs),
            Text(
              title,
              textAlign: TextAlign.center,
              style: AppTypography.bodySmall,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: AppProgress.revision,
      builder: (context, revision, child) {
        final xp = AppProgress.totalXp;
        final gold = AppProgress.totalGold;
        final level = _levelFromXp(xp);
        final progress = _progressValue();
        final progressCompleted = progress >= 1;

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
                    'Olá, ${_firstName()}',
                    style: AppTypography.headingMedium,
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    'Continue sua jornada no Cálculo.',
                    style: AppTypography.bodyMedium,
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(AppSpacing.cardPaddingLarge),
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Progresso atual',
                          style: AppTypography.bodyMedium.copyWith(
                            color: AppColors.primaryLight,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          _progressText(progress),
                          style: AppTypography.displayLarge.copyWith(
                            color: AppColors.white,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        AppProgressBar(
                          value: progress,
                          state: progressCompleted
                              ? AppProgressBarState.success
                              : AppProgressBarState.normal,
                          height: 8,
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        Text(
                          _lastLesson(),
                          style: AppTypography.bodySmall.copyWith(
                            color: AppColors.primaryLight,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Row(
                    children: [
                      _buildInfoCard(
                        icon: Icons.military_tech_outlined,
                        title: 'Nível',
                        value: '$level',
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      _buildInfoCard(
                        icon: Icons.bolt_outlined,
                        title: 'XP',
                        value: '$xp',
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      _buildInfoCard(
                        icon: Icons.monetization_on_outlined,
                        title: 'Ouro',
                        value: '$gold',
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(AppSpacing.cardPaddingLarge),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(
                        AppSpacing.radiusLarge,
                      ),
                      border: Border.all(color: AppColors.border),
                      boxShadow: const [
                        BoxShadow(
                          color: AppColors.shadow,
                          blurRadius: 12,
                          offset: Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: AppColors.selectedBackground,
                            borderRadius: BorderRadius.circular(
                              AppSpacing.radiusMedium,
                            ),
                          ),
                          child: Text(
                            'f(x)',
                            style: AppTypography.headingSmall.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Próxima missão',
                                style: AppTypography.titleMedium,
                              ),
                              const SizedBox(height: AppSpacing.xxs),
                              Text(
                                _nextMission(),
                                style: AppTypography.bodySmall,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  PrimaryButton(
                    text: 'Continuar trilha',
                    icon: Icons.arrow_forward_rounded,
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (_) => const LearningPathScreen(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: AppSpacing.screenBottom),
                ],
              ),
            ),
          ),
          bottomNavigationBar: AppBottomNavigationBar(
            currentIndex: 0,
            onTap: (index) {
              _onMenuTap(context, index);
            },
          ),
        );
      },
    );
  }
}
