import 'package:calcquest/shared/data/mock_exercise_data.dart';

const List<ExerciseData> mockFunctionsExercises = [
  ExerciseData(
    id: 'funcao-1',
    title: 'QuestÃ£o 1 de 5',
    statement: 'Dada a funÃ§Ã£o:\nf(x) = 2x + 1\n\nCalcule f(3).',
    correctOptionId: 'b',
    explanation:
        'SubstituÃ­mos x por 3: f(3) = 2 Â· 3 + 1 = 6 + 1 = 7.',
    options: [
      ExerciseOptionData(id: 'a', text: '6'),
      ExerciseOptionData(id: 'b', text: '7'),
      ExerciseOptionData(id: 'c', text: '8'),
      ExerciseOptionData(id: 'd', text: '9'),
    ],
  ),
  ExerciseData(
    id: 'funcao-2',
    title: 'QuestÃ£o 2 de 5',
    statement: 'Dada a funÃ§Ã£o:\nf(x) = xÂ²\n\nCalcule f(4).',
    correctOptionId: 'c',
    explanation:
        'SubstituÃ­mos x por 4: f(4) = 4Â² = 16.',
    options: [
      ExerciseOptionData(id: 'a', text: '4'),
      ExerciseOptionData(id: 'b', text: '8'),
      ExerciseOptionData(id: 'c', text: '16'),
      ExerciseOptionData(id: 'd', text: '20'),
    ],
  ),
  ExerciseData(
    id: 'funcao-3',
    title: 'QuestÃ£o 3 de 5',
    statement: 'Na funÃ§Ã£o:\nf(x) = 3x - 2\n\nQual Ã© o coeficiente de x?',
    correctOptionId: 'a',
    explanation:
        'O coeficiente de x Ã© o nÃºmero que multiplica x. Em f(x) = 3x - 2, esse nÃºmero Ã© 3.',
    options: [
      ExerciseOptionData(id: 'a', text: '3'),
      ExerciseOptionData(id: 'b', text: '-2'),
      ExerciseOptionData(id: 'c', text: '1'),
      ExerciseOptionData(id: 'd', text: '5'),
    ],
  ),
  ExerciseData(
    id: 'funcao-4',
    title: 'QuestÃ£o 4 de 5',
    statement: 'Dada a funÃ§Ã£o constante:\nf(x) = 5\n\nCalcule f(10).',
    correctOptionId: 'd',
    explanation:
        'A funÃ§Ã£o Ã© constante. Isso significa que a saÃ­da sempre serÃ¡ 5, independentemente do valor de x.',
    options: [
      ExerciseOptionData(id: 'a', text: '10'),
      ExerciseOptionData(id: 'b', text: '15'),
      ExerciseOptionData(id: 'c', text: '50'),
      ExerciseOptionData(id: 'd', text: '5'),
    ],
  ),
  ExerciseData(
    id: 'funcao-5',
    title: 'QuestÃ£o 5 de 5',
    statement: 'Se:\nf(x) = x + 4\n\ne f(x) = 9, qual Ã© o valor de x?',
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
