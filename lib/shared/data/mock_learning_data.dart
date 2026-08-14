class LessonData {
  final String id;
  final String title;
  final String subtitle;
  final String symbol;
  final String status;
  final bool isUnlocked;

  const LessonData({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.symbol,
    required this.status,
    required this.isUnlocked,
  });
}

class ModuleData {
  final String id;
  final String title;
  final String subtitle;
  final String symbol;
  final String status;
  final bool isUnlocked;
  final List<LessonData> lessons;

  const ModuleData({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.symbol,
    required this.status,
    required this.isUnlocked,
    required this.lessons,
  });
}

const List<ModuleData> mockModules = [
  ModuleData(
    id: 'fundamentos',
    title: 'Fundamentos MatemÃ¡ticos',
    subtitle: 'PrÃ©-CÃ¡lculo, funÃ§Ãµes e base algÃ©brica',
    symbol: 'f(x)',
    status: '0%',
    isUnlocked: true,
    lessons: [
      LessonData(
        id: 'algebra-fundamental',
        title: 'Aula 1 â€” Ãlgebra Fundamental',
        subtitle: 'OperaÃ§Ãµes, expressÃµes e simplificaÃ§Ã£o',
        symbol: 'x',
        status: 'Comece aqui',
        isUnlocked: true,
      ),
      LessonData(
        id: 'equacoes-inequacoes',
        title: 'Aula 2 â€” EquaÃ§Ãµes e InequaÃ§Ãµes',
        subtitle: 'ManipulaÃ§Ã£o algÃ©brica e resoluÃ§Ã£o',
        symbol: '=',
        status: 'Bloqueado',
        isUnlocked: false,
      ),
      LessonData(
        id: 'funcoes',
        title: 'Aula 3 â€” FunÃ§Ãµes',
        subtitle: 'DomÃ­nio, imagem e grÃ¡ficos',
        symbol: 'f',
        status: 'Bloqueado',
        isUnlocked: false,
      ),
    ],
  ),
  ModuleData(
    id: 'calculo-1',
    title: 'CÃ¡lculo I',
    subtitle: 'Limites, continuidade e derivadas',
    symbol: 'lim',
    status: 'Bloqueado',
    isUnlocked: false,
    lessons: [],
  ),
  ModuleData(
    id: 'calculo-2',
    title: 'CÃ¡lculo II',
    subtitle: 'Integrais, sÃ©ries e equaÃ§Ãµes diferenciais',
    symbol: 'âˆ«',
    status: 'Bloqueado',
    isUnlocked: false,
    lessons: [],
  ),
];
