import 'package:flutter/material.dart';

import 'package:calcquest/shared/theme/app_colors.dart';
import 'package:calcquest/shared/theme/app_spacing.dart';
import 'package:calcquest/shared/theme/app_typography.dart';
import 'package:calcquest/shared/widgets/app_bottom_navigation_bar.dart';
import 'package:calcquest/shared/widgets/learning_content.dart';
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
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const FunctionsExercisesScreen()),
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
                    eyebrow: 'Aula 3 • Relações',
                    title: 'Funções: máquinas de transformação',
                    description: 'Entenda entradas, saídas, domínio, imagem e diferentes formas de representar uma função.',
                    duration: '≈ 5 min',
                    objective: 'avaliar funções, reconhecer domínio e interpretar o significado de f(x)',
                    symbol: 'f(x)',
                  ),
                  SizedBox(height: AppSpacing.xl),
                  LessonSectionHeader(
                    number: '1',
                    title: 'Visualize uma máquina',
                    subtitle: 'Uma entrada passa por uma regra e produz uma saída.',
                  ),
                  SizedBox(height: AppSpacing.md),
                  LessonConceptCard(
                    icon: Icons.input_rounded,
                    title: 'Entrada → regra → saída',
                    content: 'Na função f(x) = 2x + 1, você escolhe uma entrada x, multiplica por 2 e soma 1. Para x = 3, a máquina devolve f(3) = 7.',
                    emphasis: 'Uma função deve atribuir uma única saída a cada entrada permitida.',
                  ),
                  SizedBox(height: AppSpacing.md),
                  LessonConceptCard(
                    icon: Icons.dataset_outlined,
                    title: 'Domínio e imagem',
                    content: 'O domínio reúne as entradas permitidas. A imagem reúne as saídas realmente produzidas. Em uma fração, excluímos valores que zeram o denominador; em uma raiz real, o radicando não pode ser negativo.',
                    emphasis: 'Antes de calcular, pergunte: este valor de x pertence ao domínio?',
                    tone: LearningCardTone.information,
                  ),
                  SizedBox(height: AppSpacing.xl),
                  LessonSectionHeader(
                    number: '2',
                    title: 'Interprete a notação',
                  ),
                  SizedBox(height: AppSpacing.md),
                  LessonConceptCard(
                    icon: Icons.translate_rounded,
                    title: 'f(3) não significa f vezes 3',
                    content: 'A escrita f(3) ordena que substituamos x por 3 na regra da função. Já resolver f(x) = 3 é outra tarefa: procuramos quais entradas produzem a saída 3.',
                    emphasis: 'Avaliar uma função procura a saída. Resolver uma equação procura a entrada.',
                    tone: LearningCardTone.warning,
                  ),
                  SizedBox(height: AppSpacing.md),
                  WorkedExampleCard(
                    title: 'Avaliação com número negativo',
                    problem: 'f(x) = 2x² − 3. Calcule f(−2).',
                    steps: [
                      'Substitua cada ocorrência de x por (−2), mantendo os parênteses.',
                      'Calcule primeiro a potência: (−2)² = 4.',
                      'Multiplique e subtraia: 2·4 − 3 = 8 − 3.',
                    ],
                    result: 'Resultado: f(−2) = 5.',
                    interpretation: 'O ponto (−2, 5) pertence ao gráfico da função.',
                  ),
                  SizedBox(height: AppSpacing.xl),
                  LessonSectionHeader(
                    number: '3',
                    title: 'Conecte fórmula, tabela e gráfico',
                  ),
                  SizedBox(height: AppSpacing.md),
                  LessonConceptCard(
                    icon: Icons.auto_graph_rounded,
                    title: 'Três representações, a mesma relação',
                    content: 'A fórmula descreve a regra; a tabela mostra pares de entrada e saída; o gráfico posiciona esses pares no plano. Saber alternar entre as três formas melhora a interpretação.',
                    emphasis: 'No gráfico, x é lido no eixo horizontal e f(x) no eixo vertical.',
                    tone: LearningCardTone.success,
                  ),
                  SizedBox(height: AppSpacing.md),
                  LessonCheckCard(
                    question: 'Qual afirmação descreve corretamente uma função?',
                    choices: [
                      'Cada entrada permitida possui exatamente uma saída.',
                      'Toda saída deve possuir somente uma entrada.',
                      'O domínio sempre contém todos os números reais.',
                    ],
                    correctIndex: 0,
                    explanation: 'Entradas diferentes podem produzir a mesma saída, mas uma entrada não pode produzir duas saídas diferentes na mesma função.',
                  ),
                  SizedBox(height: AppSpacing.md),
                  LessonTakeawaysCard(
                    items: [
                      'f(a) é o valor produzido pela função quando a entrada é a.',
                      'Domínio significa conjunto de entradas permitidas.',
                      'Parênteses evitam erros ao substituir números negativos.',
                      'Fórmula, tabela e gráfico representam a mesma relação.',
                    ],
                  ),
                  SizedBox(height: AppSpacing.lg),
                  Text(
                    'Funções são a linguagem do Cálculo: quando essa base fica clara, limites e derivadas deixam de parecer fórmulas isoladas.',
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
                text: 'Praticar funções',
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
