class ExerciseFeedbackGuidance {
  final String firstHint;
  final String nextStep;
  final bool isSpecific;

  const ExerciseFeedbackGuidance({
    required this.firstHint,
    required this.nextStep,
    required this.isSpecific,
  });
}

ExerciseFeedbackGuidance resolveExerciseFeedbackGuidance({
  required String? skill,
  required bool isEnglish,
}) {
  final normalized = _normalize(skill ?? '');

  if (_containsAny(normalized, const [
    'dividir monomios',
    'divide monomials',
    'quociente de potencias',
    'quotient rule for powers',
  ])) {
    return ExerciseFeedbackGuidance(
      firstHint: isEnglish
          ? 'Separate the calculation into two parts: divide the numerical coefficients and handle each repeated variable base on its own.'
          : 'Separe o cálculo em duas partes: divida os coeficientes numéricos e trate cada base de variável repetida separadamente.',
      nextStep: isEnglish
          ? 'For equal bases in a division, subtract the exponent in the denominator from the exponent in the numerator. Then combine the simplified factors.'
          : 'Para bases iguais em uma divisão, subtraia o expoente do denominador do expoente do numerador. Depois reúna os fatores simplificados.',
      isSpecific: true,
    );
  }

  if (_containsAny(normalized, const [
    'multiplicar monomios',
    'multiply monomials',
  ])) {
    return ExerciseFeedbackGuidance(
      firstHint: isEnglish
          ? 'Multiply the numerical coefficients first. Then identify variables with the same base.'
          : 'Multiplique primeiro os coeficientes numéricos. Depois identifique as variáveis que possuem a mesma base.',
      nextStep: isEnglish
          ? 'When multiplying powers with the same base, add their exponents. Check the sign of the numerical product separately.'
          : 'Ao multiplicar potências de mesma base, some os expoentes. Confira separadamente o sinal do produto numérico.',
      isSpecific: true,
    );
  }

  if (_containsAny(normalized, const [
    'termos semelhantes',
    'like terms',
    'combine terms with two variables',
  ])) {
    return ExerciseFeedbackGuidance(
      firstHint: isEnglish
          ? 'Group only terms that have exactly the same literal part: the same variables raised to the same exponents.'
          : 'Agrupe somente os termos que possuem exatamente a mesma parte literal: mesmas variáveis elevadas aos mesmos expoentes.',
      nextStep: isEnglish
          ? 'Keep the literal part unchanged and operate only on the coefficients of those like terms.'
          : 'Mantenha a parte literal inalterada e opere apenas os coeficientes desses termos semelhantes.',
      isSpecific: true,
    );
  }

  if (_containsAny(normalized, const [
    'distribut',
  ])) {
    return ExerciseFeedbackGuidance(
      firstHint: isEnglish
          ? 'Apply the factor outside the parentheses to every term inside them, not just to the first term.'
          : 'Aplique o fator que está fora dos parênteses a todos os termos internos, e não apenas ao primeiro.',
      nextStep: isEnglish
          ? 'After distributing, review the signs and only then combine like terms.'
          : 'Depois de distribuir, revise os sinais e só então reduza os termos semelhantes.',
      isSpecific: true,
    );
  }

  if (_containsAny(normalized, const [
    'valor numerico',
    'evaluate an algebraic expression',
  ])) {
    return ExerciseFeedbackGuidance(
      firstHint: isEnglish
          ? 'Substitute the given value everywhere the variable appears, using parentheses when the value is negative.'
          : 'Substitua o valor dado em todas as ocorrências da variável, usando parênteses quando o valor for negativo.',
      nextStep: isEnglish
          ? 'Respect the order of operations: powers before multiplication, and multiplication before addition or subtraction.'
          : 'Respeite a ordem das operações: potências antes das multiplicações, e multiplicações antes das somas ou subtrações.',
      isSpecific: true,
    );
  }

  if (_containsAny(normalized, const [
    'coeficient',
  ])) {
    return ExerciseFeedbackGuidance(
      firstHint: isEnglish
          ? 'Separate the numerical factor from the literal part of the term.'
          : 'Separe o fator numérico da parte literal do termo.',
      nextStep: isEnglish
          ? 'The coefficient includes its sign. Do not confuse an exponent with the number multiplying the variable.'
          : 'O coeficiente inclui o sinal. Não confunda o expoente com o número que multiplica a variável.',
      isSpecific: true,
    );
  }

  if (_containsAny(normalized, const [
    'expandir binomios',
    'expand binomials',
  ])) {
    return ExerciseFeedbackGuidance(
      firstHint: isEnglish
          ? 'Multiply each term of the first binomial by each term of the second binomial.'
          : 'Multiplique cada termo do primeiro binômio por cada termo do segundo binômio.',
      nextStep: isEnglish
          ? 'After expanding all products, combine only the resulting like terms and check the signs.'
          : 'Depois de desenvolver todos os produtos, reduza apenas os termos semelhantes resultantes e confira os sinais.',
      isSpecific: true,
    );
  }

  if (_containsAny(normalized, const [
    'fator comum',
    'greatest common factor',
  ])) {
    return ExerciseFeedbackGuidance(
      firstHint: isEnglish
          ? 'Find the greatest numerical and literal factor shared by every term.'
          : 'Procure o maior fator numérico e literal que aparece em todos os termos.',
      nextStep: isEnglish
          ? 'Factor it out and divide each original term by that common factor to build the expression inside the parentheses.'
          : 'Coloque esse fator em evidência e divida cada termo original por ele para montar a expressão dentro dos parênteses.',
      isSpecific: true,
    );
  }

  if (_containsAny(normalized, const [
    'potencia de potencia',
    'power of a power',
  ])) {
    return ExerciseFeedbackGuidance(
      firstHint: isEnglish
          ? 'A power applied to a product affects every factor inside the parentheses.'
          : 'Uma potência aplicada a um produto atua sobre cada fator dentro dos parênteses.',
      nextStep: isEnglish
          ? 'For a power of a power, multiply the exponents. Evaluate the numerical power separately.'
          : 'Em uma potência de potência, multiplique os expoentes. Calcule a potência numérica separadamente.',
      isSpecific: true,
    );
  }

  if (_containsAny(normalized, const [
    'quadrado de uma soma',
    'square of a sum',
  ])) {
    return ExerciseFeedbackGuidance(
      firstHint: isEnglish
          ? 'Recall the pattern: square of the first term, twice the product of both terms, square of the second term.'
          : 'Lembre do padrão: quadrado do primeiro termo, duas vezes o produto dos dois termos, quadrado do segundo termo.',
      nextStep: isEnglish
          ? 'Write the three terms of the identity before substituting the values. This reduces sign and coefficient mistakes.'
          : 'Escreva os três termos da identidade antes de substituir os valores. Isso reduz erros de sinal e coeficiente.',
      isSpecific: true,
    );
  }

  if (_containsAny(normalized, const [
    'diferenca de quadrados',
    'difference of squares',
  ])) {
    return ExerciseFeedbackGuidance(
      firstHint: isEnglish
          ? 'Check whether both terms are perfect squares separated by a subtraction.'
          : 'Verifique se os dois termos são quadrados perfeitos separados por uma subtração.',
      nextStep: isEnglish
          ? 'If they are, use the product of the difference and the sum of their square roots.'
          : 'Se forem, use o produto da diferença pela soma das raízes quadradas desses termos.',
      isSpecific: true,
    );
  }

  if (_containsAny(normalized, const [
    'fracoes algebricas',
    'algebraic fractions',
  ])) {
    return ExerciseFeedbackGuidance(
      firstHint: isEnglish
          ? 'Before adding fractions, find a common denominator.'
          : 'Antes de somar frações, encontre um denominador comum.',
      nextStep: isEnglish
          ? 'Rewrite each fraction with that denominator, then combine the numerators and simplify if possible.'
          : 'Reescreva cada fração com esse denominador, depois opere os numeradores e simplifique se for possível.',
      isSpecific: true,
    );
  }

  return ExerciseFeedbackGuidance(
    firstHint: isEnglish
        ? 'Identify the main mathematical rule needed in this question before comparing the alternatives.'
        : 'Identifique a regra matemática principal necessária nesta questão antes de comparar as alternativas.',
    nextStep: isEnglish
        ? 'Redo only the first step without looking at the alternatives. Check signs, operations and restrictions before moving on.'
        : 'Refaça apenas o primeiro passo sem olhar para as alternativas. Verifique sinais, operações e restrições antes de avançar.',
    isSpecific: false,
  );
}

bool _containsAny(String value, List<String> candidates) {
  return candidates.any(value.contains);
}

String _normalize(String value) {
  return value
      .toLowerCase()
      .replaceAll('á', 'a')
      .replaceAll('à', 'a')
      .replaceAll('â', 'a')
      .replaceAll('ã', 'a')
      .replaceAll('é', 'e')
      .replaceAll('ê', 'e')
      .replaceAll('í', 'i')
      .replaceAll('ó', 'o')
      .replaceAll('ô', 'o')
      .replaceAll('õ', 'o')
      .replaceAll('ú', 'u')
      .replaceAll('ç', 'c')
      .trim();
}
