import 'package:flutter/material.dart';

import 'package:calcquest/shared/theme/app_colors.dart';
import 'package:calcquest/shared/theme/app_spacing.dart';
import 'package:calcquest/shared/theme/app_typography.dart';
import 'package:calcquest/shared/widgets/app_bottom_navigation_bar.dart';
import 'package:calcquest/shared/widgets/learning_content.dart';
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
                    eyebrow: 'Aula 2 • Comportamento',
                    title: 'Continuidade: quando tudo se conecta',
                    description: 'Identifique furos, saltos e interrupções comparando o valor da função com seu limite.',
                    duration: '≈ 5 min',
                    objective: 'testar as três condições de continuidade e classificar descontinuidades',
                    symbol: 'C',
                  ),
                  SizedBox(height: AppSpacing.xl),
                  LessonSectionHeader(
                    number: '1',
                    title: 'Comece pela intuição',
                  ),
                  SizedBox(height: AppSpacing.md),
                  LessonConceptCard(
                    icon: Icons.gesture_rounded,
                    title: 'Um traço sem interrupção local',
                    content: 'Perto de x = a, uma função contínua não apresenta furo, salto nem explosão. Ao aproximar x de a, as saídas caminham exatamente para o valor que a função possui naquele ponto.',
                    emphasis: '“Desenhar sem tirar o lápis” ajuda na intuição, mas a definição matemática é o critério decisivo.',
                  ),
                  SizedBox(height: AppSpacing.xl),
                  LessonSectionHeader(
                    number: '2',
                    title: 'Teste os três pilares',
                  ),
                  SizedBox(height: AppSpacing.md),
                  LessonConceptCard(
                    icon: Icons.checklist_rounded,
                    title: 'Existência, aproximação e encontro',
                    content: 'Para f ser contínua em x = a: (1) f(a) precisa existir; (2) lim x→a f(x) precisa existir; e (3) o limite deve ser igual a f(a).',
                    emphasis: 'Se uma única condição falhar, a função não é contínua naquele ponto.',
                    tone: LearningCardTone.information,
                  ),
                  SizedBox(height: AppSpacing.md),
                  WorkedExampleCard(
                    title: 'Um furo que foi preenchido corretamente',
                    problem: 'f(x) = (x² − 1)/(x − 1), se x≠1; e f(1)=2',
                    steps: [
                      'A função está definida no ponto: f(1) = 2.',
                      'Para x≠1, fatore x² − 1 = (x − 1)(x + 1) e simplifique para x + 1.',
                      'Calcule a aproximação: lim x→1 (x + 1) = 2.',
                      'Compare: o limite existe e é igual a f(1).',
                    ],
                    result: 'Conclusão: f é contínua em x = 1.',
                    interpretation: 'O valor definido no ponto preenche exatamente o furo que a expressão racional teria.',
                  ),
                  SizedBox(height: AppSpacing.xl),
                  LessonSectionHeader(
                    number: '3',
                    title: 'Reconheça o tipo de ruptura',
                  ),
                  SizedBox(height: AppSpacing.md),
                  LessonConceptCard(
                    icon: Icons.broken_image_outlined,
                    title: 'Furo, salto ou crescimento ilimitado',
                    content: 'Há descontinuidade removível quando o limite existe, mas o ponto está ausente ou possui valor incorreto. Há salto quando os limites laterais são finitos e diferentes. Há descontinuidade infinita quando os valores crescem sem limite.',
                    emphasis: 'Classificar a ruptura indica se ela pode ser corrigida alterando apenas o valor da função no ponto.',
                    tone: LearningCardTone.warning,
                  ),
                  SizedBox(height: AppSpacing.md),
                  LessonCheckCard(
                    question: 'Se lim x→a f(x) = 5, mas f(a) = 2, o que podemos concluir?',
                    choices: [
                      'f é contínua em a.',
                      'f possui descontinuidade removível em a.',
                      'O limite não existe.',
                    ],
                    correctIndex: 1,
                    explanation: 'O limite existe, porém não coincide com o valor da função. Redefinir f(a) como 5 removeria a descontinuidade.',
                  ),
                  SizedBox(height: AppSpacing.md),
                  LessonTakeawaysCard(
                    items: [
                      'Verifique se f(a) está definida.',
                      'Confirme que os dois limites laterais coincidem.',
                      'Compare o limite com f(a).',
                      'Use a falha encontrada para classificar a descontinuidade.',
                    ],
                  ),
                  SizedBox(height: AppSpacing.lg),
                  Text(
                    'Continuidade transforma a ideia visual de um gráfico sem rupturas em um teste matemático preciso.',
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
                text: 'Praticar continuidade',
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
