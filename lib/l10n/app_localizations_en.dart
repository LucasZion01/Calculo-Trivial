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
