import 'package:flutter/material.dart';

import 'package:calcquest/shared/theme/app_colors.dart';
import 'package:calcquest/shared/theme/app_spacing.dart';
import 'package:calcquest/shared/theme/app_typography.dart';
import 'package:calcquest/shared/widgets/app_bottom_navigation_bar.dart';
import 'package:calcquest/shared/widgets/primary_button.dart';

import '../../dashboard/presentation/dashboard_screen.dart';
import '../../exercises/presentation/continuity_exercises_screen.dart';
import '../../learning_path/presentation/learning_path_screen.dart';
import '../../profile/presentation/profile_screen.dart';
import '../../statistics/presentation/statistics_screen.dart';

class ContinuityLessonScreen extends StatelessWidget {
  const ContinuityLessonScreen({super.key});

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
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const ContinuityExercisesScreen()),
    );
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
            'Exemplo resolvido',
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.primaryLight,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'f(x) = (x² - 1)/(x - 1), se x ≠ 1\nf(1) = 2',
            style: AppTypography.headingSmall.copyWith(
              color: AppColors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Para x ≠ 1, fatoramos x² - 1 = (x - 1)(x + 1). Assim, f(x) = x + 1 perto de x = 1 e o limite vale 2.',
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.primaryLight,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'Como lim x → 1 f(x) = f(1) = 2, f é contínua em x = 1.',
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
              Text('Aula 2 — Continuidade', style: AppTypography.headingMedium),
              const SizedBox(height: AppSpacing.xs),
              Text(
                'Descubra quando uma função não apresenta saltos, furos ou interrupções.',
                style: AppTypography.bodyMedium,
              ),
              const SizedBox(height: AppSpacing.lg),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.only(bottom: AppSpacing.lg),
                  children: [
                    _buildConceptCard(
                      title: 'O que é continuidade?',
                      symbol: 'C',
                      content:
                          'Intuitivamente, uma função é contínua quando seu gráfico pode ser percorrido sem interrupções. A definição matemática compara o valor da função com seu limite.',
                    ),
                    const SizedBox(height: AppSpacing.md),
                    _buildConceptCard(
                      title: 'As três condições',
                      symbol: '3',
                      content:
                          'Em x = a, precisamos de f(a) definida, do limite lim x → a f(x) existente e da igualdade entre esse limite e f(a). Se uma condição falhar, há descontinuidade.',
                    ),
                    const SizedBox(height: AppSpacing.md),
                    _buildConceptCard(
                      title: 'Funções contínuas conhecidas',
                      symbol: 'f',
                      content:
                          'Polinômios, seno, cosseno e exponenciais são contínuos em todo o domínio. Funções racionais são contínuas onde o denominador não é zero.',
                    ),
                    const SizedBox(height: AppSpacing.md),
                    _buildExampleCard(),
                    const SizedBox(height: AppSpacing.md),
                    _buildConceptCard(
                      title: 'Tipos de descontinuidade',
                      symbol: '≠',
                      content:
                          'Um furo é uma descontinuidade removível. Limites laterais finitos e diferentes formam um salto. Crescimento sem limite perto do ponto indica descontinuidade infinita.',
                    ),
                    const SizedBox(height: AppSpacing.md),
                    _buildConceptCard(
                      title: 'Por que isso importa?',
                      symbol: '→',
                      content:
                          'A continuidade permite prever valores intermediários e sustenta resultados importantes do Cálculo. Antes de derivar uma função em um ponto, ela precisa ser contínua ali.',
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
