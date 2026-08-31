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

  /// No description provided for @dashboardFirstWelcome.
  ///
  /// In pt, this message translates to:
  /// **'Bem-vindo, futuro engenheiro!'**
  String get dashboardFirstWelcome;

  /// No description provided for @dashboardWelcomeBack.
  ///
  /// In pt, this message translates to:
  /// **'Bem-vindo de volta, {name}!'**
  String dashboardWelcomeBack(String name);

  /// No description provided for @dashboardFirstWelcomeSubtitle.
  ///
  /// In pt, this message translates to:
  /// **'Sua jornada no Cálculo começa agora.'**
  String get dashboardFirstWelcomeSubtitle;

  /// No description provided for @dashboardWelcomeBackSubtitle.
  ///
  /// In pt, this message translates to:
  /// **'Continue sua jornada no Cálculo.'**
  String get dashboardWelcomeBackSubtitle;

  /// No description provided for @dashboardCurrentProgress.
  ///
  /// In pt, this message translates to:
  /// **'Progresso atual'**
  String get dashboardCurrentProgress;

  /// No description provided for @dashboardCalculusOneCompleted.
  ///
  /// In pt, this message translates to:
  /// **'Cálculo I concluído'**
  String get dashboardCalculusOneCompleted;

  /// No description provided for @dashboardContinuityCompleted.
  ///
  /// In pt, this message translates to:
  /// **'Continuidade concluída'**
  String get dashboardContinuityCompleted;

  /// No description provided for @dashboardLimitsCompleted.
  ///
  /// In pt, this message translates to:
  /// **'Limites concluído'**
  String get dashboardLimitsCompleted;

  /// No description provided for @dashboardFoundationsCompleted.
  ///
  /// In pt, this message translates to:
  /// **'Fundamentos Matemáticos concluído'**
  String get dashboardFoundationsCompleted;

  /// No description provided for @dashboardEquationsCompleted.
  ///
  /// In pt, this message translates to:
  /// **'Equações e Inequações concluídas'**
  String get dashboardEquationsCompleted;

  /// No description provided for @dashboardAlgebraCompleted.
  ///
  /// In pt, this message translates to:
  /// **'Álgebra Fundamental concluída'**
  String get dashboardAlgebraCompleted;

  /// No description provided for @dashboardStartFirstLesson.
  ///
  /// In pt, this message translates to:
  /// **'Comece sua primeira aula'**
  String get dashboardStartFirstLesson;

  /// No description provided for @dashboardNextMission.
  ///
  /// In pt, this message translates to:
  /// **'Próxima missão'**
  String get dashboardNextMission;

  /// No description provided for @dashboardMissionModuleCompleted.
  ///
  /// In pt, this message translates to:
  /// **'Módulo concluído! Continue praticando para fixar o conteúdo.'**
  String get dashboardMissionModuleCompleted;

  /// No description provided for @dashboardMissionDerivatives.
  ///
  /// In pt, this message translates to:
  /// **'Próxima etapa: estudar Derivadas.'**
  String get dashboardMissionDerivatives;

  /// No description provided for @dashboardMissionContinuity.
  ///
  /// In pt, this message translates to:
  /// **'Próxima etapa: estudar Continuidade.'**
  String get dashboardMissionContinuity;

  /// No description provided for @dashboardMissionLimits.
  ///
  /// In pt, this message translates to:
  /// **'Inicie Cálculo I com a aula de Limites.'**
  String get dashboardMissionLimits;

  /// No description provided for @dashboardMissionFunctions.
  ///
  /// In pt, this message translates to:
  /// **'Continue com Aula 3 — Funções.'**
  String get dashboardMissionFunctions;

  /// No description provided for @dashboardMissionEquations.
  ///
  /// In pt, this message translates to:
  /// **'Continue com Equações e Inequações.'**
  String get dashboardMissionEquations;

  /// No description provided for @dashboardMissionFoundations.
  ///
  /// In pt, this message translates to:
  /// **'Avance na trilha de Fundamentos Matemáticos.'**
  String get dashboardMissionFoundations;

  /// No description provided for @dashboardContinuePath.
  ///
  /// In pt, this message translates to:
  /// **'Continuar trilha'**
  String get dashboardContinuePath;

  /// No description provided for @level.
  ///
  /// In pt, this message translates to:
  /// **'Nível'**
  String get level;

  /// No description provided for @xp.
  ///
  /// In pt, this message translates to:
  /// **'XP'**
  String get xp;

  /// No description provided for @gold.
  ///
  /// In pt, this message translates to:
  /// **'Ouro'**
  String get gold;

  /// No description provided for @statisticsYourProgress.
  ///
  /// In pt, this message translates to:
  /// **'Seu progresso'**
  String get statisticsYourProgress;

  /// No description provided for @statisticsSubtitle.
  ///
  /// In pt, this message translates to:
  /// **'Acompanhe sua evolução com dados reais dos seus estudos.'**
  String get statisticsSubtitle;

  /// No description provided for @statisticsCheckingPremium.
  ///
  /// In pt, this message translates to:
  /// **'Verificando acesso Premium...'**
  String get statisticsCheckingPremium;

  /// No description provided for @statisticsTotalXp.
  ///
  /// In pt, this message translates to:
  /// **'XP total'**
  String get statisticsTotalXp;

  /// No description provided for @statisticsLevelStudyMessage.
  ///
  /// In pt, this message translates to:
  /// **'Nível {level} • Continue estudando para evoluir.'**
  String statisticsLevelStudyMessage(int level);

  /// No description provided for @statisticsCompletedLessons.
  ///
  /// In pt, this message translates to:
  /// **'Aulas concluídas'**
  String get statisticsCompletedLessons;

  /// No description provided for @statisticsAccumulatedGold.
  ///
  /// In pt, this message translates to:
  /// **'Ouro acumulado'**
  String get statisticsAccumulatedGold;

  /// No description provided for @statisticsTodayActivity.
  ///
  /// In pt, this message translates to:
  /// **'Atividade de hoje'**
  String get statisticsTodayActivity;

  /// No description provided for @statisticsDailyGoal.
  ///
  /// In pt, this message translates to:
  /// **'Meta diária'**
  String get statisticsDailyGoal;

  /// No description provided for @statisticsDailyGoalCompleted.
  ///
  /// In pt, this message translates to:
  /// **'Meta concluída! Você respondeu {answered} questões hoje.'**
  String statisticsDailyGoalCompleted(int answered);

  /// No description provided for @statisticsDailyGoalRemaining.
  ///
  /// In pt, this message translates to:
  /// **'Responda {remaining} questões para concluir a meta.'**
  String statisticsDailyGoalRemaining(int remaining);

  /// No description provided for @statisticsStreakDay.
  ///
  /// In pt, this message translates to:
  /// **'dia seguido'**
  String get statisticsStreakDay;

  /// No description provided for @statisticsStreakDays.
  ///
  /// In pt, this message translates to:
  /// **'dias seguidos'**
  String get statisticsStreakDays;

  /// No description provided for @statisticsPerformance.
  ///
  /// In pt, this message translates to:
  /// **'Desempenho'**
  String get statisticsPerformance;

  /// No description provided for @statisticsCorrectAnswers.
  ///
  /// In pt, this message translates to:
  /// **'Acertos'**
  String get statisticsCorrectAnswers;

  /// No description provided for @statisticsIncorrectAnswers.
  ///
  /// In pt, this message translates to:
  /// **'Erros'**
  String get statisticsIncorrectAnswers;

  /// No description provided for @statisticsOverallAccuracy.
  ///
  /// In pt, this message translates to:
  /// **'Precisão geral'**
  String get statisticsOverallAccuracy;

  /// No description provided for @statisticsAccuracyNoAnswers.
  ///
  /// In pt, this message translates to:
  /// **'Responda exercícios para calcular sua precisão.'**
  String get statisticsAccuracyNoAnswers;

  /// No description provided for @statisticsAccuracyCalculated.
  ///
  /// In pt, this message translates to:
  /// **'Calculada com todas as respostas registradas.'**
  String get statisticsAccuracyCalculated;

  /// No description provided for @statisticsContent.
  ///
  /// In pt, this message translates to:
  /// **'Conteúdo'**
  String get statisticsContent;

  /// No description provided for @statisticsContentCompleted.
  ///
  /// In pt, this message translates to:
  /// **'Conteúdo concluído'**
  String get statisticsContentCompleted;

  /// No description provided for @statisticsProgressFirstLesson.
  ///
  /// In pt, this message translates to:
  /// **'Conclua sua primeira aula para iniciar suas estatísticas.'**
  String get statisticsProgressFirstLesson;

  /// No description provided for @statisticsProgressAllCompleted.
  ///
  /// In pt, this message translates to:
  /// **'Você concluiu todo o conteúdo disponível nesta versão.'**
  String get statisticsProgressAllCompleted;

  /// No description provided for @statisticsProgressRemaining.
  ///
  /// In pt, this message translates to:
  /// **'{remaining} {lessonWord} no conteúdo atual.'**
  String statisticsProgressRemaining(int remaining, String lessonWord);

  /// No description provided for @statisticsRemainingLesson.
  ///
  /// In pt, this message translates to:
  /// **'aula restante'**
  String get statisticsRemainingLesson;

  /// No description provided for @statisticsRemainingLessons.
  ///
  /// In pt, this message translates to:
  /// **'aulas restantes'**
  String get statisticsRemainingLessons;

  /// No description provided for @settingsPrivacyAndData.
  ///
  /// In pt, this message translates to:
  /// **'Privacidade e dados'**
  String get settingsPrivacyAndData;

  /// No description provided for @settingsPrivacySubtitle.
  ///
  /// In pt, this message translates to:
  /// **'Política de privacidade e exclusão de conta'**
  String get settingsPrivacySubtitle;

  /// No description provided for @settingsNotifications.
  ///
  /// In pt, this message translates to:
  /// **'Notificações'**
  String get settingsNotifications;

  /// No description provided for @settingsNotificationsSubtitle.
  ///
  /// In pt, this message translates to:
  /// **'Lembretes de estudo e metas diárias'**
  String get settingsNotificationsSubtitle;

  /// No description provided for @settingsTheme.
  ///
  /// In pt, this message translates to:
  /// **'Tema'**
  String get settingsTheme;

  /// No description provided for @settingsThemeSubtitle.
  ///
  /// In pt, this message translates to:
  /// **'Modo claro ativado'**
  String get settingsThemeSubtitle;

  /// No description provided for @settingsSubscription.
  ///
  /// In pt, this message translates to:
  /// **'Assinatura'**
  String get settingsSubscription;

  /// No description provided for @settingsPremiumAccessActive.
  ///
  /// In pt, this message translates to:
  /// **'Você possui acesso aos recursos Premium.'**
  String get settingsPremiumAccessActive;

  /// No description provided for @settingsPremiumAccessFree.
  ///
  /// In pt, this message translates to:
  /// **'Assine para liberar todos os recursos.'**
  String get settingsPremiumAccessFree;

  /// No description provided for @settingsRestorePurchases.
  ///
  /// In pt, this message translates to:
  /// **'Restaurar compras'**
  String get settingsRestorePurchases;

  /// No description provided for @settingsRestorePurchasesSubtitle.
  ///
  /// In pt, this message translates to:
  /// **'Recupere uma assinatura comprada anteriormente'**
  String get settingsRestorePurchasesSubtitle;

  /// No description provided for @settingsManageSubscription.
  ///
  /// In pt, this message translates to:
  /// **'Gerenciar assinatura'**
  String get settingsManageSubscription;

  /// No description provided for @settingsManageSubscriptionSubtitle.
  ///
  /// In pt, this message translates to:
  /// **'Consulte, altere ou cancele seu plano'**
  String get settingsManageSubscriptionSubtitle;

  /// No description provided for @settingsSignOut.
  ///
  /// In pt, this message translates to:
  /// **'Sair da conta'**
  String get settingsSignOut;

  /// No description provided for @settingsDeleteAccount.
  ///
  /// In pt, this message translates to:
  /// **'Excluir minha conta'**
  String get settingsDeleteAccount;

  /// No description provided for @settingsDeleteAccountSubtitle.
  ///
  /// In pt, this message translates to:
  /// **'Apague permanentemente sua conta e seu progresso'**
  String get settingsDeleteAccountSubtitle;

  /// No description provided for @settingsPrivacyOpenError.
  ///
  /// In pt, this message translates to:
  /// **'Não foi possível abrir a página de privacidade.'**
  String get settingsPrivacyOpenError;

  /// No description provided for @settingsPremiumUnavailable.
  ///
  /// In pt, this message translates to:
  /// **'O sistema Premium está indisponível no momento.'**
  String get settingsPremiumUnavailable;

  /// No description provided for @settingsRestoreSuccess.
  ///
  /// In pt, this message translates to:
  /// **'Compras restauradas. Seu acesso Premium está ativo.'**
  String get settingsRestoreSuccess;

  /// No description provided for @settingsRestoreNone.
  ///
  /// In pt, this message translates to:
  /// **'Nenhuma compra Premium foi encontrada para esta conta.'**
  String get settingsRestoreNone;

  /// No description provided for @settingsRestoreError.
  ///
  /// In pt, this message translates to:
  /// **'Não foi possível restaurar suas compras.'**
  String get settingsRestoreError;

  /// No description provided for @settingsCustomerCenterError.
  ///
  /// In pt, this message translates to:
  /// **'Não foi possível abrir o gerenciamento da assinatura.'**
  String get settingsCustomerCenterError;

  /// No description provided for @settingsSignOutTitle.
  ///
  /// In pt, this message translates to:
  /// **'Sair da conta?'**
  String get settingsSignOutTitle;

  /// No description provided for @settingsSignOutDescription.
  ///
  /// In pt, this message translates to:
  /// **'Seu progresso permanecerá salvo e poderá ser recuperado quando você entrar novamente.'**
  String get settingsSignOutDescription;

  /// No description provided for @settingsSignOutAction.
  ///
  /// In pt, this message translates to:
  /// **'Sair'**
  String get settingsSignOutAction;

  /// No description provided for @settingsSignOutError.
  ///
  /// In pt, this message translates to:
  /// **'Não foi possível sair da conta. Tente novamente.'**
  String get settingsSignOutError;

  /// No description provided for @settingsSignOutUnexpectedError.
  ///
  /// In pt, this message translates to:
  /// **'Ocorreu um erro inesperado ao sair da conta.'**
  String get settingsSignOutUnexpectedError;

  /// No description provided for @settingsDeleteTitle.
  ///
  /// In pt, this message translates to:
  /// **'Excluir conta permanentemente?'**
  String get settingsDeleteTitle;

  /// No description provided for @settingsDeleteWarning.
  ///
  /// In pt, this message translates to:
  /// **'Seu progresso, XP, moedas e conta serão apagados. Essa ação não poderá ser desfeita.'**
  String get settingsDeleteWarning;

  /// No description provided for @settingsDeleteSubscriptionWarning.
  ///
  /// In pt, this message translates to:
  /// **'A exclusão não cancela uma assinatura ativa. Cancele-a em “Gerenciar assinatura” antes de continuar.'**
  String get settingsDeleteSubscriptionWarning;

  /// No description provided for @settingsDeletePasswordLabel.
  ///
  /// In pt, this message translates to:
  /// **'Confirme sua senha'**
  String get settingsDeletePasswordLabel;

  /// No description provided for @settingsDeletePermanent.
  ///
  /// In pt, this message translates to:
  /// **'Excluir permanentemente'**
  String get settingsDeletePermanent;

  /// No description provided for @settingsDeleteIdentifyError.
  ///
  /// In pt, this message translates to:
  /// **'Não foi possível identificar a conta atual.'**
  String get settingsDeleteIdentifyError;

  /// No description provided for @settingsDeleteFunctionError.
  ///
  /// In pt, this message translates to:
  /// **'Não foi possível concluir a exclusão. Tente novamente.'**
  String get settingsDeleteFunctionError;

  /// No description provided for @settingsDeleteWrongPassword.
  ///
  /// In pt, this message translates to:
  /// **'Senha incorreta. A conta não foi excluída.'**
  String get settingsDeleteWrongPassword;

  /// No description provided for @settingsDeleteTooManyRequests.
  ///
  /// In pt, this message translates to:
  /// **'Muitas tentativas. Aguarde um pouco e tente novamente.'**
  String get settingsDeleteTooManyRequests;

  /// No description provided for @settingsDeleteNetworkError.
  ///
  /// In pt, this message translates to:
  /// **'Verifique sua conexão com a internet e tente novamente.'**
  String get settingsDeleteNetworkError;

  /// No description provided for @settingsDeleteRequiresRecentLogin.
  ///
  /// In pt, this message translates to:
  /// **'Entre novamente na conta antes de tentar excluí-la.'**
  String get settingsDeleteRequiresRecentLogin;

  /// No description provided for @settingsDeleteGenericError.
  ///
  /// In pt, this message translates to:
  /// **'Não foi possível excluir a conta. Tente novamente.'**
  String get settingsDeleteGenericError;

  /// No description provided for @moduleDetailSubtitle.
  ///
  /// In pt, this message translates to:
  /// **'Construa a base necessária para estudar Cálculo.'**
  String get moduleDetailSubtitle;

  /// No description provided for @moduleDetailCompleted.
  ///
  /// In pt, this message translates to:
  /// **'Módulo concluído'**
  String get moduleDetailCompleted;

  /// No description provided for @moduleDetailLessonOneCompleted.
  ///
  /// In pt, this message translates to:
  /// **'Aula 1 concluída'**
  String get moduleDetailLessonOneCompleted;

  /// No description provided for @moduleDetailLessonTwoCompleted.
  ///
  /// In pt, this message translates to:
  /// **'Aula 2 concluída'**
  String get moduleDetailLessonTwoCompleted;

  /// No description provided for @moduleDetailStartFirstLesson.
  ///
  /// In pt, this message translates to:
  /// **'Comece pela primeira aula'**
  String get moduleDetailStartFirstLesson;

  /// No description provided for @moduleDetailLessonUnlocked.
  ///
  /// In pt, this message translates to:
  /// **'Desbloqueada'**
  String get moduleDetailLessonUnlocked;

  /// No description provided for @moduleDetailAlgebraTitle.
  ///
  /// In pt, this message translates to:
  /// **'Aula 1 — Álgebra Fundamental'**
  String get moduleDetailAlgebraTitle;

  /// No description provided for @moduleDetailAlgebraSubtitle.
  ///
  /// In pt, this message translates to:
  /// **'8 aulas • expressões, potências e fatoração'**
  String get moduleDetailAlgebraSubtitle;

  /// No description provided for @moduleDetailEquationsTitle.
  ///
  /// In pt, this message translates to:
  /// **'Aula 2 — Equações e Inequações'**
  String get moduleDetailEquationsTitle;

  /// No description provided for @moduleDetailEquationsSubtitle.
  ///
  /// In pt, this message translates to:
  /// **'Manipulação algébrica e resolução'**
  String get moduleDetailEquationsSubtitle;

  /// No description provided for @moduleDetailFunctionsTitle.
  ///
  /// In pt, this message translates to:
  /// **'Aula 3 — Funções'**
  String get moduleDetailFunctionsTitle;

  /// No description provided for @moduleDetailFunctionsSubtitle.
  ///
  /// In pt, this message translates to:
  /// **'Domínio, imagem e gráficos'**
  String get moduleDetailFunctionsSubtitle;

  /// No description provided for @exerciseQuestionProgress.
  ///
  /// In pt, this message translates to:
  /// **'Questão {current} de {total}'**
  String exerciseQuestionProgress(int current, int total);

  /// No description provided for @exerciseAlgebraInstruction.
  ///
  /// In pt, this message translates to:
  /// **'Escolha a melhor transformação algébrica.'**
  String get exerciseAlgebraInstruction;

  /// No description provided for @exerciseDifficultyFoundation.
  ///
  /// In pt, this message translates to:
  /// **'Fundamentos'**
  String get exerciseDifficultyFoundation;

  /// No description provided for @exerciseDifficultyIntermediate.
  ///
  /// In pt, this message translates to:
  /// **'Intermediária'**
  String get exerciseDifficultyIntermediate;

  /// No description provided for @exerciseDifficultyChallenge.
  ///
  /// In pt, this message translates to:
  /// **'Desafio'**
  String get exerciseDifficultyChallenge;

  /// No description provided for @exerciseChooseAlternative.
  ///
  /// In pt, this message translates to:
  /// **'Escolha uma alternativa antes de continuar.'**
  String get exerciseChooseAlternative;

  /// No description provided for @exerciseFinish.
  ///
  /// In pt, this message translates to:
  /// **'Finalizar exercícios'**
  String get exerciseFinish;

  /// No description provided for @exerciseNextQuestion.
  ///
  /// In pt, this message translates to:
  /// **'Próxima questão'**
  String get exerciseNextQuestion;

  /// No description provided for @resultExercisesCompletedSemantic.
  ///
  /// In pt, this message translates to:
  /// **'Exercícios concluídos'**
  String get resultExercisesCompletedSemantic;

  /// No description provided for @resultGoalReached.
  ///
  /// In pt, this message translates to:
  /// **'Objetivo atingido!'**
  String get resultGoalReached;

  /// No description provided for @resultKeepPracticing.
  ///
  /// In pt, this message translates to:
  /// **'Continue praticando'**
  String get resultKeepPracticing;

  /// No description provided for @resultApprovedMessage.
  ///
  /// In pt, this message translates to:
  /// **'Você alcançou o rendimento necessário para avançar.'**
  String get resultApprovedMessage;

  /// No description provided for @resultNeedEightyPercent.
  ///
  /// In pt, this message translates to:
  /// **'Você precisa de pelo menos 80% para desbloquear a próxima aula.'**
  String get resultNeedEightyPercent;

  /// No description provided for @resultAccuracyPerformance.
  ///
  /// In pt, this message translates to:
  /// **'{percentage}% de precisão'**
  String resultAccuracyPerformance(int percentage);

  /// No description provided for @resultCorrectAnswers.
  ///
  /// In pt, this message translates to:
  /// **'Acertos'**
  String get resultCorrectAnswers;

  /// No description provided for @resultIncorrectAnswers.
  ///
  /// In pt, this message translates to:
  /// **'Erros'**
  String get resultIncorrectAnswers;

  /// No description provided for @resultAccuracy.
  ///
  /// In pt, this message translates to:
  /// **'Precisão'**
  String get resultAccuracy;

  /// No description provided for @resultXpEarned.
  ///
  /// In pt, this message translates to:
  /// **'XP ganho'**
  String get resultXpEarned;

  /// No description provided for @resultGoldEarned.
  ///
  /// In pt, this message translates to:
  /// **'Ouro ganho'**
  String get resultGoldEarned;

  /// No description provided for @resultReviewOneError.
  ///
  /// In pt, this message translates to:
  /// **'Revisar 1 erro'**
  String get resultReviewOneError;

  /// No description provided for @resultReviewErrors.
  ///
  /// In pt, this message translates to:
  /// **'Revisar {count} erros'**
  String resultReviewErrors(int count);

  /// No description provided for @resultReceiveReward.
  ///
  /// In pt, this message translates to:
  /// **'Receber recompensa'**
  String get resultReceiveReward;

  /// No description provided for @resultBackToPath.
  ///
  /// In pt, this message translates to:
  /// **'Voltar para a trilha'**
  String get resultBackToPath;

  /// No description provided for @feedbackGoodAnalysis.
  ///
  /// In pt, this message translates to:
  /// **'Boa análise!'**
  String get feedbackGoodAnalysis;

  /// No description provided for @feedbackUnderstandError.
  ///
  /// In pt, this message translates to:
  /// **'Vamos entender o erro'**
  String get feedbackUnderstandError;

  /// No description provided for @feedbackYourAnswer.
  ///
  /// In pt, this message translates to:
  /// **'Sua resposta: {answer}'**
  String feedbackYourAnswer(String answer);

  /// No description provided for @feedbackCorrectAnswer.
  ///
  /// In pt, this message translates to:
  /// **'Resposta correta: {answer}'**
  String feedbackCorrectAnswer(String answer);

  /// No description provided for @feedbackStepByStep.
  ///
  /// In pt, this message translates to:
  /// **'Explicação passo a passo'**
  String get feedbackStepByStep;

  /// No description provided for @feedbackViewResult.
  ///
  /// In pt, this message translates to:
  /// **'Ver meu resultado'**
  String get feedbackViewResult;

  /// No description provided for @feedbackContinuePracticing.
  ///
  /// In pt, this message translates to:
  /// **'Continuar praticando'**
  String get feedbackContinuePracticing;

  /// No description provided for @reviewErrorsTitle.
  ///
  /// In pt, this message translates to:
  /// **'Revisão dos erros'**
  String get reviewErrorsTitle;

  /// No description provided for @reviewUnderstandEachAnswer.
  ///
  /// In pt, this message translates to:
  /// **'Entenda cada resposta'**
  String get reviewUnderstandEachAnswer;

  /// No description provided for @reviewScoreUnchanged.
  ///
  /// In pt, this message translates to:
  /// **'Sua nota não será alterada durante a revisão.'**
  String get reviewScoreUnchanged;

  /// No description provided for @reviewErrorProgress.
  ///
  /// In pt, this message translates to:
  /// **'Erro {current} de {total}'**
  String reviewErrorProgress(int current, int total);

  /// No description provided for @reviewYourAnswer.
  ///
  /// In pt, this message translates to:
  /// **'Sua resposta'**
  String get reviewYourAnswer;

  /// No description provided for @reviewCorrectAnswer.
  ///
  /// In pt, this message translates to:
  /// **'Resposta correta'**
  String get reviewCorrectAnswer;

  /// No description provided for @reviewExplanation.
  ///
  /// In pt, this message translates to:
  /// **'Explicação'**
  String get reviewExplanation;

  /// No description provided for @reviewFinish.
  ///
  /// In pt, this message translates to:
  /// **'Concluir revisão'**
  String get reviewFinish;

  /// No description provided for @reviewNextError.
  ///
  /// In pt, this message translates to:
  /// **'Próximo erro'**
  String get reviewNextError;

  /// No description provided for @rewardUnlocked.
  ///
  /// In pt, this message translates to:
  /// **'Recompensa desbloqueada'**
  String get rewardUnlocked;

  /// No description provided for @rewardDerivativesDescription.
  ///
  /// In pt, this message translates to:
  /// **'Você concluiu Derivadas e finalizou o módulo Cálculo I.'**
  String get rewardDerivativesDescription;

  /// No description provided for @rewardContinuityDescription.
  ///
  /// In pt, this message translates to:
  /// **'Você concluiu a sequência de Continuidade em Cálculo I.'**
  String get rewardContinuityDescription;

  /// No description provided for @rewardLimitsDescription.
  ///
  /// In pt, this message translates to:
  /// **'Você concluiu a sequência universitária de Limites.'**
  String get rewardLimitsDescription;

  /// No description provided for @rewardFunctionsDescription.
  ///
  /// In pt, this message translates to:
  /// **'Você concluiu a sequência de Funções e finalizou o módulo Fundamentos Matemáticos.'**
  String get rewardFunctionsDescription;

  /// No description provided for @rewardEquationsDescription.
  ///
  /// In pt, this message translates to:
  /// **'Você concluiu a sequência de Equações e Inequações.'**
  String get rewardEquationsDescription;

  /// No description provided for @rewardAlgebraDescription.
  ///
  /// In pt, this message translates to:
  /// **'Você concluiu a sequência de Álgebra Fundamental.'**
  String get rewardAlgebraDescription;

  /// No description provided for @rewardModuleCompleted.
  ///
  /// In pt, this message translates to:
  /// **'Módulo concluído'**
  String get rewardModuleCompleted;

  /// No description provided for @rewardLessonCompleted.
  ///
  /// In pt, this message translates to:
  /// **'Aula concluída'**
  String get rewardLessonCompleted;

  /// No description provided for @rewardExperienceReceived.
  ///
  /// In pt, this message translates to:
  /// **'Experiência recebida'**
  String get rewardExperienceReceived;

  /// No description provided for @rewardGoldReceived.
  ///
  /// In pt, this message translates to:
  /// **'Ouro recebido'**
  String get rewardGoldReceived;

  /// No description provided for @rewardProgress.
  ///
  /// In pt, this message translates to:
  /// **'Progresso'**
  String get rewardProgress;

  /// No description provided for @miniChallengeTitle.
  ///
  /// In pt, this message translates to:
  /// **'Mini Desafio'**
  String get miniChallengeTitle;

  /// No description provided for @miniChallengeQuickTest.
  ///
  /// In pt, this message translates to:
  /// **'Teste rápido'**
  String get miniChallengeQuickTest;

  /// No description provided for @miniChallengeSubtitle.
  ///
  /// In pt, this message translates to:
  /// **'Escolha a resposta correta para liberar os próximos exercícios.'**
  String get miniChallengeSubtitle;

  /// No description provided for @miniChallengeQuestion.
  ///
  /// In pt, this message translates to:
  /// **'Qual é o resultado de 4x + 2x?'**
  String get miniChallengeQuestion;

  /// No description provided for @miniChallengeChooseAnswer.
  ///
  /// In pt, this message translates to:
  /// **'Escolha uma alternativa antes de responder.'**
  String get miniChallengeChooseAnswer;

  /// No description provided for @miniChallengeIncorrect.
  ///
  /// In pt, this message translates to:
  /// **'Resposta incorreta. Tente novamente.'**
  String get miniChallengeIncorrect;

  /// No description provided for @miniChallengeRespond.
  ///
  /// In pt, this message translates to:
  /// **'Responder'**
  String get miniChallengeRespond;

  /// No description provided for @miniChallengeXpHint.
  ///
  /// In pt, this message translates to:
  /// **'Você ganha XP ao acertar o desafio.'**
  String get miniChallengeXpHint;

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
