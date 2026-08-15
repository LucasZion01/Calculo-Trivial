import 'package:flutter/material.dart';

import 'package:calcquest/shared/data/mock_learning_data.dart';
import 'package:calcquest/shared/state/app_progress.dart';
import 'package:calcquest/shared/theme/app_colors.dart';
import 'package:calcquest/shared/widgets/app_bottom_navigation_bar.dart';
import 'package:calcquest/shared/widgets/math_card.dart';

import '../../dashboard/presentation/dashboard_screen.dart';
import '../../learning_path/presentation/learning_path_screen.dart';
import '../../lesson/presentation/equations_lesson_screen.dart';
import '../../lesson/presentation/functions_lesson_screen.dart';
import '../../lesson/presentation/lesson_screen.dart';
import '../../profile/presentation/profile_screen.dart';
import '../../statistics/presentation/statistics_screen.dart';

class ModuleDetailScreen extends StatelessWidget {
  const ModuleDetailScreen({super.key});

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

  void _goToLesson(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const LessonScreen(),
      ),
    );
  }

  void _goToEquationsLesson(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const EquationsLessonScreen(),
      ),
    );
  }

  void _goToFunctionsLesson(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const FunctionsLessonScreen(),
      ),
    );
  }

  int _completedLessons() {
    int completed = 0;

    if (AppProgress.algebraFundamentalCompleted) {
      completed++;
    }

    if (AppProgress.equationsAndInequationsCompleted) {
      completed++;
    }

    if (AppProgress.functionsCompleted) {
      completed++;
    }

    return completed;
  }

  String _moduleProgressText() {
    final completed = _completedLessons();

    if (completed == 0) {
      return '0%';
    }

    if (completed == 1) {
      return '33%';
    }

    if (completed == 2) {
      return '66%';
    }

    return '100%';
  }

  double _moduleProgressValue() {
    final completed = _completedLessons();

    if (completed == 0) {
      return 0;
    }

    if (completed == 1) {
      return 0.33;
    }

    if (completed == 2) {
      return 0.66;
    }

    return 1;
  }

  String _moduleProgressDescription() {
    if (AppProgress.functionsCompleted) {
      return 'Módulo concluído';
    }

    if (AppProgress.equationsAndInequationsCompleted) {
      return 'Aula 2 concluída';
    }

    if (AppProgress.algebraFundamentalCompleted) {
      return 'Aula 1 concluída';
    }

    return 'Comece pela primeira aula';
  }

  String _getLessonStatus(LessonData lesson) {
    if (lesson.id == 'algebra-fundamental' &&
        AppProgress.algebraFundamentalCompleted) {
      return 'Concluída';
    }

    if (lesson.id == 'equacoes-inequacoes' &&
        AppProgress.equationsAndInequationsCompleted) {
      return 'Concluída';
    }

    if (lesson.id == 'equacoes-inequacoes' &&
        AppProgress.algebraFundamentalCompleted) {
      return 'Desbloqueada';
    }

    if (lesson.id == 'funcoes' && AppProgress.functionsCompleted) {
      return 'Concluída';
    }

    if (lesson.id == 'funcoes' &&
        AppProgress.equationsAndInequationsCompleted) {
      return 'Desbloqueada';
    }

    return lesson.status;
  }

  bool _isLessonUnlocked(LessonData lesson) {
    if (lesson.id == 'algebra-fundamental') {
      return true;
    }

    if (lesson.id == 'equacoes-inequacoes' &&
        AppProgress.algebraFundamentalCompleted) {
      return true;
    }

    if (lesson.id == 'funcoes' &&
        AppProgress.equationsAndInequationsCompleted) {
      return true;
    }

    return lesson.isUnlocked;
  }

  Color _getLessonStatusColor(LessonData lesson) {
    if (lesson.id == 'algebra-fundamental' &&
        AppProgress.algebraFundamentalCompleted) {
      return AppColors.primary;
    }

    if (lesson.id == 'equacoes-inequacoes' &&
        AppProgress.algebraFundamentalCompleted) {
      return AppColors.primary;
    }

    if (lesson.id == 'funcoes' &&
        AppProgress.equationsAndInequationsCompleted) {
      return AppColors.primary;
    }

    return lesson.isUnlocked ? AppColors.primary : AppColors.textMuted;
  }

  void _handleLessonTap(BuildContext context, LessonData lesson) {
    if (lesson.id == 'algebra-fundamental') {
      _goToLesson(context);
      return;
    }

    if (lesson.id == 'equacoes-inequacoes' &&
        AppProgress.algebraFundamentalCompleted) {
      _goToEquationsLesson(context);
      return;
    }

    if (lesson.id == 'funcoes' &&
        AppProgress.equationsAndInequationsCompleted) {
      _goToFunctionsLesson(context);
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Esta aula ainda está bloqueada.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final module = mockModules.first;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 32, 24, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                module.title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Construa a base necessária para estudar Cálculo.',
                style: TextStyle(
                  fontSize: 14,
                  height: 1.4,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Progresso do módulo',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.primaryLight,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _moduleProgressText(),
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                        color: AppColors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    LinearProgressIndicator(
                      value: _moduleProgressValue(),
                      minHeight: 6,
                      borderRadius: BorderRadius.circular(12),
                      backgroundColor: AppColors.primaryLight,
                      color: AppColors.white,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _moduleProgressDescription(),
                      style: const TextStyle(
                        fontSize: 13,
                        height: 1.3,
                        color: AppColors.primaryLight,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Aulas',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.only(bottom: 24),
                  itemCount: module.lessons.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    final lesson = module.lessons[index];
                    final isUnlocked = _isLessonUnlocked(lesson);

                    return MathCard(
                      title: lesson.title,
                      subtitle: lesson.subtitle,
                      symbol: lesson.symbol,
                      status: _getLessonStatus(lesson),
                      statusColor: _getLessonStatusColor(lesson),
                      onTap: isUnlocked
                          ? () {
                              _handleLessonTap(context, lesson);
                            }
                          : null,
                    );
                  },
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