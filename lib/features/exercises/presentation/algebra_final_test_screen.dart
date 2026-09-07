import 'package:flutter/material.dart';

import 'package:calcquest/shared/services/final_test_service.dart';
import 'package:calcquest/shared/state/app_progress.dart';
import 'package:calcquest/shared/theme/app_colors.dart';
import 'package:calcquest/shared/theme/app_spacing.dart';
import 'package:calcquest/shared/theme/app_typography.dart';
import 'package:calcquest/shared/widgets/app_progress_bar.dart';
import 'package:calcquest/shared/widgets/primary_button.dart';

import '../../result/presentation/result_screen.dart';

class AlgebraFinalTestScreen extends StatefulWidget {
  final Set<String> practiceQuestionIds;

  const AlgebraFinalTestScreen({super.key, required this.practiceQuestionIds});

  @override
  State<AlgebraFinalTestScreen> createState() => _AlgebraFinalTestScreenState();
}

class _AlgebraFinalTestScreenState extends State<AlgebraFinalTestScreen> {
  final FinalTestService _finalTestService = FinalTestService();
  final List<TrustedFinalTestAnswer> _answers = <TrustedFinalTestAnswer>[];

  TrustedFinalTestSession? _session;
  int currentExerciseIndex = 0;
  String? selectedOptionId;
  bool _isLoading = true;
  bool _isSubmitting = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _startFinalTest();
  }

  bool get _isEnglish =>
      Localizations.localeOf(context).languageCode.toLowerCase() == 'en';

  TrustedFinalTestQuestion get currentQuestion =>
      _session!.questions[currentExerciseIndex];

  bool get isLastExercise =>
      currentExerciseIndex == _session!.questions.length - 1;

  double get progress =>
      (currentExerciseIndex + 1) / _session!.questions.length;

  Future<void> _startFinalTest() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final session = await _finalTestService.startAlgebraFinalTest();

      if (!mounted) {
        return;
      }

      setState(() {
        _session = session;
        currentExerciseIndex = 0;
        selectedOptionId = null;
        _answers.clear();
        _isLoading = false;
      });
    } catch (_) {
      if (!mounted) {
        return;
      }

      setState(() {
        _isLoading = false;
        _errorMessage = 'start';
      });
    }
  }

  Future<void> _confirmAnswer() async {
    if (_isSubmitting) {
      return;
    }

    final selected = selectedOptionId;
    if (selected == null) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            backgroundColor: AppColors.warning,
            content: Text(
              _isEnglish
                  ? 'Choose an alternative before continuing.'
                  : 'Escolha uma alternativa antes de continuar.',
            ),
          ),
        );
      return;
    }

    final question = currentQuestion;
    final answer = TrustedFinalTestAnswer(
      questionId: question.id,
      optionId: selected,
    );

    if (!isLastExercise) {
      _answers.add(answer);

      setState(() {
        currentExerciseIndex++;
        selectedOptionId = null;
      });
      return;
    }

    final answers = <TrustedFinalTestAnswer>[..._answers, answer];

    await _submitFinalTest(answers);
  }

  Future<void> _submitFinalTest(List<TrustedFinalTestAnswer> answers) async {
    final session = _session;
    if (session == null) {
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    try {
      final result = await _finalTestService.submitAlgebraFinalTest(
        sessionId: session.sessionId,
        answers: answers,
      );

      if (!mounted) {
        return;
      }

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => ResultScreen(
            completedLessonId: AppProgress.algebraFundamentalId,
            totalQuestions: result.totalQuestions,
            correctAnswers: result.correctAnswers,
            xpEarned: result.awardedXp,
            goldEarned: result.awardedGold,
            enableLearningRecommendation: false,
            rewardAlreadyAppliedByBackend: true,
          ),
        ),
      );
    } catch (_) {
      if (!mounted) {
        return;
      }

      setState(() {
        _isSubmitting = false;
      });

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            backgroundColor: AppColors.warning,
            content: Text(
              _isEnglish
                  ? 'The test could not be submitted. Your answers were not changed. Try again.'
                  : 'Não foi possível enviar o teste. Suas respostas não foram alteradas. Tente novamente.',
            ),
          ),
        );
    }
  }

  Widget _buildOption(TrustedFinalTestOption option, int index) {
    final isSelected = selectedOptionId == option.id;
    const letters = <String>['A', 'B', 'C', 'D'];

    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
      child: InkWell(
        onTap: _isSubmitting
            ? null
            : () => setState(() {
                selectedOptionId = option.id;
              }),
        borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          width: double.infinity,
          padding: const EdgeInsets.all(AppSpacing.cardPadding),
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.selectedBackground
                : AppColors.surface,
            borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
            border: Border.all(
              color: isSelected ? AppColors.primary : AppColors.border,
              width: isSelected ? 2 : 1,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.primary
                      : AppColors.surfaceSecondary,
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
                ),
                child: Text(
                  index < letters.length ? letters[index] : '${index + 1}',
                  style: AppTypography.labelMedium.copyWith(
                    color: isSelected
                        ? AppColors.white
                        : AppColors.textSecondary,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(option.text, style: AppTypography.bodyLarge),
              ),
              if (isSelected)
                const Icon(
                  Icons.check_circle_rounded,
                  color: AppColors.primary,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Text(_isEnglish ? 'Final test' : 'Teste final'),
      ),
      body: const SafeArea(child: Center(child: CircularProgressIndicator())),
    );
  }

  Widget _buildErrorState() {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Text(_isEnglish ? 'Final test' : 'Teste final'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.screenHorizontal),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.cloud_off_rounded,
                  size: 48,
                  color: AppColors.warning,
                ),
                const SizedBox(height: AppSpacing.md),
                Text(
                  _isEnglish
                      ? 'The secure final test could not be loaded.'
                      : 'Não foi possível carregar o teste final seguro.',
                  textAlign: TextAlign.center,
                  style: AppTypography.headingSmall,
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  _isEnglish
                      ? 'Check your connection and try again.'
                      : 'Verifique sua conexão e tente novamente.',
                  textAlign: TextAlign.center,
                  style: AppTypography.bodyMedium,
                ),
                const SizedBox(height: AppSpacing.lg),
                PrimaryButton(
                  text: _isEnglish ? 'Try again' : 'Tentar novamente',
                  icon: Icons.refresh_rounded,
                  onPressed: _startFinalTest,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return _buildLoadingState();
    }

    if (_errorMessage != null || _session == null) {
      return _buildErrorState();
    }

    final question = currentQuestion;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Text(_isEnglish ? 'Final test' : 'Teste final'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.screenHorizontal,
            AppSpacing.md,
            AppSpacing.screenHorizontal,
            AppSpacing.screenBottom,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _isEnglish
                    ? 'Question ${currentExerciseIndex + 1} of ${_session!.questions.length}'
                    : 'Questão ${currentExerciseIndex + 1} de ${_session!.questions.length}',
                style: AppTypography.headingSmall,
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                _isEnglish
                    ? 'Answer without immediate feedback. Corrections appear only after the test.'
                    : 'Responda sem feedback imediato. A correção aparece somente após o teste.',
                style: AppTypography.bodyMedium,
              ),
              const SizedBox(height: AppSpacing.md),
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0, end: progress),
                duration: const Duration(milliseconds: 300),
                builder: (context, value, child) =>
                    AppProgressBar(value: value),
              ),
              const SizedBox(height: AppSpacing.lg),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(AppSpacing.cardPaddingLarge),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
                  border: Border.all(color: AppColors.border),
                ),
                child: Text(
                  question.statement,
                  style: AppTypography.headingSmall.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              Expanded(
                child: ListView.separated(
                  itemCount: question.options.length,
                  separatorBuilder: (_, _) =>
                      const SizedBox(height: AppSpacing.sm),
                  itemBuilder: (context, index) =>
                      _buildOption(question.options[index], index),
                ),
              ),
              if (_isSubmitting) ...[
                const SizedBox(height: AppSpacing.sm),
                const Center(child: CircularProgressIndicator()),
                const SizedBox(height: AppSpacing.sm),
              ],
              PrimaryButton(
                text: isLastExercise
                    ? (_isEnglish ? 'Finish test' : 'Finalizar teste')
                    : (_isEnglish
                          ? 'Confirm and continue'
                          : 'Confirmar e continuar'),
                icon: isLastExercise
                    ? Icons.flag_rounded
                    : Icons.arrow_forward_rounded,
                onPressed: _isSubmitting ? null : _confirmAnswer,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
