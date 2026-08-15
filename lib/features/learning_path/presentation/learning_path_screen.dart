import 'package:flutter/material.dart';

import 'package:calcquest/shared/data/mock_learning_data.dart';
import 'package:calcquest/shared/state/app_progress.dart';
import 'package:calcquest/shared/theme/app_colors.dart';
import 'package:calcquest/shared/theme/app_spacing.dart';
import 'package:calcquest/shared/theme/app_typography.dart';
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
      return;
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
      return;
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

    if (module.id == 'calculo-1') {
      if (AppProgress.limitsCompleted) {
        return '33%';
      }

      if (AppProgress.functionsCompleted) {
        return 'Desbloqueado';
      }

      return 'Bloqueado';
    }

    return module.status;
  }

  Color _getModuleStatusColor(ModuleData module) {
    if (module.id == 'fundamentos') {
      if (_completedFundamentalsLessons() == 3) {
        return AppColors.success;
      }

      return AppColors.primary;
    }

    if (module.id == 'calculo-1' && AppProgress.functionsCompleted) {
      return AppColors.primary;
    }

    return AppColors.locked;
  }

  MathCardState _getModuleCardState(ModuleData module) {
    if (module.id == 'fundamentos') {
      if (_completedFundamentalsLessons() == 3) {
        return MathCardState.completed;
      }

      return MathCardState.normal;
    }

    if (module.id == 'calculo-1') {
      if (AppProgress.functionsCompleted) {
        return MathCardState.normal;
      }

      return MathCardState.locked;
    }

    return MathCardState.locked;
  }

  VoidCallback? _getModuleTap(
    BuildContext context,
    ModuleData module,
  ) {
    if (module.id == 'fundamentos') {
      return () {
        _goToModuleDetail(context);
      };
    }

    if (module.id == 'calculo-1' &&
        AppProgress.functionsCompleted) {
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
                'Trilha de Aprendizagem',
                style: AppTypography.headingMedium,
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                'Avance módulo por módulo até dominar o Cálculo.',
                style: AppTypography.bodyMedium,
              ),
              const SizedBox(height: AppSpacing.lg),
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.only(
                    bottom: AppSpacing.lg,
                  ),
                  itemCount: mockModules.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(
                    height: AppSpacing.md,
                  ),
                  itemBuilder: (context, index) {
                    final module = mockModules[index];

                    return MathCard(
                      title: module.title,
                      subtitle: module.subtitle,
                      symbol: module.symbol,
                      status: _getModuleStatus(module),
                      statusColor: _getModuleStatusColor(module),
                      state: _getModuleCardState(module),
                      onTap: _getModuleTap(
                        context,
                        module,
                      ),
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