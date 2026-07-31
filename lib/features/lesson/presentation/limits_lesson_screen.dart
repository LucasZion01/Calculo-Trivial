import 'package:flutter/material.dart';

import 'package:calcquest/shared/theme/app_colors.dart';
import 'package:calcquest/shared/widgets/app_bottom_navigation_bar.dart';
import 'package:calcquest/shared/widgets/primary_button.dart';

import '../../dashboard/presentation/dashboard_screen.dart';
import '../../learning_path/presentation/learning_path_screen.dart';
import '../../profile/presentation/profile_screen.dart';
import '../../statistics/presentation/statistics_screen.dart';

class LimitsLessonScreen extends StatelessWidget {
  const LimitsLessonScreen({super.key});

  void _onMenuTap(BuildContext context, int index) {
    if (index == 0) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (_) => const DashboardScreen(),
        ),
        (route) => false,
      );
    }

    if (index == 1) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (_) => const LearningPathScreen(),
        ),
        (route) => false,
      );
    }

    if (index == 2) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (_) => const StatisticsScreen(),
        ),
        (route) => false,
      );
    }

    if (index == 3) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (_) => const ProfileScreen(),
        ),
        (route) => false,
      );
    }
  }

  void _showExercisesMessage(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Na próxima etapa, criaremos os exercícios de Limites.'),
      ),
    );
  }

  Widget _buildConceptCard({
    required String title,
    required String content,
    required String symbol,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: AppColors.border,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 46,
            height: 46,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.selectedBackground,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Text(
              symbol,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: AppColors.primary,
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  content,
                  style: const TextStyle(
                    fontSize: 14,
                    height: 1.45,
                    color: AppColors.textSecondary,
                  ),
                ),
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
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Exemplo rápido',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.primaryLight,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'lim x → 2  (x + 3)',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: AppColors.white,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Como a expressão x + 3 não tem problema em x = 2, basta substituir x por 2.',
            style: TextStyle(
              fontSize: 14,
              height: 1.45,
              color: AppColors.primaryLight,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Resultado: 2 + 3 = 5',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.white,
            ),
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
          padding: const EdgeInsets.fromLTRB(24, 40, 24, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Aula 1 — Limites',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Entenda a ideia de aproximação antes das regras formais.',
                style: TextStyle(
                  fontSize: 14,
                  height: 1.4,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: ListView(
                  children: [
                    _buildConceptCard(
                      title: 'O que é limite?',
                      symbol: 'lim',
                      content:
                          'Limite descreve o valor que uma função se aproxima quando x chega perto de determinado número. O foco não é exatamente o ponto, mas o comportamento perto dele.',
                    ),
                    const SizedBox(height: 16),
                    _buildConceptCard(
                      title: 'Ideia intuitiva',
                      symbol: '→',
                      content:
                          'Quando escrevemos x → 2, estamos dizendo que x está se aproximando de 2. Ele pode vir pela esquerda, pela direita ou pelos dois lados.',
                    ),
                    const SizedBox(height: 16),
                    _buildConceptCard(
                      title: 'Substituição direta',
                      symbol: 'x',
                      content:
                          'Em muitos limites simples, basta substituir o valor de x na expressão. Isso funciona quando a função não gera divisão por zero ou outra indeterminação.',
                    ),
                    const SizedBox(height: 16),
                    _buildExampleCard(),
                    const SizedBox(height: 16),
                    _buildConceptCard(
                      title: 'Atenção',
                      symbol: '!',
                      content:
                          'Nem todo limite pode ser resolvido só substituindo. Em alguns casos aparecem formas como 0/0, exigindo fatoração, simplificação ou outra estratégia.',
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
              PrimaryButton(
                text: 'Iniciar exercícios',
                onPressed: () {
                  _showExercisesMessage(context);
                },
              ),
              const SizedBox(height: 24),
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