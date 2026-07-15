import 'package:flutter/material.dart';

import 'package:calcquest/shared/theme/app_colors.dart';
import 'package:calcquest/shared/widgets/app_bottom_navigation_bar.dart';
import 'package:calcquest/shared/widgets/math_card.dart';

import '../../dashboard/presentation/dashboard_screen.dart';
import '../../module_detail/presentation/module_detail_screen.dart';
import '../../profile/presentation/profile_screen.dart';
import '../../statistics/presentation/statistics_screen.dart';

class LearningPathScreen extends StatelessWidget {
  const LearningPathScreen({super.key});

  void _onMenuTap(BuildContext context, int index) {
    if (index == 0) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => const DashboardScreen(),
        ),
      );
    }

    if (index == 1) {
      return;
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

  void _goToModuleDetail(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const ModuleDetailScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 40, 24, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Trilha de Aprendizagem',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Avance módulo por módulo até dominar o Cálculo.',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 24),
              MathCard(
                title: 'Fundamentos Matemáticos',
                subtitle: 'Pré-Cálculo, funções e base algébrica',
                symbol: 'f(x)',
                status: '0%',
                statusColor: AppColors.primary,
                onTap: () {
                  _goToModuleDetail(context);
                },
              ),
              const SizedBox(height: 16),
              const MathCard(
                title: 'Cálculo I',
                subtitle: 'Limites, continuidade e derivadas',
                symbol: 'lim',
                status: 'Bloqueado',
                statusColor: AppColors.textMuted,
              ),
              const SizedBox(height: 16),
              const MathCard(
                title: 'Cálculo II',
                subtitle: 'Integrais, séries e equações diferenciais',
                symbol: '∫',
                status: 'Bloqueado',
                statusColor: AppColors.textMuted,
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