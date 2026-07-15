class ExerciseOptionData {
  final String id;
  final String text;

  const ExerciseOptionData({
    required this.id,
    required this.text,
  });
}

class ExerciseData {
  final String id;
  final String title;
  final String statement;
  final List<ExerciseOptionData> options;
  final String correctOptionId;
  final String explanation;

  const ExerciseData({
    required this.id,
    required this.title,
    required this.statement,
    required this.options,
    required this.correctOptionId,
    required this.explanation,
  });
}

const List<ExerciseData> mockExercises = [
  ExerciseData(
    id: 'simplificacao-1',
    title: 'Questão 1 de 5',
    statement: 'Simplifique a expressão:\n3x + 5x - 2x',
    correctOptionId: 'a',
    explanation: 'Somamos os coeficientes semelhantes: 3 + 5 - 2 = 6. Portanto, o resultado é 6x.',
    options: [
      ExerciseOptionData(
        id: 'a',
        text: '6x',
      ),
      ExerciseOptionData(
        id: 'b',
        text: '8x',
      ),
      ExerciseOptionData(
        id: 'c',
        text: '10x',
      ),
      ExerciseOptionData(
        id: 'd',
        text: 'x',
      ),
    ],
  ),
  ExerciseData(
    id: 'simplificacao-2',
    title: 'Questão 2 de 5',
    statement: 'Simplifique a expressão:\n7a - 2a + 4a',
    correctOptionId: 'c',
    explanation: 'Somamos os coeficientes: 7 - 2 + 4 = 9. Portanto, o resultado é 9a.',
    options: [
      ExerciseOptionData(
        id: 'a',
        text: '5a',
      ),
      ExerciseOptionData(
        id: 'b',
        text: '7a',
      ),
      ExerciseOptionData(
        id: 'c',
        text: '9a',
      ),
      ExerciseOptionData(
        id: 'd',
        text: '13a',
      ),
    ],
  ),
  ExerciseData(
    id: 'simplificacao-3',
    title: 'Questão 3 de 5',
    statement: 'Simplifique a expressão:\n10y - 3y - y',
    correctOptionId: 'b',
    explanation: 'Somamos os coeficientes: 10 - 3 - 1 = 6. Portanto, o resultado é 6y.',
    options: [
      ExerciseOptionData(
        id: 'a',
        text: '4y',
      ),
      ExerciseOptionData(
        id: 'b',
        text: '6y',
      ),
      ExerciseOptionData(
        id: 'c',
        text: '7y',
      ),
      ExerciseOptionData(
        id: 'd',
        text: '10y',
      ),
    ],
  ),
];