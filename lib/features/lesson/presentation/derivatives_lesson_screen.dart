import 'package:flutter/material.dart';

import 'package:calcquest/shared/theme/app_colors.dart';
import 'package:calcquest/shared/theme/app_spacing.dart';
import 'package:calcquest/shared/theme/app_typography.dart';
import 'package:calcquest/shared/widgets/app_bottom_navigation_bar.dart';
import 'package:calcquest/shared/widgets/learning_content.dart';
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
                      'Trilha de Cálculo I',
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
                    eyebrow: 'Aula 3 • Variação',
                    title: 'Derivadas: medir mudanças instantâneas',
                    description: 'Conecte velocidade, inclinação e taxa de variação antes de aplicar as regras algébricas.',
                    duration: '≈ 5 min',
                    objective: 'interpretar uma derivada e aplicar as regras básicas com significado',
                    symbol: 'f′',
                  ),
                  SizedBox(height: AppSpacing.xl),
                  LessonSectionHeader(
                    number: '1',
                    title: 'Comece pelo velocímetro',
                  ),
                  SizedBox(height: AppSpacing.md),
                  LessonConceptCard(
                    icon: Icons.speed_rounded,
                    title: 'Da média ao instante',
                    content: 'A velocidade média usa a distância percorrida durante um intervalo. O velocímetro, porém, mostra a velocidade naquele instante. A derivada nasce quando reduzimos o intervalo até obter uma taxa de variação instantânea.',
                    emphasis: 'Derivada responde: quão rápido a saída muda quando a entrada sofre uma pequena variação?',
                  ),
                  SizedBox(height: AppSpacing.md),
                  LessonConceptCard(
                    icon: Icons.show_chart_rounded,
                    title: 'Inclinação da reta tangente',
                    content: 'No gráfico, f′(a) representa a inclinação da reta que toca a curva perto de x = a. Valor positivo indica crescimento local; negativo indica decrescimento; zero indica tangente horizontal.',
                    tone: LearningCardTone.information,
                  ),
                  SizedBox(height: AppSpacing.xl),
                  LessonSectionHeader(
                    number: '2',
                    title: 'Entenda a definição',
                  ),
                  SizedBox(height: AppSpacing.md),
                  LessonConceptCard(
                    icon: Icons.functions_rounded,
                    title: 'f′(x) = lim h→0 [f(x+h) − f(x)]/h',
                    content: 'O numerador mede a variação da saída e h mede a variação da entrada. O quociente é uma taxa média; quando h se aproxima de zero, obtemos a taxa instantânea.',
                    emphasis: 'Não substituímos h = 0 diretamente, pois isso dividiria por zero. Calculamos o limite.',
                  ),
                  SizedBox(height: AppSpacing.md),
                  WorkedExampleCard(
                    title: 'Derivação termo a termo',
                    problem: 'f(x) = 3x² − 2x + 1',
                    steps: [
                      'Use a regra da potência em 3x²: 2·3x²⁻¹ = 6x.',
                      'A derivada de −2x é −2.',
                      'A derivada da constante 1 é zero.',
                      'Some as derivadas obtidas: f′(x) = 6x − 2.',
                    ],
                    result: 'Em x = 1: f′(1) = 6·1 − 2 = 4.',
                    interpretation: 'Perto de x = 1, a saída cresce aproximadamente 4 unidades para cada unidade adicional de x.',
                  ),
                  SizedBox(height: AppSpacing.xl),
                  LessonSectionHeader(
                    number: '3',
                    title: 'Escolha a regra pela estrutura',
                  ),
                  SizedBox(height: AppSpacing.md),
                  LessonConceptCard(
                    icon: Icons.account_tree_outlined,
                    title: 'A regra da cadeia acompanha camadas',
                    content: 'Em uma composição como (x² + 1)³, derive a camada externa e multiplique pela derivada da interna: 3(x² + 1)²·2x.',
                    emphasis: 'Erro comum: derivar apenas a parte externa e esquecer a derivada da expressão interna.',
                    tone: LearningCardTone.warning,
                  ),
                  SizedBox(height: AppSpacing.md),
                  LessonCheckCard(
                    question: 'Se f′(a) < 0, qual é a interpretação local mais adequada?',
                    choices: [
                      'A função está decrescendo perto de a.',
                      'A função é negativa em a.',
                      'A função obrigatoriamente vale zero em a.',
                    ],
                    correctIndex: 0,
                    explanation: 'O sinal da derivada descreve a direção da variação, não o sinal do valor da própria função.',
                  ),
                  SizedBox(height: AppSpacing.md),
                  LessonTakeawaysCard(
                    items: [
                      'Derivada é taxa de variação instantânea.',
                      'Geometricamente, ela mede a inclinação da tangente.',
                      'Constantes têm derivada zero e potências seguem n·xⁿ⁻¹.',
                      'Funções compostas exigem a regra da cadeia.',
                    ],
                  ),
                  SizedBox(height: AppSpacing.lg),
                  Text(
                    'A regra encontra a expressão; a interpretação explica o que esse resultado significa no problema.',
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
                text: 'Praticar derivadas',
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
