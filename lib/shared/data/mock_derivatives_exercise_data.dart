import 'package:calcquest/shared/data/mock_exercise_data.dart';

const List<ExerciseData> mockDerivativesExercises = [
  ExerciseData(
    id: 'derivada-significado',
    title: 'Questão 1 de 20',
    statement:
        'Qual é a principal interpretação geométrica da derivada f\'(a)?',
    correctOptionId: 'b',
    explanation:
        'A derivada em um ponto representa a inclinação da reta tangente ao gráfico naquele ponto.',
    options: [
      ExerciseOptionData(id: 'a', text: 'A área sob o gráfico'),
      ExerciseOptionData(id: 'b', text: 'A inclinação da reta tangente'),
      ExerciseOptionData(id: 'c', text: 'O valor máximo da função'),
      ExerciseOptionData(id: 'd', text: 'A distância até a origem'),
    ],
  ),
  ExerciseData(
    id: 'derivada-potencia-cubica',
    title: 'Questão 2 de 20',
    statement: 'Se f(x) = x³, qual é f\'(x)?',
    correctOptionId: 'c',
    explanation:
        'Pela regra da potência, a derivada de xⁿ é n·xⁿ⁻¹. Portanto, (x³)\' = 3x².',
    options: [
      ExerciseOptionData(id: 'a', text: 'x²'),
      ExerciseOptionData(id: 'b', text: '3x'),
      ExerciseOptionData(id: 'c', text: '3x²'),
      ExerciseOptionData(id: 'd', text: 'x⁴/4'),
    ],
  ),
  ExerciseData(
    id: 'derivada-polinomio',
    title: 'Questão 3 de 20',
    statement: 'Calcule a derivada de f(x) = 5x² - 3x + 4.',
    correctOptionId: 'a',
    explanation:
        'Derivamos termo a termo: (5x²)\' = 10x, (-3x)\' = -3 e a derivada da constante 4 é zero.',
    options: [
      ExerciseOptionData(id: 'a', text: '10x - 3'),
      ExerciseOptionData(id: 'b', text: '5x - 3'),
      ExerciseOptionData(id: 'c', text: '10x + 4'),
      ExerciseOptionData(id: 'd', text: '10x² - 3'),
    ],
  ),
  ExerciseData(
    id: 'derivada-constante',
    title: 'Questão 4 de 20',
    statement: 'Qual é a derivada da função constante f(x) = 12?',
    correctOptionId: 'd',
    explanation:
        'Uma função constante não varia. Por isso, sua taxa de variação e sua derivada são iguais a zero.',
    options: [
      ExerciseOptionData(id: 'a', text: '12'),
      ExerciseOptionData(id: 'b', text: '1'),
      ExerciseOptionData(id: 'c', text: '12x'),
      ExerciseOptionData(id: 'd', text: '0'),
    ],
  ),
  ExerciseData(
    id: 'derivada-identidade',
    title: 'Questão 5 de 20',
    statement: 'Se f(x) = x, qual é o valor de f\'(x)?',
    correctOptionId: 'b',
    explanation:
        'A função identidade tem inclinação constante igual a 1. Assim, sua derivada é 1.',
    options: [
      ExerciseOptionData(id: 'a', text: '0'),
      ExerciseOptionData(id: 'b', text: '1'),
      ExerciseOptionData(id: 'c', text: 'x'),
      ExerciseOptionData(id: 'd', text: '2x'),
    ],
  ),
  ExerciseData(
    id: 'derivada-raiz',
    title: 'Questão 6 de 20',
    statement: 'Para x > 0, qual é a derivada de f(x) = √x?',
    correctOptionId: 'c',
    explanation:
        'Escrevemos √x como x¹ᐟ². Pela regra da potência, f\'(x) = (1/2)x⁻¹ᐟ² = 1/(2√x).',
    options: [
      ExerciseOptionData(id: 'a', text: '√x/2'),
      ExerciseOptionData(id: 'b', text: '2√x'),
      ExerciseOptionData(id: 'c', text: '1/(2√x)'),
      ExerciseOptionData(id: 'd', text: '1/√x'),
    ],
  ),
  ExerciseData(
    id: 'derivada-inversa',
    title: 'Questão 7 de 20',
    statement: 'Para x ≠ 0, qual é a derivada de f(x) = 1/x?',
    correctOptionId: 'a',
    explanation:
        'Como 1/x = x⁻¹, aplicamos a regra da potência: (x⁻¹)\' = -x⁻² = -1/x².',
    options: [
      ExerciseOptionData(id: 'a', text: '-1/x²'),
      ExerciseOptionData(id: 'b', text: '1/x²'),
      ExerciseOptionData(id: 'c', text: '-1/x'),
      ExerciseOptionData(id: 'd', text: '0'),
    ],
  ),
  ExerciseData(
    id: 'derivada-produto',
    title: 'Questão 8 de 20',
    statement: 'Calcule a derivada de f(x) = x²(x + 1).',
    correctOptionId: 'd',
    explanation:
        'Expandindo, f(x) = x³ + x². Derivando termo a termo, obtemos f\'(x) = 3x² + 2x.',
    options: [
      ExerciseOptionData(id: 'a', text: '2x(x + 1)'),
      ExerciseOptionData(id: 'b', text: '3x² + 1'),
      ExerciseOptionData(id: 'c', text: 'x² + 2x'),
      ExerciseOptionData(id: 'd', text: '3x² + 2x'),
    ],
  ),
  ExerciseData(
    id: 'derivada-quociente-simplificado',
    title: 'Questão 9 de 20',
    statement: 'Para x ≠ 0, derive f(x) = (x² + 1)/x.',
    correctOptionId: 'b',
    explanation: 'Simplificamos f(x) = x + 1/x. Logo, f\'(x) = 1 - 1/x².',
    options: [
      ExerciseOptionData(id: 'a', text: '1 + 1/x²'),
      ExerciseOptionData(id: 'b', text: '1 - 1/x²'),
      ExerciseOptionData(id: 'c', text: '2x/x'),
      ExerciseOptionData(id: 'd', text: 'x² - 1'),
    ],
  ),
  ExerciseData(
    id: 'derivada-regra-cadeia',
    title: 'Questão 10 de 20',
    statement: 'Calcule a derivada de f(x) = (2x + 1)³.',
    correctOptionId: 'c',
    explanation:
        'Pela regra da cadeia, derivamos a potência e multiplicamos pela derivada interna: 3(2x + 1)²·2 = 6(2x + 1)².',
    options: [
      ExerciseOptionData(id: 'a', text: '3(2x + 1)²'),
      ExerciseOptionData(id: 'b', text: '6(2x + 1)'),
      ExerciseOptionData(id: 'c', text: '6(2x + 1)²'),
      ExerciseOptionData(id: 'd', text: '(2x + 1)²'),
    ],
  ),
  ExerciseData(
    id: 'derivada-seno',
    title: 'Questão 11 de 20',
    statement: 'Qual é a derivada de f(x) = sen(x)?',
    correctOptionId: 'a',
    explanation: 'A derivada da função seno é a função cosseno.',
    options: [
      ExerciseOptionData(id: 'a', text: 'cos(x)'),
      ExerciseOptionData(id: 'b', text: '-cos(x)'),
      ExerciseOptionData(id: 'c', text: 'sen(x)'),
      ExerciseOptionData(id: 'd', text: '-sen(x)'),
    ],
  ),
  ExerciseData(
    id: 'derivada-cosseno',
    title: 'Questão 12 de 20',
    statement: 'Qual é a derivada de f(x) = cos(x)?',
    correctOptionId: 'd',
    explanation: 'A derivada da função cosseno é -sen(x).',
    options: [
      ExerciseOptionData(id: 'a', text: 'sen(x)'),
      ExerciseOptionData(id: 'b', text: 'cos(x)'),
      ExerciseOptionData(id: 'c', text: '-cos(x)'),
      ExerciseOptionData(id: 'd', text: '-sen(x)'),
    ],
  ),
  ExerciseData(
    id: 'derivada-exponencial',
    title: 'Questão 13 de 20',
    statement: 'Qual é a derivada de f(x) = eˣ?',
    correctOptionId: 'b',
    explanation: 'A função exponencial de base e é igual à própria derivada.',
    options: [
      ExerciseOptionData(id: 'a', text: 'x·eˣ⁻¹'),
      ExerciseOptionData(id: 'b', text: 'eˣ'),
      ExerciseOptionData(id: 'c', text: '1/eˣ'),
      ExerciseOptionData(id: 'd', text: 'ln(x)'),
    ],
  ),
  ExerciseData(
    id: 'derivada-logaritmo',
    title: 'Questão 14 de 20',
    statement: 'Para x > 0, qual é a derivada de f(x) = ln(x)?',
    correctOptionId: 'c',
    explanation: 'A derivada do logaritmo natural ln(x) é 1/x.',
    options: [
      ExerciseOptionData(id: 'a', text: 'ln(x)/x'),
      ExerciseOptionData(id: 'b', text: 'x'),
      ExerciseOptionData(id: 'c', text: '1/x'),
      ExerciseOptionData(id: 'd', text: 'eˣ'),
    ],
  ),
  ExerciseData(
    id: 'derivada-inclinacao-ponto',
    title: 'Questão 15 de 20',
    statement:
        'Qual é a inclinação da reta tangente a f(x) = x² no ponto em que x = 2?',
    correctOptionId: 'a',
    explanation:
        'A derivada é f\'(x) = 2x. Avaliando em x = 2, temos f\'(2) = 4.',
    options: [
      ExerciseOptionData(id: 'a', text: '4'),
      ExerciseOptionData(id: 'b', text: '2'),
      ExerciseOptionData(id: 'c', text: '1'),
      ExerciseOptionData(id: 'd', text: '0'),
    ],
  ),
  ExerciseData(
    id: 'derivada-equacao-tangente',
    title: 'Questão 16 de 20',
    statement: 'Qual é a reta tangente a f(x) = x² no ponto (1, 1)?',
    correctOptionId: 'c',
    explanation:
        'A inclinação é f\'(1) = 2. Usando y - 1 = 2(x - 1), obtemos y = 2x - 1.',
    options: [
      ExerciseOptionData(id: 'a', text: 'y = x + 1'),
      ExerciseOptionData(id: 'b', text: 'y = x - 1'),
      ExerciseOptionData(id: 'c', text: 'y = 2x - 1'),
      ExerciseOptionData(id: 'd', text: 'y = 2x + 1'),
    ],
  ),
  ExerciseData(
    id: 'derivada-ponto-critico',
    title: 'Questão 17 de 20',
    statement:
        'Em qual valor de x a função f(x) = x² - 4x possui derivada igual a zero?',
    correctOptionId: 'd',
    explanation:
        'Temos f\'(x) = 2x - 4. Igualando a zero: 2x - 4 = 0, então x = 2.',
    options: [
      ExerciseOptionData(id: 'a', text: '-4'),
      ExerciseOptionData(id: 'b', text: '-2'),
      ExerciseOptionData(id: 'c', text: '0'),
      ExerciseOptionData(id: 'd', text: '2'),
    ],
  ),
  ExerciseData(
    id: 'derivabilidade-continuidade',
    title: 'Questão 18 de 20',
    statement:
        'Se uma função é derivável em x = a, o que obrigatoriamente podemos afirmar?',
    correctOptionId: 'b',
    explanation:
        'Toda função derivável em um ponto é contínua nesse ponto. A recíproca não é sempre verdadeira.',
    options: [
      ExerciseOptionData(id: 'a', text: 'Ela possui máximo em a'),
      ExerciseOptionData(id: 'b', text: 'Ela é contínua em a'),
      ExerciseOptionData(id: 'c', text: 'Sua derivada é zero em a'),
      ExerciseOptionData(id: 'd', text: 'Ela é uma função polinomial'),
    ],
  ),
  ExerciseData(
    id: 'derivada-modulo-zero',
    title: 'Questão 19 de 20',
    statement: 'Por que f(x) = |x| não é derivável em x = 0?',
    correctOptionId: 'a',
    explanation:
        'Em x = 0, a inclinação pela esquerda é -1 e pela direita é 1. Como as derivadas laterais são diferentes, a derivada não existe.',
    options: [
      ExerciseOptionData(id: 'a', text: 'As derivadas laterais são diferentes'),
      ExerciseOptionData(id: 'b', text: 'A função não está definida em zero'),
      ExerciseOptionData(id: 'c', text: 'O limite da função é infinito'),
      ExerciseOptionData(id: 'd', text: 'A função não é contínua em zero'),
    ],
  ),
  ExerciseData(
    id: 'derivada-velocidade',
    title: 'Questão 20 de 20',
    statement:
        'A posição de um móvel é s(t) = t² + 3t, em metros. Qual é sua velocidade instantânea em t = 2 s?',
    correctOptionId: 'c',
    explanation:
        'A velocidade é a derivada da posição: v(t) = s\'(t) = 2t + 3. Em t = 2, v(2) = 7 m/s.',
    options: [
      ExerciseOptionData(id: 'a', text: '4 m/s'),
      ExerciseOptionData(id: 'b', text: '5 m/s'),
      ExerciseOptionData(id: 'c', text: '7 m/s'),
      ExerciseOptionData(id: 'd', text: '10 m/s'),
    ],
  ),
];
