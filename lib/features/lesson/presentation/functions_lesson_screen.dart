import 'package:flutter/material.dart';

import 'package:calcquest/shared/localization/lesson_ui_text.dart';
import 'package:calcquest/shared/theme/app_colors.dart';
import 'package:calcquest/shared/theme/app_spacing.dart';
import 'package:calcquest/shared/theme/app_typography.dart';
import 'package:calcquest/shared/widgets/app_bottom_navigation_bar.dart';
import 'package:calcquest/shared/widgets/function_visualization_card.dart';
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
    final isEnglish = Localizations.localeOf(context).languageCode == 'en';
    final ui = LessonUiText.of(context);

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
                    tooltip: ui.back,
                    onPressed: () => Navigator.of(context).maybePop(),
                    icon: const Icon(Icons.arrow_back_rounded),
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  Expanded(
                    child: Text(
                      isEnglish ? 'Pre-Calculus Path' : 'Trilha de Pré-Cálculo',
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
                children: [
                  LessonHeroCard(
                    eyebrow: isEnglish ? 'Lesson 3 • Relations' : 'Aula 3 • Relações',
                    title: isEnglish
                        ? 'Functions: transformation machines'
                        : 'Funções: máquinas de transformação',
                    description: isEnglish
                        ? 'Understand inputs, outputs, domain, range, and different ways to represent a function.'
                        : 'Entenda entradas, saídas, domínio, imagem e diferentes formas de representar uma função.',
                    duration: '≈ 5 min',
                    objective: isEnglish
                        ? 'evaluate functions, identify the domain, and interpret the meaning of f(x)'
                        : 'avaliar funções, reconhecer domínio e interpretar o significado de f(x)',
                    symbol: 'f(x)',
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  LessonSectionHeader(
                    number: '1',
                    title: isEnglish ? 'Picture a machine' : 'Visualize uma máquina',
                    subtitle: isEnglish
                        ? 'An input goes through a rule and produces an output.'
                        : 'Uma entrada passa por uma regra e produz uma saída.',
                  ),
                  const SizedBox(height: AppSpacing.md),
                  LessonConceptCard(
                    icon: Icons.input_rounded,
                    title: isEnglish
                        ? 'Input → rule → output'
                        : 'Entrada → regra → saída',
                    content: isEnglish
                        ? 'For the function f(x) = 2x + 1, you choose an input x, multiply it by 2, and add 1. For x = 3, the machine returns f(3) = 7.'
                        : 'Na função f(x) = 2x + 1, você escolhe uma entrada x, multiplica por 2 e soma 1. Para x = 3, a máquina devolve f(3) = 7.',
                    emphasis: isEnglish
                        ? 'A function must assign exactly one output to each allowed input.'
                        : 'Uma função deve atribuir uma única saída a cada entrada permitida.',
                  ),
                  const SizedBox(height: AppSpacing.md),
                  LessonConceptCard(
                    icon: Icons.dataset_outlined,
                    title: isEnglish ? 'Domain and range' : 'Domínio e imagem',
                    content: isEnglish
                        ? 'The domain contains the allowed inputs. The range contains the outputs actually produced. In a fraction, we exclude values that make the denominator zero; for a real square root, the radicand cannot be negative.'
                        : 'O domínio reúne as entradas permitidas. A imagem reúne as saídas realmente produzidas. Em uma fração, excluímos valores que zeram o denominador; em uma raiz real, o radicando não pode ser negativo.',
                    emphasis: isEnglish
                        ? 'Before calculating, ask: does this value of x belong to the domain?'
                        : 'Antes de calcular, pergunte: este valor de x pertence ao domínio?',
                    tone: LearningCardTone.information,
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  LessonSectionHeader(
                    number: '2',
                    title: isEnglish ? 'Interpret the notation' : 'Interprete a notação',
                  ),
                  const SizedBox(height: AppSpacing.md),
                  LessonConceptCard(
                    icon: Icons.translate_rounded,
                    title: isEnglish
                        ? 'f(3) does not mean f times 3'
                        : 'f(3) não significa f vezes 3',
                    content: isEnglish
                        ? 'The notation f(3) tells us to replace x with 3 in the function rule. Solving f(x) = 3 is a different task: we look for the inputs that produce the output 3.'
                        : 'A escrita f(3) ordena que substituamos x por 3 na regra da função. Já resolver f(x) = 3 é outra tarefa: procuramos quais entradas produzem a saída 3.',
                    emphasis: isEnglish
                        ? 'Evaluating a function finds an output. Solving an equation finds an input.'
                        : 'Avaliar uma função procura a saída. Resolver uma equação procura a entrada.',
                    tone: LearningCardTone.warning,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  WorkedExampleCard(
                    title: isEnglish
                        ? 'Evaluation with a negative number'
                        : 'Avaliação com número negativo',
                    problem: isEnglish
                        ? 'f(x) = 2x² − 3. Calculate f(−2).'
                        : 'f(x) = 2x² − 3. Calcule f(−2).',
                    steps: isEnglish
                        ? const [
                            'Replace every occurrence of x with (−2), keeping the parentheses.',
                            'Evaluate the power first: (−2)² = 4.',
                            'Multiply and subtract: 2·4 − 3 = 8 − 3.',
                          ]
                        : const [
                            'Substitua cada ocorrência de x por (−2), mantendo os parênteses.',
                            'Calcule primeiro a potência: (−2)² = 4.',
                            'Multiplique e subtraia: 2·4 − 3 = 8 − 3.',
                          ],
                    result: isEnglish
                        ? 'Result: f(−2) = 5.'
                        : 'Resultado: f(−2) = 5.',
                    interpretation: isEnglish
                        ? 'The point (−2, 5) belongs to the graph of the function.'
                        : 'O ponto (−2, 5) pertence ao gráfico da função.',
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  LessonSectionHeader(
                    number: '3',
                    title: isEnglish
                        ? 'Connect formula, table, and graph'
                        : 'Conecte fórmula, tabela e gráfico',
                  ),
                  const SizedBox(height: AppSpacing.md),
                  LessonConceptCard(
                    icon: Icons.auto_graph_rounded,
                    title: isEnglish
                        ? 'Three representations, the same relation'
                        : 'Três representações, a mesma relação',
                    content: isEnglish
                        ? 'The formula describes the rule; the table shows input-output pairs; the graph places those pairs on the coordinate plane. Being able to move between all three improves interpretation.'
                        : 'A fórmula descreve a regra; a tabela mostra pares de entrada e saída; o gráfico posiciona esses pares no plano. Saber alternar entre as três formas melhora a interpretação.',
                    emphasis: isEnglish
                        ? 'On the graph, x is read on the horizontal axis and f(x) on the vertical axis.'
                        : 'No gráfico, x é lido no eixo horizontal e f(x) no eixo vertical.',
                    tone: LearningCardTone.success,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  FunctionVisualizationCard(isEnglish: isEnglish),
                  const SizedBox(height: AppSpacing.md),
                  LessonCheckCard(
                    question: isEnglish
                        ? 'Which statement correctly describes a function?'
                        : 'Qual afirmação descreve corretamente uma função?',
                    choices: isEnglish
                        ? const [
                            'Each allowed input has exactly one output.',
                            'Every output must have only one input.',
                            'The domain always contains all real numbers.',
                          ]
                        : const [
                            'Cada entrada permitida possui exatamente uma saída.',
                            'Toda saída deve possuir somente uma entrada.',
                            'O domínio sempre contém todos os números reais.',
                          ],
                    correctIndex: 0,
                    explanation: isEnglish
                        ? 'Different inputs can produce the same output, but one input cannot produce two different outputs in the same function.'
                        : 'Entradas diferentes podem produzir a mesma saída, mas uma entrada não pode produzir duas saídas diferentes na mesma função.',
                  ),
                  const SizedBox(height: AppSpacing.md),
                  LessonTakeawaysCard(
                    items: isEnglish
                        ? const [
                            'f(a) is the value produced by the function when the input is a.',
                            'Domain means the set of allowed inputs.',
                            'Parentheses prevent errors when substituting negative numbers.',
                            'Formula, table, and graph represent the same relation.',
                          ]
                        : const [
                            'f(a) é o valor produzido pela função quando a entrada é a.',
                            'Domínio significa conjunto de entradas permitidas.',
                            'Parênteses evitam erros ao substituir números negativos.',
                            'Fórmula, tabela e gráfico representam a mesma relação.',
                          ],
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Text(
                    isEnglish
                        ? 'Functions are the language of Calculus: once this foundation is clear, limits and derivatives stop looking like isolated formulas.'
                        : 'Funções são a linguagem do Cálculo: quando essa base fica clara, limites e derivadas deixam de parecer fórmulas isoladas.',
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
                text: isEnglish ? 'Practice functions' : 'Praticar funções',
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
