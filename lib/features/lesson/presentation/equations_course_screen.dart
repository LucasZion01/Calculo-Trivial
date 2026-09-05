import 'package:flutter/material.dart';

import 'package:calcquest/shared/data/equations_course_data.dart';
import 'package:calcquest/shared/data/localized_equations_course_data.dart';
import 'package:calcquest/shared/domain/course_lesson_data.dart';
import 'package:calcquest/shared/localization/lesson_ui_text.dart';
import 'package:calcquest/shared/state/app_progress.dart';
import 'package:calcquest/shared/theme/app_colors.dart';
import 'package:calcquest/shared/theme/app_spacing.dart';
import 'package:calcquest/shared/theme/app_typography.dart';
import 'package:calcquest/shared/widgets/app_progress_bar.dart';
import 'package:calcquest/shared/widgets/math_card.dart';
import 'package:calcquest/shared/widgets/primary_button.dart';

import '../../exercises/presentation/equations_exercises_screen.dart';
import 'course_lesson_screen.dart';

class EquationsCourseScreen extends StatefulWidget {
  const EquationsCourseScreen({super.key});

  @override
  State<EquationsCourseScreen> createState() => _EquationsCourseScreenState();
}

class _EquationsCourseScreenState extends State<EquationsCourseScreen> {
  List<CourseLessonData> get _lessons =>
      localizedEquationsCourseLessons(Localizations.localeOf(context));

  int get _completedCount => equationsCourseLessons
      .where((lesson) => AppProgress.isContentLessonCompleted(lesson.id))
      .length;

  bool _isUnlocked(int index) {
    return index == 0 ||
        AppProgress.isContentLessonCompleted(equationsCourseLessons[index - 1].id);
  }

  Future<void> _openLesson(int index) async {
    if (!_isUnlocked(index)) return;

    await Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => _buildLessonScreen(index)),
    );

    if (mounted) setState(() {});
  }

  CourseLessonScreen _buildLessonScreen(int index) {
    final lessons = _lessons;
    final lesson = lessons[index];
    final isLast = index == lessons.length - 1;
    final uiText = LessonUiText.of(context);

    return CourseLessonScreen(
      lesson: lesson,
      onComplete: () => AppProgress.completeContentLesson(lesson.id),
      actionLabel: isLast ? uiText.completeLesson : uiText.completeAndContinue,
      nextDestination: isLast ? null : (_) => _buildLessonScreen(index + 1),
    );
  }

  void _openExercises() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const EquationsExercisesScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final lessons = _lessons;
    final completedCount = _completedCount;
    final total = lessons.length;
    final progress = total == 0 ? 0.0 : completedCount / total;
    final canPractice = completedCount == total;
    final uiText = LessonUiText.of(context);
    final isEnglish = Localizations.localeOf(context).languageCode == 'en';

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
                    tooltip: uiText.back,
                    onPressed: () => Navigator.of(context).maybePop(),
                    icon: const Icon(Icons.arrow_back_rounded),
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  Expanded(
                    child: Text(
                      isEnglish
                          ? 'Equations and Inequalities'
                          : 'Equações e Inequações',
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
                      borderRadius: BorderRadius.circular(AppSpacing.radiusXLarge),
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
                          isEnglish
                              ? 'SOLVE, INTERPRET, AND COMPARE'
                              : 'RESOLVA, INTERPRETE E COMPARE',
                          style: AppTypography.labelSmall.copyWith(
                            color: AppColors.secondaryLight,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          isEnglish
                              ? 'Turn relationships into solutions'
                              : 'Transforme relações em soluções',
                          style: AppTypography.headingMedium.copyWith(
                            color: AppColors.white,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        Text(
                          isEnglish
                              ? 'Linear equations, fractions, systems, quadratics, inequalities, absolute value, and special cases.'
                              : 'Equações lineares, frações, sistemas, quadráticas, inequações, módulo e casos especiais.',
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
                          isEnglish
                              ? '$completedCount of $total lessons completed'
                              : '$completedCount de $total aulas concluídas',
                          style: AppTypography.labelMedium.copyWith(
                            color: AppColors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  Text(
                    isEnglish ? 'Your journey' : 'Sua jornada',
                    style: AppTypography.titleLarge,
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    isEnglish
                        ? 'Learn to recognize the problem type, choose the right strategy, and justify each transformation.'
                        : 'Aprenda a reconhecer o tipo de problema, escolher a estratégia correta e justificar cada transformação.',
                    style: AppTypography.bodyMedium,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  for (var index = 0; index < lessons.length; index++) ...[
                    _LessonCard(
                      number: index + 1,
                      lesson: lessons[index],
                      isCompleted: AppProgress.isContentLessonCompleted(
                        lessons[index].id,
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
                      borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
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
                              ? (isEnglish
                                    ? 'Ready for guided practice'
                                    : 'Pronto para a prática guiada')
                              : (isEnglish
                                    ? 'Practice flow locked'
                                    : 'Fluxo de prática bloqueado'),
                          style: AppTypography.titleMedium,
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          canPractice
                              ? (isEnglish
                                    ? 'Start guided practice, review any mistakes, and then take a separate final test.'
                                    : 'Faça a prática guiada, revise os erros e depois realize um teste final separado.')
                              : (isEnglish
                                    ? 'Complete all eight lessons to unlock guided practice, error review, and the final test.'
                                    : 'Conclua as oito aulas para liberar a prática guiada, a revisão dos erros e o teste final.'),
                          textAlign: TextAlign.center,
                          style: AppTypography.bodyMedium,
                        ),
                        const SizedBox(height: AppSpacing.md),
                        PrimaryButton(
                          text: isEnglish
                              ? 'Start guided practice'
                              : 'Iniciar prática guiada',
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
    final isEnglish = Localizations.localeOf(context).languageCode == 'en';
    final status = isCompleted
        ? (isEnglish ? 'Completed' : 'Concluída')
        : isUnlocked
        ? (isEnglish ? 'Available' : 'Disponível')
        : (isEnglish ? 'Locked' : 'Bloqueada');

    return MathCard(
      title:
          '${isEnglish ? 'Lesson' : 'Aula'} $number — ${lesson.title}',
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
