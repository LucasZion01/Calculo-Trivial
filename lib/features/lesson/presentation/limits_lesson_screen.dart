import 'package:flutter/material.dart';

import 'package:calcquest/shared/theme/app_colors.dart';
import 'package:calcquest/shared/theme/app_spacing.dart';
import 'package:calcquest/shared/theme/app_typography.dart';
import 'package:calcquest/shared/widgets/app_bottom_navigation_bar.dart';
import 'package:calcquest/shared/widgets/primary_button.dart';

import '../../dashboard/presentation/dashboard_screen.dart';
import '../../exercises/presentation/limits_exercises_screen.dart';
import '../../learning_path/presentation/learning_path_screen.dart';
import '../../profile/presentation/profile_screen.dart';
import '../../statistics/presentation/statistics_screen.dart';

class LimitsLessonScreen extends StatelessWidget {
  const LimitsLessonScreen({super.key});

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
    ).push(MaterialPageRoute(builder: (_) => const LimitsExercisesScreen()));
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

  Widget _buildExampleCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.cardPaddingLarge),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(AppSpacing.radiusXLarge),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 16,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Exemplo rápido',
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.primaryLight,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'lim x → 2  (x² - 4) / (x - 2)',
            style: AppTypography.headingSmall.copyWith(
              color: AppColors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'A substituição direta gera 0/0. Então fatoramos x² - 4 como (x - 2)(x + 2), cancelamos x - 2 e avaliamos x + 2 em x = 2.',
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.primaryLight,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'Resultado: 4',
            style: AppTypography.titleMedium.copyWith(color: AppColors.white),
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
              Text('Aula 1 — Limites', style: AppTypography.headingMedium),
              const SizedBox(height: AppSpacing.xs),
              Text(
                'Entenda limites com substituição, fatoração, racionalização e análise no infinito.',
                style: AppTypography.bodyMedium,
              ),
              const SizedBox(height: AppSpacing.lg),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.only(bottom: AppSpacing.lg),
                  children: [
                    _buildConceptCard(
                      title: 'Ideia central',
                      symbol: 'lim',
                      content:
                          'Limite descreve o valor que uma função se aproxima quando x chega perto de um número. Em Cálculo, isso prepara a base para continuidade, derivadas e integrais.',
                    ),
                    const SizedBox(height: AppSpacing.md),
                    _buildConceptCard(
                      title: 'Quando substituir diretamente?',
                      symbol: 'x',
                      content:
                          'Em funções polinomiais e em expressões contínuas, geralmente podemos substituir o valor de x diretamente.',
                    ),
                    const SizedBox(height: AppSpacing.md),
                    _buildConceptCard(
                      title: 'Quando aparece 0/0',
                      symbol: '0/0',
                      content:
                          'A forma 0/0 é uma indeterminação. Ela indica que é necessário transformar a expressão, geralmente por fatoração, simplificação ou racionalização.',
                    ),
                    const SizedBox(height: AppSpacing.md),
                    _buildExampleCard(),
                    const SizedBox(height: AppSpacing.md),
                    _buildConceptCard(
                      title: 'Limite no infinito',
                      symbol: '∞',
                      content:
                          'Em funções racionais, quando x tende ao infinito, comparamos os termos de maior grau. Eles dominam o comportamento da função.',
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
