import 'package:flutter/material.dart';

import 'package:calcquest/shared/data/derivatives_course_data.dart';
import 'package:calcquest/shared/data/derivatives_course_data_en.dart';
import 'package:calcquest/shared/domain/course_lesson_data.dart';
import 'package:calcquest/shared/localization/lesson_ui_text.dart';
import 'package:calcquest/shared/state/app_progress.dart';
import 'package:calcquest/shared/theme/app_colors.dart';
import 'package:calcquest/shared/theme/app_spacing.dart';
import 'package:calcquest/shared/theme/app_typography.dart';
import 'package:calcquest/shared/widgets/app_progress_bar.dart';
import 'package:calcquest/shared/widgets/math_card.dart';
import 'package:calcquest/shared/widgets/primary_button.dart';

import '../../exercises/presentation/derivatives_exercises_screen.dart';
import 'course_lesson_screen.dart';

class DerivativesCourseScreen extends StatefulWidget {
  const DerivativesCourseScreen({super.key});

  @override
  State<DerivativesCourseScreen> createState() =>
      _DerivativesCourseScreenState();
}

class _DerivativesCourseScreenState extends State<DerivativesCourseScreen> {
  List<CourseLessonData> _lessons(BuildContext context) {
    return Localizations.localeOf(context).languageCode == 'en'
        ? derivativesCourseLessonsEn
        : derivativesCourseLessons;
  }

  int _completedCount(BuildContext context) => _lessons(context)
      .where((lesson) => AppProgress.isContentLessonCompleted(lesson.id))
      .length;

  bool _isUnlocked(BuildContext context, int index) {
    final lessons = _lessons(context);
    return index == 0 ||
        AppProgress.isContentLessonCompleted(lessons[index - 1].id);
  }

  Future<void> _openLesson(int index) async {
    if (!_isUnlocked(context, index)) return;

    await Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => _buildLessonScreen(index)),
    );

    if (mounted) setState(() {});
  }

  CourseLessonScreen _buildLessonScreen(int index) {
    final lessons = _lessons(context);
    final lesson = lessons[index];
    final isLast = index == lessons.length - 1;
    final ui = LessonUiText.of(context);

    return CourseLessonScreen(
      lesson: lesson,
      onComplete: () => AppProgress.completeContentLesson(lesson.id),
      actionLabel: isLast ? ui.completeLesson : ui.completeAndContinue,
      nextDestination: isLast ? null : (_) => _buildLessonScreen(index + 1),
    );
  }

  void _openExercises() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const DerivativesExercisesScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isEnglish = Localizations.localeOf(context).languageCode == 'en';
    final ui = LessonUiText.of(context);
    final lessons = _lessons(context);
    final completedCount = _completedCount(context);
    final total = lessons.length;
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
                    tooltip: ui.back,
                    onPressed: () => Navigator.of(context).maybePop(),
                    icon: const Icon(Icons.arrow_back_rounded),
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  Expanded(
                    child: Text(
                      isEnglish ? 'Derivatives Course' : 'Curso de Derivadas',
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
                          isEnglish ? 'COMPLETE UNIT' : 'UNIDADE COMPLETA',
                          style: AppTypography.labelSmall.copyWith(
                            color: AppColors.secondaryLight,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          isEnglish
                              ? 'Derivatives with meaning'
                              : 'Derivadas com significado',
                          style: AppTypography.headingMedium.copyWith(
                            color: AppColors.white,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        Text(
                          isEnglish
                              ? 'Rates, rules, chain rule, tangents, analysis, and Engineering applications.'
                              : 'Taxas, regras, cadeia, tangentes, análise e aplicações em Engenharia.',
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
                        ? 'Learn the meaning before the rules and progress toward motion and modeling applications.'
                        : 'Aprenda o significado antes das regras e avance até aplicações de movimento e modelagem.',
                    style: AppTypography.bodyMedium,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  for (var index = 0; index < lessons.length; index++) ...[
                    _DerivativesLessonCard(
                      number: index + 1,
                      lesson: lessons[index],
                      isCompleted: AppProgress.isContentLessonCompleted(
                        lessons[index].id,
                      ),
                      isUnlocked: _isUnlocked(context, index),
                      isEnglish: isEnglish,
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
                              ? (isEnglish
                                    ? 'Ready to practice'
                                    : 'Pronto para praticar')
                              : (isEnglish
                                    ? 'Final practice locked'
                                    : 'Prática final bloqueada'),
                          style: AppTypography.titleMedium,
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          canPractice
                              ? (isEnglish
                                    ? 'Apply rules and interpretation to identify which skills still need review.'
                                    : 'Aplique regras e interpretação para descobrir quais habilidades precisam de revisão.')
                              : (isEnglish
                                    ? 'Complete all eight lessons to unlock the final synthesis exercises.'
                                    : 'Conclua as oito aulas para liberar os exercícios de síntese.'),
                          textAlign: TextAlign.center,
                          style: AppTypography.bodyMedium,
                        ),
                        const SizedBox(height: AppSpacing.md),
                        PrimaryButton(
                          text: isEnglish
                              ? 'Start exercises'
                              : 'Iniciar exercícios',
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

class _DerivativesLessonCard extends StatelessWidget {
  final int number;
  final CourseLessonData lesson;
  final bool isCompleted;
  final bool isUnlocked;
  final bool isEnglish;
  final VoidCallback onTap;

  const _DerivativesLessonCard({
    required this.number,
    required this.lesson,
    required this.isCompleted,
    required this.isUnlocked,
    required this.isEnglish,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final status = isCompleted
        ? (isEnglish ? 'Completed' : 'Concluída')
        : isUnlocked
        ? (isEnglish ? 'Available' : 'Disponível')
        : (isEnglish ? 'Locked' : 'Bloqueada');

    return MathCard(
      title: '${isEnglish ? 'Lesson' : 'Aula'} $number — ${lesson.title}',
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
