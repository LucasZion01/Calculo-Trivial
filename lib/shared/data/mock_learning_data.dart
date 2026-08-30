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
    title: 'Fundamentos Matemáticos',
    subtitle: 'Pré-Cálculo, funções e base algébrica',
    symbol: 'f(x)',
    status: '0%',
    isUnlocked: true,
    lessons: [
      LessonData(
        id: 'algebra-fundamental',
        title: 'Aula 1 — Álgebra Fundamental',
        subtitle: '8 aulas • expressões, potências e fatoração',
        symbol: 'x',
        status: 'Comece aqui',
        isUnlocked: true,
      ),
      LessonData(
        id: 'equacoes-inequacoes',
        title: 'Aula 2 — Equações e Inequações',
        subtitle: 'Manipulação algébrica e resolução',
        symbol: '=',
        status: 'Bloqueado',
        isUnlocked: false,
      ),
      LessonData(
        id: 'funcoes',
        title: 'Aula 3 — Funções',
        subtitle: 'Domínio, imagem e gráficos',
        symbol: 'f',
        status: 'Bloqueado',
        isUnlocked: false,
      ),
    ],
  ),
  ModuleData(
    id: 'calculo-1',
    title: 'Cálculo I',
    subtitle: 'Limites, continuidade e derivadas',
    symbol: 'lim',
    status: 'Bloqueado',
    isUnlocked: false,
    lessons: [],
  ),
  ModuleData(
    id: 'calculo-2',
    title: 'Cálculo II',
    subtitle: 'Integrais, séries e equações diferenciais',
    symbol: '∫',
    status: 'Bloqueado',
    isUnlocked: false,
    lessons: [],
  ),
];
