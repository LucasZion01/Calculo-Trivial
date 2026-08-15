import 'package:flutter/material.dart';

import 'package:calcquest/shared/theme/app_colors.dart';
import 'package:calcquest/shared/theme/app_spacing.dart';
import 'package:calcquest/shared/theme/app_typography.dart';
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.selectedBackground,
              borderRadius: BorderRadius.circular(
                AppSpacing.radiusMedium,
              ),
            ),
            child: Text(
              symbol,
              textAlign: TextAlign.center,
              style: AppTypography.headingSmall.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTypography.titleMedium,
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  content,
                  style: AppTypography.bodyMedium,
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
                'Aula 2 — Equações e Inequações',
                style: AppTypography.headingMedium,
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                'Aprenda a resolver igualdades e desigualdades usando manipulação algébrica.',
                style: AppTypography.bodyMedium,
              ),
              const SizedBox(height: AppSpacing.lg),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.only(
                    bottom: AppSpacing.md,
                  ),
                  children: [
                    _buildConceptCard(
                      title: 'O que é uma equação?',
                      symbol: '=',
                      content:
                          'Uma equação é uma igualdade que possui uma incógnita. Resolver uma equação significa descobrir qual valor torna a igualdade verdadeira.',
                    ),
                    const SizedBox(height: AppSpacing.md),
                    _buildConceptCard(
                      title: 'Exemplo simples',
                      symbol: 'x',
                      content:
                          'Na equação x + 3 = 8, queremos isolar o x. Subtraindo 3 dos dois lados, temos x = 5.',
                    ),
                    const SizedBox(height: AppSpacing.md),
                    _buildConceptCard(
                      title: 'Regra principal',
                      symbol: '±',
                      content:
                          'Tudo que você faz de um lado da equação também deve fazer do outro. Isso mantém a igualdade equilibrada.',
                    ),
                    const SizedBox(height: AppSpacing.md),
                    _buildConceptCard(
                      title: 'O que é uma inequação?',
                      symbol: '<',
                      content:
                          'Uma inequação usa sinais como <, >, ≤ ou ≥. Ela representa uma comparação entre expressões, não uma igualdade exata.',
                    ),
                    const SizedBox(height: AppSpacing.md),
                    _buildConceptCard(
                      title: 'Atenção importante',
                      symbol: '!',
                      content:
                          'Ao multiplicar ou dividir uma inequação por número negativo, o sinal da desigualdade inverte.',
                    ),
                  ],
                ),
              ),
              PrimaryButton(
                text: 'Iniciar exercícios',
                icon: Icons.play_arrow_rounded,
                onPressed: () {
                  _goToExercises(context);
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