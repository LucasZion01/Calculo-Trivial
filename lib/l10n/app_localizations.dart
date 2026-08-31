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

  /// No description provided for @appTagline.
  ///
  /// In pt, this message translates to:
  /// **'Domine o cálculo. Evolua além.'**
  String get appTagline;

  /// No description provided for @appSymbolSemanticLabel.
  ///
  /// In pt, this message translates to:
  /// **'Símbolo do Cálculo Trivial'**
  String get appSymbolSemanticLabel;

  /// No description provided for @loading.
  ///
  /// In pt, this message translates to:
  /// **'Carregando'**
  String get loading;

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

  /// No description provided for @languageSettingsSubtitle.
  ///
  /// In pt, this message translates to:
  /// **'Escolha o idioma usado no aplicativo.'**
  String get languageSettingsSubtitle;

  /// No description provided for @languageUpdated.
  ///
  /// In pt, this message translates to:
  /// **'Idioma atualizado'**
  String get languageUpdated;

  /// No description provided for @account.
  ///
  /// In pt, this message translates to:
  /// **'Conta'**
  String get account;

  /// No description provided for @accountSettings.
  ///
  /// In pt, this message translates to:
  /// **'Ajustes da conta'**
  String get accountSettings;

  /// No description provided for @accountSettingsSubtitle.
  ///
  /// In pt, this message translates to:
  /// **'Gerencie sua conta, preferências e assinatura.'**
  String get accountSettingsSubtitle;

  /// No description provided for @unidentifiedAccount.
  ///
  /// In pt, this message translates to:
  /// **'Conta não identificada'**
  String get unidentifiedAccount;

  /// No description provided for @name.
  ///
  /// In pt, this message translates to:
  /// **'Nome'**
  String get name;

  /// No description provided for @email.
  ///
  /// In pt, this message translates to:
  /// **'E-mail'**
  String get email;

  /// No description provided for @password.
  ///
  /// In pt, this message translates to:
  /// **'Senha'**
  String get password;

  /// No description provided for @confirmPassword.
  ///
  /// In pt, this message translates to:
  /// **'Confirmar senha'**
  String get confirmPassword;

  /// No description provided for @login.
  ///
  /// In pt, this message translates to:
  /// **'Entrar'**
  String get login;

  /// No description provided for @createAccount.
  ///
  /// In pt, this message translates to:
  /// **'Criar conta'**
  String get createAccount;

  /// No description provided for @forgotPassword.
  ///
  /// In pt, this message translates to:
  /// **'Esqueci minha senha'**
  String get forgotPassword;

  /// No description provided for @loginAccessAccount.
  ///
  /// In pt, this message translates to:
  /// **'Acesse sua conta'**
  String get loginAccessAccount;

  /// No description provided for @loginJourneySubtitle.
  ///
  /// In pt, this message translates to:
  /// **'Entre para iniciar ou continuar sua jornada.'**
  String get loginJourneySubtitle;

  /// No description provided for @loginEmailHint.
  ///
  /// In pt, this message translates to:
  /// **'Digite seu e-mail'**
  String get loginEmailHint;

  /// No description provided for @loginPasswordHint.
  ///
  /// In pt, this message translates to:
  /// **'Digite sua senha'**
  String get loginPasswordHint;

  /// No description provided for @loginNoAccount.
  ///
  /// In pt, this message translates to:
  /// **'Ainda não tem uma conta?'**
  String get loginNoAccount;

  /// No description provided for @loginFillEmailAndPassword.
  ///
  /// In pt, this message translates to:
  /// **'Preencha o e-mail e a senha.'**
  String get loginFillEmailAndPassword;

  /// No description provided for @loginInvalidEmail.
  ///
  /// In pt, this message translates to:
  /// **'Digite um endereço de e-mail válido.'**
  String get loginInvalidEmail;

  /// No description provided for @loginUserDisabled.
  ///
  /// In pt, this message translates to:
  /// **'Esta conta foi desativada.'**
  String get loginUserDisabled;

  /// No description provided for @loginInvalidCredentials.
  ///
  /// In pt, this message translates to:
  /// **'E-mail ou senha incorretos.'**
  String get loginInvalidCredentials;

  /// No description provided for @loginTooManyRequests.
  ///
  /// In pt, this message translates to:
  /// **'Muitas tentativas. Aguarde um pouco e tente novamente.'**
  String get loginTooManyRequests;

  /// No description provided for @loginNetworkError.
  ///
  /// In pt, this message translates to:
  /// **'Verifique sua conexão com a internet.'**
  String get loginNetworkError;

  /// No description provided for @loginGenericError.
  ///
  /// In pt, this message translates to:
  /// **'Não foi possível entrar. Tente novamente.'**
  String get loginGenericError;

  /// No description provided for @loginUnexpectedError.
  ///
  /// In pt, this message translates to:
  /// **'Ocorreu um erro inesperado ao entrar.'**
  String get loginUnexpectedError;

  /// No description provided for @loginEnterEmailForReset.
  ///
  /// In pt, this message translates to:
  /// **'Digite seu e-mail para receber a recuperação de senha.'**
  String get loginEnterEmailForReset;

  /// No description provided for @loginResetEmailSent.
  ///
  /// In pt, this message translates to:
  /// **'Enviamos as instruções de recuperação para o seu e-mail.'**
  String get loginResetEmailSent;

  /// No description provided for @loginResetEmailError.
  ///
  /// In pt, this message translates to:
  /// **'Não foi possível enviar a recuperação de senha.'**
  String get loginResetEmailError;

  /// No description provided for @registerCreateAccountTitle.
  ///
  /// In pt, this message translates to:
  /// **'Crie sua conta'**
  String get registerCreateAccountTitle;

  /// No description provided for @registerJourneySubtitle.
  ///
  /// In pt, this message translates to:
  /// **'Comece sua jornada de aprendizagem.'**
  String get registerJourneySubtitle;

  /// No description provided for @registerNameHint.
  ///
  /// In pt, this message translates to:
  /// **'Digite seu nome'**
  String get registerNameHint;

  /// No description provided for @registerPasswordHint.
  ///
  /// In pt, this message translates to:
  /// **'Crie uma senha'**
  String get registerPasswordHint;

  /// No description provided for @registerConfirmPasswordHint.
  ///
  /// In pt, this message translates to:
  /// **'Digite sua senha novamente'**
  String get registerConfirmPasswordHint;

  /// No description provided for @registerAlreadyHaveAccount.
  ///
  /// In pt, this message translates to:
  /// **'Já possui uma conta?'**
  String get registerAlreadyHaveAccount;

  /// No description provided for @registerFillAllFields.
  ///
  /// In pt, this message translates to:
  /// **'Preencha todos os campos.'**
  String get registerFillAllFields;

  /// No description provided for @registerEnterName.
  ///
  /// In pt, this message translates to:
  /// **'Digite seu nome.'**
  String get registerEnterName;

  /// No description provided for @registerPasswordTooShort.
  ///
  /// In pt, this message translates to:
  /// **'A senha precisa ter pelo menos 6 caracteres.'**
  String get registerPasswordTooShort;

  /// No description provided for @registerPasswordsDoNotMatch.
  ///
  /// In pt, this message translates to:
  /// **'As senhas não coincidem.'**
  String get registerPasswordsDoNotMatch;

  /// No description provided for @registerEmailAlreadyInUse.
  ///
  /// In pt, this message translates to:
  /// **'Já existe uma conta cadastrada com este e-mail.'**
  String get registerEmailAlreadyInUse;

  /// No description provided for @registerWeakPassword.
  ///
  /// In pt, this message translates to:
  /// **'Crie uma senha mais forte, com pelo menos 6 caracteres.'**
  String get registerWeakPassword;

  /// No description provided for @registerOperationNotAllowed.
  ///
  /// In pt, this message translates to:
  /// **'O cadastro por e-mail não está disponível.'**
  String get registerOperationNotAllowed;

  /// No description provided for @registerGenericError.
  ///
  /// In pt, this message translates to:
  /// **'Não foi possível criar sua conta.'**
  String get registerGenericError;

  /// No description provided for @registerUnexpectedError.
  ///
  /// In pt, this message translates to:
  /// **'Ocorreu um erro inesperado ao criar sua conta.'**
  String get registerUnexpectedError;

  /// No description provided for @student.
  ///
  /// In pt, this message translates to:
  /// **'Estudante'**
  String get student;

  /// No description provided for @emailNotProvided.
  ///
  /// In pt, this message translates to:
  /// **'E-mail não informado'**
  String get emailNotProvided;

  /// No description provided for @levelLabel.
  ///
  /// In pt, this message translates to:
  /// **'Nível {level}'**
  String levelLabel(int level);

  /// No description provided for @xpAndGold.
  ///
  /// In pt, this message translates to:
  /// **'{xp} XP • {gold} de ouro'**
  String xpAndGold(int xp, int gold);

  /// No description provided for @xpRemainingForNextLevel.
  ///
  /// In pt, this message translates to:
  /// **'Faltam {xp} XP para o próximo nível.'**
  String xpRemainingForNextLevel(int xp);

  /// No description provided for @achievements.
  ///
  /// In pt, this message translates to:
  /// **'Conquistas'**
  String get achievements;

  /// No description provided for @premium.
  ///
  /// In pt, this message translates to:
  /// **'Premium'**
  String get premium;

  /// No description provided for @premiumActive.
  ///
  /// In pt, this message translates to:
  /// **'Premium ativo'**
  String get premiumActive;

  /// No description provided for @premiumActiveUppercase.
  ///
  /// In pt, this message translates to:
  /// **'PREMIUM ATIVO'**
  String get premiumActiveUppercase;

  /// No description provided for @premiumUppercase.
  ///
  /// In pt, this message translates to:
  /// **'PREMIUM'**
  String get premiumUppercase;

  /// No description provided for @freePlan.
  ///
  /// In pt, this message translates to:
  /// **'Plano gratuito'**
  String get freePlan;

  /// No description provided for @premiumManageSubscription.
  ///
  /// In pt, this message translates to:
  /// **'Gerencie sua assinatura e suas compras.'**
  String get premiumManageSubscription;

  /// No description provided for @premiumDiscoverFeatures.
  ///
  /// In pt, this message translates to:
  /// **'Conheça os recursos do Cálculo Trivial Premium.'**
  String get premiumDiscoverFeatures;

  /// No description provided for @achievementCalculusOneMastered.
  ///
  /// In pt, this message translates to:
  /// **'Cálculo I dominado'**
  String get achievementCalculusOneMastered;

  /// No description provided for @achievementCalculusOneMasteredDescription.
  ///
  /// In pt, this message translates to:
  /// **'Você concluiu Limites, Continuidade e Derivadas.'**
  String get achievementCalculusOneMasteredDescription;

  /// No description provided for @achievementContinuityCompleted.
  ///
  /// In pt, this message translates to:
  /// **'Funções sem interrupções'**
  String get achievementContinuityCompleted;

  /// No description provided for @achievementContinuityCompletedDescription.
  ///
  /// In pt, this message translates to:
  /// **'Você concluiu Continuidade em Cálculo I.'**
  String get achievementContinuityCompletedDescription;

  /// No description provided for @achievementFirstCalculusSteps.
  ///
  /// In pt, this message translates to:
  /// **'Primeiros passos no Cálculo I'**
  String get achievementFirstCalculusSteps;

  /// No description provided for @achievementFirstCalculusStepsDescription.
  ///
  /// In pt, this message translates to:
  /// **'Você concluiu sua primeira sequência de Limites.'**
  String get achievementFirstCalculusStepsDescription;

  /// No description provided for @achievementFoundationsMastered.
  ///
  /// In pt, this message translates to:
  /// **'Fundamentos dominados'**
  String get achievementFoundationsMastered;

  /// No description provided for @achievementFoundationsMasteredDescription.
  ///
  /// In pt, this message translates to:
  /// **'Você concluiu o módulo Fundamentos Matemáticos.'**
  String get achievementFoundationsMasteredDescription;

  /// No description provided for @achievementEquationsCompleted.
  ///
  /// In pt, this message translates to:
  /// **'Equações concluídas'**
  String get achievementEquationsCompleted;

  /// No description provided for @achievementEquationsCompletedDescription.
  ///
  /// In pt, this message translates to:
  /// **'Você avançou em Equações e Inequações.'**
  String get achievementEquationsCompletedDescription;

  /// No description provided for @achievementFirstLessonCompleted.
  ///
  /// In pt, this message translates to:
  /// **'Primeira aula concluída'**
  String get achievementFirstLessonCompleted;

  /// No description provided for @achievementFirstLessonCompletedDescription.
  ///
  /// In pt, this message translates to:
  /// **'Você iniciou sua jornada no Cálculo Trivial.'**
  String get achievementFirstLessonCompletedDescription;

  /// No description provided for @achievementFirstAchievement.
  ///
  /// In pt, this message translates to:
  /// **'Sua primeira conquista'**
  String get achievementFirstAchievement;

  /// No description provided for @achievementFirstAchievementDescription.
  ///
  /// In pt, this message translates to:
  /// **'Conclua a primeira aula para desbloquear.'**
  String get achievementFirstAchievementDescription;

  /// No description provided for @learningPathTitle.
  ///
  /// In pt, this message translates to:
  /// **'Trilha de Aprendizagem'**
  String get learningPathTitle;

  /// No description provided for @learningPathSubtitle.
  ///
  /// In pt, this message translates to:
  /// **'Avance módulo por módulo até dominar o Cálculo.'**
  String get learningPathSubtitle;

  /// No description provided for @mathematicalFoundations.
  ///
  /// In pt, this message translates to:
  /// **'Fundamentos Matemáticos'**
  String get mathematicalFoundations;

  /// No description provided for @mathematicalFoundationsSubtitle.
  ///
  /// In pt, this message translates to:
  /// **'Pré-Cálculo, funções e base algébrica'**
  String get mathematicalFoundationsSubtitle;

  /// No description provided for @calculusOne.
  ///
  /// In pt, this message translates to:
  /// **'Cálculo I'**
  String get calculusOne;

  /// No description provided for @calculusOneSubtitle.
  ///
  /// In pt, this message translates to:
  /// **'Limites, continuidade e derivadas'**
  String get calculusOneSubtitle;

  /// No description provided for @calculusTwo.
  ///
  /// In pt, this message translates to:
  /// **'Cálculo II'**
  String get calculusTwo;

  /// No description provided for @calculusTwoSubtitle.
  ///
  /// In pt, this message translates to:
  /// **'Integrais, séries e equações diferenciais'**
  String get calculusTwoSubtitle;

  /// No description provided for @unlocked.
  ///
  /// In pt, this message translates to:
  /// **'Desbloqueado'**
  String get unlocked;

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
