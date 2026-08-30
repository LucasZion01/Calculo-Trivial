import 'package:flutter/material.dart';

import 'package:calcquest/shared/theme/app_colors.dart';
import 'package:calcquest/shared/theme/app_spacing.dart';
import 'package:calcquest/shared/theme/app_typography.dart';
import 'package:calcquest/shared/widgets/app_bottom_navigation_bar.dart';
import 'package:calcquest/shared/widgets/learning_content.dart';
import 'package:calcquest/shared/widgets/primary_button.dart';

import '../../dashboard/presentation/dashboard_screen.dart';
import '../../learning_path/presentation/learning_path_screen.dart';
import '../../mini_challenge/presentation/mini_challenge_screen.dart';
import '../../profile/presentation/profile_screen.dart';
import '../../statistics/presentation/statistics_screen.dart';

class LessonScreen extends StatelessWidget {
  const LessonScreen({super.key});

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

  void _goToMiniChallenge(BuildContext context) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => const MiniChallengeScreen()));
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
                    eyebrow: 'Aula 1 • Fundamentos',
                    title: 'Álgebra: a caixa de ferramentas do Cálculo',
                    description:
                        'Aprenda a ler expressões, combinar termos e transformar fórmulas sem alterar seu valor.',
                    duration: '10–12 min',
                    objective:
                        'simplificar expressões e justificar cada transformação algébrica',
                    symbol: 'x',
                  ),
                  SizedBox(height: AppSpacing.xl),
                  LessonSectionHeader(
                    number: '1',
                    title: 'Leia antes de operar',
                  ),
                  SizedBox(height: AppSpacing.md),
                  LessonConceptCard(
                    icon: Icons.category_outlined,
                    title: 'Termos semelhantes pertencem à mesma família',
                    content:
                        'Em 2x + 3x, os dois termos possuem a mesma parte literal x. Por isso, somamos os coeficientes: 2 + 3 = 5, mantendo x. Já 2x + 3x² não pode ser reduzido, pois x e x² representam partes literais diferentes.',
                    emphasis:
                        'Coeficiente é o número que multiplica a parte literal. Em −4x², o coeficiente é −4.',
                  ),
                  SizedBox(height: AppSpacing.md),
                  LessonConceptCard(
                    icon: Icons.format_list_numbered_rounded,
                    title: 'A ordem das operações evita ambiguidades',
                    content:
                        'Resolva primeiro parênteses, depois potências e raízes, em seguida multiplicações e divisões e, por último, adições e subtrações.',
                    emphasis:
                        'Na expressão 2 + 3·4, a multiplicação vem primeiro: 2 + 12 = 14.',
                    tone: LearningCardTone.information,
                  ),
                  SizedBox(height: AppSpacing.xl),
                  LessonSectionHeader(
                    number: '2',
                    title: 'Transforme sem mudar o valor',
                  ),
                  SizedBox(height: AppSpacing.md),
                  LessonConceptCard(
                    icon: Icons.open_in_full_rounded,
                    title: 'Distributiva conecta produto e soma',
                    content:
                        'Multiplique o fator externo por cada termo interno: a(b + c) = ab + ac. O sinal também deve ser distribuído.',
                    emphasis:
                        'Exemplo: −2(x − 3) = −2x + 6. O produto de dois números negativos é positivo.',
                    tone: LearningCardTone.warning,
                  ),
                  SizedBox(height: AppSpacing.md),
                  WorkedExampleCard(
                    title: 'Simplificação organizada',
                    problem: '3(2x − 1) + 4x − 5',
                    steps: [
                      'Aplique a distributiva: 6x − 3 + 4x − 5.',
                      'Agrupe os termos com x: 6x + 4x = 10x.',
                      'Agrupe as constantes: −3 − 5 = −8.',
                    ],
                    result: 'Expressão simplificada: 10x − 8.',
                    interpretation:
                        'A expressão mudou de forma, mas conserva o mesmo valor para qualquer x.',
                  ),
                  SizedBox(height: AppSpacing.xl),
                  LessonSectionHeader(
                    number: '3',
                    title: 'Confirme a equivalência',
                  ),
                  SizedBox(height: AppSpacing.md),
                  LessonConceptCard(
                    icon: Icons.fact_check_outlined,
                    title: 'Teste com um valor simples',
                    content:
                        'Quando estiver em dúvida, escolha um valor como x = 1 e calcule a expressão original e a simplificada. Resultados diferentes revelam algum erro, embora um único teste igual não substitua a justificativa algébrica.',
                    tone: LearningCardTone.success,
                  ),
                  SizedBox(height: AppSpacing.md),
                  LessonCheckCard(
                    question: 'Qual é a forma simplificada de 2(x + 3) − x?',
                    choices: ['x + 6', '2x + 3', 'x + 3'],
                    correctIndex: 0,
                    explanation:
                        'A distributiva produz 2x + 6. Depois, 2x − x = x, resultando em x + 6.',
                  ),
                  SizedBox(height: AppSpacing.md),
                  LessonTakeawaysCard(
                    items: [
                      'Combine apenas termos com a mesma parte literal.',
                      'Respeite a ordem das operações.',
                      'Distribua também os sinais negativos.',
                      'Uma transformação correta preserva o valor da expressão.',
                    ],
                  ),
                  SizedBox(height: AppSpacing.lg),
                  Text(
                    'A álgebra bem organizada reduz erros e libera sua atenção para compreender as ideias do Cálculo.',
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
                text: 'Fazer desafio rápido',
                icon: Icons.bolt_rounded,
                onPressed: () => _goToMiniChallenge(context),
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
