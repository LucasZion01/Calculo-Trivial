import 'package:flutter/material.dart';

import 'package:calcquest/shared/theme/app_colors.dart';
import 'package:calcquest/shared/theme/app_spacing.dart';
import 'package:calcquest/shared/theme/app_typography.dart';
import 'package:calcquest/shared/widgets/app_bottom_navigation_bar.dart';
import 'package:calcquest/shared/widgets/learning_content.dart';
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
      MaterialPageRoute(builder: (_) => const EquationsExercisesScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.sm,
                AppSpacing.xs,
                AppSpacing.screenHorizontal,
                0,
              ),
              child: Row(
                children: [
                  IconButton(
                    tooltip: 'Voltar',
                    onPressed: () => Navigator.of(context).maybePop(),
                    icon: const Icon(Icons.arrow_back_rounded),
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  Expanded(
                    child: Text(
                      'Trilha de Pré-Cálculo',
                      style: AppTypography.titleMedium,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.screenHorizontal,
                  AppSpacing.md,
                  AppSpacing.screenHorizontal,
                  AppSpacing.lg,
                ),
                children: const [
                  LessonHeroCard(
                    eyebrow: 'Aula 2 • Álgebra',
                    title: 'Equações: preserve o equilíbrio',
                    description: 'Aprenda a isolar incógnitas com operações justificadas e a interpretar desigualdades.',
                    duration: '10–12 min',
                    objective: 'resolver equações lineares e manipular inequações sem perder soluções',
                    symbol: '=',
                  ),
                  SizedBox(height: AppSpacing.xl),
                  LessonSectionHeader(
                    number: '1',
                    title: 'Pense em uma balança',
                    subtitle: 'A igualdade permanece verdadeira quando os dois lados recebem a mesma operação.',
                  ),
                  SizedBox(height: AppSpacing.md),
                  LessonConceptCard(
                    icon: Icons.balance_rounded,
                    title: 'Dois lados em equilíbrio',
                    content: 'Uma equação afirma que duas expressões possuem o mesmo valor. Somar, subtrair, multiplicar ou dividir os dois lados pelo mesmo número não nulo produz uma equação equivalente.',
                    emphasis: '“Passar para o outro lado trocando o sinal” é apenas um atalho para aplicar a operação inversa nos dois membros.',
                  ),
                  SizedBox(height: AppSpacing.md),
                  LessonConceptCard(
                    icon: Icons.track_changes_rounded,
                    title: 'Resolver é verificar uma condição',
                    content: 'A solução é o valor que torna a sentença verdadeira. Depois de isolar x, substitua o resultado na equação original: os dois lados precisam coincidir.',
                    tone: LearningCardTone.information,
                  ),
                  SizedBox(height: AppSpacing.xl),
                  LessonSectionHeader(
                    number: '2',
                    title: 'Organize antes de calcular',
                  ),
                  SizedBox(height: AppSpacing.md),
                  WorkedExampleCard(
                    title: 'Equação com parênteses',
                    problem: '3(x − 2) + 4 = 10',
                    steps: [
                      'Use a distributiva: 3x − 6 + 4 = 10.',
                      'Reduza os termos semelhantes: 3x − 2 = 10.',
                      'Some 2 aos dois lados: 3x = 12.',
                      'Divida os dois lados por 3: x = 4.',
                    ],
                    result: 'Verificação: 3(4 − 2) + 4 = 6 + 4 = 10.',
                    interpretation: 'Como a substituição recupera a igualdade original, x = 4 é solução.',
                  ),
                  SizedBox(height: AppSpacing.xl),
                  LessonSectionHeader(
                    number: '3',
                    title: 'Inequações exigem um cuidado extra',
                  ),
                  SizedBox(height: AppSpacing.md),
                  LessonConceptCard(
                    icon: Icons.swap_horiz_rounded,
                    title: 'Número negativo inverte o sinal',
                    content: 'Ao multiplicar ou dividir os dois lados de uma inequação por um número negativo, inverta < para >, ≤ para ≥ e vice-versa.',
                    emphasis: 'Exemplo: −2x > 6. Dividindo por −2, obtemos x < −3.',
                    tone: LearningCardTone.warning,
                  ),
                  SizedBox(height: AppSpacing.md),
                  LessonCheckCard(
                    question: 'Qual é a solução de −3x ≤ 12?',
                    choices: ['x ≤ −4', 'x ≥ −4', 'x ≥ 4'],
                    correctIndex: 1,
                    explanation: 'Ao dividir por −3, o sinal ≤ precisa ser invertido. Assim, x ≥ −4.',
                  ),
                  SizedBox(height: AppSpacing.md),
                  LessonTakeawaysCard(
                    items: [
                      'Aplique a mesma operação aos dois lados da equação.',
                      'Use distributiva e reduza termos semelhantes antes de isolar x.',
                      'Verifique a solução na sentença original.',
                      'Inverta a desigualdade ao multiplicar ou dividir por número negativo.',
                    ],
                  ),
                  SizedBox(height: AppSpacing.lg),
                  Text(
                    'Resolver não é transportar termos magicamente: é aplicar a mesma operação aos dois lados e preservar a equivalência.',
                    textAlign: TextAlign.center,
                    style: AppTypography.bodyMedium,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.screenHorizontal,
                AppSpacing.xs,
                AppSpacing.screenHorizontal,
                AppSpacing.screenBottom,
              ),
              child: PrimaryButton(
                text: 'Praticar equações',
                icon: Icons.play_arrow_rounded,
                onPressed: () => _goToExercises(context),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: AppBottomNavigationBar(
        currentIndex: 1,
        onTap: (index) => _onMenuTap(context, index),
      ),
    );
  }
}
