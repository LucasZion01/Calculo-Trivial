import 'package:calcquest/shared/data/mock_exercise_data.dart';

const List<ExerciseData> mockLimitsExercises = [
  ExerciseData(
    id: 'limite-substituicao-direta',
    title: 'QuestÃ£o 1 de 5',
    statement: 'Calcule o limite:\n\nlim x â†’ 3  (2xÂ² - x + 1)',
    correctOptionId: 'd',
    explanation:
        'Como a funÃ§Ã£o polinomial Ã© contÃ­nua, podemos substituir x por 3 diretamente: 2(3Â²) - 3 + 1 = 18 - 3 + 1 = 16.',
    options: [
      ExerciseOptionData(id: 'a', text: '10'),
      ExerciseOptionData(id: 'b', text: '12'),
      ExerciseOptionData(id: 'c', text: '15'),
      ExerciseOptionData(id: 'd', text: '16'),
    ],
  ),
  ExerciseData(
    id: 'limite-fatoracao',
    title: 'QuestÃ£o 2 de 5',
    statement:
        'Calcule o limite:\n\nlim x â†’ 2  (xÂ² - 4) / (x - 2)',
    correctOptionId: 'c',
    explanation:
        'Substituindo diretamente, aparece 0/0. Fatoramos xÂ² - 4 = (x - 2)(x + 2). Cancelando x - 2, sobra x + 2. EntÃ£o, no limite, temos 2 + 2 = 4.',
    options: [
      ExerciseOptionData(id: 'a', text: '0'),
      ExerciseOptionData(id: 'b', text: '2'),
      ExerciseOptionData(id: 'c', text: '4'),
      ExerciseOptionData(id: 'd', text: 'NÃ£o existe'),
    ],
  ),
  ExerciseData(
    id: 'limite-racionalizacao',
    title: 'QuestÃ£o 3 de 5',
    statement:
        'Calcule o limite:\n\nlim x â†’ 0  (âˆš(x + 9) - 3) / x',
    correctOptionId: 'b',
    explanation:
        'Substituindo diretamente, aparece 0/0. Multiplicamos pelo conjugado: (âˆš(x+9)+3). O numerador vira x, que cancela com o x do denominador. Sobra 1 / (âˆš(x+9)+3). Substituindo x = 0, temos 1/(3+3) = 1/6.',
    options: [
      ExerciseOptionData(id: 'a', text: '1/3'),
      ExerciseOptionData(id: 'b', text: '1/6'),
      ExerciseOptionData(id: 'c', text: '6'),
      ExerciseOptionData(id: 'd', text: '0'),
    ],
  ),
  ExerciseData(
    id: 'limite-trigonometrico-fundamental',
    title: 'QuestÃ£o 4 de 5',
    statement:
        'Calcule o limite:\n\nlim x â†’ 0  sen(x) / x',
    correctOptionId: 'a',
    explanation:
        'Este Ã© um limite trigonomÃ©trico fundamental. Quando x tende a 0, sen(x)/x tende a 1, considerando x em radianos.',
    options: [
      ExerciseOptionData(id: 'a', text: '1'),
      ExerciseOptionData(id: 'b', text: '0'),
      ExerciseOptionData(id: 'c', text: 'âˆž'),
      ExerciseOptionData(id: 'd', text: 'NÃ£o existe'),
    ],
  ),
  ExerciseData(
    id: 'limite-no-infinito',
    title: 'QuestÃ£o 5 de 5',
    statement:
        'Calcule o limite:\n\nlim x â†’ âˆž  (3xÂ² - 2x + 1) / (xÂ² + 5)',
    correctOptionId: 'c',
    explanation:
        'Em funÃ§Ãµes racionais com mesmo grau no numerador e no denominador, o limite no infinito Ã© a razÃ£o dos coeficientes lÃ­deres. Aqui, temos 3xÂ²/xÂ², entÃ£o o limite Ã© 3.',
    options: [
      ExerciseOptionData(id: 'a', text: '0'),
      ExerciseOptionData(id: 'b', text: '1'),
      ExerciseOptionData(id: 'c', text: '3'),
      ExerciseOptionData(id: 'd', text: 'âˆž'),
    ],
  ),
];
