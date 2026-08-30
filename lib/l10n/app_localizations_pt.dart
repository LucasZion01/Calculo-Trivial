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
