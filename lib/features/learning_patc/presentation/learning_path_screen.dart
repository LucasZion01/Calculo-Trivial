import 'package:flutter/material.dart';

import 'package:calcquest/shared/data/mock_learning_data.dart';
import 'package:calcquest/shared/state/app_progress.dart';
import 'package:calcquest/shared/theme/app_colors.dart';
import 'package:calcquest/shared/widgets/app_bottom_navigation_bar.dart';
import 'package:calcquest/shared/widgets/math_card.dart';

import '../../calculus_one/presentation/calculus_one_detail_screen.dart';
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

  void _goToCalculusOne(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const CalculusOneDetailScreen(),
      ),
    );
  }

  int _completedFundamentalsLessons() {
    int completed = 0;

    if (AppProgress.algebraFundamentalCompleted) {
      completed++;
    }

    if (AppProgress.equationsAndInequationsCompleted) {
      completed++;
    }

    if (AppProgress.functionsCompleted) {
      completed++;
    }

    return completed;
  }

  String _getModuleStatus(ModuleData module) {
    if (module.id == 'fundamentos') {
      final completed = _completedFundamentalsLessons();

      if (completed == 0) {
        return '0%';
      }

      if (completed == 1) {
        return '33%';
      }

      if (completed == 2) {
        return '66%';
      }

      return '100%';
    }

    if (module.id == 'calculo-1' && AppProgress.functionsCompleted) {
      return 'Desbloqueado';
    }

    return module.status;
  }

  Color _getModuleStatusColor(ModuleData module) {
    if (module.id == 'fundamentos') {
      return AppColors.primary;
    }

    if (module.id == 'calculo-1' && AppProgress.functionsCompleted) {
      return AppColors.primary;
    }

    return module.isUnlocked ? AppColors.primary : AppColors.textMuted;
  }

  VoidCallback? _getModuleTap(BuildContext context, ModuleData module) {
    if (module.id == 'fundamentos') {
      return () {
        _goToModuleDetail(context);
      };
    }

    if (module.id == 'calculo-1' && AppProgress.functionsCompleted) {
      return () {
        _goToCalculusOne(context);
      };
    }

    return null;
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
              Expanded(
                child: ListView.separated(
                  itemCount: mockModules.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    final module = mockModules[index];

                    return MathCard(
                      title: module.title,
                      subtitle: module.subtitle,
                      symbol: module.symbol,
                      status: _getModuleStatus(module),
                      statusColor: _getModuleStatusColor(module),
                      onTap: _getModuleTap(context, module),
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
        onTap: (index) {
          _onMenuTap(context, index);
        },
      ),
    );
  }
}