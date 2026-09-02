// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Cálculo Trivial';

  @override
  String get appTagline => 'Master calculus. Go further.';

  @override
  String get appSymbolSemanticLabel => 'Cálculo Trivial symbol';

  @override
  String get loading => 'Loading';

  @override
  String get home => 'Home';

  @override
  String get learningPath => 'Learning Path';

  @override
  String get statistics => 'Statistics';

  @override
  String get profile => 'Profile';

  @override
  String get settings => 'Settings';

  @override
  String get language => 'Language';

  @override
  String get portuguese => 'Português';

  @override
  String get english => 'English';

  @override
  String get languageSettingsSubtitle => 'Choose the language used in the app.';

  @override
  String get languageUpdated => 'Language updated';

  @override
  String get account => 'Account';

  @override
  String get accountSettings => 'Account settings';

  @override
  String get accountSettingsSubtitle =>
      'Manage your account, preferences, and subscription.';

  @override
  String get unidentifiedAccount => 'Account not identified';

  @override
  String get name => 'Name';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get confirmPassword => 'Confirm password';

  @override
  String get login => 'Sign in';

  @override
  String get createAccount => 'Create account';

  @override
  String get forgotPassword => 'Forgot my password';

  @override
  String get loginAccessAccount => 'Access your account';

  @override
  String get loginJourneySubtitle =>
      'Sign in to start or continue your journey.';

  @override
  String get loginEmailHint => 'Enter your email';

  @override
  String get loginPasswordHint => 'Enter your password';

  @override
  String get loginNoAccount => 'Don\'t have an account yet?';

  @override
  String get loginFillEmailAndPassword => 'Enter your email and password.';

  @override
  String get loginInvalidEmail => 'Enter a valid email address.';

  @override
  String get loginUserDisabled => 'This account has been disabled.';

  @override
  String get loginInvalidCredentials => 'Incorrect email or password.';

  @override
  String get loginTooManyRequests =>
      'Too many attempts. Wait a moment and try again.';

  @override
  String get loginNetworkError => 'Check your internet connection.';

  @override
  String get loginGenericError => 'Unable to sign in. Try again.';

  @override
  String get loginUnexpectedError =>
      'An unexpected error occurred while signing in.';

  @override
  String get loginEnterEmailForReset =>
      'Enter your email to receive password recovery instructions.';

  @override
  String get loginResetEmailSent =>
      'Password recovery instructions were sent to your email.';

  @override
  String get loginResetEmailError =>
      'Unable to send password recovery instructions.';

  @override
  String get registerCreateAccountTitle => 'Create your account';

  @override
  String get registerJourneySubtitle => 'Start your learning journey.';

  @override
  String get registerNameHint => 'Enter your name';

  @override
  String get registerPasswordHint => 'Create a password';

  @override
  String get registerConfirmPasswordHint => 'Enter your password again';

  @override
  String get registerAlreadyHaveAccount => 'Already have an account?';

  @override
  String get registerFillAllFields => 'Fill in all fields.';

  @override
  String get registerEnterName => 'Enter your name.';

  @override
  String get registerPasswordTooShort =>
      'Your password must contain at least 6 characters.';

  @override
  String get registerPasswordsDoNotMatch => 'The passwords do not match.';

  @override
  String get registerEmailAlreadyInUse =>
      'An account with this email already exists.';

  @override
  String get registerWeakPassword =>
      'Create a stronger password with at least 6 characters.';

  @override
  String get registerOperationNotAllowed =>
      'Email registration is not available.';

  @override
  String get registerGenericError => 'Unable to create your account.';

  @override
  String get registerUnexpectedError =>
      'An unexpected error occurred while creating your account.';

  @override
  String get student => 'Student';

  @override
  String get emailNotProvided => 'Email not provided';

  @override
  String levelLabel(int level) {
    return 'Level $level';
  }

  @override
  String xpAndGold(int xp, int gold) {
    return '$xp XP • $gold gold';
  }

  @override
  String xpRemainingForNextLevel(int xp) {
    return '$xp XP remaining until the next level.';
  }

  @override
  String get achievements => 'Achievements';

  @override
  String get premium => 'Premium';

  @override
  String get premiumActive => 'Premium active';

  @override
  String get premiumActiveUppercase => 'PREMIUM ACTIVE';

  @override
  String get premiumUppercase => 'PREMIUM';

  @override
  String get freePlan => 'Free plan';

  @override
  String get premiumManageSubscription =>
      'Manage your subscription and purchases.';

  @override
  String get premiumDiscoverFeatures =>
      'Discover Cálculo Trivial Premium features.';

  @override
  String get achievementCalculusOneMastered => 'Calculus I mastered';

  @override
  String get achievementCalculusOneMasteredDescription =>
      'You completed Limits, Continuity, and Derivatives.';

  @override
  String get achievementContinuityCompleted =>
      'Functions without interruptions';

  @override
  String get achievementContinuityCompletedDescription =>
      'You completed Continuity in Calculus I.';

  @override
  String get achievementFirstCalculusSteps => 'First steps in Calculus I';

  @override
  String get achievementFirstCalculusStepsDescription =>
      'You completed your first Limits sequence.';

  @override
  String get achievementFoundationsMastered => 'Foundations mastered';

  @override
  String get achievementFoundationsMasteredDescription =>
      'You completed the Mathematical Foundations module.';

  @override
  String get achievementEquationsCompleted => 'Equations completed';

  @override
  String get achievementEquationsCompletedDescription =>
      'You progressed through Equations and Inequalities.';

  @override
  String get achievementFirstLessonCompleted => 'First lesson completed';

  @override
  String get achievementFirstLessonCompletedDescription =>
      'You started your journey in Cálculo Trivial.';

  @override
  String get achievementFirstAchievement => 'Your first achievement';

  @override
  String get achievementFirstAchievementDescription =>
      'Complete the first lesson to unlock it.';

  @override
  String get learningPathTitle => 'Learning Path';

  @override
  String get learningPathSubtitle =>
      'Progress module by module until you master Calculus.';

  @override
  String get mathematicalFoundations => 'Mathematical Foundations';

  @override
  String get mathematicalFoundationsSubtitle =>
      'Pre-Calculus, functions, and algebraic foundations';

  @override
  String get calculusOne => 'Calculus I';

  @override
  String get calculusOneSubtitle => 'Limits, continuity, and derivatives';

  @override
  String get calculusTwo => 'Calculus II';

  @override
  String get calculusTwoSubtitle =>
      'Integrals, series, and differential equations';

  @override
  String get unlocked => 'Unlocked';

  @override
  String get dashboardFirstWelcome => 'Welcome, future engineer!';

  @override
  String dashboardWelcomeBack(String name) {
    return 'Welcome back, $name!';
  }

  @override
  String get dashboardFirstWelcomeSubtitle =>
      'Your Calculus journey starts now.';

  @override
  String get dashboardWelcomeBackSubtitle => 'Continue your Calculus journey.';

  @override
  String get dashboardCurrentProgress => 'Current progress';

  @override
  String get dashboardCalculusOneCompleted => 'Calculus I completed';

  @override
  String get dashboardContinuityCompleted => 'Continuity completed';

  @override
  String get dashboardLimitsCompleted => 'Limits completed';

  @override
  String get dashboardFoundationsCompleted =>
      'Mathematical Foundations completed';

  @override
  String get dashboardEquationsCompleted =>
      'Equations and Inequalities completed';

  @override
  String get dashboardAlgebraCompleted => 'Fundamental Algebra completed';

  @override
  String get dashboardStartFirstLesson => 'Start your first lesson';

  @override
  String get dashboardNextMission => 'Next mission';

  @override
  String get dashboardMissionModuleCompleted =>
      'Module completed! Keep practicing to reinforce the content.';

  @override
  String get dashboardMissionDerivatives => 'Next step: study Derivatives.';

  @override
  String get dashboardMissionContinuity => 'Next step: study Continuity.';

  @override
  String get dashboardMissionLimits =>
      'Start Calculus I with the Limits lesson.';

  @override
  String get dashboardMissionFunctions => 'Continue with Lesson 3 — Functions.';

  @override
  String get dashboardMissionEquations =>
      'Continue with Equations and Inequalities.';

  @override
  String get dashboardMissionFoundations =>
      'Progress through the Mathematical Foundations path.';

  @override
  String get dashboardContinuePath => 'Continue path';

  @override
  String get level => 'Level';

  @override
  String get xp => 'XP';

  @override
  String get gold => 'Gold';

  @override
  String get statisticsYourProgress => 'Your progress';

  @override
  String get statisticsSubtitle =>
      'Track your progress with real data from your studies.';

  @override
  String get statisticsCheckingPremium => 'Checking Premium access...';

  @override
  String get statisticsTotalXp => 'Total XP';

  @override
  String statisticsLevelStudyMessage(int level) {
    return 'Level $level • Keep studying to progress.';
  }

  @override
  String get statisticsCompletedLessons => 'Lessons completed';

  @override
  String get statisticsAccumulatedGold => 'Gold earned';

  @override
  String get statisticsTodayActivity => 'Today\'s activity';

  @override
  String get statisticsDailyGoal => 'Daily goal';

  @override
  String statisticsDailyGoalCompleted(int answered) {
    return 'Goal completed! You answered $answered questions today.';
  }

  @override
  String statisticsDailyGoalRemaining(int remaining) {
    return 'Answer $remaining questions to complete the goal.';
  }

  @override
  String get statisticsStreakDay => 'day in a row';

  @override
  String get statisticsStreakDays => 'days in a row';

  @override
  String get statisticsPerformance => 'Performance';

  @override
  String get statisticsCorrectAnswers => 'Correct answers';

  @override
  String get statisticsIncorrectAnswers => 'Incorrect answers';

  @override
  String get statisticsOverallAccuracy => 'Overall accuracy';

  @override
  String get statisticsAccuracyNoAnswers =>
      'Answer exercises to calculate your accuracy.';

  @override
  String get statisticsAccuracyCalculated =>
      'Calculated using all recorded answers.';

  @override
  String get statisticsContent => 'Content';

  @override
  String get statisticsContentCompleted => 'Content completed';

  @override
  String get statisticsProgressFirstLesson =>
      'Complete your first lesson to start your statistics.';

  @override
  String get statisticsProgressAllCompleted =>
      'You completed all content available in this version.';

  @override
  String statisticsProgressRemaining(int remaining, String lessonWord) {
    return '$remaining $lessonWord in the current content.';
  }

  @override
  String get statisticsRemainingLesson => 'lesson remaining';

  @override
  String get statisticsRemainingLessons => 'lessons remaining';

  @override
  String get settingsPrivacyAndData => 'Privacy and data';

  @override
  String get settingsPrivacySubtitle => 'Privacy policy and account deletion';

  @override
  String get settingsNotifications => 'Notifications';

  @override
  String get settingsNotificationsSubtitle => 'Study reminders and daily goals';

  @override
  String get settingsTheme => 'Theme';

  @override
  String get settingsThemeSubtitle => 'Light mode enabled';

  @override
  String get settingsSubscription => 'Subscription';

  @override
  String get settingsPremiumAccessActive =>
      'You have access to Premium features.';

  @override
  String get settingsPremiumAccessFree => 'Subscribe to unlock all features.';

  @override
  String get settingsRestorePurchases => 'Restore purchases';

  @override
  String get settingsRestorePurchasesSubtitle =>
      'Recover a subscription purchased previously';

  @override
  String get settingsManageSubscription => 'Manage subscription';

  @override
  String get settingsManageSubscriptionSubtitle =>
      'View, change, or cancel your plan';

  @override
  String get settingsSignOut => 'Sign out';

  @override
  String get settingsDeleteAccount => 'Delete my account';

  @override
  String get settingsDeleteAccountSubtitle =>
      'Permanently delete your account and progress';

  @override
  String get settingsPrivacyOpenError => 'Unable to open the privacy page.';

  @override
  String get settingsPremiumUnavailable => 'Premium is currently unavailable.';

  @override
  String get settingsRestoreSuccess =>
      'Purchases restored. Your Premium access is active.';

  @override
  String get settingsRestoreNone =>
      'No Premium purchase was found for this account.';

  @override
  String get settingsRestoreError => 'Unable to restore your purchases.';

  @override
  String get settingsCustomerCenterError =>
      'Unable to open subscription management.';

  @override
  String get settingsSignOutTitle => 'Sign out of your account?';

  @override
  String get settingsSignOutDescription =>
      'Your progress will remain saved and can be restored when you sign in again.';

  @override
  String get settingsSignOutAction => 'Sign out';

  @override
  String get settingsSignOutError => 'Unable to sign out. Try again.';

  @override
  String get settingsSignOutUnexpectedError =>
      'An unexpected error occurred while signing out.';

  @override
  String get settingsDeleteTitle => 'Permanently delete account?';

  @override
  String get settingsDeleteWarning =>
      'Your progress, XP, coins, and account will be deleted. This action cannot be undone.';

  @override
  String get settingsDeleteSubscriptionWarning =>
      'Deleting your account does not cancel an active subscription. Cancel it in “Manage subscription” before continuing.';

  @override
  String get settingsDeletePasswordLabel => 'Confirm your password';

  @override
  String get settingsDeletePermanent => 'Delete permanently';

  @override
  String get settingsDeleteIdentifyError =>
      'Unable to identify the current account.';

  @override
  String get settingsDeleteFunctionError =>
      'Unable to complete account deletion. Try again.';

  @override
  String get settingsDeleteWrongPassword =>
      'Incorrect password. The account was not deleted.';

  @override
  String get settingsDeleteTooManyRequests =>
      'Too many attempts. Wait a moment and try again.';

  @override
  String get settingsDeleteNetworkError =>
      'Check your internet connection and try again.';

  @override
  String get settingsDeleteRequiresRecentLogin =>
      'Sign in again before trying to delete your account.';

  @override
  String get settingsDeleteGenericError =>
      'Unable to delete the account. Try again.';

  @override
  String get moduleDetailSubtitle =>
      'Build the foundation you need to study Calculus.';

  @override
  String get moduleDetailCompleted => 'Module completed';

  @override
  String get moduleDetailLessonOneCompleted => 'Lesson 1 completed';

  @override
  String get moduleDetailLessonTwoCompleted => 'Lesson 2 completed';

  @override
  String get moduleDetailStartFirstLesson => 'Start with the first lesson';

  @override
  String get moduleDetailLessonUnlocked => 'Unlocked';

  @override
  String get moduleDetailAlgebraTitle => 'Lesson 1 — Fundamental Algebra';

  @override
  String get moduleDetailAlgebraSubtitle =>
      '8 lessons • expressions, powers, and factoring';

  @override
  String get moduleDetailEquationsTitle =>
      'Lesson 2 — Equations and Inequalities';

  @override
  String get moduleDetailEquationsSubtitle =>
      'Algebraic manipulation and solving';

  @override
  String get moduleDetailFunctionsTitle => 'Lesson 3 — Functions';

  @override
  String get moduleDetailFunctionsSubtitle => 'Domain, range, and graphs';

  @override
  String exerciseQuestionProgress(int current, int total) {
    return 'Question $current of $total';
  }

  @override
  String get exerciseAlgebraInstruction =>
      'Choose the best algebraic transformation.';

  @override
  String get exerciseDifficultyFoundation => 'Foundations';

  @override
  String get exerciseDifficultyIntermediate => 'Intermediate';

  @override
  String get exerciseDifficultyChallenge => 'Challenge';

  @override
  String get exerciseChooseAlternative => 'Choose an option before continuing.';

  @override
  String get exerciseFinish => 'Finish exercises';

  @override
  String get exerciseNextQuestion => 'Next question';

  @override
  String get resultExercisesCompletedSemantic => 'Exercises completed';

  @override
  String get resultGoalReached => 'Goal reached!';

  @override
  String get resultKeepPracticing => 'Keep practicing';

  @override
  String get resultApprovedMessage =>
      'You reached the performance required to move forward.';

  @override
  String get resultNeedEightyPercent =>
      'You need at least 80% to unlock the next lesson.';

  @override
  String resultAccuracyPerformance(int percentage) {
    return '$percentage% accuracy';
  }

  @override
  String get resultCorrectAnswers => 'Correct answers';

  @override
  String get resultIncorrectAnswers => 'Incorrect answers';

  @override
  String get resultAccuracy => 'Accuracy';

  @override
  String get resultXpEarned => 'XP earned';

  @override
  String get resultGoldEarned => 'Gold earned';

  @override
  String get resultReviewOneError => 'Review 1 mistake';

  @override
  String resultReviewErrors(int count) {
    return 'Review $count mistakes';
  }

  @override
  String get resultReceiveReward => 'Claim reward';

  @override
  String get resultBackToPath => 'Back to learning path';

  @override
  String get feedbackGoodAnalysis => 'Good analysis!';

  @override
  String get feedbackUnderstandError => 'Let\'s understand the mistake';

  @override
  String feedbackYourAnswer(String answer) {
    return 'Your answer: $answer';
  }

  @override
  String feedbackCorrectAnswer(String answer) {
    return 'Correct answer: $answer';
  }

  @override
  String get feedbackStepByStep => 'Step-by-step explanation';

  @override
  String get feedbackViewResult => 'View my result';

  @override
  String get feedbackContinuePracticing => 'Keep practicing';

  @override
  String get reviewErrorsTitle => 'Mistake review';

  @override
  String get reviewUnderstandEachAnswer => 'Understand each answer';

  @override
  String get reviewScoreUnchanged =>
      'Your score will not change during the review.';

  @override
  String reviewErrorProgress(int current, int total) {
    return 'Mistake $current of $total';
  }

  @override
  String get reviewYourAnswer => 'Your answer';

  @override
  String get reviewCorrectAnswer => 'Correct answer';

  @override
  String get reviewExplanation => 'Explanation';

  @override
  String get reviewFinish => 'Finish review';

  @override
  String get reviewNextError => 'Next mistake';

  @override
  String get rewardUnlocked => 'Reward unlocked';

  @override
  String get rewardDerivativesDescription =>
      'You completed Derivatives and finished the Calculus I module.';

  @override
  String get rewardContinuityDescription =>
      'You completed the Continuity sequence in Calculus I.';

  @override
  String get rewardLimitsDescription =>
      'You completed the university-level Limits sequence.';

  @override
  String get rewardFunctionsDescription =>
      'You completed the Functions sequence and finished the Mathematical Foundations module.';

  @override
  String get rewardEquationsDescription =>
      'You completed the Equations and Inequalities sequence.';

  @override
  String get rewardAlgebraDescription =>
      'You completed the Fundamental Algebra sequence.';

  @override
  String get rewardModuleCompleted => 'Module completed';

  @override
  String get rewardLessonCompleted => 'Lesson completed';

  @override
  String get rewardExperienceReceived => 'Experience received';

  @override
  String get rewardGoldReceived => 'Gold received';

  @override
  String get rewardProgress => 'Progress';

  @override
  String get miniChallengeTitle => 'Mini Challenge';

  @override
  String get miniChallengeQuickTest => 'Quick test';

  @override
  String get miniChallengeSubtitle =>
      'Choose the correct answer to unlock the next exercises.';

  @override
  String get miniChallengeQuestion => 'What is the result of 4x + 2x?';

  @override
  String get miniChallengeChooseAnswer => 'Choose an option before answering.';

  @override
  String get miniChallengeIncorrect => 'Incorrect answer. Try again.';

  @override
  String get miniChallengeRespond => 'Answer';

  @override
  String get miniChallengeXpHint =>
      'You earn XP when you solve the challenge correctly.';

  @override
  String get back => 'Back';

  @override
  String get continueLabel => 'Continue';

  @override
  String get finish => 'Finish';

  @override
  String get cancel => 'Cancel';

  @override
  String get available => 'Available';

  @override
  String get locked => 'Locked';

  @override
  String get completed => 'Completed';

  @override
  String get lesson => 'Lesson';

  @override
  String get lessons => 'Lessons';

  @override
  String get lessonCompleted => 'Lesson completed';

  @override
  String get startExercises => 'Start exercises';

  @override
  String get readyToPractice => 'Ready to practice';

  @override
  String get finalPracticeLocked => 'Final practice locked';

  @override
  String get yourJourney => 'Your journey';

  @override
  String get moduleProgress => 'Module progress';

  @override
  String get equationsAndInequalities => 'Equations and Inequalities';

  @override
  String get fundamentalAlgebra => 'Fundamental Algebra';

  @override
  String get functions => 'Functions';

  @override
  String get limits => 'Limits';

  @override
  String get continuity => 'Continuity';

  @override
  String get derivatives => 'Derivatives';

  @override
  String approxMinutes(int minutes) {
    return '≈ $minutes min';
  }
}
