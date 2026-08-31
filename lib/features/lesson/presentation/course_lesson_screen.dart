import 'package:flutter/material.dart';

import 'package:calcquest/shared/domain/course_lesson_data.dart';
import 'package:calcquest/shared/localization/lesson_ui_text.dart';
import 'package:calcquest/shared/theme/app_colors.dart';
import 'package:calcquest/shared/theme/app_spacing.dart';
import 'package:calcquest/shared/theme/app_typography.dart';
import 'package:calcquest/shared/widgets/learning_content.dart';
import 'package:calcquest/shared/widgets/primary_button.dart';

class CourseLessonScreen extends StatefulWidget {
  final CourseLessonData lesson;
  final Future<void> Function() onComplete;
  final WidgetBuilder? nextDestination;
  final String actionLabel;

  const CourseLessonScreen({
    super.key,
    required this.lesson,
    required this.onComplete,
    required this.actionLabel,
    this.nextDestination,
  });

  @override
  State<CourseLessonScreen> createState() => _CourseLessonScreenState();
}

class _CourseLessonScreenState extends State<CourseLessonScreen> {
  bool _isCompleting = false;

  Future<void> _completeLesson() async {
    if (_isCompleting) return;

    setState(() => _isCompleting = true);

    try {
      await widget.onComplete();

      if (!mounted) return;

      final destination = widget.nextDestination;
      if (destination == null) {
        Navigator.of(context).pop();
        return;
      }

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: destination),
      );
    } finally {
      if (mounted) {
        setState(() => _isCompleting = false);
      }
    }
  }

  IconData _iconFor(LessonVisual visual) {
    return switch (visual) {
      LessonVisual.route => Icons.route_outlined,
      LessonVisual.compare => Icons.compare_arrows_rounded,
      LessonVisual.notation => Icons.translate_rounded,
      LessonVisual.calculate => Icons.calculate_outlined,
      LessonVisual.transform => Icons.build_outlined,
      LessonVisual.table => Icons.table_chart_outlined,
      LessonVisual.graph => Icons.auto_graph_rounded,
      LessonVisual.warning => Icons.warning_amber_rounded,
      LessonVisual.infinity => Icons.all_inclusive_rounded,
      LessonVisual.engineering => Icons.precision_manufacturing_outlined,
      LessonVisual.checklist => Icons.checklist_rounded,
      LessonVisual.idea => Icons.lightbulb_outline_rounded,
    };
  }

  Widget _buildBlock(LessonBlockData block) {
    return switch (block) {
      ConceptBlockData concept => LessonConceptCard(
        icon: _iconFor(concept.visual),
        title: concept.title,
        content: concept.content,
        emphasis: concept.emphasis,
        tone: concept.tone,
      ),
      WorkedExampleBlockData example => WorkedExampleCard(
        title: example.title,
        problem: example.problem,
        steps: example.steps,
        result: example.result,
        interpretation: example.interpretation,
      ),
    };
  }

  List<Widget> _buildSections() {
    final widgets = <Widget>[];

    for (final section in widget.lesson.sections) {
      widgets
        ..add(
          LessonSectionHeader(
            number: section.number,
            title: section.title,
            subtitle: section.subtitle,
          ),
        )
        ..add(const SizedBox(height: AppSpacing.md));

      for (var index = 0; index < section.blocks.length; index++) {
        widgets.add(_buildBlock(section.blocks[index]));

        if (index < section.blocks.length - 1) {
          widgets.add(const SizedBox(height: AppSpacing.md));
        }
      }

      widgets.add(const SizedBox(height: AppSpacing.xl));
    }

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    final lesson = widget.lesson;
    final uiText = LessonUiText.of(context);

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
                    onPressed: _isCompleting
                        ? null
                        : () => Navigator.of(context).maybePop(),
                    icon: const Icon(Icons.arrow_back_rounded),
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  Expanded(
                    child: Text(
                      lesson.trailTitle,
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
                  LessonHeroCard(
                    eyebrow: lesson.eyebrow,
                    title: lesson.title,
                    description: lesson.description,
                    duration: lesson.duration,
                    objective: lesson.objective,
                    symbol: lesson.symbol,
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  ..._buildSections(),
                  LessonCheckCard(
                    question: lesson.check.question,
                    choices: lesson.check.choices,
                    correctIndex: lesson.check.correctIndex,
                    explanation: lesson.check.explanation,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  LessonTakeawaysCard(items: lesson.takeaways),
                  const SizedBox(height: AppSpacing.lg),
                  Text(
                    lesson.closing,
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
                text: widget.actionLabel,
                icon: Icons.arrow_forward_rounded,
                onPressed: _isCompleting ? null : _completeLesson,
                isLoading: _isCompleting,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
