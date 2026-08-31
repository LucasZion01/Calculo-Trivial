// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appName => 'Cálculo Trivial';

  @override
  String get appTagline => 'Domine o cálculo. Evolua além.';

  @override
  String get appSymbolSemanticLabel => 'Símbolo do Cálculo Trivial';

  @override
  String get loading => 'Carregando';

  @override
  String get home => 'Início';

  @override
  String get learningPath => 'Trilha';

  @override
  String get statistics => 'Estatísticas';

  @override
  String get profile => 'Perfil';

  @override
  String get settings => 'Configurações';

  @override
  String get language => 'Idioma';

  @override
  String get portuguese => 'Português';

  @override
  String get english => 'English';

  @override
  String get languageSettingsSubtitle =>
      'Escolha o idioma usado no aplicativo.';

  @override
  String get languageUpdated => 'Idioma atualizado';

  @override
  String get account => 'Conta';

  @override
  String get accountSettings => 'Ajustes da conta';

  @override
  String get accountSettingsSubtitle =>
      'Gerencie sua conta, preferências e assinatura.';

  @override
  String get unidentifiedAccount => 'Conta não identificada';

  @override
  String get name => 'Nome';

  @override
  String get email => 'E-mail';

  @override
  String get password => 'Senha';

  @override
  String get confirmPassword => 'Confirmar senha';

  @override
  String get login => 'Entrar';

  @override
  String get createAccount => 'Criar conta';

  @override
  String get forgotPassword => 'Esqueci minha senha';

  @override
  String get loginAccessAccount => 'Acesse sua conta';

  @override
  String get loginJourneySubtitle =>
      'Entre para iniciar ou continuar sua jornada.';

  @override
  String get loginEmailHint => 'Digite seu e-mail';

  @override
  String get loginPasswordHint => 'Digite sua senha';

  @override
  String get loginNoAccount => 'Ainda não tem uma conta?';

  @override
  String get loginFillEmailAndPassword => 'Preencha o e-mail e a senha.';

  @override
  String get loginInvalidEmail => 'Digite um endereço de e-mail válido.';

  @override
  String get loginUserDisabled => 'Esta conta foi desativada.';

  @override
  String get loginInvalidCredentials => 'E-mail ou senha incorretos.';

  @override
  String get loginTooManyRequests =>
      'Muitas tentativas. Aguarde um pouco e tente novamente.';

  @override
  String get loginNetworkError => 'Verifique sua conexão com a internet.';

  @override
  String get loginGenericError => 'Não foi possível entrar. Tente novamente.';

  @override
  String get loginUnexpectedError => 'Ocorreu um erro inesperado ao entrar.';

  @override
  String get loginEnterEmailForReset =>
      'Digite seu e-mail para receber a recuperação de senha.';

  @override
  String get loginResetEmailSent =>
      'Enviamos as instruções de recuperação para o seu e-mail.';

  @override
  String get loginResetEmailError =>
      'Não foi possível enviar a recuperação de senha.';

  @override
  String get registerCreateAccountTitle => 'Crie sua conta';

  @override
  String get registerJourneySubtitle => 'Comece sua jornada de aprendizagem.';

  @override
  String get registerNameHint => 'Digite seu nome';

  @override
  String get registerPasswordHint => 'Crie uma senha';

  @override
  String get registerConfirmPasswordHint => 'Digite sua senha novamente';

  @override
  String get registerAlreadyHaveAccount => 'Já possui uma conta?';

  @override
  String get registerFillAllFields => 'Preencha todos os campos.';

  @override
  String get registerEnterName => 'Digite seu nome.';

  @override
  String get registerPasswordTooShort =>
      'A senha precisa ter pelo menos 6 caracteres.';

  @override
  String get registerPasswordsDoNotMatch => 'As senhas não coincidem.';

  @override
  String get registerEmailAlreadyInUse =>
      'Já existe uma conta cadastrada com este e-mail.';

  @override
  String get registerWeakPassword =>
      'Crie uma senha mais forte, com pelo menos 6 caracteres.';

  @override
  String get registerOperationNotAllowed =>
      'O cadastro por e-mail não está disponível.';

  @override
  String get registerGenericError => 'Não foi possível criar sua conta.';

  @override
  String get registerUnexpectedError =>
      'Ocorreu um erro inesperado ao criar sua conta.';

  @override
  String get student => 'Estudante';

  @override
  String get emailNotProvided => 'E-mail não informado';

  @override
  String levelLabel(int level) {
    return 'Nível $level';
  }

  @override
  String xpAndGold(int xp, int gold) {
    return '$xp XP • $gold de ouro';
  }

  @override
  String xpRemainingForNextLevel(int xp) {
    return 'Faltam $xp XP para o próximo nível.';
  }

  @override
  String get achievements => 'Conquistas';

  @override
  String get premium => 'Premium';

  @override
  String get premiumActive => 'Premium ativo';

  @override
  String get premiumActiveUppercase => 'PREMIUM ATIVO';

  @override
  String get premiumUppercase => 'PREMIUM';

  @override
  String get freePlan => 'Plano gratuito';

  @override
  String get premiumManageSubscription =>
      'Gerencie sua assinatura e suas compras.';

  @override
  String get premiumDiscoverFeatures =>
      'Conheça os recursos do Cálculo Trivial Premium.';

  @override
  String get achievementCalculusOneMastered => 'Cálculo I dominado';

  @override
  String get achievementCalculusOneMasteredDescription =>
      'Você concluiu Limites, Continuidade e Derivadas.';

  @override
  String get achievementContinuityCompleted => 'Funções sem interrupções';

  @override
  String get achievementContinuityCompletedDescription =>
      'Você concluiu Continuidade em Cálculo I.';

  @override
  String get achievementFirstCalculusSteps => 'Primeiros passos no Cálculo I';

  @override
  String get achievementFirstCalculusStepsDescription =>
      'Você concluiu sua primeira sequência de Limites.';

  @override
  String get achievementFoundationsMastered => 'Fundamentos dominados';

  @override
  String get achievementFoundationsMasteredDescription =>
      'Você concluiu o módulo Fundamentos Matemáticos.';

  @override
  String get achievementEquationsCompleted => 'Equações concluídas';

  @override
  String get achievementEquationsCompletedDescription =>
      'Você avançou em Equações e Inequações.';

  @override
  String get achievementFirstLessonCompleted => 'Primeira aula concluída';

  @override
  String get achievementFirstLessonCompletedDescription =>
      'Você iniciou sua jornada no Cálculo Trivial.';

  @override
  String get achievementFirstAchievement => 'Sua primeira conquista';

  @override
  String get achievementFirstAchievementDescription =>
      'Conclua a primeira aula para desbloquear.';

  @override
  String get learningPathTitle => 'Trilha de Aprendizagem';

  @override
  String get learningPathSubtitle =>
      'Avance módulo por módulo até dominar o Cálculo.';

  @override
  String get mathematicalFoundations => 'Fundamentos Matemáticos';

  @override
  String get mathematicalFoundationsSubtitle =>
      'Pré-Cálculo, funções e base algébrica';

  @override
  String get calculusOne => 'Cálculo I';

  @override
  String get calculusOneSubtitle => 'Limites, continuidade e derivadas';

  @override
  String get calculusTwo => 'Cálculo II';

  @override
  String get calculusTwoSubtitle => 'Integrais, séries e equações diferenciais';

  @override
  String get unlocked => 'Desbloqueado';

  @override
  String get back => 'Voltar';

  @override
  String get continueLabel => 'Continuar';

  @override
  String get finish => 'Concluir';

  @override
  String get cancel => 'Cancelar';

  @override
  String get available => 'Disponível';

  @override
  String get locked => 'Bloqueada';

  @override
  String get completed => 'Concluída';

  @override
  String get lesson => 'Aula';

  @override
  String get lessons => 'Aulas';

  @override
  String get lessonCompleted => 'Aula concluída';

  @override
  String get startExercises => 'Iniciar exercícios';

  @override
  String get readyToPractice => 'Pronto para praticar';

  @override
  String get finalPracticeLocked => 'Prática final bloqueada';

  @override
  String get yourJourney => 'Sua jornada';

  @override
  String get moduleProgress => 'Progresso do módulo';

  @override
  String get equationsAndInequalities => 'Equações e Inequações';

  @override
  String get fundamentalAlgebra => 'Álgebra Fundamental';

  @override
  String get functions => 'Funções';

  @override
  String get limits => 'Limites';

  @override
  String get continuity => 'Continuidade';

  @override
  String get derivatives => 'Derivadas';

  @override
  String approxMinutes(int minutes) {
    return '≈ $minutes min';
  }
}
