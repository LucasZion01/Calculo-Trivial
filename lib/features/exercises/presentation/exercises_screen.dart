import 'package:flutter/material.dart';

import 'package:calcquest/shared/theme/app_colors.dart';

import '../../result/presentation/result_screen.dart';

class ExercisesScreen extends StatelessWidget {
  const ExercisesScreen({super.key});

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
                'ExercÃ­cios',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Pratique Ãlgebra',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Resolva exercÃ­cios para fixar o conteÃºdo da aula.',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 24),
              Container(
                width: double.infinity,
                height: 300,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: AppColors.border,
                  ),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'QuestÃ£o 1 de 5',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primary,
                      ),
                    ),
                    SizedBox(height: 18),
                    Text(
                      'Simplifique a expressÃ£o:',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '3x + 5x - 2x',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: 22),
                    _AnswerOption(text: 'A) 6x'),
                    SizedBox(height: 10),
                    _AnswerOption(text: 'B) 8x'),
                    SizedBox(height: 10),
                    _AnswerOption(text: 'C) 10x'),
                    SizedBox(height: 10),
                    _AnswerOption(text: 'D) x'),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const ResultScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Confirmar resposta',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              const Center(
                child: Text(
                  '1/5 exercÃ­cios concluÃ­dos',
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
      bottomNavigationBar: const _ExercisesBottomNavigationBar(),
    );
  }
}

class _AnswerOption extends StatelessWidget {
  final String text;

  const _AnswerOption({
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 40,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.inputBorder,
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 14,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }
}

class _ExercisesBottomNavigationBar extends StatelessWidget {
  const _ExercisesBottomNavigationBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      decoration: const BoxDecoration(
        color: AppColors.white,
        border: Border(
          top: BorderSide(
            color: AppColors.border,
          ),
        ),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _BottomNavItem(
            label: 'InÃ­cio',
            isActive: false,
          ),
          _BottomNavItem(
            label: 'Trilha',
            isActive: true,
          ),
          _BottomNavItem(
            label: 'EstatÃ­sticas',
            isActive: false,
          ),
          _BottomNavItem(
            label: 'Perfil',
            isActive: false,
          ),
        ],
      ),
    );
  }
}

class _BottomNavItem extends StatelessWidget {
  final String label;
  final bool isActive;

  const _BottomNavItem({
    required this.label,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
        fontSize: 12,
        fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
        color: isActive ? AppColors.primary : AppColors.textSecondary,
      ),
    );
  }
}

