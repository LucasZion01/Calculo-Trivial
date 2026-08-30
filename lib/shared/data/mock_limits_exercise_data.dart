import 'package:calcquest/shared/data/mock_exercise_data.dart';

const List<ExerciseData> mockLimitsExercises = [
  ExerciseData(
    id: 'limite-substituicao-direta',
    title: 'Questão 1 de 10',
    contentLessonId: 'limites-03-propriedades',
    skill: 'Substituição direta em polinômios',
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
    contentLessonId: 'limites-04-fatoracao',
    skill: 'Diferença de quadrados',
    difficulty: ExerciseDifficulty.intermediate,
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
    contentLessonId: 'limites-05-racionalizacao',
    skill: 'Racionalização com conjugado',
    difficulty: ExerciseDifficulty.intermediate,
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
    contentLessonId: 'limites-07-trigonometricos',
    skill: 'Limite trigonométrico fundamental',
    statement: 'Calcule o limite:\n\nlim x → 0  sen(x) / x',
    correctOptionId: 'a',
    explanation:
        'A substituição gera 0/0, mas isso é uma indeterminação, não a resposta. Em radianos, sen(x) e x ficam equivalentes perto de zero. Portanto, a razão sen(x)/x tende a 1. Esse resultado é o padrão fundamental usado para transformar limites trigonométricos mais complexos.',
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
    contentLessonId: 'limites-06-infinito',
    skill: 'Termos dominantes com graus iguais',
    difficulty: ExerciseDifficulty.intermediate,
    statement: 'Calcule o limite:\n\nlim x → ∞  (3x² - 2x + 1) / (x² + 5)',
    correctOptionId: 'c',
    explanation:
        'Divida numerador e denominador por x², a maior potência presente: (3 - 2/x + 1/x²)/(1 + 5/x²). Quando x cresce, os termos com 1/x e 1/x² tendem a zero. Restam os coeficientes líderes 3/1, logo o limite é 3.',
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
    contentLessonId: 'limites-01-intuicao',
    skill: 'Leitura de tendência em tabela',
    statement:
        'A tabela mostra valores de f(x) perto de x = 2:\n\nx: 1,9 | 1,99 | 2,01 | 2,1\nf(x): 4,8 | 4,98 | 5,02 | 5,2\n\nQual é a melhor previsão para lim x → 2 f(x)?',
    correctOptionId: 'b',
    explanation:
        'Pelos dois lados de 2, as saídas se aproximam de 5: 4,98 pela esquerda e 5,02 pela direita. O limite descreve essa tendência, portanto vale 5. Não precisamos conhecer o valor exato de f(2) para fazer essa previsão.',
    options: [
      ExerciseOptionData(id: 'a', text: '2'),
      ExerciseOptionData(id: 'b', text: '5'),
      ExerciseOptionData(id: 'c', text: '4,98'),
      ExerciseOptionData(id: 'd', text: 'Não é possível prever'),
    ],
  ),
  ExerciseData(
    id: 'limite-fatoracao-segundo',
    title: 'Questão 7 de 10',
    contentLessonId: 'limites-04-fatoracao',
    skill: 'Cancelamento de fator responsável por 0/0',
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
    contentLessonId: 'limites-06-infinito',
    skill: 'Comparação de graus',
    statement: 'Calcule o limite:\n\nlim x → ∞  (2x + 1) / (x² + 3)',
    correctOptionId: 'a',
    explanation:
        'Dividindo tudo por x², obtemos (2/x + 1/x²)/(1 + 3/x²). Todos os termos com x no denominador tendem a zero, enquanto o denominador tende a 1. Assim, o quociente tende a 0. Isso confirma que o denominador cresce mais rapidamente.',
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
    contentLessonId: 'limites-02-laterais',
    skill: 'Limite lateral pela direita',
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
    contentLessonId: 'limites-02-laterais',
    skill: 'Comparação de limites laterais',
    difficulty: ExerciseDifficulty.intermediate,
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
    contentLessonId: 'limites-03-propriedades',
    skill: 'Substituição com número negativo',
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
    contentLessonId: 'limites-04-fatoracao',
    skill: 'Diferença de quadrados',
    difficulty: ExerciseDifficulty.intermediate,
    statement: 'Calcule o limite:\n\nlim x → 3  (x² - 9) / (x - 3)',
    correctOptionId: 'd',
    explanation:
        'A substituição inicial produz 0/0, indicando que precisamos transformar a expressão. Como x² - 9 é uma diferença de quadrados, escrevemos (x - 3)(x + 3). Para x próximo de 3 e diferente de 3, cancelamos x - 3. Resta x + 3, que tende a 6.',
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
    contentLessonId: 'limites-05-racionalizacao',
    skill: 'Racionalização de diferença com raiz',
    difficulty: ExerciseDifficulty.intermediate,
    statement: 'Calcule o limite:\n\nlim x → 4  (√x - 2) / (x - 4)',
    correctOptionId: 'c',
    explanation:
        'A substituição produz 0/0. Multiplique numerador e denominador pelo conjugado √x + 2. O produto (√x - 2)(√x + 2) vira x - 4 e cancela o denominador original. Resta 1/(√x + 2), cujo limite em x = 4 é 1/4.',
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
    contentLessonId: 'limites-07-trigonometricos',
    skill: 'Ajuste para a forma sen(u)/u',
    difficulty: ExerciseDifficulty.intermediate,
    statement: 'Calcule o limite:\n\nlim x → 0  sen(2x) / x',
    correctOptionId: 'a',
    explanation:
        'Precisamos fazer o argumento 2x aparecer também no denominador. Escrevemos sen(2x)/x = 2·sen(2x)/(2x). Quando x tende a zero, 2x também tende a zero e a razão fundamental tende a 1. Logo, o resultado é 2·1 = 2.',
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
    contentLessonId: 'limites-07-trigonometricos',
    skill: 'Identidade trigonométrica e conjugado',
    difficulty: ExerciseDifficulty.challenge,
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
    contentLessonId: 'limites-06-infinito',
    skill: 'Termos dominantes de grau cúbico',
    difficulty: ExerciseDifficulty.intermediate,
    statement: 'Calcule o limite:\n\nlim x → ∞  (5x³ + x) / (2x³ - 1)',
    correctOptionId: 'c',
    explanation:
        'Divida todos os termos por x³: (5 + 1/x²)/(2 - 1/x³). Quando x tende ao infinito, 1/x² e 1/x³ tendem a zero. A expressão se aproxima de 5/2, a razão entre os coeficientes dos termos dominantes.',
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
    contentLessonId: 'limites-06-infinito',
    skill: 'Crescimento sem limite',
    difficulty: ExerciseDifficulty.intermediate,
    statement: 'Calcule o limite:\n\nlim x → ∞  x² / (x + 1)',
    correctOptionId: 'd',
    explanation:
        'Dividindo numerador e denominador por x, obtemos x/(1 + 1/x). O denominador tende a 1 e o numerador cresce positivamente sem limite. Portanto, a razão tende a +∞; não existe assíntota horizontal nesse sentido.',
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
    contentLessonId: 'limites-02-laterais',
    skill: 'Comportamento infinito pela direita',
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
    contentLessonId: 'limites-02-laterais',
    skill: 'Comportamento infinito pela esquerda',
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
    contentLessonId: 'limites-08-sintese',
    skill: 'Diagnóstico de existência do limite bilateral',
    difficulty: ExerciseDifficulty.challenge,
    statement: 'Calcule o limite:\n\nlim x → 0  1/x',
    correctOptionId: 'c',
    explanation:
        'Use o roteiro de diagnóstico: primeiro compare os lados. Para x positivo e muito próximo de zero, 1/x cresce para +∞. Para x negativo e muito próximo de zero, 1/x decresce para -∞. Como os comportamentos laterais não coincidem, o limite bilateral não existe.',
    options: [
      ExerciseOptionData(id: 'a', text: '+∞'),
      ExerciseOptionData(id: 'b', text: '-∞'),
      ExerciseOptionData(id: 'c', text: 'Não existe'),
      ExerciseOptionData(id: 'd', text: '0'),
    ],
  ),
];
