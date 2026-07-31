import 'package:flutter/material.dart';

import 'package:calcquest/shared/state/app_progress.dart';
import 'package:calcquest/shared/theme/app_colors.dart';
import 'package:calcquest/shared/widgets/app_bottom_navigation_bar.dart';
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
        content: Text('Aula de Continuidade será criada na próxima etapa.'),
      ),
    );
  }

  void _showLockedMessage(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Esta aula ainda está bloqueada.'),
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
    final limitsStatus =
        AppProgress.limitsCompleted ? 'Concluída' : 'Comece aqui';

    final continuityStatus =
        AppProgress.limitsCompleted ? 'Desbloqueada' : 'Bloqueado';

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 40, 24, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Cálculo I',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Estude limites, continuidade e derivadas passo a passo.',
                style: TextStyle(
                  fontSize: 14,
                  height: 1.4,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 24),
              Container(
                width: double.infinity,
                height: 126,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Progresso do módulo',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.primaryLight,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _moduleProgressText(),
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                        color: AppColors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    LinearProgressIndicator(
                      value: _moduleProgressValue(),
                      minHeight: 6,
                      borderRadius: BorderRadius.circular(12),
                      backgroundColor: AppColors.primaryLight,
                      color: AppColors.white,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _moduleProgressDescription(),
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.primaryLight,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Aulas',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: ListView(
                  children: [
                    MathCard(
                      title: 'Aula 1 — Limites',
                      subtitle: 'Ideia intuitiva, notação e cálculo inicial',
                      symbol: 'lim',
                      status: limitsStatus,
                      statusColor: AppColors.primary,
                      onTap: () {
                        _goToLimitsLesson(context);
                      },
                    ),
                    const SizedBox(height: 16),
                    MathCard(
                      title: 'Aula 2 — Continuidade',
                      subtitle: 'Funções contínuas e pontos de descontinuidade',
                      symbol: 'C',
                      status: continuityStatus,
                      statusColor: AppProgress.limitsCompleted
                          ? AppColors.primary
                          : AppColors.textMuted,
                      onTap: AppProgress.limitsCompleted
                          ? () {
                              _showContinuityMessage(context);
                            }
                          : () {
                              _showLockedMessage(context);
                            },
                    ),
                    const SizedBox(height: 16),
                    MathCard(
                      title: 'Aula 3 — Derivadas',
                      subtitle: 'Taxa de variação e reta tangente',
                      symbol: "f'",
                      status: 'Bloqueado',
                      statusColor: AppColors.textMuted,
                      onTap: () {
                        _showLockedMessage(context);
                      },
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