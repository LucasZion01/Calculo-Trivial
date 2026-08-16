import 'package:flutter/material.dart';

import 'package:calcquest/shared/theme/app_colors.dart';
import 'package:calcquest/shared/theme/app_spacing.dart';
import 'package:calcquest/shared/theme/app_typography.dart';
import 'package:calcquest/shared/widgets/app_bottom_navigation_bar.dart';
import 'package:calcquest/shared/widgets/primary_button.dart';

import '../../dashboard/presentation/dashboard_screen.dart';
import '../../exercises/presentation/functions_exercises_screen.dart';
import '../../learning_path/presentation/learning_path_screen.dart';
import '../../profile/presentation/profile_screen.dart';
import '../../statistics/presentation/statistics_screen.dart';

class FunctionsLessonScreen extends StatelessWidget {
  const FunctionsLessonScreen({super.key});

  void _onMenuTap(BuildContext context, int index) {
    if (index == 0) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const DashboardScreen()),
        (route) => false,
      );
      return;
    }

    if (index == 1) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const LearningPathScreen()),
        (route) => false,
      );
      return;
    }

    if (index == 2) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const StatisticsScreen()),
        (route) => false,
      );
      return;
    }

    if (index == 3) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const ProfileScreen()),
        (route) => false,
      );
    }
  }

  void _goToExercises(BuildContext context) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => const FunctionsExercisesScreen()));
  }

  Widget _buildConceptCard({
    required String title,
    required String content,
    required String symbol,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.cardPaddingLarge),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
        border: Border.all(color: AppColors.border),
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
              borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
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
                Text(title, style: AppTypography.titleMedium),
                const SizedBox(height: AppSpacing.xs),
                Text(content, style: AppTypography.bodyMedium),
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
              Text('Aula 3 — Funções', style: AppTypography.headingMedium),
              const SizedBox(height: AppSpacing.xs),
              Text(
                'Entenda como uma função relaciona uma entrada a uma saída.',
                style: AppTypography.bodyMedium,
              ),
              const SizedBox(height: AppSpacing.lg),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.only(bottom: AppSpacing.md),
                  children: [
                    _buildConceptCard(
                      title: 'O que é uma função?',
                      symbol: 'f',
                      content:
                          'Uma função é uma regra que associa cada valor de entrada a um único valor de saída. A entrada geralmente é representada por x, e a saída por f(x).',
                    ),
                    const SizedBox(height: AppSpacing.md),
                    _buildConceptCard(
                      title: 'Exemplo',
                      symbol: 'f(x)',
                      content:
                          'Na função f(x) = 2x + 1, cada valor de x gera um valor de f(x). Se x = 3, então f(3) = 2 · 3 + 1 = 7.',
                    ),
                    const SizedBox(height: AppSpacing.md),
                    _buildConceptCard(
                      title: 'Domínio',
                      symbol: 'D',
                      content:
                          'O domínio é o conjunto dos valores que podem ser usados como entrada da função.',
                    ),
                    const SizedBox(height: AppSpacing.md),
                    _buildConceptCard(
                      title: 'Imagem',
                      symbol: 'Im',
                      content:
                          'A imagem é o conjunto dos valores que podem aparecer como saída da função.',
                    ),
                    const SizedBox(height: AppSpacing.md),
                    _buildConceptCard(
                      title: 'Por que isso importa?',
                      symbol: 'π',
                      content:
                          'Funções aparecem em limites, derivadas, integrais, gráficos, movimento, crescimento, custo, receita e muitos problemas de engenharia.',
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
              const SizedBox(height: AppSpacing.screenBottom),
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
