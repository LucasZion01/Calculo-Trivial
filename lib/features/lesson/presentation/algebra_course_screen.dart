import 'package:flutter/material.dart';

import 'package:calcquest/shared/data/algebra_course_data.dart';
import 'package:calcquest/shared/domain/course_lesson_data.dart';
import 'package:calcquest/shared/state/app_progress.dart';
import 'package:calcquest/shared/theme/app_colors.dart';
import 'package:calcquest/shared/theme/app_spacing.dart';
import 'package:calcquest/shared/theme/app_typography.dart';
import 'package:calcquest/shared/widgets/app_progress_bar.dart';
import 'package:calcquest/shared/widgets/math_card.dart';
import 'package:calcquest/shared/widgets/primary_button.dart';

import '../../exercises/presentation/exercises_screen.dart';
import 'course_lesson_screen.dart';

class AlgebraCourseScreen extends StatefulWidget {
  const AlgebraCourseScreen({super.key});

  @override
  State<AlgebraCourseScreen> createState() => _AlgebraCourseScreenState();
}

class _AlgebraCourseScreenState extends State<AlgebraCourseScreen> {
  int get _completedCount => algebraCourseLessons
      .where((lesson) => AppProgress.isContentLessonCompleted(lesson.id))
      .length;

  bool _isUnlocked(int index) {
    return index == 0 ||
        AppProgress.isContentLessonCompleted(
          algebraCourseLessons[index - 1].id,
        );
  }

  Future<void> _openLesson(int index) async {
    if (!_isUnlocked(index)) return;

    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => _buildLessonScreen(index),
      ),
    );

    if (mounted) setState(() {});
  }

  CourseLessonScreen _buildLessonScreen(int index) {
    final lesson = algebraCourseLessons[index];
    final isLast = index == algebraCourseLessons.length - 1;

    return CourseLessonScreen(
      lesson: lesson,
      onComplete: () => AppProgress.completeContentLesson(lesson.id),
      actionLabel: isLast ? 'Concluir aula' : 'Concluir e continuar',
      nextDestination: isLast
          ? null
          : (_) => _buildLessonScreen(index + 1),
    );
  }

  void _openExercises() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const ExercisesScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final completedCount = _completedCount;
    final total = algebraCourseLessons.length;
    final progress = completedCount / total;
    final canPractice = completedCount == total;

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
                      'Álgebra Fundamental',
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
                  Container(
                    padding: const EdgeInsets.all(AppSpacing.cardPaddingLarge),
                    decoration: BoxDecoration(
                      color: AppColors.navy,
                      borderRadius: BorderRadius.circular(
                        AppSpacing.radiusXLarge,
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: AppColors.shadow,
                          blurRadius: 16,
                          offset: Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'BASE PARA TODO O CÁLCULO',
                          style: AppTypography.labelSmall.copyWith(
                            color: AppColors.secondaryLight,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          'Transforme símbolos em estratégia',
                          style: AppTypography.headingMedium.copyWith(
                            color: AppColors.white,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        Text(
                          'Variáveis, simplificação, distributiva, potências, '
                          'produtos notáveis, fatoração e frações algébricas.',
                          style: AppTypography.bodyMedium.copyWith(
                            color: AppColors.primaryLight,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.lg),
                        AppProgressBar(
                          value: progress,
                          state: canPractice
                              ? AppProgressBarState.success
                              : AppProgressBarState.normal,
                          height: 8,
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        Text(
                          '$completedCount de $total aulas concluídas',
                          style: AppTypography.labelMedium.copyWith(
                            color: AppColors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  Text('Sua jornada', style: AppTypography.titleLarge),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    'A Álgebra é a oficina do Cálculo. Cada aula ensina uma '
                    'ferramenta que você vai usar em limites, funções e derivadas.',
                    style: AppTypography.bodyMedium,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  for (var index = 0;
                      index < algebraCourseLessons.length;
                      index++) ...[
                    _LessonCard(
                      number: index + 1,
                      lesson: algebraCourseLessons[index],
                      isCompleted: AppProgress.isContentLessonCompleted(
                        algebraCourseLessons[index].id,
                      ),
                      isUnlocked: _isUnlocked(index),
                      onTap: () => _openLesson(index),
                    ),
                    const SizedBox(height: AppSpacing.md),
                  ],
                  const SizedBox(height: AppSpacing.sm),
                  Container(
                    padding: const EdgeInsets.all(AppSpacing.cardPaddingLarge),
                    decoration: BoxDecoration(
                      color: canPractice
                          ? AppColors.successLight
                          : AppColors.surfaceSecondary,
                      borderRadius: BorderRadius.circular(
                        AppSpacing.radiusLarge,
                      ),
                      border: Border.all(
                        color: canPractice
                            ? AppColors.success
                            : AppColors.border,
                      ),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          canPractice
                              ? Icons.rocket_launch_outlined
                              : Icons.lock_outline_rounded,
                          color: canPractice
                              ? AppColors.successDark
                              : AppColors.locked,
                          size: 32,
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        Text(
                          canPractice
                              ? 'Pronto para praticar'
                              : 'Prática final bloqueada',
                          style: AppTypography.titleMedium,
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          canPractice
                              ? 'Resolva uma sessão de exercícios e descubra '
                                  'quais pontos ainda precisam de revisão.'
                              : 'Conclua as oito aulas para liberar a prática '
                                  'final de Álgebra Fundamental.',
                          textAlign: TextAlign.center,
                          style: AppTypography.bodyMedium,
                        ),
                        const SizedBox(height: AppSpacing.md),
                        PrimaryButton(
                          text: 'Iniciar exercícios',
                          icon: Icons.play_arrow_rounded,
                          onPressed: canPractice ? _openExercises : null,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LessonCard extends StatelessWidget {
  final int number;
  final CourseLessonData lesson;
  final bool isCompleted;
  final bool isUnlocked;
  final VoidCallback onTap;

  const _LessonCard({
    required this.number,
    required this.lesson,
    required this.isCompleted,
    required this.isUnlocked,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final status = isCompleted
        ? 'Concluída'
        : isUnlocked
        ? 'Disponível'
        : 'Bloqueada';

    return MathCard(
      title: 'Aula $number — ${lesson.title}',
      subtitle: '${lesson.duration} • ${lesson.description}',
      symbol: lesson.symbol,
      status: status,
      statusColor: isCompleted
          ? AppColors.success
          : isUnlocked
          ? AppColors.primary
          : AppColors.locked,
      state: isCompleted
          ? MathCardState.completed
          : isUnlocked
          ? MathCardState.normal
          : MathCardState.locked,
      onTap: isUnlocked ? onTap : null,
    );
  }
}
