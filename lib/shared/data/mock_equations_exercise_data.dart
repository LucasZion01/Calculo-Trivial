import 'package:calcquest/shared/data/mock_exercise_data.dart';

const List<ExerciseData> mockEquationsExercises = [
  ExerciseData(
    id: 'equacao-1',
    title: 'QuestÃ£o 1 de 5',
    statement: 'Resolva a equaÃ§Ã£o:\nx + 3 = 8',
    correctOptionId: 'b',
    explanation:
        'Para isolar x, subtraÃ­mos 3 dos dois lados: x = 8 - 3. Portanto, x = 5.',
    options: [
      ExerciseOptionData(id: 'a', text: '3'),
      ExerciseOptionData(id: 'b', text: '5'),
      ExerciseOptionData(id: 'c', text: '8'),
      ExerciseOptionData(id: 'd', text: '11'),
    ],
  ),
  ExerciseData(
    id: 'equacao-2',
    title: 'QuestÃ£o 2 de 5',
    statement: 'Resolva a equaÃ§Ã£o:\n2x = 10',
    correctOptionId: 'c',
    explanation:
        'Para isolar x, dividimos os dois lados por 2: x = 10 Ã· 2. Portanto, x = 5.',
    options: [
      ExerciseOptionData(id: 'a', text: '2'),
      ExerciseOptionData(id: 'b', text: '4'),
      ExerciseOptionData(id: 'c', text: '5'),
      ExerciseOptionData(id: 'd', text: '10'),
    ],
  ),
  ExerciseData(
    id: 'equacao-3',
    title: 'QuestÃ£o 3 de 5',
    statement: 'Resolva a equaÃ§Ã£o:\nx - 4 = 9',
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
    title: 'QuestÃ£o 4 de 5',
    statement: 'Resolva a equaÃ§Ã£o:\n3x + 2 = 11',
    correctOptionId: 'a',
    explanation:
        'Primeiro subtraÃ­mos 2 dos dois lados: 3x = 9. Depois dividimos por 3: x = 3.',
    options: [
      ExerciseOptionData(id: 'a', text: '3'),
      ExerciseOptionData(id: 'b', text: '4'),
      ExerciseOptionData(id: 'c', text: '9'),
      ExerciseOptionData(id: 'd', text: '11'),
    ],
  ),
  ExerciseData(
    id: 'inequacao-1',
    title: 'QuestÃ£o 5 de 5',
    statement: 'Resolva a inequaÃ§Ã£o:\nx + 2 > 7',
    correctOptionId: 'c',
    explanation:
        'Para isolar x, subtraÃ­mos 2 dos dois lados: x > 7 - 2. Portanto, x > 5.',
    options: [
      ExerciseOptionData(id: 'a', text: 'x > 2'),
      ExerciseOptionData(id: 'b', text: 'x > 3'),
      ExerciseOptionData(id: 'c', text: 'x > 5'),
      ExerciseOptionData(id: 'd', text: 'x > 9'),
    ],
  ),
];
