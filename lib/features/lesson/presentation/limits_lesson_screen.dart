import 'package:flutter/material.dart';

import 'package:calcquest/shared/theme/app_colors.dart';
import 'package:calcquest/shared/theme/app_spacing.dart';
import 'package:calcquest/shared/theme/app_typography.dart';
import 'package:calcquest/shared/widgets/app_bottom_navigation_bar.dart';
import 'package:calcquest/shared/widgets/learning_content.dart';
import 'package:calcquest/shared/widgets/primary_button.dart';

import '../../dashboard/presentation/dashboard_screen.dart';
import '../../exercises/presentation/limits_exercises_screen.dart';
import '../../learning_path/presentation/learning_path_screen.dart';
import '../../profile/presentation/profile_screen.dart';
import '../../statistics/presentation/statistics_screen.dart';

class LimitsLessonScreen extends StatelessWidget {
  const LimitsLessonScreen({super.key});

  void _onMenuTap(BuildContext context, int index) {
    final destination = switch (index) {
      0 => const DashboardScreen(),
      1 => const LearningPathScreen(),
      2 => const StatisticsScreen(),
      3 => const ProfileScreen(),
      _ => null,
    };

    if (destination == null) return;

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => destination),
      (route) => false,
    );
  }

  void _goToExercises(BuildContext context) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => const LimitsExercisesScreen()));
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
                    eyebrow: 'Aula 1 • Fundamentos',
                    title: 'Limites sem decorar receitas',
                    description:
                        'Descubra como prever o comportamento de uma função quando x se aproxima de um ponto.',
                    duration: '≈ 5 min',
                    objective:
                        'interpretar a notação de limite, escolher uma estratégia e justificar o resultado',
                    symbol: 'lim',
                  ),
                  SizedBox(height: AppSpacing.xl),
                  LessonSectionHeader(
                    number: '1',
                    title: 'Primeiro, forme a imagem mental',
                    subtitle:
                        'O limite observa a aproximação, não apenas o ponto final.',
                  ),
                  SizedBox(height: AppSpacing.md),
                  LessonConceptCard(
                    icon: Icons.route_outlined,
                    title: 'Pense em uma estrada',
                    content:
                        'Imagine que x é um carro seguindo por uma estrada e f(x) é a altitude do carro. Quando x chega cada vez mais perto do quilômetro 2, observamos para qual altitude f(x) se aproxima. Essa altitude prevista é o limite.',
                    emphasis:
                        'O carro não precisa estacionar exatamente no quilômetro 2. Para estudar o limite, importa o que acontece bem perto dele.',
                  ),
                  SizedBox(height: AppSpacing.md),
                  LessonConceptCard(
                    icon: Icons.compare_arrows_rounded,
                    title: 'Aproximação pelos dois lados',
                    content:
                        'Podemos chegar ao ponto usando valores menores, como 1,9 e 1,99, ou valores maiores, como 2,1 e 2,01. O limite existe quando as duas aproximações conduzem ao mesmo valor.',
                    emphasis:
                        'Se o lado esquerdo e o lado direito chegam a valores diferentes, o limite bilateral não existe.',
                    tone: LearningCardTone.information,
                  ),
                  SizedBox(height: AppSpacing.xl),
                  LessonSectionHeader(
                    number: '2',
                    title: 'Leia a linguagem matemática',
                    subtitle:
                        'Cada parte da notação responde a uma pergunta.',
                  ),
                  SizedBox(height: AppSpacing.md),
                  LessonConceptCard(
                    icon: Icons.translate_rounded,
                    title: 'lim x→a f(x) = L',
                    content:
                        'Lemos: “o limite de f(x), quando x tende a a, é L”. O símbolo x→a informa de qual ponto nos aproximamos. A letra L representa o valor para o qual as saídas da função caminham.',
                    emphasis:
                        'O limite pode existir mesmo quando f(a) não existe ou quando f(a) é diferente de L.',
                  ),
                  SizedBox(height: AppSpacing.xl),
                  LessonSectionHeader(
                    number: '3',
                    title: 'Escolha a estratégia',
                    subtitle:
                        'Comece sempre pela tentativa mais simples e avance somente se necessário.',
                  ),
                  SizedBox(height: AppSpacing.md),
                  LessonConceptCard(
                    icon: Icons.looks_one_outlined,
                    title: 'Passo 1 — substituição direta',
                    content:
                        'Substitua x pelo valor indicado. Se o resultado for um número real bem definido, esse normalmente é o limite em polinômios e outras funções contínuas.',
                    emphasis:
                        'Exemplo: lim x→3 (2x + 1) = 2·3 + 1 = 7.',
                    tone: LearningCardTone.success,
                  ),
                  SizedBox(height: AppSpacing.md),
                  LessonConceptCard(
                    icon: Icons.build_outlined,
                    title: 'Passo 2 — trate a indeterminação',
                    content:
                        'Se a substituição produzir 0/0, ainda não encontramos a resposta. A expressão precisa ser reescrita por fatoração, racionalização ou outra equivalência válida para revelar seu comportamento.',
                    emphasis:
                        '0/0 não é zero e também não é o resultado do limite: é um aviso para continuar a análise.',
                    tone: LearningCardTone.warning,
                  ),
                  SizedBox(height: AppSpacing.md),
                  WorkedExampleCard(
                    title: 'Fatoração elimina a indeterminação',
                    problem: 'lim x→2  (x² − 4)/(x − 2)',
                    steps: [
                      'Substitua x = 2: obtemos (4 − 4)/(2 − 2) = 0/0. Isso indica uma indeterminação.',
                      'Reconheça a diferença de quadrados: x² − 4 = (x − 2)(x + 2).',
                      'Para x ≠ 2, simplifique o fator comum x − 2. A expressão passa a se comportar como x + 2.',
                      'Agora calcule a aproximação: quando x→2, x + 2→4.',
                    ],
                    result: 'Resultado: o limite é 4.',
                    interpretation:
                        'Embora a expressão original não esteja definida em x = 2, os valores próximos de 2 se aproximam de 4. É exatamente esse comportamento que o limite descreve.',
                  ),
                  SizedBox(height: AppSpacing.xl),
                  LessonSectionHeader(
                    number: '4',
                    title: 'Evite os atalhos que causam erro',
                  ),
                  SizedBox(height: AppSpacing.md),
                  LessonConceptCard(
                    icon: Icons.warning_amber_rounded,
                    title: 'Erro comum: cancelar termos',
                    content:
                        'Só podemos cancelar fatores que multiplicam toda a expressão. Não é permitido cancelar partes separadas por soma ou subtração.',
                    emphasis:
                        'Correto: (x − 2)(x + 2)/(x − 2) = x + 2, para x ≠ 2. Incorreto: cancelar o x em (x² − 4)/(x − 2).',
                    tone: LearningCardTone.warning,
                  ),
                  SizedBox(height: AppSpacing.md),
                  LessonCheckCard(
                    question:
                        'Ao substituir diretamente em um limite, você encontrou 0/0. O que isso significa?',
                    choices: [
                      'O limite é automaticamente zero.',
                      'O limite não existe em qualquer situação.',
                      'A expressão precisa ser transformada antes da conclusão.',
                    ],
                    correctIndex: 2,
                    explanation:
                        'A forma 0/0 é indeterminada. Ela pede uma nova análise, como fatoração ou racionalização; o resultado final pode ser zero, outro número ou até não existir.',
                  ),
                  SizedBox(height: AppSpacing.md),
                  LessonTakeawaysCard(
                    items: [
                      'Limite descreve o valor de aproximação de f(x).',
                      'Compare os comportamentos pela esquerda e pela direita.',
                      'Tente primeiro a substituição direta.',
                      'Diante de 0/0, transforme a expressão e justifique cada passo.',
                    ],
                  ),
                  SizedBox(height: AppSpacing.lg),
                  Text(
                    'Você não precisa memorizar tudo agora. Os exercícios vão transformar essa sequência de decisões em hábito.',
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
                text: 'Praticar limites',
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
