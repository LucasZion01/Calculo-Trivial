class ExerciseOptionData {
  final String id;
  final String text;

  const ExerciseOptionData({required this.id, required this.text});
}

class ExerciseData {
  final String id;
  final String title;
  final String statement;
  final List<ExerciseOptionData> options;
  final String correctOptionId;
  final String explanation;

  const ExerciseData({
    required this.id,
    required this.title,
    required this.statement,
    required this.options,
    required this.correctOptionId,
    required this.explanation,
  });
}

const List<ExerciseData> mockExercises = [
  ExerciseData(
    id: 'simplificacao-1',
    title: 'Questão 1 de 10',
    statement: 'Simplifique a expressão:\n3x + 5x - 2x',
    correctOptionId: 'a',
    explanation:
        'Somamos os coeficientes semelhantes: 3 + 5 - 2 = 6. Portanto, o resultado é 6x.',
    options: [
      ExerciseOptionData(id: 'a', text: '6x'),
      ExerciseOptionData(id: 'b', text: '8x'),
      ExerciseOptionData(id: 'c', text: '10x'),
      ExerciseOptionData(id: 'd', text: 'x'),
    ],
  ),
  ExerciseData(
    id: 'simplificacao-2',
    title: 'Questão 2 de 10',
    statement: 'Simplifique a expressão:\n7a - 2a + 4a',
    correctOptionId: 'c',
    explanation:
        'Somamos os coeficientes semelhantes: 7 - 2 + 4 = 9. Portanto, o resultado é 9a.',
    options: [
      ExerciseOptionData(id: 'a', text: '5a'),
      ExerciseOptionData(id: 'b', text: '7a'),
      ExerciseOptionData(id: 'c', text: '9a'),
      ExerciseOptionData(id: 'd', text: '13a'),
    ],
  ),
  ExerciseData(
    id: 'simplificacao-3',
    title: 'Questão 3 de 10',
    statement: 'Simplifique a expressão:\n10y - 3y - y',
    correctOptionId: 'b',
    explanation:
        'Somamos os coeficientes semelhantes: 10 - 3 - 1 = 6. Portanto, o resultado é 6y.',
    options: [
      ExerciseOptionData(id: 'a', text: '4y'),
      ExerciseOptionData(id: 'b', text: '6y'),
      ExerciseOptionData(id: 'c', text: '7y'),
      ExerciseOptionData(id: 'd', text: '10y'),
    ],
  ),
  ExerciseData(
    id: 'simplificacao-4',
    title: 'Questão 4 de 10',
    statement: 'Simplifique a expressão:\n4m + 6m - 3m',
    correctOptionId: 'd',
    explanation:
        'Somamos os coeficientes semelhantes: 4 + 6 - 3 = 7. Portanto, o resultado é 7m.',
    options: [
      ExerciseOptionData(id: 'a', text: '3m'),
      ExerciseOptionData(id: 'b', text: '6m'),
      ExerciseOptionData(id: 'c', text: '10m'),
      ExerciseOptionData(id: 'd', text: '7m'),
    ],
  ),
  ExerciseData(
    id: 'simplificacao-5',
    title: 'Questão 5 de 10',
    statement: 'Simplifique a expressão:\n12x - 5x + 2x',
    correctOptionId: 'c',
    explanation:
        'Somamos os coeficientes semelhantes: 12 - 5 + 2 = 9. Portanto, o resultado é 9x.',
    options: [
      ExerciseOptionData(id: 'a', text: '7x'),
      ExerciseOptionData(id: 'b', text: '8x'),
      ExerciseOptionData(id: 'c', text: '9x'),
      ExerciseOptionData(id: 'd', text: '19x'),
    ],
  ),
  ExerciseData(
    id: 'distributiva-1',
    title: 'Questão 6 de 10',
    statement: 'Simplifique a expressão:\n2(3x - 4) + x',
    correctOptionId: 'b',
    explanation:
        'Aplicamos a distributiva: 2(3x - 4) = 6x - 8. Depois somamos x, obtendo 7x - 8.',
    options: [
      ExerciseOptionData(id: 'a', text: '6x - 8'),
      ExerciseOptionData(id: 'b', text: '7x - 8'),
      ExerciseOptionData(id: 'c', text: '7x - 4'),
      ExerciseOptionData(id: 'd', text: '5x - 8'),
    ],
  ),
  ExerciseData(
    id: 'distributiva-2',
    title: 'Questão 7 de 10',
    statement: 'Simplifique a expressão:\n5a - 2(a + 3)',
    correctOptionId: 'c',
    explanation:
        'Distribuímos -2: 5a - 2a - 6. Reduzindo os termos semelhantes, obtemos 3a - 6.',
    options: [
      ExerciseOptionData(id: 'a', text: '3a + 6'),
      ExerciseOptionData(id: 'b', text: '7a - 6'),
      ExerciseOptionData(id: 'c', text: '3a - 6'),
      ExerciseOptionData(id: 'd', text: '5a - 5'),
    ],
  ),
  ExerciseData(
    id: 'potencias-1',
    title: 'Questão 8 de 10',
    statement: 'Efetue a multiplicação:\n(-3x²)(2x)',
    correctOptionId: 'd',
    explanation:
        'Multiplicamos os coeficientes: -3 · 2 = -6. Como x² · x = x³, o resultado é -6x³.',
    options: [
      ExerciseOptionData(id: 'a', text: '-6x²'),
      ExerciseOptionData(id: 'b', text: '6x³'),
      ExerciseOptionData(id: 'c', text: '-5x³'),
      ExerciseOptionData(id: 'd', text: '-6x³'),
    ],
  ),
  ExerciseData(
    id: 'produto-notavel-1',
    title: 'Questão 9 de 10',
    statement: 'Desenvolva o produto:\n(x + 3)(x - 2)',
    correctOptionId: 'a',
    explanation:
        'Aplicando a distributiva: x² - 2x + 3x - 6. Somando os termos semelhantes, obtemos x² + x - 6.',
    options: [
      ExerciseOptionData(id: 'a', text: 'x² + x - 6'),
      ExerciseOptionData(id: 'b', text: 'x² - x - 6'),
      ExerciseOptionData(id: 'c', text: 'x² + 5x + 6'),
      ExerciseOptionData(id: 'd', text: 'x² + x + 6'),
    ],
  ),
  ExerciseData(
    id: 'divisao-monomios-1',
    title: 'Questão 10 de 10',
    statement: 'Simplifique a expressão:\n(12x³y²) / (3xy)',
    correctOptionId: 'b',
    explanation:
        'Dividimos os coeficientes e subtraímos os expoentes: 12/3 = 4, x³/x = x² e y²/y = y. Portanto, o resultado é 4x²y.',
    options: [
      ExerciseOptionData(id: 'a', text: '4x³y'),
      ExerciseOptionData(id: 'b', text: '4x²y'),
      ExerciseOptionData(id: 'c', text: '9x²y'),
      ExerciseOptionData(id: 'd', text: '4xy²'),
    ],
  ),
  ExerciseData(
    id: 'fator-comum-1',
    title: 'Questão 11 de 20',
    statement: 'Fatore a expressão:\n6x + 9',
    correctOptionId: 'a',
    explanation:
        'O máximo fator comum entre 6x e 9 é 3. Colocando-o em evidência, obtemos 3(2x + 3).',
    options: [
      ExerciseOptionData(id: 'a', text: '3(2x + 3)'),
      ExerciseOptionData(id: 'b', text: '6(x + 3)'),
      ExerciseOptionData(id: 'c', text: '3(2x + 9)'),
      ExerciseOptionData(id: 'd', text: '9(6x + 1)'),
    ],
  ),
  ExerciseData(
    id: 'quociente-potencias-1',
    title: 'Questão 12 de 20',
    statement: 'Simplifique, considerando x ≠ 0:\nx⁵ / x²',
    correctOptionId: 'c',
    explanation:
        'Na divisão de potências de mesma base, subtraímos os expoentes: x⁵/x² = x⁵⁻² = x³.',
    options: [
      ExerciseOptionData(id: 'a', text: 'x²'),
      ExerciseOptionData(id: 'b', text: 'x⁷'),
      ExerciseOptionData(id: 'c', text: 'x³'),
      ExerciseOptionData(id: 'd', text: '3x'),
    ],
  ),
  ExerciseData(
    id: 'potencia-potencia-1',
    title: 'Questão 13 de 20',
    statement: 'Simplifique a expressão:\n(2x²)³',
    correctOptionId: 'd',
    explanation:
        'Elevamos o coeficiente e multiplicamos os expoentes: 2³ = 8 e (x²)³ = x⁶. Logo, 8x⁶.',
    options: [
      ExerciseOptionData(id: 'a', text: '6x⁵'),
      ExerciseOptionData(id: 'b', text: '8x⁵'),
      ExerciseOptionData(id: 'c', text: '6x⁶'),
      ExerciseOptionData(id: 'd', text: '8x⁶'),
    ],
  ),
  ExerciseData(
    id: 'distributiva-3',
    title: 'Questão 14 de 20',
    statement: 'Simplifique a expressão:\n3(x + 2) - 2(x - 1)',
    correctOptionId: 'b',
    explanation:
        'Aplicando a distributiva: 3x + 6 - 2x + 2. Reduzindo os termos, obtemos x + 8.',
    options: [
      ExerciseOptionData(id: 'a', text: 'x + 4'),
      ExerciseOptionData(id: 'b', text: 'x + 8'),
      ExerciseOptionData(id: 'c', text: '5x + 4'),
      ExerciseOptionData(id: 'd', text: 'x - 8'),
    ],
  ),
  ExerciseData(
    id: 'valor-numerico-1',
    title: 'Questão 15 de 20',
    statement: 'Calcule 2a² - 3a para a = -2.',
    correctOptionId: 'c',
    explanation: 'Substituindo a por -2: 2(-2)² - 3(-2) = 2 · 4 + 6 = 14.',
    options: [
      ExerciseOptionData(id: 'a', text: '2'),
      ExerciseOptionData(id: 'b', text: '8'),
      ExerciseOptionData(id: 'c', text: '14'),
      ExerciseOptionData(id: 'd', text: '-14'),
    ],
  ),
  ExerciseData(
    id: 'quadrado-soma-1',
    title: 'Questão 16 de 20',
    statement: 'Desenvolva o produto notável:\n(x + 4)²',
    correctOptionId: 'a',
    explanation:
        'Usamos (a + b)² = a² + 2ab + b². Assim, (x + 4)² = x² + 8x + 16.',
    options: [
      ExerciseOptionData(id: 'a', text: 'x² + 8x + 16'),
      ExerciseOptionData(id: 'b', text: 'x² + 4x + 16'),
      ExerciseOptionData(id: 'c', text: 'x² + 16'),
      ExerciseOptionData(id: 'd', text: 'x² - 8x + 16'),
    ],
  ),
  ExerciseData(
    id: 'diferenca-quadrados-1',
    title: 'Questão 17 de 20',
    statement: 'Fatore a expressão:\nx² - 9',
    correctOptionId: 'd',
    explanation:
        'Trata-se de uma diferença de quadrados: x² - 3² = (x - 3)(x + 3).',
    options: [
      ExerciseOptionData(id: 'a', text: '(x - 9)(x + 1)'),
      ExerciseOptionData(id: 'b', text: '(x - 3)²'),
      ExerciseOptionData(id: 'c', text: '(x + 3)²'),
      ExerciseOptionData(id: 'd', text: '(x - 3)(x + 3)'),
    ],
  ),
  ExerciseData(
    id: 'soma-fracoes-algebricas-1',
    title: 'Questão 18 de 20',
    statement: 'Simplifique a expressão:\nx/2 + x/3',
    correctOptionId: 'b',
    explanation:
        'O mínimo múltiplo comum de 2 e 3 é 6. Assim, 3x/6 + 2x/6 = 5x/6.',
    options: [
      ExerciseOptionData(id: 'a', text: '2x/5'),
      ExerciseOptionData(id: 'b', text: '5x/6'),
      ExerciseOptionData(id: 'c', text: 'x/5'),
      ExerciseOptionData(id: 'd', text: '2x/6'),
    ],
  ),
  ExerciseData(
    id: 'termos-semelhantes-1',
    title: 'Questão 19 de 20',
    statement: 'Simplifique:\n4x²y - 7x²y + 2x²y',
    correctOptionId: 'c',
    explanation:
        'Somamos os coeficientes dos termos semelhantes: 4 - 7 + 2 = -1. Logo, o resultado é -x²y.',
    options: [
      ExerciseOptionData(id: 'a', text: 'x²y'),
      ExerciseOptionData(id: 'b', text: '-3x²y'),
      ExerciseOptionData(id: 'c', text: '-x²y'),
      ExerciseOptionData(id: 'd', text: '9x²y'),
    ],
  ),
  ExerciseData(
    id: 'grau-polinomio-1',
    title: 'Questão 20 de 20',
    statement: 'Qual é o grau do polinômio 5x⁴ - 2x² + x - 7?',
    correctOptionId: 'a',
    explanation:
        'O grau de um polinômio é o maior expoente da variável com coeficiente não nulo. Nesse caso, é 4.',
    options: [
      ExerciseOptionData(id: 'a', text: '4'),
      ExerciseOptionData(id: 'b', text: '3'),
      ExerciseOptionData(id: 'c', text: '2'),
      ExerciseOptionData(id: 'd', text: '5'),
    ],
  ),
];
