import 'package:flutter/material.dart';

import 'package:calcquest/shared/theme/app_colors.dart';

import '../../../shared/widgets/app_bottom_navigation_bar.dart';
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
                'OlÃ¡, Lucas ðŸ‘‹',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Pronto para evoluir hoje?',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 24),
              Container(
                width: double.infinity,
                height: 130,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'NÃ­vel 1',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.primaryLight,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '120 XP',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                        color: AppColors.white,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Continue estudando para subir de nÃ­vel',
                      style: TextStyle(
                        fontSize: 13,
                        color: AppColors.primaryLight,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),
              const Text(
                'Continuar estudando',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 12),
              Material(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(16),
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (_) => const LearningPathScreen(),
                      ),
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    height: 96,
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: AppColors.border,
                      ),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'PrÃ©-CÃ¡lculo',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          'Aula 1 â€” Ãlgebra Fundamental',
                          style: TextStyle(
                            fontSize: 13,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        Spacer(),
                        Text(
                          'Continuar',
                          style: TextStyle(
                            fontSize: 13,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 28),
              const Text(
                'Resumo de hoje',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 90,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: AppColors.border,
                        ),
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'ðŸ”¥ 3 dias',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'SequÃªncia',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Container(
                      height: 90,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: AppColors.border,
                        ),
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '40%',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Meta diÃ¡ria',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
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

