import 'package:flutter/material.dart';

import 'package:calcquest/shared/state/app_progress.dart';
import 'package:calcquest/shared/theme/app_colors.dart';
import 'package:calcquest/shared/widgets/app_bottom_navigation_bar.dart';
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
    }

    if (index == 1) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (_) => const LearningPathScreen(),
        ),
        (route) => false,
      );
    }

    if (index == 2) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (_) => const StatisticsScreen(),
        ),
        (route) => false,
      );
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
    if (widget.completedLessonId == 'funcoes') {
      return 'Você concluiu a sequência de Funções e finalizou o módulo Fundamentos Matemáticos.';
    }

    if (widget.completedLessonId == 'equacoes-inequacoes') {
      return 'Você concluiu a sequência de Equações e Inequações.';
    }

    return 'Você concluiu a sequência de Álgebra Fundamental.';
  }

  Widget _buildRewardItem({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: AppColors.border,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.selectedBackground,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              icon,
              color: AppColors.primary,
              size: 24,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 15,
                color: AppColors.textSecondary,
              ),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final progressText = widget.completedLessonId == 'funcoes'
        ? 'Módulo concluído'
        : 'Aula concluída';

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 40, 24, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 12),
              Container(
                width: 104,
                height: 104,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(32),
                ),
                child: const Text(
                  '∑',
                  style: TextStyle(
                    fontSize: 56,
                    fontWeight: FontWeight.w800,
                    color: AppColors.white,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Recompensa desbloqueada',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                _rewardDescription,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  height: 1.4,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 32),
              _buildRewardItem(
                icon: Icons.bolt_outlined,
                title: 'Experiência recebida',
                value: '+${widget.xpEarned} XP',
              ),
              const SizedBox(height: 14),
              _buildRewardItem(
                icon: Icons.monetization_on_outlined,
                title: 'Ouro recebido',
                value: '+${widget.goldEarned}',
              ),
              const SizedBox(height: 14),
              _buildRewardItem(
                icon: Icons.school_outlined,
                title: 'Progresso',
                value: progressText,
              ),
              const Spacer(),
              PrimaryButton(
                text: 'Voltar para a trilha',
                onPressed: () {
                  _backToLearningPath(context);
                },
              ),
              const SizedBox(height: 24),
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