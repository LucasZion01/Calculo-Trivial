import 'package:calcquest/shared/data/mock_exercise_data.dart';

const List<ExerciseData> mockFunctionsExercises = [
  ExerciseData(
    id: 'funcao-1',
    title: 'Questão 1 de 5',
    statement: 'Dada a função:\nf(x) = 2x + 1\n\nCalcule f(3).',
    correctOptionId: 'b',
    explanation:
        'Substituímos x por 3: f(3) = 2 · 3 + 1 = 6 + 1 = 7.',
    options: [
      ExerciseOptionData(id: 'a', text: '6'),
      ExerciseOptionData(id: 'b', text: '7'),
      ExerciseOptionData(id: 'c', text: '8'),
      ExerciseOptionData(id: 'd', text: '9'),
    ],
  ),
  ExerciseData(
    id: 'funcao-2',
    title: 'Questão 2 de 5',
    statement: 'Dada a função:\nf(x) = x²\n\nCalcule f(4).',
    correctOptionId: 'c',
    explanation:
        'Substituímos x por 4: f(4) = 4² = 16.',
    options: [
      ExerciseOptionData(id: 'a', text: '4'),
      ExerciseOptionData(id: 'b', text: '8'),
      ExerciseOptionData(id: 'c', text: '16'),
      ExerciseOptionData(id: 'd', text: '20'),
    ],
  ),
  ExerciseData(
    id: 'funcao-3',
    title: 'Questão 3 de 5',
    statement: 'Na função:\nf(x) = 3x - 2\n\nQual é o coeficiente de x?',
    correctOptionId: 'a',
    explanation:
        'O coeficiente de x é o número que multiplica x. Em f(x) = 3x - 2, esse número é 3.',
    options: [
      ExerciseOptionData(id: 'a', text: '3'),
      ExerciseOptionData(id: 'b', text: '-2'),
      ExerciseOptionData(id: 'c', text: '1'),
      ExerciseOptionData(id: 'd', text: '5'),
    ],
  ),
  ExerciseData(
    id: 'funcao-4',
    title: 'Questão 4 de 5',
    statement: 'Dada a função constante:\nf(x) = 5\n\nCalcule f(10).',
    correctOptionId: 'd',
    explanation:
        'A função é constante. Isso significa que a saída sempre será 5, independentemente do valor de x.',
    options: [
      ExerciseOptionData(id: 'a', text: '10'),
      ExerciseOptionData(id: 'b', text: '15'),
      ExerciseOptionData(id: 'c', text: '50'),
      ExerciseOptionData(id: 'd', text: '5'),
    ],
  ),
  ExerciseData(
    id: 'funcao-5',
    title: 'Questão 5 de 5',
    statement: 'Se:\nf(x) = x + 4\n\ne f(x) = 9, qual é o valor de x?',
    correctOptionId: 'c',
    explanation:
        'Temos x + 4 = 9. Subtraindo 4 dos dois lados, obtemos x = 5.',
    options: [
      ExerciseOptionData(id: 'a', text: '3'),
      ExerciseOptionData(id: 'b', text: '4'),
      ExerciseOptionData(id: 'c', text: '5'),
      ExerciseOptionData(id: 'd', text: '9'),
    ],
  ),
];