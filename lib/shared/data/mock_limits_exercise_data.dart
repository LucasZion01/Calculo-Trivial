import 'package:calcquest/shared/data/mock_exercise_data.dart';

const List<ExerciseData> mockLimitsExercises = [
  ExerciseData(
    id: 'limite-substituicao-direta',
    title: 'Questão 1 de 5',
    statement: 'Calcule o limite:\n\nlim x → 3  (2x² - x + 1)',
    correctOptionId: 'd',
    explanation:
        'Como a função polinomial é contínua, podemos substituir x por 3 diretamente: 2(3²) - 3 + 1 = 18 - 3 + 1 = 16.',
    options: [
      ExerciseOptionData(id: 'a', text: '10'),
      ExerciseOptionData(id: 'b', text: '12'),
      ExerciseOptionData(id: 'c', text: '15'),
      ExerciseOptionData(id: 'd', text: '16'),
    ],
  ),
  ExerciseData(
    id: 'limite-fatoracao',
    title: 'Questão 2 de 5',
    statement:
        'Calcule o limite:\n\nlim x → 2  (x² - 4) / (x - 2)',
    correctOptionId: 'c',
    explanation:
        'Substituindo diretamente, aparece 0/0. Fatoramos x² - 4 = (x - 2)(x + 2). Cancelando x - 2, sobra x + 2. Então, no limite, temos 2 + 2 = 4.',
    options: [
      ExerciseOptionData(id: 'a', text: '0'),
      ExerciseOptionData(id: 'b', text: '2'),
      ExerciseOptionData(id: 'c', text: '4'),
      ExerciseOptionData(id: 'd', text: 'Não existe'),
    ],
  ),
  ExerciseData(
    id: 'limite-racionalizacao',
    title: 'Questão 3 de 5',
    statement:
        'Calcule o limite:\n\nlim x → 0  (√(x + 9) - 3) / x',
    correctOptionId: 'b',
    explanation:
        'Substituindo diretamente, aparece 0/0. Multiplicamos pelo conjugado: (√(x+9)+3). O numerador vira x, que cancela com o x do denominador. Sobra 1 / (√(x+9)+3). Substituindo x = 0, temos 1/(3+3) = 1/6.',
    options: [
      ExerciseOptionData(id: 'a', text: '1/3'),
      ExerciseOptionData(id: 'b', text: '1/6'),
      ExerciseOptionData(id: 'c', text: '6'),
      ExerciseOptionData(id: 'd', text: '0'),
    ],
  ),
  ExerciseData(
    id: 'limite-trigonometrico-fundamental',
    title: 'Questão 4 de 5',
    statement:
        'Calcule o limite:\n\nlim x → 0  sen(x) / x',
    correctOptionId: 'a',
    explanation:
        'Este é um limite trigonométrico fundamental. Quando x tende a 0, sen(x)/x tende a 1, considerando x em radianos.',
    options: [
      ExerciseOptionData(id: 'a', text: '1'),
      ExerciseOptionData(id: 'b', text: '0'),
      ExerciseOptionData(id: 'c', text: '∞'),
      ExerciseOptionData(id: 'd', text: 'Não existe'),
    ],
  ),
  ExerciseData(
    id: 'limite-no-infinito',
    title: 'Questão 5 de 5',
    statement:
        'Calcule o limite:\n\nlim x → ∞  (3x² - 2x + 1) / (x² + 5)',
    correctOptionId: 'c',
    explanation:
        'Em funções racionais com mesmo grau no numerador e no denominador, o limite no infinito é a razão dos coeficientes líderes. Aqui, temos 3x²/x², então o limite é 3.',
    options: [
      ExerciseOptionData(id: 'a', text: '0'),
      ExerciseOptionData(id: 'b', text: '1'),
      ExerciseOptionData(id: 'c', text: '3'),
      ExerciseOptionData(id: 'd', text: '∞'),
    ],
  ),
];