import 'package:flutter/material.dart';

import 'package:calcquest/shared/theme/app_colors.dart';

import '../../../shared/widgets/app_bottom_navigation_bar.dart';
import '../../../shared/widgets/primary_button.dart';
import '../../dashboard/presentation/dashboard_screen.dart';
import '../../exercises/presentation/exercises_screen.dart';
import '../../learning_path/presentation/learning_path_screen.dart';
import '../../profile/presentation/profile_screen.dart';
import '../../statistics/presentation/statistics_screen.dart';

class MiniChallengeScreen extends StatefulWidget {
  const MiniChallengeScreen({super.key});

  @override
  State<MiniChallengeScreen> createState() => _MiniChallengeScreenState();
}

class _MiniChallengeScreenState extends State<MiniChallengeScreen> {
  String? selectedAnswer;

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

  void _selectAnswer(String answer) {
    setState(() {
      selectedAnswer = answer;
    });
  }

  void _confirmAnswer() {
    if (selectedAnswer == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Escolha uma alternativa antes de responder.'),
        ),
      );
      return;
    }

    if (selectedAnswer == 'A') {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => const ExercisesScreen(),
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Resposta incorreta. Tente novamente.'),
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
                'Mini Desafio',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Teste rÃ¡pido',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Escolha a resposta correta para liberar os prÃ³ximos exercÃ­cios.',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 24),
              Container(
                width: double.infinity,
                height: 260,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: AppColors.border,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Qual Ã© o resultado de 4x + 2x?',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 24),
                    _AnswerOption(
                      text: 'A) 6x',
                      isSelected: selectedAnswer == 'A',
                      onTap: () {
                        _selectAnswer('A');
                      },
                    ),
                    const SizedBox(height: 12),
                    _AnswerOption(
                      text: 'B) 8x',
                      isSelected: selectedAnswer == 'B',
                      onTap: () {
                        _selectAnswer('B');
                      },
                    ),
                    const SizedBox(height: 12),
                    _AnswerOption(
                      text: 'C) 4xÂ²',
                      isSelected: selectedAnswer == 'C',
                      onTap: () {
                        _selectAnswer('C');
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              PrimaryButton(
                text: 'Responder',
                onPressed: _confirmAnswer,
              ),
              const SizedBox(height: 12),
              const Center(
                child: Text(
                  'VocÃª ganha XP ao acertar o desafio.',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
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

class _AnswerOption extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const _AnswerOption({
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isSelected ? AppColors.selectedBackground : AppColors.white,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: double.infinity,
          height: 44,
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected
                  ? AppColors.primary
                  : AppColors.inputBorder,
              width: isSelected ? 2 : 1,
            ),
          ),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              color: isSelected
                  ? AppColors.primary
                  : AppColors.textPrimary,
            ),
          ),
        ),
      ),
    );
  }
}

