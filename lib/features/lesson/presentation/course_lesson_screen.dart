import 'package:flutter/material.dart';

import 'package:calcquest/shared/domain/course_lesson_data.dart';
import 'package:calcquest/shared/localization/lesson_ui_text.dart';
import 'package:calcquest/shared/theme/app_colors.dart';
import 'package:calcquest/shared/theme/app_spacing.dart';
import 'package:calcquest/shared/theme/app_typography.dart';
import 'package:calcquest/shared/widgets/guided_factoring_practice_card.dart';
import 'package:calcquest/shared/widgets/learning_content.dart';
import 'package:calcquest/shared/widgets/lesson_visualization_resolver.dart';
import 'package:calcquest/shared/widgets/limits_example_variability_card.dart';
import 'package:calcquest/shared/widgets/limits_strategy_comparison_card.dart';
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
  final ScrollController _scrollController = ScrollController();

  bool _isCompleting = false;
  bool _lessonCheckAnswered = false;
  double _readingProgress = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_updateReadingProgress);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_updateReadingProgress)
      ..dispose();
    super.dispose();
  }

  void _updateReadingProgress() {
    if (!_scrollController.hasClients) return;

    final maxExtent = _scrollController.position.maxScrollExtent;
    final nextProgress = maxExtent <= 0
        ? 1.0
        : (_scrollController.offset / maxExtent).clamp(0.0, 1.0).toDouble();

    if ((nextProgress - _readingProgress).abs() < 0.01) return;

    setState(() => _readingProgress = nextProgress);
  }

  void _markLessonCheckAnswered() {
    if (_lessonCheckAnswered) return;
    setState(() => _lessonCheckAnswered = true);
  }

  Future<void> _completeLesson() async {
    if (_isCompleting || !_lessonCheckAnswered) return;

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

    for (var sectionIndex = 0;
        sectionIndex < widget.lesson.sections.length;
        sectionIndex++) {
      final section = widget.lesson.sections[sectionIndex];

      widgets
        ..add(
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: 1),
            duration: Duration(milliseconds: 320 + (sectionIndex * 70)),
            curve: Curves.easeOutCubic,
            builder: (context, value, child) {
              return Opacity(
                opacity: value,
                child: Transform.translate(
                  offset: Offset(0, 14 * (1 - value)),
                  child: child,
                ),
              );
            },
            child: LessonSectionHeader(
              number: section.number,
              title: section.title,
              subtitle: section.subtitle,
            ),
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

  Widget _buildReadingProgress() {
    final percentage = (_readingProgress * 100).round();

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.screenHorizontal,
        AppSpacing.xs,
        AppSpacing.screenHorizontal,
        AppSpacing.xs,
      ),
      child: Row(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(999),
              child: LinearProgressIndicator(
                value: _readingProgress,
                minHeight: 5,
                backgroundColor: AppColors.border,
                valueColor: const AlwaysStoppedAnimation<Color>(
                  AppColors.primary,
                ),
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 180),
            child: Text(
              '$percentage%',
              key: ValueKey<int>(percentage),
              style: AppTypography.labelMedium.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final lesson = widget.lesson;
    final uiText = LessonUiText.of(context);
    final isEnglish = Localizations.localeOf(context).languageCode == 'en';
    final visualization = lessonVisualizationFor(
      lesson,
      isEnglish: isEnglish,
    );
    final showGuidedFactoringPractice = lesson.id == 'limites-04-fatoracao';
    final showStrategyComparison = lesson.id == 'limites-04-fatoracao';
    final showExampleVariability = lesson.id == 'limites-04-fatoracao';

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
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.titleMedium,
                    ),
                  ),
                ],
              ),
            ),
            _buildReadingProgress(),
            Expanded(
              child: ListView(
                controller: _scrollController,
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.screenHorizontal,
                  AppSpacing.md,
                  AppSpacing.screenHorizontal,
                  AppSpacing.lg,
                ),
                children: [
                  TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0, end: 1),
                    duration: const Duration(milliseconds: 360),
                    curve: Curves.easeOutCubic,
                    builder: (context, value, child) {
                      return Opacity(
                        opacity: value,
                        child: Transform.translate(
                          offset: Offset(0, 18 * (1 - value)),
                          child: child,
                        ),
                      );
                    },
                    child: LessonHeroCard(
                      eyebrow: lesson.eyebrow,
                      title: lesson.title,
                      description: lesson.description,
                      duration: lesson.duration,
                      objective: lesson.objective,
                      symbol: lesson.symbol,
                    ),
                  ),
                  if (visualization != null) ...[
                    const SizedBox(height: AppSpacing.xl),
                    visualization,
                  ],
                  const SizedBox(height: AppSpacing.xl),
                  ..._buildSections(),
                  if (showGuidedFactoringPractice) ...[
                    GuidedFactoringPracticeCard(isEnglish: isEnglish),
                    const SizedBox(height: AppSpacing.xl),
                  ],
                  if (showStrategyComparison) ...[
                    LimitsStrategyComparisonCard(isEnglish: isEnglish),
                    const SizedBox(height: AppSpacing.xl),
                  ],
                  if (showExampleVariability) ...[
                    LimitsExampleVariabilityCard(isEnglish: isEnglish),
                    const SizedBox(height: AppSpacing.xl),
                  ],
                  LessonCheckCard(
                    question: lesson.check.question,
                    choices: lesson.check.choices,
                    correctIndex: lesson.check.correctIndex,
                    explanation: lesson.check.explanation,
                    onAnswered: _markLessonCheckAnswered,
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
            Container(
              decoration: const BoxDecoration(
                color: AppColors.background,
                border: Border(
                  top: BorderSide(color: AppColors.border),
                ),
              ),
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.screenHorizontal,
                AppSpacing.sm,
                AppSpacing.screenHorizontal,
                AppSpacing.screenBottom,
              ),
              child: PrimaryButton(
                text: widget.actionLabel,
                icon: Icons.arrow_forward_rounded,
                onPressed: _isCompleting || !_lessonCheckAnswered
                    ? null
                    : _completeLesson,
                isLoading: _isCompleting,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
