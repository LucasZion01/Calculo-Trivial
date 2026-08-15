import 'package:flutter/material.dart';

import 'package:calcquest/shared/state/app_progress.dart';
import 'package:calcquest/shared/theme/app_colors.dart';
import 'package:calcquest/shared/theme/app_spacing.dart';
import 'package:calcquest/shared/theme/app_typography.dart';
import 'package:calcquest/shared/widgets/app_bottom_navigation_bar.dart';
import 'package:calcquest/shared/widgets/app_icon.dart';
import 'package:calcquest/shared/widgets/primary_button.dart';

import '../../dashboard/presentation/dashboard_screen.dart';
import '../../learning_path/presentation/learning_path_screen.dart';
import '../../profile/presentation/profile_screen.dart';
import '../../statistics/presentation/statistics_screen.dart';

class RewardScreen extends StatefulWidget {
  final String completedLessonId;
  final int xpEarned;
  final int goldEarned;

  const RewardScreen({
    super.key,
    this.completedLessonId = 'algebra-fundamental',
    this.xpEarned = 60,
    this.goldEarned = 25,
  });

  @override
  State<RewardScreen> createState() => _RewardScreenState();
}

class _RewardScreenState extends State<RewardScreen> {
  @override
  void initState() {
    super.initState();
    _saveProgress();
  }

  Future<void> _saveProgress() async {
    if (widget.completedLessonId == 'limites') {
      await AppProgress.completeLimits();
      return;
    }

    if (widget.completedLessonId == 'funcoes') {
      await AppProgress.completeFunctions();
      return;
    }

    if (widget.completedLessonId == 'equacoes-inequacoes') {
      await AppProgress.completeEquationsAndInequations();
      return;
    }

    await AppProgress.completeAlgebraFundamental();
  }

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

  void _backToLearningPath(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (_) => const LearningPathScreen(),
      ),
      (route) => false,
    );
  }

  String get _rewardDescription {
    if (widget.completedLessonId == 'limites') {
      return 'Você concluiu a sequência universitária de Limites.';
    }

    if (widget.completedLessonId == 'funcoes') {
      return 'Você concluiu a sequência de Funções e finalizou o módulo Fundamentos Matemáticos.';
    }

    if (widget.completedLessonId == 'equacoes-inequacoes') {
      return 'Você concluiu a sequência de Equações e Inequações.';
    }

    return 'Você concluiu a sequência de Álgebra Fundamental.';
  }

  String get _progressText {
    if (widget.completedLessonId == 'funcoes') {
      return 'Módulo concluído';
    }

    return 'Aula concluída';
  }

  Widget _buildRewardItem({
    required IconData icon,
    required String title,
    required String value,
    required Color iconColor,
    required Color iconBackground,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(
        AppSpacing.cardPaddingLarge,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(
          AppSpacing.radiusLarge,
        ),
        border: Border.all(
          color: AppColors.border,
        ),
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
              color: iconBackground,
              borderRadius: BorderRadius.circular(
                AppSpacing.radiusMedium,
              ),
            ),
            child: AppIcon(
              icon: icon,
              size: AppIconSize.large,
              color: iconColor,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              title,
              style: AppTypography.bodyMedium,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Text(
            value,
            style: AppTypography.titleLarge,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: AppSpacing.sm),

              Container(
                width: 96,
                height: 96,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.achievementLight,
                  borderRadius: BorderRadius.circular(
                    AppSpacing.radiusXLarge,
                  ),
                ),
                child: const Text(
                  '∑',
                  style: TextStyle(
                    fontSize: 52,
                    fontWeight: FontWeight.w800,
                    color: AppColors.achievement,
                  ),
                ),
              ),

              const SizedBox(height: AppSpacing.lg),

              Text(
                'Recompensa desbloqueada',
                textAlign: TextAlign.center,
                style: AppTypography.headingLarge,
              ),

              const SizedBox(height: AppSpacing.xs),

              Text(
                _rewardDescription,
                textAlign: TextAlign.center,
                style: AppTypography.bodyMedium,
              ),

              const SizedBox(height: AppSpacing.xl),

              _buildRewardItem(
                icon: Icons.bolt_outlined,
                title: 'Experiência recebida',
                value: '+${widget.xpEarned} XP',
                iconColor: AppColors.xp,
                iconBackground: AppColors.xpLight,
              ),

              const SizedBox(height: AppSpacing.sm),

              _buildRewardItem(
                icon: Icons.monetization_on_outlined,
                title: 'Ouro recebido',
                value: '+${widget.goldEarned}',
                iconColor: AppColors.gold,
                iconBackground: AppColors.goldLight,
              ),

              const SizedBox(height: AppSpacing.sm),

              _buildRewardItem(
                icon: Icons.school_outlined,
                title: 'Progresso',
                value: _progressText,
                iconColor: AppColors.success,
                iconBackground: AppColors.successLight,
              ),

              const Spacer(),

              PrimaryButton(
                text: 'Voltar para a trilha',
                icon: Icons.map_outlined,
                onPressed: () {
                  _backToLearningPath(context);
                },
              ),

              const SizedBox(
                height: AppSpacing.screenBottom,
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