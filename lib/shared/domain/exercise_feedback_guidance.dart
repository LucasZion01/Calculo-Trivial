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

  if (_containsAny(normalized, const ['distribut'])) {
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

  if (_containsAny(normalized, const ['coeficient'])) {
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

  if (_containsAny(normalized, const [
    'limite lateral',
    'one-sided limit',
  ])) {
    return ExerciseFeedbackGuidance(
      firstHint: isEnglish
          ? 'Respect the indicated side of approach. Inspect values or the expression only from that side of the target point.'
          : 'Respeite o lado indicado da aproximação. Analise valores ou a expressão somente por esse lado do ponto-alvo.',
      nextStep: isEnglish
          ? 'Compare the behavior as x gets arbitrarily close from the requested side; do not replace a one-sided limit with a two-sided conclusion.'
          : 'Compare o comportamento quando x fica arbitrariamente próximo pelo lado pedido; não troque um limite lateral por uma conclusão bilateral.',
      isSpecific: true,
    );
  }

  if (_containsAny(normalized, const [
    'racionalizacao',
    'conjugado',
    'rationalization',
    'conjugate',
  ])) {
    return ExerciseFeedbackGuidance(
      firstHint: isEnglish
          ? 'If direct substitution produces an indeterminate form with radicals, multiply numerator and denominator by the conjugate of the radical expression.'
          : 'Se a substituição direta produzir uma indeterminação com radicais, multiplique numerador e denominador pelo conjugado da expressão radical.',
      nextStep: isEnglish
          ? 'Use the difference-of-squares identity created by the conjugate, simplify the common factor, and only then evaluate the limit.'
          : 'Use a diferença de quadrados criada pelo conjugado, simplifique o fator comum e só então avalie o limite.',
      isSpecific: true,
    );
  }

  if (_containsAny(normalized, const [
    'fatoracao',
    'factorization',
    'factoring',
  ])) {
    return ExerciseFeedbackGuidance(
      firstHint: isEnglish
          ? 'If substitution gives 0/0, look for a factorization that exposes a common factor between numerator and denominator.'
          : 'Se a substituição resultar em 0/0, procure uma fatoração que revele um fator comum entre numerador e denominador.',
      nextStep: isEnglish
          ? 'Cancel only factors, never isolated terms. After simplification, evaluate the equivalent expression near the target point.'
          : 'Cancele apenas fatores, nunca termos isolados. Depois da simplificação, avalie a expressão equivalente perto do ponto-alvo.',
      isSpecific: true,
    );
  }

  if (_containsAny(normalized, const [
    'substituicao direta',
    'direct substitution',
  ])) {
    return ExerciseFeedbackGuidance(
      firstHint: isEnglish
          ? 'First substitute the target value exactly as written and classify the result before choosing another technique.'
          : 'Primeiro substitua o valor-alvo exatamente como está indicado e classifique o resultado antes de escolher outra técnica.',
      nextStep: isEnglish
          ? 'If the result is a finite real number, that usually settles the limit for a continuous expression; if it is indeterminate, switch techniques.'
          : 'Se o resultado for um número real finito, isso normalmente resolve o limite para uma expressão contínua; se houver indeterminação, troque de técnica.',
      isSpecific: true,
    );
  }

  if (_containsAny(normalized, const [
    'dominio de funcao racional',
    'domain of rational',
  ])) {
    return ExerciseFeedbackGuidance(
      firstHint: isEnglish
          ? 'For a rational function, start by finding where the denominator becomes zero.'
          : 'Em uma função racional, comece identificando onde o denominador se torna zero.',
      nextStep: isEnglish
          ? 'Those excluded points are outside the domain, so continuity cannot hold there. Analyze continuity only where the function is defined.'
          : 'Esses pontos ficam fora do domínio, portanto a continuidade não pode valer neles. Analise continuidade apenas onde a função está definida.',
      isSpecific: true,
    );
  }

  if (_containsAny(normalized, const [
    'tres condicoes',
    'three conditions',
    'continuidade em um ponto',
    'continuity at a point',
  ])) {
    return ExerciseFeedbackGuidance(
      firstHint: isEnglish
          ? 'Check continuity in three separate questions: is f(a) defined, does the limit as x approaches a exist, and do both values agree?'
          : 'Verifique a continuidade em três perguntas separadas: f(a) está definida, o limite quando x tende a a existe e os dois valores coincidem?',
      nextStep: isEnglish
          ? 'A failure in any one of the three conditions is enough to conclude that the function is not continuous at that point.'
          : 'A falha em qualquer uma das três condições já é suficiente para concluir que a função não é contínua naquele ponto.',
      isSpecific: true,
    );
  }

  if (_containsAny(normalized, const [
    'funcao por partes',
    'piecewise',
  ])) {
    return ExerciseFeedbackGuidance(
      firstHint: isEnglish
          ? 'At the transition point of a piecewise function, evaluate the left-hand and right-hand limits using the corresponding formulas.'
          : 'No ponto de transição de uma função definida por partes, calcule os limites laterais usando a fórmula correspondente a cada lado.',
      nextStep: isEnglish
          ? 'Then compare both one-sided limits with the actual function value at the transition point.'
          : 'Depois compare os dois limites laterais com o valor real da função no ponto de transição.',
      isSpecific: true,
    );
  }

  if (_containsAny(normalized, const [
    'familias de funcoes continuas',
    'families of continuous functions',
  ])) {
    return ExerciseFeedbackGuidance(
      firstHint: isEnglish
          ? 'Identify the function family first. Polynomials, for example, are continuous for every real input.'
          : 'Identifique primeiro a família da função. Polinômios, por exemplo, são contínuos para toda entrada real.',
      nextStep: isEnglish
          ? 'For quotients, roots and compositions, also check domain restrictions before applying the continuity rules.'
          : 'Para quocientes, raízes e composições, verifique também as restrições de domínio antes de aplicar as regras de continuidade.',
      isSpecific: true,
    );
  }

  if (_containsAny(normalized, const [
    'regra da potencia',
    'power rule',
  ])) {
    return ExerciseFeedbackGuidance(
      firstHint: isEnglish
          ? 'For a power xⁿ, bring the exponent down as a multiplier.'
          : 'Para uma potência xⁿ, traga o expoente para a frente como multiplicador.',
      nextStep: isEnglish
          ? 'Then reduce the original exponent by one. Apply constants and signs separately.'
          : 'Depois diminua o expoente original em uma unidade. Trate constantes e sinais separadamente.',
      isSpecific: true,
    );
  }

  if (_containsAny(normalized, const [
    'derivacao termo a termo',
    'term-by-term differentiation',
  ])) {
    return ExerciseFeedbackGuidance(
      firstHint: isEnglish
          ? 'Differentiate each term independently; sums and differences let you apply the derivative term by term.'
          : 'Derive cada termo de forma independente; somas e diferenças permitem aplicar a derivada termo a termo.',
      nextStep: isEnglish
          ? 'Use the appropriate rule on each term and remember that the derivative of a constant is zero.'
          : 'Use a regra adequada em cada termo e lembre que a derivada de uma constante é zero.',
      isSpecific: true,
    );
  }

  if (_containsAny(normalized, const [
    'regra do produto',
    'product rule',
  ])) {
    return ExerciseFeedbackGuidance(
      firstHint: isEnglish
          ? 'For a product u·v, do not differentiate both factors at once. Keep one factor while differentiating the other.'
          : 'Em um produto u·v, não derive os dois fatores ao mesmo tempo. Mantenha um fator enquanto deriva o outro.',
      nextStep: isEnglish
          ? 'Build u′v + uv′, then simplify. Check that both contributions are present.'
          : 'Monte u′v + uv′ e depois simplifique. Confira se as duas parcelas estão presentes.',
      isSpecific: true,
    );
  }

  if (_containsAny(normalized, const [
    'regra do quociente',
    'quotient rule',
  ])) {
    return ExerciseFeedbackGuidance(
      firstHint: isEnglish
          ? 'For u/v, identify numerator and denominator before differentiating.'
          : 'Em u/v, identifique numerador e denominador antes de derivar.',
      nextStep: isEnglish
          ? 'Use (u′v − uv′)/v² and keep the subtraction order. Only simplify after assembling the full expression.'
          : 'Use (u′v − uv′)/v² e preserve a ordem da subtração. Só simplifique depois de montar a expressão completa.',
      isSpecific: true,
    );
  }

  if (_containsAny(normalized, const [
    'regra da cadeia',
    'chain rule',
  ])) {
    return ExerciseFeedbackGuidance(
      firstHint: isEnglish
          ? 'Identify the outer function and the inner function before differentiating.'
          : 'Identifique a função externa e a função interna antes de derivar.',
      nextStep: isEnglish
          ? 'Differentiate the outer function while keeping the inner expression, then multiply by the derivative of the inner function.'
          : 'Derive a função externa mantendo a expressão interna e depois multiplique pela derivada da função interna.',
      isSpecific: true,
    );
  }

  if (_containsAny(normalized, const [
    'reta tangente',
    'tangent line',
  ])) {
    return ExerciseFeedbackGuidance(
      firstHint: isEnglish
          ? 'The derivative at the point gives the slope of the tangent line.'
          : 'A derivada no ponto fornece a inclinação da reta tangente.',
      nextStep: isEnglish
          ? 'Find the point on the curve and the derivative value there, then use the point-slope form of a line.'
          : 'Encontre o ponto da curva e o valor da derivada nele; depois use a forma ponto-inclinação da reta.',
      isSpecific: true,
    );
  }

  if (_containsAny(normalized, const [
    'taxa de variacao',
    'rate of change',
  ])) {
    return ExerciseFeedbackGuidance(
      firstHint: isEnglish
          ? 'Translate the derivative into the quantity that is changing and keep track of the units.'
          : 'Traduza a derivada para a grandeza que está variando e acompanhe as unidades.',
      nextStep: isEnglish
          ? 'Evaluate the derivative at the requested input and interpret its sign and units in the context of the problem.'
          : 'Avalie a derivada na entrada solicitada e interprete o sinal e as unidades no contexto do problema.',
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
