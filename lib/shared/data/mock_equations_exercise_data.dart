import 'package:calcquest/shared/data/mock_exercise_data.dart';

const List<ExerciseData> mockEquationsExercises = [
  ExerciseData(
    id: 'equacao-1',
    title: 'Questão 1 de 10',
    statement: 'Resolva a equação:\nx + 3 = 8',
    correctOptionId: 'b',
    explanation:
        'Para isolar x, subtraímos 3 dos dois lados: x = 8 - 3. Portanto, x = 5.',
    options: [
      ExerciseOptionData(id: 'a', text: '3'),
      ExerciseOptionData(id: 'b', text: '5'),
      ExerciseOptionData(id: 'c', text: '8'),
      ExerciseOptionData(id: 'd', text: '11'),
    ],
  ),
  ExerciseData(
    id: 'equacao-2',
    title: 'Questão 2 de 10',
    statement: 'Resolva a equação:\n2x = 10',
    correctOptionId: 'c',
    explanation:
        'Para isolar x, dividimos os dois lados por 2: x = 10 ÷ 2. Portanto, x = 5.',
    options: [
      ExerciseOptionData(id: 'a', text: '2'),
      ExerciseOptionData(id: 'b', text: '4'),
      ExerciseOptionData(id: 'c', text: '5'),
      ExerciseOptionData(id: 'd', text: '10'),
    ],
  ),
  ExerciseData(
    id: 'equacao-3',
    title: 'Questão 3 de 10',
    statement: 'Resolva a equação:\nx - 4 = 9',
    correctOptionId: 'd',
    explanation:
        'Para isolar x, somamos 4 dos dois lados: x = 9 + 4. Portanto, x = 13.',
    options: [
      ExerciseOptionData(id: 'a', text: '5'),
      ExerciseOptionData(id: 'b', text: '9'),
      ExerciseOptionData(id: 'c', text: '12'),
      ExerciseOptionData(id: 'd', text: '13'),
    ],
  ),
  ExerciseData(
    id: 'equacao-4',
    title: 'Questão 4 de 10',
    statement: 'Resolva a equação:\n3x + 2 = 11',
    correctOptionId: 'a',
    explanation:
        'Primeiro subtraímos 2 dos dois lados: 3x = 9. Depois dividimos por 3: x = 3.',
    options: [
      ExerciseOptionData(id: 'a', text: '3'),
      ExerciseOptionData(id: 'b', text: '4'),
      ExerciseOptionData(id: 'c', text: '9'),
      ExerciseOptionData(id: 'd', text: '11'),
    ],
  ),
  ExerciseData(
    id: 'inequacao-1',
    title: 'Questão 5 de 10',
    statement: 'Resolva a inequação:\nx + 2 > 7',
    correctOptionId: 'c',
    explanation:
        'Para isolar x, subtraímos 2 dos dois lados: x > 7 - 2. Portanto, x > 5.',
    options: [
      ExerciseOptionData(id: 'a', text: 'x > 2'),
      ExerciseOptionData(id: 'b', text: 'x > 3'),
      ExerciseOptionData(id: 'c', text: 'x > 5'),
      ExerciseOptionData(id: 'd', text: 'x > 9'),
    ],
  ),
  ExerciseData(
    id: 'equacao-5',
    title: 'Questão 6 de 10',
    statement: 'Resolva a equação:\n5x - 7 = 18',
    correctOptionId: 'b',
    explanation:
        'Somamos 7 aos dois lados: 5x = 25. Depois dividimos por 5, obtendo x = 5.',
    options: [
      ExerciseOptionData(id: 'a', text: '4'),
      ExerciseOptionData(id: 'b', text: '5'),
      ExerciseOptionData(id: 'c', text: '6'),
      ExerciseOptionData(id: 'd', text: '25'),
    ],
  ),
  ExerciseData(
    id: 'equacao-distributiva',
    title: 'Questão 7 de 10',
    statement: 'Resolva a equação:\n4(x - 2) = 12',
    correctOptionId: 'c',
    explanation:
        'Dividimos os dois lados por 4: x - 2 = 3. Somando 2 aos dois lados, encontramos x = 5.',
    options: [
      ExerciseOptionData(id: 'a', text: '1'),
      ExerciseOptionData(id: 'b', text: '3'),
      ExerciseOptionData(id: 'c', text: '5'),
      ExerciseOptionData(id: 'd', text: '8'),
    ],
  ),
  ExerciseData(
    id: 'equacao-fracao',
    title: 'Questão 8 de 10',
    statement: 'Resolva a equação:\nx/3 + 2 = 6',
    correctOptionId: 'd',
    explanation:
        'Subtraímos 2 dos dois lados: x/3 = 4. Multiplicando os dois lados por 3, obtemos x = 12.',
    options: [
      ExerciseOptionData(id: 'a', text: '4'),
      ExerciseOptionData(id: 'b', text: '6'),
      ExerciseOptionData(id: 'c', text: '8'),
      ExerciseOptionData(id: 'd', text: '12'),
    ],
  ),
  ExerciseData(
    id: 'inequacao-2',
    title: 'Questão 9 de 10',
    statement: 'Resolva a inequação:\n2x - 3 ≤ 7',
    correctOptionId: 'a',
    explanation:
        'Somamos 3 aos dois lados: 2x ≤ 10. Dividindo por 2, que é positivo, o sinal permanece: x ≤ 5.',
    options: [
      ExerciseOptionData(id: 'a', text: 'x ≤ 5'),
      ExerciseOptionData(id: 'b', text: 'x ≥ 5'),
      ExerciseOptionData(id: 'c', text: 'x ≤ 2'),
      ExerciseOptionData(id: 'd', text: 'x ≥ 2'),
    ],
  ),
  ExerciseData(
    id: 'inequacao-negativa',
    title: 'Questão 10 de 10',
    statement: 'Resolva a inequação:\n-3x > 12',
    correctOptionId: 'c',
    explanation:
        'Ao dividir uma inequação por um número negativo, invertemos o sinal. Dividindo por -3, obtemos x < -4.',
    options: [
      ExerciseOptionData(id: 'a', text: 'x > -4'),
      ExerciseOptionData(id: 'b', text: 'x > 4'),
      ExerciseOptionData(id: 'c', text: 'x < -4'),
      ExerciseOptionData(id: 'd', text: 'x < 4'),
    ],
  ),
];
