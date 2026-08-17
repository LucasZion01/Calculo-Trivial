import 'package:calcquest/shared/data/mock_exercise_data.dart';

const List<ExerciseData> mockFunctionsExercises = [
  ExerciseData(
    id: 'funcoes-dominio',
    title: 'Questão 1 de 10',
    statement:
        'Considere a função:\n\nf(x) = √(x - 2)\n\nQual é o domínio de f?',
    correctOptionId: 'c',
    explanation:
        'Para que a raiz quadrada seja real, o radicando deve ser maior ou igual a zero. Assim, x - 2 ≥ 0, portanto x ≥ 2. Logo, o domínio é [2, ∞).',
    options: [
      ExerciseOptionData(id: 'a', text: '(-∞, 2)'),
      ExerciseOptionData(id: 'b', text: '(-∞, 2]'),
      ExerciseOptionData(id: 'c', text: '[2, ∞)'),
      ExerciseOptionData(id: 'd', text: 'ℝ'),
    ],
  ),
  ExerciseData(
    id: 'funcoes-composicao',
    title: 'Questão 2 de 10',
    statement: 'Sejam:\n\nf(x) = 2x + 1\ng(x) = x²\n\nDetermine (f ∘ g)(x).',
    correctOptionId: 'b',
    explanation:
        'Na composição (f ∘ g)(x), calculamos f(g(x)). Como g(x) = x², substituímos x por x² em f: f(x²) = 2x² + 1.',
    options: [
      ExerciseOptionData(id: 'a', text: '4x² + 1'),
      ExerciseOptionData(id: 'b', text: '2x² + 1'),
      ExerciseOptionData(id: 'c', text: '(2x + 1)²'),
      ExerciseOptionData(id: 'd', text: '2x + x²'),
    ],
  ),
  ExerciseData(
    id: 'funcoes-inversa',
    title: 'Questão 3 de 10',
    statement:
        'Considere a função:\n\nf(x) = 3x - 6\n\nQual é a função inversa f⁻¹(x)?',
    correctOptionId: 'a',
    explanation:
        'Escrevemos y = 3x - 6 e isolamos x: y + 6 = 3x, então x = (y + 6)/3. Trocando y por x, obtemos f⁻¹(x) = (x + 6)/3.',
    options: [
      ExerciseOptionData(id: 'a', text: 'f⁻¹(x) = (x + 6) / 3'),
      ExerciseOptionData(id: 'b', text: 'f⁻¹(x) = (x - 6) / 3'),
      ExerciseOptionData(id: 'c', text: 'f⁻¹(x) = 3x + 6'),
      ExerciseOptionData(id: 'd', text: 'f⁻¹(x) = 1 / (3x - 6)'),
    ],
  ),
  ExerciseData(
    id: 'funcoes-paridade',
    title: 'Questão 4 de 10',
    statement:
        'Considere a função:\n\nf(x) = x² + 4\n\nComo essa função pode ser classificada quanto à paridade?',
    correctOptionId: 'a',
    explanation:
        'Calculando f(-x), temos (-x)² + 4 = x² + 4 = f(x). Portanto, f(-x) = f(x), o que caracteriza uma função par.',
    options: [
      ExerciseOptionData(id: 'a', text: 'Função par'),
      ExerciseOptionData(id: 'b', text: 'Função ímpar'),
      ExerciseOptionData(id: 'c', text: 'Nem par nem ímpar'),
      ExerciseOptionData(id: 'd', text: 'Função constante'),
    ],
  ),
  ExerciseData(
    id: 'funcoes-imagem-quadratica',
    title: 'Questão 5 de 10',
    statement:
        'Considere a função:\n\nf(x) = x² - 4x + 3\n\nQual é o menor valor assumido por f(x)?',
    correctOptionId: 'd',
    explanation:
        'Completando o quadrado, temos f(x) = (x - 2)² - 1. Como (x - 2)² ≥ 0, o menor valor ocorre quando x = 2. Portanto, o valor mínimo da função é -1.',
    options: [
      ExerciseOptionData(id: 'a', text: '3'),
      ExerciseOptionData(id: 'b', text: '1'),
      ExerciseOptionData(id: 'c', text: '0'),
      ExerciseOptionData(id: 'd', text: '-1'),
    ],
  ),
  ExerciseData(
    id: 'funcoes-valor-numerico',
    title: 'Questão 6 de 10',
    statement:
        'Considere a função:\n\nf(x) = 2x² - x + 1\n\nQual é o valor de f(3)?',
    correctOptionId: 'b',
    explanation:
        'Substituímos x por 3: f(3) = 2(3²) - 3 + 1 = 18 - 3 + 1 = 16.',
    options: [
      ExerciseOptionData(id: 'a', text: '14'),
      ExerciseOptionData(id: 'b', text: '16'),
      ExerciseOptionData(id: 'c', text: '18'),
      ExerciseOptionData(id: 'd', text: '20'),
    ],
  ),
  ExerciseData(
    id: 'funcoes-raizes',
    title: 'Questão 7 de 10',
    statement:
        'Considere a função:\n\nf(x) = x² - 5x + 6\n\nQuais são os zeros de f?',
    correctOptionId: 'd',
    explanation:
        'Fatoramos o polinômio: x² - 5x + 6 = (x - 2)(x - 3). Portanto, os zeros são x = 2 e x = 3.',
    options: [
      ExerciseOptionData(id: 'a', text: 'x = -2 e x = -3'),
      ExerciseOptionData(id: 'b', text: 'x = 1 e x = 6'),
      ExerciseOptionData(id: 'c', text: 'x = -1 e x = -6'),
      ExerciseOptionData(id: 'd', text: 'x = 2 e x = 3'),
    ],
  ),
  ExerciseData(
    id: 'funcoes-coeficiente-angular',
    title: 'Questão 8 de 10',
    statement:
        'Considere a função afim:\n\nf(x) = -3x + 4\n\nQual é o coeficiente angular?',
    correctOptionId: 'a',
    explanation:
        'Na forma f(x) = ax + b, o coeficiente angular é a. Nesse caso, a = -3.',
    options: [
      ExerciseOptionData(id: 'a', text: '-3'),
      ExerciseOptionData(id: 'b', text: '3'),
      ExerciseOptionData(id: 'c', text: '4'),
      ExerciseOptionData(id: 'd', text: '-4'),
    ],
  ),
  ExerciseData(
    id: 'funcoes-composicao-inversa',
    title: 'Questão 9 de 10',
    statement: 'Sejam:\n\nf(x) = x + 2\ng(x) = 3x\n\nDetermine (g ∘ f)(x).',
    correctOptionId: 'c',
    explanation:
        'Calculamos g(f(x)). Como f(x) = x + 2, substituímos em g: g(x + 2) = 3(x + 2) = 3x + 6.',
    options: [
      ExerciseOptionData(id: 'a', text: '3x + 2'),
      ExerciseOptionData(id: 'b', text: 'x + 6'),
      ExerciseOptionData(id: 'c', text: '3x + 6'),
      ExerciseOptionData(id: 'd', text: '3x² + 6'),
    ],
  ),
  ExerciseData(
    id: 'funcoes-imagem-modulo',
    title: 'Questão 10 de 10',
    statement: 'Considere a função:\n\nf(x) = |x|\n\nQual é a imagem de f?',
    correctOptionId: 'b',
    explanation:
        'O valor absoluto nunca é negativo. A função pode assumir zero e qualquer valor positivo, portanto sua imagem é [0, ∞).',
    options: [
      ExerciseOptionData(id: 'a', text: '(-∞, 0]'),
      ExerciseOptionData(id: 'b', text: '[0, ∞)'),
      ExerciseOptionData(id: 'c', text: '(0, ∞)'),
      ExerciseOptionData(id: 'd', text: 'ℝ'),
    ],
  ),
  ExerciseData(
    id: 'funcoes-dominio-racional',
    title: 'Questão 11 de 20',
    statement:
        'Considere a função:\n\nf(x) = 1 / (x - 4)\n\nQual é o domínio de f?',
    correctOptionId: 'c',
    explanation:
        'O denominador não pode ser zero. Como x - 4 = 0 quando x = 4, o domínio contém todos os reais, exceto 4.',
    options: [
      ExerciseOptionData(id: 'a', text: '[4, ∞)'),
      ExerciseOptionData(id: 'b', text: '(-∞, 4)'),
      ExerciseOptionData(id: 'c', text: 'ℝ - {4}'),
      ExerciseOptionData(id: 'd', text: 'ℝ'),
    ],
  ),
  ExerciseData(
    id: 'funcoes-valor-numerico-2',
    title: 'Questão 12 de 20',
    statement:
        'Considere a função:\n\nf(x) = -x² + 4x\n\nQual é o valor de f(2)?',
    correctOptionId: 'a',
    explanation: 'Substituindo x por 2: f(2) = -(2²) + 4 · 2 = -4 + 8 = 4.',
    options: [
      ExerciseOptionData(id: 'a', text: '4'),
      ExerciseOptionData(id: 'b', text: '0'),
      ExerciseOptionData(id: 'c', text: '8'),
      ExerciseOptionData(id: 'd', text: '12'),
    ],
  ),
  ExerciseData(
    id: 'funcoes-vertice',
    title: 'Questão 13 de 20',
    statement:
        'Considere a função:\n\nf(x) = x² - 6x + 5\n\nQual é o valor mínimo de f?',
    correctOptionId: 'd',
    explanation:
        'Completando o quadrado: f(x) = (x - 3)² - 4. O menor valor ocorre em x = 3 e é -4.',
    options: [
      ExerciseOptionData(id: 'a', text: '5'),
      ExerciseOptionData(id: 'b', text: '3'),
      ExerciseOptionData(id: 'c', text: '0'),
      ExerciseOptionData(id: 'd', text: '-4'),
    ],
  ),
  ExerciseData(
    id: 'funcoes-crescimento-afim',
    title: 'Questão 14 de 20',
    statement:
        'Considere a função:\n\nf(x) = 2x + 1\n\nComo ela é classificada quanto ao crescimento?',
    correctOptionId: 'b',
    explanation:
        'O coeficiente angular é 2, que é positivo. Portanto, a função é crescente.',
    options: [
      ExerciseOptionData(id: 'a', text: 'Decrescente'),
      ExerciseOptionData(id: 'b', text: 'Crescente'),
      ExerciseOptionData(id: 'c', text: 'Constante'),
      ExerciseOptionData(id: 'd', text: 'Periódica'),
    ],
  ),
  ExerciseData(
    id: 'funcoes-intersecao-eixo-y',
    title: 'Questão 15 de 20',
    statement:
        'Considere a função:\n\nf(x) = -3x + 6\n\nEm qual valor o gráfico intercepta o eixo y?',
    correctOptionId: 'c',
    explanation:
        'A interseção com o eixo y ocorre quando x = 0. Assim, f(0) = 6.',
    options: [
      ExerciseOptionData(id: 'a', text: '-3'),
      ExerciseOptionData(id: 'b', text: '0'),
      ExerciseOptionData(id: 'c', text: '6'),
      ExerciseOptionData(id: 'd', text: '3'),
    ],
  ),
  ExerciseData(
    id: 'funcoes-inversa-2',
    title: 'Questão 16 de 20',
    statement:
        'Considere a função:\n\nf(x) = 2x + 4\n\nQual é a função inversa?',
    correctOptionId: 'a',
    explanation:
        'Escrevemos y = 2x + 4 e isolamos x: x = (y - 4)/2. Logo, f⁻¹(x) = (x - 4)/2.',
    options: [
      ExerciseOptionData(id: 'a', text: 'f⁻¹(x) = (x - 4) / 2'),
      ExerciseOptionData(id: 'b', text: 'f⁻¹(x) = (x + 4) / 2'),
      ExerciseOptionData(id: 'c', text: 'f⁻¹(x) = 2x - 4'),
      ExerciseOptionData(id: 'd', text: 'f⁻¹(x) = 1 / (2x + 4)'),
    ],
  ),
  ExerciseData(
    id: 'funcoes-composicao-3',
    title: 'Questão 17 de 20',
    statement: 'Sejam:\n\nf(x) = x²\ng(x) = x + 1\n\nDetermine (f ∘ g)(x).',
    correctOptionId: 'd',
    explanation:
        'Calculamos f(g(x)). Substituindo g(x) = x + 1 em f, obtemos (x + 1)².',
    options: [
      ExerciseOptionData(id: 'a', text: 'x² + 1'),
      ExerciseOptionData(id: 'b', text: 'x³ + 1'),
      ExerciseOptionData(id: 'c', text: '2x + 1'),
      ExerciseOptionData(id: 'd', text: '(x + 1)²'),
    ],
  ),
  ExerciseData(
    id: 'funcoes-impar',
    title: 'Questão 18 de 20',
    statement:
        'Considere a função:\n\nf(x) = x³ - x\n\nComo ela é classificada quanto à paridade?',
    correctOptionId: 'b',
    explanation:
        'Calculando f(-x), obtemos -x³ + x = -(x³ - x) = -f(x). Portanto, a função é ímpar.',
    options: [
      ExerciseOptionData(id: 'a', text: 'Função par'),
      ExerciseOptionData(id: 'b', text: 'Função ímpar'),
      ExerciseOptionData(id: 'c', text: 'Nem par nem ímpar'),
      ExerciseOptionData(id: 'd', text: 'Função constante'),
    ],
  ),
  ExerciseData(
    id: 'funcoes-exponencial',
    title: 'Questão 19 de 20',
    statement: 'Considere a função:\n\nf(x) = 2ˣ\n\nQual é o valor de f(3)?',
    correctOptionId: 'c',
    explanation: 'Substituindo x por 3, temos f(3) = 2³ = 8.',
    options: [
      ExerciseOptionData(id: 'a', text: '5'),
      ExerciseOptionData(id: 'b', text: '6'),
      ExerciseOptionData(id: 'c', text: '8'),
      ExerciseOptionData(id: 'd', text: '9'),
    ],
  ),
  ExerciseData(
    id: 'funcoes-imagem-quadratica-2',
    title: 'Questão 20 de 20',
    statement:
        'Considere a função:\n\nf(x) = -(x - 1)² + 4\n\nQual é a imagem de f?',
    correctOptionId: 'a',
    explanation:
        'A parábola tem concavidade para baixo e valor máximo 4. Portanto, assume todos os valores menores ou iguais a 4.',
    options: [
      ExerciseOptionData(id: 'a', text: '(-∞, 4]'),
      ExerciseOptionData(id: 'b', text: '[4, ∞)'),
      ExerciseOptionData(id: 'c', text: '(-∞, 1]'),
      ExerciseOptionData(id: 'd', text: 'ℝ'),
    ],
  ),
];
