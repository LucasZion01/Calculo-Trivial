import 'package:calcquest/shared/data/mock_exercise_data.dart';

const List<ExerciseData> mockLimitsExercises = [
  ExerciseData(
    id: 'limite-substituicao-direta',
    title: 'Questão 1 de 10',
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
    title: 'Questão 2 de 10',
    statement: 'Calcule o limite:\n\nlim x → 2  (x² - 4) / (x - 2)',
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
    title: 'Questão 3 de 10',
    statement: 'Calcule o limite:\n\nlim x → 0  (√(x + 9) - 3) / x',
    correctOptionId: 'b',
    explanation:
        'Substituindo diretamente, aparece 0/0. Multiplicamos pelo conjugado: (√(x + 9) + 3). O numerador vira x, que cancela com o x do denominador. Sobra 1 / (√(x + 9) + 3). Substituindo x = 0, temos 1/(3 + 3) = 1/6.',
    options: [
      ExerciseOptionData(id: 'a', text: '1/3'),
      ExerciseOptionData(id: 'b', text: '1/6'),
      ExerciseOptionData(id: 'c', text: '6'),
      ExerciseOptionData(id: 'd', text: '0'),
    ],
  ),
  ExerciseData(
    id: 'limite-trigonometrico-fundamental',
    title: 'Questão 4 de 10',
    statement: 'Calcule o limite:\n\nlim x → 0  sen(x) / x',
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
    title: 'Questão 5 de 10',
    statement: 'Calcule o limite:\n\nlim x → ∞  (3x² - 2x + 1) / (x² + 5)',
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
  ExerciseData(
    id: 'limite-racional-direto',
    title: 'Questão 6 de 10',
    statement: 'Calcule o limite:\n\nlim x → 1  (x² + 2) / (x + 1)',
    correctOptionId: 'b',
    explanation:
        'O denominador não é zero em x = 1, então podemos substituir diretamente: (1² + 2)/(1 + 1) = 3/2.',
    options: [
      ExerciseOptionData(id: 'a', text: '1'),
      ExerciseOptionData(id: 'b', text: '3/2'),
      ExerciseOptionData(id: 'c', text: '2'),
      ExerciseOptionData(id: 'd', text: '3'),
    ],
  ),
  ExerciseData(
    id: 'limite-fatoracao-segundo',
    title: 'Questão 7 de 10',
    statement: 'Calcule o limite:\n\nlim x → 1  (x² - 1) / (x - 1)',
    correctOptionId: 'c',
    explanation:
        'Fatoramos x² - 1 = (x - 1)(x + 1). Cancelando x - 1, resta x + 1. Quando x tende a 1, o limite é 2.',
    options: [
      ExerciseOptionData(id: 'a', text: '0'),
      ExerciseOptionData(id: 'b', text: '1'),
      ExerciseOptionData(id: 'c', text: '2'),
      ExerciseOptionData(id: 'd', text: 'Não existe'),
    ],
  ),
  ExerciseData(
    id: 'limite-infinito-grau-menor',
    title: 'Questão 8 de 10',
    statement: 'Calcule o limite:\n\nlim x → ∞  (2x + 1) / (x² + 3)',
    correctOptionId: 'a',
    explanation:
        'O grau do numerador é menor que o grau do denominador. Assim, o denominador cresce mais rapidamente e o limite é 0.',
    options: [
      ExerciseOptionData(id: 'a', text: '0'),
      ExerciseOptionData(id: 'b', text: '1'),
      ExerciseOptionData(id: 'c', text: '2'),
      ExerciseOptionData(id: 'd', text: '∞'),
    ],
  ),
  ExerciseData(
    id: 'limite-lateral-modulo',
    title: 'Questão 9 de 10',
    statement: 'Calcule o limite lateral:\n\nlim x → 0⁺  |x| / x',
    correctOptionId: 'd',
    explanation:
        'Quando x se aproxima de zero pela direita, x é positivo e |x| = x. Portanto, |x|/x = 1.',
    options: [
      ExerciseOptionData(id: 'a', text: '-1'),
      ExerciseOptionData(id: 'b', text: '0'),
      ExerciseOptionData(id: 'c', text: 'Não existe'),
      ExerciseOptionData(id: 'd', text: '1'),
    ],
  ),
  ExerciseData(
    id: 'limite-bilateral-modulo',
    title: 'Questão 10 de 10',
    statement: 'Calcule o limite:\n\nlim x → 0  |x| / x',
    correctOptionId: 'c',
    explanation:
        'Pela direita, |x|/x tende a 1; pela esquerda, tende a -1. Como os limites laterais são diferentes, o limite bilateral não existe.',
    options: [
      ExerciseOptionData(id: 'a', text: '-1'),
      ExerciseOptionData(id: 'b', text: '0'),
      ExerciseOptionData(id: 'c', text: 'Não existe'),
      ExerciseOptionData(id: 'd', text: '1'),
    ],
  ),
  ExerciseData(
    id: 'limite-polinomial-negativo',
    title: 'Questão 11 de 20',
    statement: 'Calcule o limite:\n\nlim x → -1  (x³ + 2x)',
    correctOptionId: 'b',
    explanation:
        'A função é polinomial e contínua. Substituindo x = -1: (-1)³ + 2(-1) = -1 - 2 = -3.',
    options: [
      ExerciseOptionData(id: 'a', text: '3'),
      ExerciseOptionData(id: 'b', text: '-3'),
      ExerciseOptionData(id: 'c', text: '-1'),
      ExerciseOptionData(id: 'd', text: '1'),
    ],
  ),
  ExerciseData(
    id: 'limite-fatoracao-terceiro',
    title: 'Questão 12 de 20',
    statement: 'Calcule o limite:\n\nlim x → 3  (x² - 9) / (x - 3)',
    correctOptionId: 'd',
    explanation:
        'Fatoramos x² - 9 = (x - 3)(x + 3). Cancelando x - 3, resta x + 3, cujo limite é 6.',
    options: [
      ExerciseOptionData(id: 'a', text: '0'),
      ExerciseOptionData(id: 'b', text: '3'),
      ExerciseOptionData(id: 'c', text: '9'),
      ExerciseOptionData(id: 'd', text: '6'),
    ],
  ),
  ExerciseData(
    id: 'limite-racionalizacao-2',
    title: 'Questão 13 de 20',
    statement: 'Calcule o limite:\n\nlim x → 4  (√x - 2) / (x - 4)',
    correctOptionId: 'c',
    explanation:
        'Racionalizando, obtemos 1/(√x + 2). Substituindo x = 4, resulta 1/(2 + 2) = 1/4.',
    options: [
      ExerciseOptionData(id: 'a', text: '1/2'),
      ExerciseOptionData(id: 'b', text: '2'),
      ExerciseOptionData(id: 'c', text: '1/4'),
      ExerciseOptionData(id: 'd', text: '4'),
    ],
  ),
  ExerciseData(
    id: 'limite-trigonometrico-2',
    title: 'Questão 14 de 20',
    statement: 'Calcule o limite:\n\nlim x → 0  sen(2x) / x',
    correctOptionId: 'a',
    explanation:
        'Escrevemos sen(2x)/x = 2 · sen(2x)/(2x). O limite fundamental vale 1, então o resultado é 2.',
    options: [
      ExerciseOptionData(id: 'a', text: '2'),
      ExerciseOptionData(id: 'b', text: '1'),
      ExerciseOptionData(id: 'c', text: '0'),
      ExerciseOptionData(id: 'd', text: 'Não existe'),
    ],
  ),
  ExerciseData(
    id: 'limite-cosseno',
    title: 'Questão 15 de 20',
    statement: 'Calcule o limite:\n\nlim x → 0  (1 - cos x) / x',
    correctOptionId: 'b',
    explanation:
        'Racionalizando, (1 - cos x)/x = sen²(x) / [x(1 + cos x)]. '
        'Reescrevendo como [sen(x)/x] · [sen(x)/(1 + cos x)], os fatores '
        'tendem a 1 e 0, respectivamente. Portanto, o limite é 0.',
    options: [
      ExerciseOptionData(id: 'a', text: '1'),
      ExerciseOptionData(id: 'b', text: '0'),
      ExerciseOptionData(id: 'c', text: '1/2'),
      ExerciseOptionData(id: 'd', text: '∞'),
    ],
  ),
  ExerciseData(
    id: 'limite-infinito-cubico',
    title: 'Questão 16 de 20',
    statement: 'Calcule o limite:\n\nlim x → ∞  (5x³ + x) / (2x³ - 1)',
    correctOptionId: 'c',
    explanation:
        'Numerador e denominador têm grau 3. O limite é a razão entre os coeficientes líderes: 5/2.',
    options: [
      ExerciseOptionData(id: 'a', text: '0'),
      ExerciseOptionData(id: 'b', text: '2/5'),
      ExerciseOptionData(id: 'c', text: '5/2'),
      ExerciseOptionData(id: 'd', text: '∞'),
    ],
  ),
  ExerciseData(
    id: 'limite-infinito-grau-maior',
    title: 'Questão 17 de 20',
    statement: 'Calcule o limite:\n\nlim x → ∞  x² / (x + 1)',
    correctOptionId: 'd',
    explanation:
        'O numerador cresce como x² e o denominador como x. O quociente cresce sem limite positivo, portanto tende a +∞.',
    options: [
      ExerciseOptionData(id: 'a', text: '0'),
      ExerciseOptionData(id: 'b', text: '1'),
      ExerciseOptionData(id: 'c', text: '-∞'),
      ExerciseOptionData(id: 'd', text: '+∞'),
    ],
  ),
  ExerciseData(
    id: 'limite-lateral-reciproco-direita',
    title: 'Questão 18 de 20',
    statement: 'Calcule o limite lateral:\n\nlim x → 0⁺  1/x',
    correctOptionId: 'a',
    explanation:
        'Pela direita, x assume valores positivos cada vez menores. Assim, 1/x cresce sem limite e tende a +∞.',
    options: [
      ExerciseOptionData(id: 'a', text: '+∞'),
      ExerciseOptionData(id: 'b', text: '-∞'),
      ExerciseOptionData(id: 'c', text: '0'),
      ExerciseOptionData(id: 'd', text: '1'),
    ],
  ),
  ExerciseData(
    id: 'limite-lateral-reciproco-esquerda',
    title: 'Questão 19 de 20',
    statement: 'Calcule o limite lateral:\n\nlim x → 0⁻  1/x',
    correctOptionId: 'b',
    explanation:
        'Pela esquerda, x assume valores negativos cada vez mais próximos de zero. Assim, 1/x tende a -∞.',
    options: [
      ExerciseOptionData(id: 'a', text: '+∞'),
      ExerciseOptionData(id: 'b', text: '-∞'),
      ExerciseOptionData(id: 'c', text: '0'),
      ExerciseOptionData(id: 'd', text: '-1'),
    ],
  ),
  ExerciseData(
    id: 'limite-bilateral-reciproco',
    title: 'Questão 20 de 20',
    statement: 'Calcule o limite:\n\nlim x → 0  1/x',
    correctOptionId: 'c',
    explanation:
        'Pela direita, 1/x tende a +∞; pela esquerda, tende a -∞. Como os limites laterais são diferentes, o limite bilateral não existe.',
    options: [
      ExerciseOptionData(id: 'a', text: '+∞'),
      ExerciseOptionData(id: 'b', text: '-∞'),
      ExerciseOptionData(id: 'c', text: 'Não existe'),
      ExerciseOptionData(id: 'd', text: '0'),
    ],
  ),
];
