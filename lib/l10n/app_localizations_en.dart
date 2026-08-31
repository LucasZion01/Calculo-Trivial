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
