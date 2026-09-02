import 'package:flutter/material.dart';

import 'package:calcquest/shared/data/continuity_course_data.dart';
import 'package:calcquest/shared/data/localized_continuity_course_data.dart';
import 'package:calcquest/shared/domain/course_lesson_data.dart';
import 'package:calcquest/shared/localization/lesson_ui_text.dart';
import 'package:calcquest/shared/state/app_progress.dart';
import 'package:calcquest/shared/theme/app_colors.dart';
import 'package:calcquest/shared/theme/app_spacing.dart';
import 'package:calcquest/shared/theme/app_typography.dart';
import 'package:calcquest/shared/widgets/app_progress_bar.dart';
import 'package:calcquest/shared/widgets/math_card.dart';
import 'package:calcquest/shared/widgets/primary_button.dart';

import '../../exercises/presentation/continuity_exercises_screen.dart';
import 'course_lesson_screen.dart';

class ContinuityCourseScreen extends StatefulWidget {
  const ContinuityCourseScreen({super.key});

  @override
  State<ContinuityCourseScreen> createState() =>
      _ContinuityCourseScreenState();
}

class _ContinuityCourseScreenState extends State<ContinuityCourseScreen> {
  List<CourseLessonData> _lessons(BuildContext context) {
    return Localizations.localeOf(context).languageCode == 'en'
        ? englishContinuityCourseLessons
        : continuityCourseLessons;
  }

  int get _completedCount => continuityCourseLessons
      .where((lesson) => AppProgress.isContentLessonCompleted(lesson.id))
      .length;

  bool _isUnlocked(int index) {
    return index == 0 ||
        AppProgress.isContentLessonCompleted(
          continuityCourseLessons[index - 1].id,
        );
  }

  Future<void> _openLesson(int index) async {
    if (!_isUnlocked(index)) return;

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
      MaterialPageRoute(builder: (_) => const ContinuityExercisesScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isEnglish = Localizations.localeOf(context).languageCode == 'en';
    final ui = LessonUiText.of(context);
    final lessons = _lessons(context);
    final completedCount = _completedCount;
    final total = continuityCourseLessons.length;
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
                      isEnglish ? 'Continuity Course' : 'Curso de Continuidade',
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
                              ? 'Continuity without gaps'
                              : 'Continuidade sem lacunas',
                          style: AppTypography.headingMedium.copyWith(
                            color: AppColors.white,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        Text(
                          isEnglish
                              ? 'Definition, domain, discontinuities, piecewise functions, parameters, and the Intermediate Value Theorem.'
                              : 'Definição, domínio, rupturas, funções por partes, parâmetros e Teorema do Valor Intermediário.',
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
                        ? 'Move forward in sequence and return to completed lessons whenever you need to review.'
                        : 'Avance em sequência e retorne às aulas concluídas sempre que precisar revisar.',
                    style: AppTypography.bodyMedium,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  for (var index = 0; index < lessons.length; index++) ...[
                    _ContinuityLessonCard(
                      number: index + 1,
                      lesson: lessons[index],
                      isCompleted: AppProgress.isContentLessonCompleted(
                        continuityCourseLessons[index].id,
                      ),
                      isUnlocked: _isUnlocked(index),
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
                                    ? 'Apply the continuity roadmap and identify which concepts still need review.'
                                    : 'Aplique o roteiro de continuidade e descubra quais conceitos precisam de revisão.')
                              : (isEnglish
                                    ? 'Complete all seven lessons to unlock the synthesis exercises.'
                                    : 'Conclua as sete aulas para liberar os exercícios de síntese.'),
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

class _ContinuityLessonCard extends StatelessWidget {
  final int number;
  final CourseLessonData lesson;
  final bool isCompleted;
  final bool isUnlocked;
  final bool isEnglish;
  final VoidCallback onTap;

  const _ContinuityLessonCard({
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
