import 'package:flutter/material.dart';

import 'package:calcquest/shared/state/app_progress.dart';
import 'package:calcquest/shared/theme/app_colors.dart';
import 'package:calcquest/shared/widgets/app_bottom_navigation_bar.dart';
import 'package:calcquest/shared/widgets/primary_button.dart';

import '../../learning_path/presentation/learning_path_screen.dart';
import '../../profile/presentation/profile_screen.dart';
import '../../statistics/presentation/statistics_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  void _onMenuTap(BuildContext context, int index) {
    if (index == 0) {
      return;
    }

    if (index == 1) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => const LearningPathScreen(),
        ),
      );
    }

    if (index == 2) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => const StatisticsScreen(),
        ),
      );
    }

    if (index == 3) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => const ProfileScreen(),
        ),
      );
    }
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: AppColors.border,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: AppColors.primary,
              size: 26,
            ),
            const SizedBox(height: 10),
            Text(
              value,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  double _progressValue() {
    if (AppProgress.equationsAndInequationsCompleted) {
      return 0.66;
    }

    if (AppProgress.algebraFundamentalCompleted) {
      return 0.33;
    }

    return 0;
  }

  String _progressText() {
    if (AppProgress.equationsAndInequationsCompleted) {
      return '66%';
    }

    if (AppProgress.algebraFundamentalCompleted) {
      return '33%';
    }

    return '0%';
  }

  int _xp() {
    if (AppProgress.equationsAndInequationsCompleted) {
      return 130;
    }

    if (AppProgress.algebraFundamentalCompleted) {
      return 60;
    }

    return 0;
  }

  int _gold() {
    if (AppProgress.equationsAndInequationsCompleted) {
      return 55;
    }

    if (AppProgress.algebraFundamentalCompleted) {
      return 25;
    }

    return 0;
  }

  String _lastLesson() {
    if (AppProgress.equationsAndInequationsCompleted) {
      return 'Equações e Inequações concluída';
    }

    if (AppProgress.algebraFundamentalCompleted) {
      return 'Álgebra Fundamental concluída';
    }

    return 'Comece sua primeira aula';
  }

  String _nextMission() {
    if (AppProgress.equationsAndInequationsCompleted) {
      return 'Próxima etapa: Aula 3 — Funções.';
    }

    if (AppProgress.algebraFundamentalCompleted) {
      return 'Continue com Equações e Inequações.';
    }

    return 'Avance na trilha de Fundamentos Matemáticos.';
  }

  @override
  Widget build(BuildContext context) {
    final xp = _xp();
    final gold = _gold();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 40, 24, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Olá, Lucas',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Continue sua jornada no Cálculo.',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 28),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Progresso atual',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.primaryLight,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _progressText(),
                      style: const TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.w800,
                        color: AppColors.white,
                      ),
                    ),
                    const SizedBox(height: 12),
                    LinearProgressIndicator(
                      value: _progressValue(),
                      minHeight: 8,
                      borderRadius: BorderRadius.circular(12),
                      backgroundColor: AppColors.primaryLight,
                      color: AppColors.white,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      _lastLesson(),
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.primaryLight,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  _buildInfoCard(
                    icon: Icons.military_tech_outlined,
                    title: 'Nível',
                    value: '1',
                  ),
                  const SizedBox(width: 12),
                  _buildInfoCard(
                    icon: Icons.bolt_outlined,
                    title: 'XP',
                    value: '$xp',
                  ),
                  const SizedBox(width: 12),
                  _buildInfoCard(
                    icon: Icons.monetization_on_outlined,
                    title: 'Ouro',
                    value: '$gold',
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Container(
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
                      width: 48,
                      height: 48,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColors.selectedBackground,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Text(
                        'f(x)',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Próxima missão',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            _nextMission(),
                            style: const TextStyle(
                              fontSize: 13,
                              color: AppColors.textSecondary,
                            ),
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
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (_) => const LearningPathScreen(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 24),
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
  }
}