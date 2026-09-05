import 'package:flutter/material.dart';

import 'package:calcquest/shared/domain/learning_difficulty_diagnosis.dart';
import 'package:calcquest/shared/services/learning_difficulty_tracker.dart';
import 'package:calcquest/shared/theme/app_colors.dart';
import 'package:calcquest/shared/theme/app_spacing.dart';
import 'package:calcquest/shared/theme/app_typography.dart';

class LearningDifficultyRecommendationSection extends StatefulWidget {
  final String moduleId;
  final bool isEnglish;
  final VoidCallback onReview;

  const LearningDifficultyRecommendationSection({
    super.key,
    required this.moduleId,
    required this.isEnglish,
    required this.onReview,
  });

  @override
  State<LearningDifficultyRecommendationSection> createState() =>
      _LearningDifficultyRecommendationSectionState();
}

class _LearningDifficultyRecommendationSectionState
    extends State<LearningDifficultyRecommendationSection> {
  late final Future<LearningDifficultyDiagnosis> _diagnosis;

  @override
  void initState() {
    super.initState();
    _diagnosis = LearningDifficultyTracker.diagnose(moduleId: widget.moduleId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<LearningDifficultyDiagnosis>(
      future: _diagnosis,
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.hasError) {
          return const SizedBox.shrink();
        }

        final recommendations = snapshot.data!.reviewRecommendations;
        if (recommendations.isEmpty) {
          return const SizedBox.shrink();
        }

        return LearningDifficultyRecommendationCard(
          evidence: recommendations.first,
          isEnglish: widget.isEnglish,
          onReview: widget.onReview,
        );
      },
    );
  }
}

class LearningDifficultyRecommendationCard extends StatelessWidget {
  final LearningDifficultyEvidence evidence;
  final bool isEnglish;
  final VoidCallback onReview;

  const LearningDifficultyRecommendationCard({
    super.key,
    required this.evidence,
    required this.isEnglish,
    required this.onReview,
  });

  @override
  Widget build(BuildContext context) {
    final title = isEnglish
        ? 'It may be worth reviewing'
        : 'Pode valer a pena revisar';
    final evidenceText = isEnglish
        ? '${evidence.errors} errors in ${evidence.attempts} recent attempts. This is a study suggestion, not a grade or proof of learning.'
        : '${evidence.errors} erros em ${evidence.attempts} tentativas recentes. Esta é uma sugestão de estudo, não uma nota nem uma prova de aprendizagem.';
    final actionText = isEnglish
        ? 'Review recommended content'
        : 'Revisar conteúdo recomendado';

    return Semantics(
      container: true,
      label: '$title: ${evidence.skill}',
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AppSpacing.cardPaddingLarge),
        decoration: BoxDecoration(
          color: AppColors.selectedBackground,
          borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
          border: Border.all(color: AppColors.primary),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.school_outlined,
                  color: AppColors.primary,
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: AppTypography.labelMedium.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xxs),
                      Text(evidence.skill, style: AppTypography.titleMedium),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(evidenceText, style: AppTypography.bodyMedium),
            const SizedBox(height: AppSpacing.sm),
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton.icon(
                onPressed: onReview,
                icon: const Icon(Icons.menu_book_outlined),
                label: Text(actionText),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
