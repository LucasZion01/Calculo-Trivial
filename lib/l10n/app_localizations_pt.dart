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
  String get dashboardFirstWelcome => 'Bem-vindo, futuro engenheiro!';

  @override
  String dashboardWelcomeBack(String name) {
    return 'Bem-vindo de volta, $name!';
  }

  @override
  String get dashboardFirstWelcomeSubtitle =>
      'Sua jornada no Cálculo começa agora.';

  @override
  String get dashboardWelcomeBackSubtitle => 'Continue sua jornada no Cálculo.';

  @override
  String get dashboardCurrentProgress => 'Progresso atual';

  @override
  String get dashboardCalculusOneCompleted => 'Cálculo I concluído';

  @override
  String get dashboardContinuityCompleted => 'Continuidade concluída';

  @override
  String get dashboardLimitsCompleted => 'Limites concluído';

  @override
  String get dashboardFoundationsCompleted =>
      'Fundamentos Matemáticos concluído';

  @override
  String get dashboardEquationsCompleted => 'Equações e Inequações concluídas';

  @override
  String get dashboardAlgebraCompleted => 'Álgebra Fundamental concluída';

  @override
  String get dashboardStartFirstLesson => 'Comece sua primeira aula';

  @override
  String get dashboardNextMission => 'Próxima missão';

  @override
  String get dashboardMissionModuleCompleted =>
      'Módulo concluído! Continue praticando para fixar o conteúdo.';

  @override
  String get dashboardMissionDerivatives => 'Próxima etapa: estudar Derivadas.';

  @override
  String get dashboardMissionContinuity =>
      'Próxima etapa: estudar Continuidade.';

  @override
  String get dashboardMissionLimits =>
      'Inicie Cálculo I com a aula de Limites.';

  @override
  String get dashboardMissionFunctions => 'Continue com Aula 3 — Funções.';

  @override
  String get dashboardMissionEquations => 'Continue com Equações e Inequações.';

  @override
  String get dashboardMissionFoundations =>
      'Avance na trilha de Fundamentos Matemáticos.';

  @override
  String get dashboardContinuePath => 'Continuar trilha';

  @override
  String get level => 'Nível';

  @override
  String get xp => 'XP';

  @override
  String get gold => 'Ouro';

  @override
  String get statisticsYourProgress => 'Seu progresso';

  @override
  String get statisticsSubtitle =>
      'Acompanhe sua evolução com dados reais dos seus estudos.';

  @override
  String get statisticsCheckingPremium => 'Verificando acesso Premium...';

  @override
  String get statisticsTotalXp => 'XP total';

  @override
  String statisticsLevelStudyMessage(int level) {
    return 'Nível $level • Continue estudando para evoluir.';
  }

  @override
  String get statisticsCompletedLessons => 'Aulas concluídas';

  @override
  String get statisticsAccumulatedGold => 'Ouro acumulado';

  @override
  String get statisticsTodayActivity => 'Atividade de hoje';

  @override
  String get statisticsDailyGoal => 'Meta diária';

  @override
  String statisticsDailyGoalCompleted(int answered) {
    return 'Meta concluída! Você respondeu $answered questões hoje.';
  }

  @override
  String statisticsDailyGoalRemaining(int remaining) {
    return 'Responda $remaining questões para concluir a meta.';
  }

  @override
  String get statisticsStreakDay => 'dia seguido';

  @override
  String get statisticsStreakDays => 'dias seguidos';

  @override
  String get statisticsPerformance => 'Desempenho';

  @override
  String get statisticsCorrectAnswers => 'Acertos';

  @override
  String get statisticsIncorrectAnswers => 'Erros';

  @override
  String get statisticsOverallAccuracy => 'Precisão geral';

  @override
  String get statisticsAccuracyNoAnswers =>
      'Responda exercícios para calcular sua precisão.';

  @override
  String get statisticsAccuracyCalculated =>
      'Calculada com todas as respostas registradas.';

  @override
  String get statisticsContent => 'Conteúdo';

  @override
  String get statisticsContentCompleted => 'Conteúdo concluído';

  @override
  String get statisticsProgressFirstLesson =>
      'Conclua sua primeira aula para iniciar suas estatísticas.';

  @override
  String get statisticsProgressAllCompleted =>
      'Você concluiu todo o conteúdo disponível nesta versão.';

  @override
  String statisticsProgressRemaining(int remaining, String lessonWord) {
    return '$remaining $lessonWord no conteúdo atual.';
  }

  @override
  String get statisticsRemainingLesson => 'aula restante';

  @override
  String get statisticsRemainingLessons => 'aulas restantes';

  @override
  String get settingsPrivacyAndData => 'Privacidade e dados';

  @override
  String get settingsPrivacySubtitle =>
      'Política de privacidade e exclusão de conta';

  @override
  String get settingsNotifications => 'Notificações';

  @override
  String get settingsNotificationsSubtitle =>
      'Lembretes de estudo e metas diárias';

  @override
  String get settingsTheme => 'Tema';

  @override
  String get settingsThemeSubtitle => 'Modo claro ativado';

  @override
  String get settingsSubscription => 'Assinatura';

  @override
  String get settingsPremiumAccessActive =>
      'Você possui acesso aos recursos Premium.';

  @override
  String get settingsPremiumAccessFree =>
      'Assine para liberar todos os recursos.';

  @override
  String get settingsRestorePurchases => 'Restaurar compras';

  @override
  String get settingsRestorePurchasesSubtitle =>
      'Recupere uma assinatura comprada anteriormente';

  @override
  String get settingsManageSubscription => 'Gerenciar assinatura';

  @override
  String get settingsManageSubscriptionSubtitle =>
      'Consulte, altere ou cancele seu plano';

  @override
  String get settingsSignOut => 'Sair da conta';

  @override
  String get settingsDeleteAccount => 'Excluir minha conta';

  @override
  String get settingsDeleteAccountSubtitle =>
      'Apague permanentemente sua conta e seu progresso';

  @override
  String get settingsPrivacyOpenError =>
      'Não foi possível abrir a página de privacidade.';

  @override
  String get settingsPremiumUnavailable =>
      'O sistema Premium está indisponível no momento.';

  @override
  String get settingsRestoreSuccess =>
      'Compras restauradas. Seu acesso Premium está ativo.';

  @override
  String get settingsRestoreNone =>
      'Nenhuma compra Premium foi encontrada para esta conta.';

  @override
  String get settingsRestoreError => 'Não foi possível restaurar suas compras.';

  @override
  String get settingsCustomerCenterError =>
      'Não foi possível abrir o gerenciamento da assinatura.';

  @override
  String get settingsSignOutTitle => 'Sair da conta?';

  @override
  String get settingsSignOutDescription =>
      'Seu progresso permanecerá salvo e poderá ser recuperado quando você entrar novamente.';

  @override
  String get settingsSignOutAction => 'Sair';

  @override
  String get settingsSignOutError =>
      'Não foi possível sair da conta. Tente novamente.';

  @override
  String get settingsSignOutUnexpectedError =>
      'Ocorreu um erro inesperado ao sair da conta.';

  @override
  String get settingsDeleteTitle => 'Excluir conta permanentemente?';

  @override
  String get settingsDeleteWarning =>
      'Seu progresso, XP, moedas e conta serão apagados. Essa ação não poderá ser desfeita.';

  @override
  String get settingsDeleteSubscriptionWarning =>
      'A exclusão não cancela uma assinatura ativa. Cancele-a em “Gerenciar assinatura” antes de continuar.';

  @override
  String get settingsDeletePasswordLabel => 'Confirme sua senha';

  @override
  String get settingsDeletePermanent => 'Excluir permanentemente';

  @override
  String get settingsDeleteIdentifyError =>
      'Não foi possível identificar a conta atual.';

  @override
  String get settingsDeleteFunctionError =>
      'Não foi possível concluir a exclusão. Tente novamente.';

  @override
  String get settingsDeleteWrongPassword =>
      'Senha incorreta. A conta não foi excluída.';

  @override
  String get settingsDeleteTooManyRequests =>
      'Muitas tentativas. Aguarde um pouco e tente novamente.';

  @override
  String get settingsDeleteNetworkError =>
      'Verifique sua conexão com a internet e tente novamente.';

  @override
  String get settingsDeleteRequiresRecentLogin =>
      'Entre novamente na conta antes de tentar excluí-la.';

  @override
  String get settingsDeleteGenericError =>
      'Não foi possível excluir a conta. Tente novamente.';

  @override
  String get moduleDetailSubtitle =>
      'Construa a base necessária para estudar Cálculo.';

  @override
  String get moduleDetailCompleted => 'Módulo concluído';

  @override
  String get moduleDetailLessonOneCompleted => 'Aula 1 concluída';

  @override
  String get moduleDetailLessonTwoCompleted => 'Aula 2 concluída';

  @override
  String get moduleDetailStartFirstLesson => 'Comece pela primeira aula';

  @override
  String get moduleDetailLessonUnlocked => 'Desbloqueada';

  @override
  String get moduleDetailAlgebraTitle => 'Aula 1 — Álgebra Fundamental';

  @override
  String get moduleDetailAlgebraSubtitle =>
      '8 aulas • expressões, potências e fatoração';

  @override
  String get moduleDetailEquationsTitle => 'Aula 2 — Equações e Inequações';

  @override
  String get moduleDetailEquationsSubtitle =>
      'Manipulação algébrica e resolução';

  @override
  String get moduleDetailFunctionsTitle => 'Aula 3 — Funções';

  @override
  String get moduleDetailFunctionsSubtitle => 'Domínio, imagem e gráficos';

  @override
  String exerciseQuestionProgress(int current, int total) {
    return 'Questão $current de $total';
  }

  @override
  String get exerciseAlgebraInstruction =>
      'Escolha a melhor transformação algébrica.';

  @override
  String get exerciseDifficultyFoundation => 'Fundamentos';

  @override
  String get exerciseDifficultyIntermediate => 'Intermediária';

  @override
  String get exerciseDifficultyChallenge => 'Desafio';

  @override
  String get exerciseChooseAlternative =>
      'Escolha uma alternativa antes de continuar.';

  @override
  String get exerciseFinish => 'Finalizar exercícios';

  @override
  String get exerciseNextQuestion => 'Próxima questão';

  @override
  String get resultExercisesCompletedSemantic => 'Exercícios concluídos';

  @override
  String get resultGoalReached => 'Objetivo atingido!';

  @override
  String get resultKeepPracticing => 'Continue praticando';

  @override
  String get resultApprovedMessage =>
      'Você alcançou o rendimento necessário para avançar.';

  @override
  String get resultNeedEightyPercent =>
      'Você precisa de pelo menos 80% para desbloquear a próxima aula.';

  @override
  String resultAccuracyPerformance(int percentage) {
    return '$percentage% de precisão';
  }

  @override
  String get resultCorrectAnswers => 'Acertos';

  @override
  String get resultIncorrectAnswers => 'Erros';

  @override
  String get resultAccuracy => 'Precisão';

  @override
  String get resultXpEarned => 'XP ganho';

  @override
  String get resultGoldEarned => 'Ouro ganho';

  @override
  String get resultReviewOneError => 'Revisar 1 erro';

  @override
  String resultReviewErrors(int count) {
    return 'Revisar $count erros';
  }

  @override
  String get resultReceiveReward => 'Receber recompensa';

  @override
  String get resultBackToPath => 'Voltar para a trilha';

  @override
  String get feedbackGoodAnalysis => 'Boa análise!';

  @override
  String get feedbackUnderstandError => 'Vamos entender o erro';

  @override
  String feedbackYourAnswer(String answer) {
    return 'Sua resposta: $answer';
  }

  @override
  String feedbackCorrectAnswer(String answer) {
    return 'Resposta correta: $answer';
  }

  @override
  String get feedbackStepByStep => 'Explicação passo a passo';

  @override
  String get feedbackViewResult => 'Ver meu resultado';

  @override
  String get feedbackContinuePracticing => 'Continuar praticando';

  @override
  String get reviewErrorsTitle => 'Revisão dos erros';

  @override
  String get reviewUnderstandEachAnswer => 'Entenda cada resposta';

  @override
  String get reviewScoreUnchanged =>
      'Sua nota não será alterada durante a revisão.';

  @override
  String reviewErrorProgress(int current, int total) {
    return 'Erro $current de $total';
  }

  @override
  String get reviewYourAnswer => 'Sua resposta';

  @override
  String get reviewCorrectAnswer => 'Resposta correta';

  @override
  String get reviewExplanation => 'Explicação';

  @override
  String get reviewFinish => 'Concluir revisão';

  @override
  String get reviewNextError => 'Próximo erro';

  @override
  String get rewardUnlocked => 'Recompensa desbloqueada';

  @override
  String get rewardDerivativesDescription =>
      'Você concluiu Derivadas e finalizou o módulo Cálculo I.';

  @override
  String get rewardContinuityDescription =>
      'Você concluiu a sequência de Continuidade em Cálculo I.';

  @override
  String get rewardLimitsDescription =>
      'Você concluiu a sequência universitária de Limites.';

  @override
  String get rewardFunctionsDescription =>
      'Você concluiu a sequência de Funções e finalizou o módulo Fundamentos Matemáticos.';

  @override
  String get rewardEquationsDescription =>
      'Você concluiu a sequência de Equações e Inequações.';

  @override
  String get rewardAlgebraDescription =>
      'Você concluiu a sequência de Álgebra Fundamental.';

  @override
  String get rewardModuleCompleted => 'Módulo concluído';

  @override
  String get rewardLessonCompleted => 'Aula concluída';

  @override
  String get rewardExperienceReceived => 'Experiência recebida';

  @override
  String get rewardGoldReceived => 'Ouro recebido';

  @override
  String get rewardProgress => 'Progresso';

  @override
  String get miniChallengeTitle => 'Mini Desafio';

  @override
  String get miniChallengeQuickTest => 'Teste rápido';

  @override
  String get miniChallengeSubtitle =>
      'Escolha a resposta correta para liberar os próximos exercícios.';

  @override
  String get miniChallengeQuestion => 'Qual é o resultado de 4x + 2x?';

  @override
  String get miniChallengeChooseAnswer =>
      'Escolha uma alternativa antes de responder.';

  @override
  String get miniChallengeIncorrect => 'Resposta incorreta. Tente novamente.';

  @override
  String get miniChallengeRespond => 'Responder';

  @override
  String get miniChallengeXpHint => 'Você ganha XP ao acertar o desafio.';

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
