import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_pt.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('pt'),
    Locale('en'),
  ];

  /// No description provided for @appName.
  ///
  /// In pt, this message translates to:
  /// **'Cálculo Trivial'**
  String get appName;

  /// No description provided for @home.
  ///
  /// In pt, this message translates to:
  /// **'Início'**
  String get home;

  /// No description provided for @learningPath.
  ///
  /// In pt, this message translates to:
  /// **'Trilha'**
  String get learningPath;

  /// No description provided for @statistics.
  ///
  /// In pt, this message translates to:
  /// **'Estatísticas'**
  String get statistics;

  /// No description provided for @profile.
  ///
  /// In pt, this message translates to:
  /// **'Perfil'**
  String get profile;

  /// No description provided for @settings.
  ///
  /// In pt, this message translates to:
  /// **'Configurações'**
  String get settings;

  /// No description provided for @language.
  ///
  /// In pt, this message translates to:
  /// **'Idioma'**
  String get language;

  /// No description provided for @portuguese.
  ///
  /// In pt, this message translates to:
  /// **'Português'**
  String get portuguese;

  /// No description provided for @english.
  ///
  /// In pt, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @back.
  ///
  /// In pt, this message translates to:
  /// **'Voltar'**
  String get back;

  /// No description provided for @continueLabel.
  ///
  /// In pt, this message translates to:
  /// **'Continuar'**
  String get continueLabel;

  /// No description provided for @finish.
  ///
  /// In pt, this message translates to:
  /// **'Concluir'**
  String get finish;

  /// No description provided for @cancel.
  ///
  /// In pt, this message translates to:
  /// **'Cancelar'**
  String get cancel;

  /// No description provided for @available.
  ///
  /// In pt, this message translates to:
  /// **'Disponível'**
  String get available;

  /// No description provided for @locked.
  ///
  /// In pt, this message translates to:
  /// **'Bloqueada'**
  String get locked;

  /// No description provided for @completed.
  ///
  /// In pt, this message translates to:
  /// **'Concluída'**
  String get completed;

  /// No description provided for @lesson.
  ///
  /// In pt, this message translates to:
  /// **'Aula'**
  String get lesson;

  /// No description provided for @lessons.
  ///
  /// In pt, this message translates to:
  /// **'Aulas'**
  String get lessons;

  /// No description provided for @lessonCompleted.
  ///
  /// In pt, this message translates to:
  /// **'Aula concluída'**
  String get lessonCompleted;

  /// No description provided for @startExercises.
  ///
  /// In pt, this message translates to:
  /// **'Iniciar exercícios'**
  String get startExercises;

  /// No description provided for @readyToPractice.
  ///
  /// In pt, this message translates to:
  /// **'Pronto para praticar'**
  String get readyToPractice;

  /// No description provided for @finalPracticeLocked.
  ///
  /// In pt, this message translates to:
  /// **'Prática final bloqueada'**
  String get finalPracticeLocked;

  /// No description provided for @yourJourney.
  ///
  /// In pt, this message translates to:
  /// **'Sua jornada'**
  String get yourJourney;

  /// No description provided for @moduleProgress.
  ///
  /// In pt, this message translates to:
  /// **'Progresso do módulo'**
  String get moduleProgress;

  /// No description provided for @equationsAndInequalities.
  ///
  /// In pt, this message translates to:
  /// **'Equações e Inequações'**
  String get equationsAndInequalities;

  /// No description provided for @fundamentalAlgebra.
  ///
  /// In pt, this message translates to:
  /// **'Álgebra Fundamental'**
  String get fundamentalAlgebra;

  /// No description provided for @functions.
  ///
  /// In pt, this message translates to:
  /// **'Funções'**
  String get functions;

  /// No description provided for @limits.
  ///
  /// In pt, this message translates to:
  /// **'Limites'**
  String get limits;

  /// No description provided for @continuity.
  ///
  /// In pt, this message translates to:
  /// **'Continuidade'**
  String get continuity;

  /// No description provided for @derivatives.
  ///
  /// In pt, this message translates to:
  /// **'Derivadas'**
  String get derivatives;

  /// No description provided for @approxMinutes.
  ///
  /// In pt, this message translates to:
  /// **'≈ {minutes} min'**
  String approxMinutes(int minutes);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'pt'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'pt':
      return AppLocalizationsPt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
