import 'package:flutter/material.dart';

import 'package:calcquest/shared/theme/app_colors.dart';
import 'package:calcquest/shared/theme/app_spacing.dart';
import 'package:calcquest/shared/theme/app_typography.dart';
import 'package:calcquest/shared/widgets/app_bottom_navigation_bar.dart';
import 'package:calcquest/shared/widgets/primary_button.dart';

import '../../dashboard/presentation/dashboard_screen.dart';
import '../../exercises/presentation/derivatives_exercises_screen.dart';
import '../../learning_path/presentation/learning_path_screen.dart';
import '../../profile/presentation/profile_screen.dart';
import '../../statistics/presentation/statistics_screen.dart';

class DerivativesLessonScreen extends StatelessWidget {
  const DerivativesLessonScreen({super.key});

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
      MaterialPageRoute(builder: (_) => const DerivativesExercisesScreen()),
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
            'f(x) = 3x² - 2x + 1',
            style: AppTypography.headingSmall.copyWith(
              color: AppColors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Aplicamos a regra da potência em cada termo: (3x²)\' = 6x, (-2x)\' = -2 e a derivada da constante 1 é zero.',
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.primaryLight,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'f\'(x) = 6x - 2  e  f\'(1) = 4',
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
              Text('Aula 3 — Derivadas', style: AppTypography.headingMedium),
              const SizedBox(height: AppSpacing.xs),
              Text(
                'Aprenda a medir variações instantâneas e inclinações de curvas.',
                style: AppTypography.bodyMedium,
              ),
              const SizedBox(height: AppSpacing.lg),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.only(bottom: AppSpacing.lg),
                  children: [
                    _buildConceptCard(
                      title: 'O que é derivada?',
                      symbol: "f'",
                      content:
                          'A derivada mede como uma quantidade varia instantaneamente. Geometricamente, ela fornece a inclinação da reta tangente ao gráfico em um ponto.',
                    ),
                    const SizedBox(height: AppSpacing.md),
                    _buildConceptCard(
                      title: 'Definição por limite',
                      symbol: 'lim',
                      content:
                          'A derivada em x é definida por f\'(x) = lim h → 0 [f(x + h) - f(x)]/h. O quociente calcula uma variação média que se torna instantânea quando h tende a zero.',
                    ),
                    const SizedBox(height: AppSpacing.md),
                    _buildConceptCard(
                      title: 'Regras básicas',
                      symbol: 'xⁿ',
                      content:
                          'A derivada de uma constante é zero, (xⁿ)\' = n·xⁿ⁻¹ e podemos derivar somas termo a termo. Essas regras resolvem rapidamente funções polinomiais.',
                    ),
                    const SizedBox(height: AppSpacing.md),
                    _buildExampleCard(),
                    const SizedBox(height: AppSpacing.md),
                    _buildConceptCard(
                      title: 'Produto, quociente e cadeia',
                      symbol: '×',
                      content:
                          'Produtos e quocientes possuem regras próprias. Em funções compostas, usamos a regra da cadeia: derivamos a parte externa e multiplicamos pela derivada da parte interna.',
                    ),
                    const SizedBox(height: AppSpacing.md),
                    _buildConceptCard(
                      title: 'Aplicações',
                      symbol: 'v',
                      content:
                          'Derivadas calculam velocidade, aceleração, crescimento, pontos de máximo e mínimo e taxas de variação em fenômenos da Engenharia, Física e Economia.',
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
