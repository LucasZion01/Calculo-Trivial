import 'package:flutter/material.dart';

import 'package:calcquest/shared/services/premium_access_guard.dart';
import 'package:calcquest/shared/state/app_progress.dart';
import 'package:calcquest/shared/theme/app_colors.dart';
import 'package:calcquest/shared/theme/app_spacing.dart';
import 'package:calcquest/shared/theme/app_typography.dart';
import 'package:calcquest/shared/widgets/app_bottom_navigation_bar.dart';
import 'package:calcquest/shared/widgets/app_icon.dart';
import 'package:calcquest/shared/widgets/app_progress_bar.dart';

import '../../dashboard/presentation/dashboard_screen.dart';
import '../../learning_path/presentation/learning_path_screen.dart';
import '../../profile/presentation/profile_screen.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  static const int _availableLessonCount = 5;

  bool _checkingPremiumAccess = true;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _verifyPremiumAccess();
    });
  }

  Future<void> _verifyPremiumAccess() async {
    final hasAccess = await PremiumAccessGuard.ensureAccess(context);

    if (!mounted) {
      return;
    }

    if (!hasAccess) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const DashboardScreen()),
      );
      return;
    }

    setState(() {
      _checkingPremiumAccess = false;
    });
  }

  void _onMenuTap(BuildContext context, int index) {
    if (index == 0) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const DashboardScreen()),
      );
      return;
    }

    if (index == 1) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const LearningPathScreen()),
      );
      return;
    }

    if (index == 2) {
      return;
    }

    if (index == 3) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const ProfileScreen()),
      );
    }
  }

  int _levelFromXp(int xp) {
    return (xp ~/ 250) + 1;
  }

  int _completedLessons() {
    return AppProgress.completedLessonIds.length
        .clamp(0, _availableLessonCount)
        .toInt();
  }

  double _progressValue() {
    return (_completedLessons() / _availableLessonCount)
        .clamp(0.0, 1.0)
        .toDouble();
  }

  String _progressDescription(int completedLessons) {
    if (completedLessons == 0) {
      return 'Conclua sua primeira aula para iniciar suas estatísticas.';
    }

    if (completedLessons >= _availableLessonCount) {
      return 'Você concluiu todo o conteúdo disponível nesta versão.';
    }

    final remaining = _availableLessonCount - completedLessons;

    final lessonWord = remaining == 1 ? 'aula restante' : 'aulas restantes';

    return '$remaining $lessonWord no conteúdo atual.';
  }

  Widget _buildSmallStatCard({
    required IconData icon,
    required String value,
    required String label,
    required Color iconColor,
    required Color iconBackground,
  }) {
    return Container(
      width: double.infinity,
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
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: iconBackground,
              borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
            ),
            child: AppIcon(
              icon: icon,
              size: AppIconSize.medium,
              color: iconColor,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(value, style: AppTypography.headingSmall),
          const SizedBox(height: AppSpacing.xxs),
          Text(label, style: AppTypography.bodySmall),
        ],
      ),
    );
  }

  Widget _buildLoadingScreen() {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.screenHorizontal),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator(),
                const SizedBox(height: AppSpacing.md),
                Text(
                  'Verificando acesso Premium...',
                  textAlign: TextAlign.center,
                  style: AppTypography.bodyMedium,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_checkingPremiumAccess) {
      return _buildLoadingScreen();
    }

    return ValueListenableBuilder<int>(
      valueListenable: AppProgress.revision,
      builder: (context, revision, child) {
        final xp = AppProgress.totalXp;
        final gold = AppProgress.totalGold;
        final level = _levelFromXp(xp);
        final completedLessons = _completedLessons();
        final progress = _progressValue();
        final progressPercentage = (progress * 100).round();
        final correctAnswers = AppProgress.correctAnswerAttempts;
        final incorrectAnswers = AppProgress.incorrectAnswerAttempts;
        final accuracyPercentage = (AppProgress.accuracy * 100).round();
        final studyStreak = AppProgress.studyStreak;
        final dailyAnswers = AppProgress.dailyAnsweredQuestions;
        final dailyGoal = AppProgress.dailyQuestionGoal;
        final dailyGoalProgress = AppProgress.dailyGoalProgress;
        final dailyGoalCompleted = dailyAnswers >= dailyGoal;
        final streakLabel = studyStreak == 1 ? 'dia seguido' : 'dias seguidos';

        return Scaffold(
          backgroundColor: AppColors.background,
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.screenHorizontal,
                AppSpacing.screenTop,
                AppSpacing.screenHorizontal,
                AppSpacing.screenBottom,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Estatísticas',
                    style: AppTypography.labelMedium.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text('Seu progresso', style: AppTypography.headingMedium),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    'Acompanhe sua evolução com dados reais dos seus estudos.',
                    style: AppTypography.bodyMedium,
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(AppSpacing.cardPaddingLarge),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(
                        AppSpacing.radiusXLarge,
                      ),
                      border: Border.all(color: AppColors.border),
                      boxShadow: const [
                        BoxShadow(
                          color: AppColors.shadow,
                          blurRadius: 14,
                          offset: Offset(0, 7),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 44,
                              height: 44,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: AppColors.xpLight,
                                borderRadius: BorderRadius.circular(
                                  AppSpacing.radiusMedium,
                                ),
                              ),
                              child: const AppIcon(
                                icon: Icons.bolt_outlined,
                                size: AppIconSize.large,
                                color: AppColors.xp,
                              ),
                            ),
                            const SizedBox(width: AppSpacing.sm),
                            Text('XP total', style: AppTypography.titleMedium),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.md),
                        Text('$xp XP', style: AppTypography.headingLarge),
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          'Nível $level • Continue estudando para evoluir.',
                          style: AppTypography.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: _buildSmallStatCard(
                          icon: Icons.menu_book_outlined,
                          value: '$completedLessons/$_availableLessonCount',
                          label: 'Aulas concluídas',
                          iconColor: AppColors.success,
                          iconBackground: AppColors.successLight,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: _buildSmallStatCard(
                          icon: Icons.monetization_on_outlined,
                          value: '$gold',
                          label: 'Ouro acumulado',
                          iconColor: AppColors.gold,
                          iconBackground: AppColors.goldLight,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Text('Atividade de hoje', style: AppTypography.titleLarge),
                  const SizedBox(height: AppSpacing.sm),
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
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 44,
                              height: 44,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: dailyGoalCompleted
                                    ? AppColors.successLight
                                    : AppColors.selectedBackground,
                                borderRadius: BorderRadius.circular(
                                  AppSpacing.radiusMedium,
                                ),
                              ),
                              child: AppIcon(
                                icon: dailyGoalCompleted
                                    ? Icons.task_alt_rounded
                                    : Icons.flag_outlined,
                                size: AppIconSize.large,
                                color: dailyGoalCompleted
                                    ? AppColors.success
                                    : AppColors.primary,
                              ),
                            ),
                            const SizedBox(width: AppSpacing.sm),
                            Expanded(
                              child: Text(
                                'Meta diária',
                                style: AppTypography.titleMedium,
                              ),
                            ),
                            Text(
                              '$dailyAnswers/$dailyGoal',
                              style: AppTypography.titleLarge,
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.md),
                        AppProgressBar(
                          value: dailyGoalProgress,
                          state: dailyGoalCompleted
                              ? AppProgressBarState.success
                              : AppProgressBarState.normal,
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          dailyGoalCompleted
                              ? 'Meta concluída! Você respondeu $dailyAnswers questões hoje.'
                              : 'Responda ${dailyGoal - dailyAnswers} questões para concluir a meta.',
                          style: AppTypography.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  _buildSmallStatCard(
                    icon: Icons.local_fire_department_outlined,
                    value: '$studyStreak',
                    label: streakLabel,
                    iconColor: AppColors.warning,
                    iconBackground: AppColors.warningLight,
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Text('Desempenho', style: AppTypography.titleLarge),
                  const SizedBox(height: AppSpacing.sm),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: _buildSmallStatCard(
                          icon: Icons.check_circle_outline_rounded,
                          value: '$correctAnswers',
                          label: 'Acertos',
                          iconColor: AppColors.success,
                          iconBackground: AppColors.successLight,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: _buildSmallStatCard(
                          icon: Icons.cancel_outlined,
                          value: '$incorrectAnswers',
                          label: 'Erros',
                          iconColor: AppColors.error,
                          iconBackground: AppColors.errorLight,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.sm),
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
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 44,
                              height: 44,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: AppColors.selectedBackground,
                                borderRadius: BorderRadius.circular(
                                  AppSpacing.radiusMedium,
                                ),
                              ),
                              child: const AppIcon(
                                icon: Icons.analytics_outlined,
                                size: AppIconSize.large,
                                color: AppColors.primary,
                              ),
                            ),
                            const SizedBox(width: AppSpacing.sm),
                            Expanded(
                              child: Text(
                                'Precisão geral',
                                style: AppTypography.titleMedium,
                              ),
                            ),
                            Text(
                              '$accuracyPercentage%',
                              style: AppTypography.headingSmall,
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.md),
                        AppProgressBar(value: AppProgress.accuracy),
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          correctAnswers + incorrectAnswers == 0
                              ? 'Responda exercícios para calcular sua precisão.'
                              : 'Calculada com todas as respostas registradas.',
                          style: AppTypography.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Text('Conteúdo', style: AppTypography.titleLarge),
                  const SizedBox(height: AppSpacing.sm),
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
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 44,
                              height: 44,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: AppColors.successLight,
                                borderRadius: BorderRadius.circular(
                                  AppSpacing.radiusMedium,
                                ),
                              ),
                              child: const AppIcon(
                                icon: Icons.check_circle_outline_rounded,
                                size: AppIconSize.large,
                                color: AppColors.success,
                              ),
                            ),
                            const SizedBox(width: AppSpacing.sm),
                            Expanded(
                              child: Text(
                                'Conteúdo concluído',
                                style: AppTypography.titleMedium,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.md),
                        Text(
                          '$progressPercentage%',
                          style: AppTypography.headingLarge,
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        AppProgressBar(
                          value: progress,
                          state: progress >= 1
                              ? AppProgressBarState.success
                              : AppProgressBarState.normal,
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          _progressDescription(completedLessons),
                          style: AppTypography.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: AppBottomNavigationBar(
            currentIndex: 2,
            onTap: (index) {
              _onMenuTap(context, index);
            },
          ),
        );
      },
    );
  }
}
