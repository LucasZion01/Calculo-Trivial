import 'package:flutter/material.dart';

import 'package:calcquest/shared/data/mock_exercise_data.dart';
import 'package:calcquest/shared/data/mock_limits_exercise_data.dart';
import 'package:calcquest/shared/theme/app_colors.dart';
import 'package:calcquest/shared/widgets/app_bottom_navigation_bar.dart';
import 'package:calcquest/shared/widgets/primary_button.dart';

import '../../dashboard/presentation/dashboard_screen.dart';
import '../../learning_path/presentation/learning_path_screen.dart';
import '../../profile/presentation/profile_screen.dart';
import '../../result/presentation/result_screen.dart';
import '../../statistics/presentation/statistics_screen.dart';

class LimitsExercisesScreen extends StatefulWidget {
  const LimitsExercisesScreen({super.key});

  @override
  State<LimitsExercisesScreen> createState() => _LimitsExercisesScreenState();
}

class _LimitsExercisesScreenState extends State<LimitsExercisesScreen> {
  int currentExerciseIndex = 0;
  String? selectedOptionId;

  ExerciseData get currentExercise =>
      mockLimitsExercises[currentExerciseIndex];

  bool get isLastExercise =>
      currentExerciseIndex == mockLimitsExercises.length - 1;

  double get progress =>
      (currentExerciseIndex + 1) / mockLimitsExercises.length;

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

  void _confirmAnswer() {
    if (selectedOptionId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Escolha uma alternativa antes de continuar.'),
        ),
      );
      return;
    }

    if (selectedOptionId != currentExercise.correctOptionId) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Resposta incorreta. Tente novamente.'),
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(currentExercise.explanation),
      ),
    );

    if (isLastExercise) {
      Future.delayed(const Duration(milliseconds: 700), () {
        if (!mounted) return;

        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => ResultScreen(
              completedLessonId: 'limites',
              totalQuestions: mockLimitsExercises.length,
              correctAnswers: mockLimitsExercises.length,
              xpEarned: 90,
              goldEarned: 40,
            ),
          ),
        );
      });

      return;
    }

    setState(() {
      currentExerciseIndex++;
      selectedOptionId = null;
    });
  }

  String _letterForIndex(int index) {
    const letters = ['A', 'B', 'C', 'D'];
    return letters[index];
  }

  Widget _buildOption({
    required ExerciseOptionData option,
    required int index,
  }) {
    final isSelected = selectedOptionId == option.id;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedOptionId = option.id;
        });
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.selectedBackground : AppColors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 34,
              height: 34,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : AppColors.background,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                _letterForIndex(index),
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: isSelected ? AppColors.white : AppColors.textSecondary,
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                option.text,
                style: const TextStyle(
                  fontSize: 16,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final exercise = currentExercise;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 40, 24, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'QuestÃ£o ${currentExerciseIndex + 1} de ${mockLimitsExercises.length}',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Resolva o limite usando a estratÃ©gia adequada.',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 16),
              LinearProgressIndicator(
                value: progress,
                minHeight: 8,
                borderRadius: BorderRadius.circular(12),
                backgroundColor: AppColors.border,
                color: AppColors.primary,
              ),
              const SizedBox(height: 24),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: AppColors.border,
                  ),
                ),
                child: Text(
                  exercise.statement,
                  style: const TextStyle(
                    fontSize: 20,
                    height: 1.4,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: ListView.separated(
                  itemCount: exercise.options.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final option = exercise.options[index];

                    return _buildOption(
                      option: option,
                      index: index,
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              PrimaryButton(
                text:
                    isLastExercise ? 'Finalizar exercÃ­cios' : 'PrÃ³xima questÃ£o',
                onPressed: _confirmAnswer,
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
