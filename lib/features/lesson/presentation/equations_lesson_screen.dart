import 'package:flutter/material.dart';

import 'package:calcquest/shared/theme/app_colors.dart';
import 'package:calcquest/shared/widgets/app_bottom_navigation_bar.dart';
import 'package:calcquest/shared/widgets/primary_button.dart';

import '../../dashboard/presentation/dashboard_screen.dart';
import '../../exercises/presentation/equations_exercises_screen.dart';
import '../../learning_path/presentation/learning_path_screen.dart';
import '../../profile/presentation/profile_screen.dart';
import '../../statistics/presentation/statistics_screen.dart';

class EquationsLessonScreen extends StatelessWidget {
  const EquationsLessonScreen({super.key});

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

  void _goToExercises(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const EquationsExercisesScreen(),
      ),
    );
  }

  Widget _buildConceptCard({
    required String title,
    required String content,
    required String symbol,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 46,
            height: 46,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.selectedBackground,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Text(
              symbol,
              style: const TextStyle(
                fontSize: 22,
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
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  content,
                  style: const TextStyle(
                    fontSize: 14,
                    height: 1.45,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
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
          padding: const EdgeInsets.fromLTRB(24, 40, 24, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Aula 2 â€” EquaÃ§Ãµes e InequaÃ§Ãµes',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Aprenda a resolver igualdades e desigualdades usando manipulaÃ§Ã£o algÃ©brica.',
                style: TextStyle(
                  fontSize: 14,
                  height: 1.4,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: ListView(
                  children: [
                    _buildConceptCard(
                      title: 'O que Ã© uma equaÃ§Ã£o?',
                      symbol: '=',
                      content:
                          'Uma equaÃ§Ã£o Ã© uma igualdade que possui uma incÃ³gnita. Resolver uma equaÃ§Ã£o significa descobrir qual valor torna a igualdade verdadeira.',
                    ),
                    const SizedBox(height: 16),
                    _buildConceptCard(
                      title: 'Exemplo simples',
                      symbol: 'x',
                      content:
                          'Na equaÃ§Ã£o x + 3 = 8, queremos isolar o x. Subtraindo 3 dos dois lados, temos x = 5.',
                    ),
                    const SizedBox(height: 16),
                    _buildConceptCard(
                      title: 'Regra principal',
                      symbol: 'Â±',
                      content:
                          'Tudo que vocÃª faz de um lado da equaÃ§Ã£o tambÃ©m deve fazer do outro. Isso mantÃ©m a igualdade equilibrada.',
                    ),
                    const SizedBox(height: 16),
                    _buildConceptCard(
                      title: 'O que Ã© uma inequaÃ§Ã£o?',
                      symbol: '<',
                      content:
                          'Uma inequaÃ§Ã£o usa sinais como <, >, â‰¤ ou â‰¥. Ela representa uma comparaÃ§Ã£o entre expressÃµes, nÃ£o uma igualdade exata.',
                    ),
                    const SizedBox(height: 16),
                    _buildConceptCard(
                      title: 'AtenÃ§Ã£o importante',
                      symbol: '!',
                      content:
                          'Ao multiplicar ou dividir uma inequaÃ§Ã£o por nÃºmero negativo, o sinal da desigualdade inverte.',
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
              PrimaryButton(
                text: 'Iniciar exercÃ­cios',
                onPressed: () {
                  _goToExercises(context);
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
