import 'package:calcquest/shared/data/mock_exercise_data.dart';

const List<ExerciseData> mockFunctionsExercises = [
  ExerciseData(
    id: 'funcoes-dominio',
    title: 'Questão 1 de 5',
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
    title: 'Questão 2 de 5',
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
    title: 'Questão 3 de 5',
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
    title: 'Questão 4 de 5',
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
    title: 'Questão 5 de 5',
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
];
