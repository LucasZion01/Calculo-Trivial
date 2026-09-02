import 'package:calcquest/shared/data/mock_exercise_data.dart';

const List<ExerciseData> mockContinuityExercises = [
  ExerciseData(
    id: 'continuidade-tres-condicoes',
    title: 'Questão 1 de 20',
    contentLessonId: 'continuidade-01-significado',
    skill: 'Três condições de continuidade',
    statement:
        'Para uma função f ser contínua em x = a, quais condições devem ser satisfeitas?',
    correctOptionId: 'c',
    explanation:
        'Verifique na ordem: f(a) precisa estar definida; o limite bilateral lim x→a f(x) precisa existir; por fim, a tendência deve coincidir com o valor real, isto é, lim x→a f(x)=f(a). A falha de qualquer condição torna f descontínua em a.',
    options: [
      ExerciseOptionData(id: 'a', text: 'Somente f(a) deve existir'),
      ExerciseOptionData(id: 'b', text: 'Somente o limite deve existir'),
      ExerciseOptionData(
        id: 'c',
        text: 'f(a) existe, o limite existe e lim x → a f(x) = f(a)',
      ),
      ExerciseOptionData(id: 'd', text: 'A derivada de f deve ser zero'),
    ],
  ),
  ExerciseData(
    id: 'continuidade-polinomial',
    title: 'Questão 2 de 20',
    contentLessonId: 'continuidade-02-dominio',
    skill: 'Famílias de funções contínuas',
    statement: 'Em quais números reais f(x) = 3x² - 2x + 5 é contínua?',
    correctOptionId: 'a',
    explanation:
        'Polinômios são formados por somas e produtos de potências inteiras não negativas de x, operações que preservam continuidade. Como não há denominadores ou raízes que restrinjam o domínio, f é contínua em todo ℝ.',
    options: [
      ExerciseOptionData(id: 'a', text: 'Em todos os números reais'),
      ExerciseOptionData(id: 'b', text: 'Somente para x > 0'),
      ExerciseOptionData(id: 'c', text: 'Somente para x ≠ 0'),
      ExerciseOptionData(id: 'd', text: 'Somente nos números inteiros'),
    ],
  ),
  ExerciseData(
    id: 'continuidade-racional-dominio',
    title: 'Questão 3 de 20',
    contentLessonId: 'continuidade-02-dominio',
    skill: 'Domínio de função racional',
    statement: 'Onde a função f(x) = (x + 1) / (x - 2) não é contínua?',
    correctOptionId: 'b',
    explanation:
        'Uma função racional é contínua em todos os pontos de seu domínio. Resolva x−2=0 e obtenha x=2; nesse ponto, a divisão não está definida. Portanto, os intervalos de continuidade são (−∞,2) e (2,+∞).',
    options: [
      ExerciseOptionData(id: 'a', text: 'x = -1'),
      ExerciseOptionData(id: 'b', text: 'x = 2'),
      ExerciseOptionData(id: 'c', text: 'x = 0'),
      ExerciseOptionData(id: 'd', text: 'Ela é contínua em todo ℝ'),
    ],
  ),
  ExerciseData(
    id: 'continuidade-furo-corrigido',
    title: 'Questão 4 de 20',
    contentLessonId: 'continuidade-05-parametros',
    skill: 'Correção de descontinuidade removível',
    difficulty: ExerciseDifficulty.intermediate,
    statement:
        'Considere f(x) = (x² - 1)/(x - 1), se x ≠ 1, e f(1) = 2. A função é contínua em x = 1?',
    correctOptionId: 'a',
    explanation:
        'Fatore x²−1=(x−1)(x+1). Para x próximo de 1 e diferente de 1, a expressão equivale a x+1, cujo limite é 2. Como f(1) foi definido como 2, valor e limite coincidem; as três condições são satisfeitas.',
    options: [
      ExerciseOptionData(id: 'a', text: 'Sim, pois o limite e f(1) valem 2'),
      ExerciseOptionData(id: 'b', text: 'Não, pois o limite vale 0'),
      ExerciseOptionData(id: 'c', text: 'Não, pois f(1) não existe'),
      ExerciseOptionData(
        id: 'd',
        text: 'Sim, pois toda função racional é contínua',
      ),
    ],
  ),
  ExerciseData(
    id: 'continuidade-furo-nao-corrigido',
    title: 'Questão 5 de 20',
    contentLessonId: 'continuidade-03-descontinuidades',
    skill: 'Classificação de furo removível',
    difficulty: ExerciseDifficulty.intermediate,
    statement:
        'Considere f(x) = (x² - 1)/(x - 1), se x ≠ 1, e f(1) = 3. Que tipo de descontinuidade ocorre em x = 1?',
    correctOptionId: 'd',
    explanation:
        'A expressão simplificada x+1 mostra que o limite em 1 existe e vale 2. Entretanto, o valor definido é f(1)=3. Como apenas o valor no ponto impede a igualdade, a descontinuidade é removível: redefinir f(1)=2 seria suficiente.',
    options: [
      ExerciseOptionData(id: 'a', text: 'Nenhuma; a função é contínua'),
      ExerciseOptionData(id: 'b', text: 'Descontinuidade infinita'),
      ExerciseOptionData(id: 'c', text: 'Descontinuidade de salto'),
      ExerciseOptionData(id: 'd', text: 'Descontinuidade removível'),
    ],
  ),
  ExerciseData(
    id: 'continuidade-partes-simples',
    title: 'Questão 6 de 20',
    contentLessonId: 'continuidade-04-partes',
    skill: 'Encontro de funções por partes',
    difficulty: ExerciseDifficulty.intermediate,
    statement:
        'Se f(x) = x + 1 para x < 1 e f(x) = 2x para x ≥ 1, f é contínua em x = 1?',
    correctOptionId: 'b',
    explanation:
        'Use x+1 pela esquerda: o limite é 2. Use 2x pela direita: o limite também é 2. A segunda regra inclui x=1, então f(1)=2. Como limite esquerdo, limite direito e valor no ponto coincidem, f é contínua.',
    options: [
      ExerciseOptionData(
        id: 'a',
        text: 'Não, pois os limites laterais não existem',
      ),
      ExerciseOptionData(
        id: 'b',
        text: 'Sim, pois os dois limites e f(1) valem 2',
      ),
      ExerciseOptionData(id: 'c', text: 'Não, pois f(1) = 1'),
      ExerciseOptionData(id: 'd', text: 'Sim, pois f(1) = 0'),
    ],
  ),
  ExerciseData(
    id: 'continuidade-salto',
    title: 'Questão 7 de 20',
    contentLessonId: 'continuidade-03-descontinuidades',
    skill: 'Descontinuidade de salto',
    statement:
        'Se f(x) = -1 para x < 0 e f(x) = 1 para x ≥ 0, o que ocorre em x = 0?',
    correctOptionId: 'c',
    explanation:
        'Ao aproximar-se de zero pela esquerda, a função permanece em −1. Pela direita, permanece em 1. Como os limites laterais são finitos, mas diferentes, o limite bilateral não existe e a ruptura é classificada como salto.',
    options: [
      ExerciseOptionData(id: 'a', text: 'A função é contínua'),
      ExerciseOptionData(id: 'b', text: 'Há uma descontinuidade removível'),
      ExerciseOptionData(id: 'c', text: 'Há uma descontinuidade de salto'),
      ExerciseOptionData(id: 'd', text: 'Há uma descontinuidade infinita'),
    ],
  ),
  ExerciseData(
    id: 'continuidade-infinita',
    title: 'Questão 8 de 20',
    contentLessonId: 'continuidade-03-descontinuidades',
    skill: 'Descontinuidade infinita',
    statement: 'Qual tipo de descontinuidade f(x) = 1/(x - 2) possui em x = 2?',
    correctOptionId: 'a',
    explanation:
        'Próximo de x = 2, os valores da função crescem sem limite em módulo. Existe uma assíntota vertical e a descontinuidade é infinita.',
    options: [
      ExerciseOptionData(id: 'a', text: 'Infinita'),
      ExerciseOptionData(id: 'b', text: 'Removível'),
      ExerciseOptionData(id: 'c', text: 'De salto finito'),
      ExerciseOptionData(id: 'd', text: 'Nenhuma'),
    ],
  ),
  ExerciseData(
    id: 'continuidade-modulo',
    title: 'Questão 9 de 20',
    contentLessonId: 'continuidade-02-dominio',
    skill: 'Continuidade em ponto anguloso',
    statement: 'A função f(x) = |x| é contínua em x = 0?',
    correctOptionId: 'd',
    explanation:
        'Uma ponta no gráfico não significa descontinuidade. Pela esquerda, |x|=−x e o limite é 0; pela direita, |x|=x e o limite também é 0. Como f(0)=0, as três condições são satisfeitas.',
    options: [
      ExerciseOptionData(
        id: 'a',
        text: 'Não, porque existe uma ponta no gráfico',
      ),
      ExerciseOptionData(id: 'b', text: 'Não, porque o limite vale 1'),
      ExerciseOptionData(id: 'c', text: 'Somente pela direita'),
      ExerciseOptionData(id: 'd', text: 'Sim'),
    ],
  ),
  ExerciseData(
    id: 'continuidade-parte-inteira',
    title: 'Questão 10 de 20',
    contentLessonId: 'continuidade-03-descontinuidades',
    skill: 'Saltos da função parte inteira',
    statement:
        'A função parte inteira f(x) = ⌊x⌋ apresenta qual comportamento nos números inteiros?',
    correctOptionId: 'b',
    explanation:
        'Ao atravessar um inteiro n, os valores pela esquerda permanecem em n−1, enquanto pela direita e no ponto valem n. Os limites laterais são finitos, porém diferentes, caracterizando uma descontinuidade de salto.',
    options: [
      ExerciseOptionData(id: 'a', text: 'É contínua em todos eles'),
      ExerciseOptionData(id: 'b', text: 'Possui descontinuidades de salto'),
      ExerciseOptionData(id: 'c', text: 'Possui somente furos removíveis'),
      ExerciseOptionData(id: 'd', text: 'Tende sempre ao infinito'),
    ],
  ),
  ExerciseData(
    id: 'continuidade-seno',
    title: 'Questão 11 de 20',
    contentLessonId: 'continuidade-02-dominio',
    skill: 'Continuidade de função trigonométrica',
    statement: 'Em qual conjunto a função f(x) = sen(x) é contínua?',
    correctOptionId: 'c',
    explanation:
        'A função seno está definida e é contínua para todo número real. Restringi-la a [0,2π] confundiria um período de repetição com seu domínio, que é ℝ.',
    options: [
      ExerciseOptionData(id: 'a', text: 'Somente em [0, 2π]'),
      ExerciseOptionData(id: 'b', text: 'Somente para x ≠ 0'),
      ExerciseOptionData(id: 'c', text: 'Em todo ℝ'),
      ExerciseOptionData(id: 'd', text: 'Somente nos múltiplos de π'),
    ],
  ),
  ExerciseData(
    id: 'continuidade-raiz',
    title: 'Questão 12 de 20',
    contentLessonId: 'continuidade-02-dominio',
    skill: 'Continuidade no domínio da raiz',
    statement: 'Em seu domínio real, onde f(x) = √x é contínua?',
    correctOptionId: 'a',
    explanation:
        'No conjunto real, √x exige x≥0. A função é contínua em todo esse domínio; no extremo x=0, a continuidade é verificada pela direita, pois valores negativos não pertencem ao domínio.',
    options: [
      ExerciseOptionData(id: 'a', text: '[0, +∞)'),
      ExerciseOptionData(id: 'b', text: '(-∞, 0]'),
      ExerciseOptionData(id: 'c', text: 'ℝ exceto 0'),
      ExerciseOptionData(id: 'd', text: 'Somente em x = 0'),
    ],
  ),
  ExerciseData(
    id: 'continuidade-composicao',
    title: 'Questão 13 de 20',
    contentLessonId: 'continuidade-02-dominio',
    skill: 'Composição de funções contínuas',
    difficulty: ExerciseDifficulty.intermediate,
    statement:
        'Se g é contínua em a e f é contínua em g(a), o que podemos afirmar sobre f(g(x)) em a?',
    correctOptionId: 'd',
    explanation:
        'Como g(x) se aproxima de g(a) quando x→a e f é contínua no valor g(a), podemos passar o limite pela função externa. Assim, lim x→a f(g(x))=f(g(a)), que é exatamente a condição de continuidade da composição.',
    options: [
      ExerciseOptionData(id: 'a', text: 'É sempre descontínua'),
      ExerciseOptionData(id: 'b', text: 'Seu limite é necessariamente zero'),
      ExerciseOptionData(id: 'c', text: 'Nada pode ser concluído'),
      ExerciseOptionData(id: 'd', text: 'É contínua em a'),
    ],
  ),
  ExerciseData(
    id: 'continuidade-valor-intermediario',
    title: 'Questão 14 de 20',
    contentLessonId: 'continuidade-06-valor-intermediario',
    skill: 'Teorema do Valor Intermediário',
    difficulty: ExerciseDifficulty.intermediate,
    statement:
        'Uma função f é contínua em [1, 2], com f(1) = -3 e f(2) = 4. O que o Teorema do Valor Intermediário garante?',
    correctOptionId: 'b',
    explanation:
        'A função é contínua em todo [1,2] e zero está entre f(1)=−3 e f(2)=4. Pelo Teorema do Valor Intermediário, existe pelo menos um c em (1,2) com f(c)=0. O teorema não garante que a raiz seja única nem que c=1,5.',
    options: [
      ExerciseOptionData(id: 'a', text: 'f é uma função linear'),
      ExerciseOptionData(id: 'b', text: 'Existe c em (1, 2) com f(c) = 0'),
      ExerciseOptionData(id: 'c', text: 'f possui exatamente uma raiz'),
      ExerciseOptionData(id: 'd', text: 'f(1,5) = 0 obrigatoriamente'),
    ],
  ),
  ExerciseData(
    id: 'continuidade-parametro-ponto',
    title: 'Questão 15 de 20',
    contentLessonId: 'continuidade-05-parametros',
    skill: 'Definição de valor para remover furo',
    statement:
        'Se f(x) = x² para x ≠ 2 e f(2) = k, qual valor de k torna f contínua em x = 2?',
    correctOptionId: 'c',
    explanation:
        'O limite de x² quando x tende a 2 é 4. Para haver continuidade, f(2) também precisa valer 4.',
    options: [
      ExerciseOptionData(id: 'a', text: '0'),
      ExerciseOptionData(id: 'b', text: '2'),
      ExerciseOptionData(id: 'c', text: '4'),
      ExerciseOptionData(id: 'd', text: '8'),
    ],
  ),
  ExerciseData(
    id: 'continuidade-parametro-partes',
    title: 'Questão 16 de 20',
    contentLessonId: 'continuidade-05-parametros',
    skill: 'Parâmetro em função por partes',
    difficulty: ExerciseDifficulty.challenge,
    statement:
        'Se f(x) = 2x + 1 para x < 1 e f(x) = x + k para x ≥ 1, qual valor de k torna f contínua em x = 1?',
    correctOptionId: 'a',
    explanation:
        'Calcule cada lado no ponto de troca. Pela esquerda, 2(1)+1=3. Pela direita e no ponto, a segunda regra fornece 1+k. Para os trechos se encontrarem, imponha 1+k=3 e resolva: k=2.',
    options: [
      ExerciseOptionData(id: 'a', text: '2'),
      ExerciseOptionData(id: 'b', text: '1'),
      ExerciseOptionData(id: 'c', text: '3'),
      ExerciseOptionData(id: 'd', text: '-2'),
    ],
  ),
  ExerciseData(
    id: 'continuidade-valor-indefinido',
    title: 'Questão 17 de 20',
    contentLessonId: 'continuidade-05-parametros',
    skill: 'Identificação de valor ausente',
    statement:
        'O limite lim x → a f(x) existe e é finito, mas f(a) não está definida. f é contínua em a?',
    correctOptionId: 'c',
    explanation:
        'Não. A primeira condição de continuidade exige que f(a) esteja definida. Nesse caso, normalmente há uma descontinuidade removível.',
    options: [
      ExerciseOptionData(id: 'a', text: 'Sim, pois basta o limite existir'),
      ExerciseOptionData(id: 'b', text: 'Sim, se a for positivo'),
      ExerciseOptionData(id: 'c', text: 'Não, pois f(a) precisa existir'),
      ExerciseOptionData(
        id: 'd',
        text: 'Não, pois o limite deveria ser infinito',
      ),
    ],
  ),
  ExerciseData(
    id: 'continuidade-extremo-intervalo',
    title: 'Questão 18 de 20',
    contentLessonId: 'continuidade-04-partes',
    skill: 'Continuidade unilateral em extremo',
    statement:
        'Para verificar a continuidade de f no extremo esquerdo a de um intervalo fechado [a, b], qual limite é usado?',
    correctOptionId: 'd',
    explanation:
        'No extremo esquerdo a, não existem pontos do domínio [a,b] menores que a. Portanto, a aproximação relevante usa valores maiores que a, isto é, o limite pela direita, que deve coincidir com f(a).',
    options: [
      ExerciseOptionData(id: 'a', text: 'Somente o limite pela esquerda'),
      ExerciseOptionData(id: 'b', text: 'Nenhum limite'),
      ExerciseOptionData(id: 'c', text: 'Sempre um limite no infinito'),
      ExerciseOptionData(id: 'd', text: 'O limite pela direita'),
    ],
  ),
  ExerciseData(
    id: 'continuidade-removivel-conceito',
    title: 'Questão 19 de 20',
    contentLessonId: 'continuidade-03-descontinuidades',
    skill: 'Reparação de descontinuidade removível',
    statement: 'Quando uma descontinuidade é chamada de removível?',
    correctOptionId: 'a',
    explanation:
        'Ela é removível quando o limite no ponto existe e é finito, permitindo corrigir a função apenas redefinindo seu valor naquele ponto.',
    options: [
      ExerciseOptionData(
        id: 'a',
        text: 'Quando redefinir o valor no ponto pode tornar a função contínua',
      ),
      ExerciseOptionData(
        id: 'b',
        text: 'Quando os limites laterais são diferentes',
      ),
      ExerciseOptionData(id: 'c', text: 'Quando existe uma assíntota vertical'),
      ExerciseOptionData(id: 'd', text: 'Quando a função não possui domínio'),
    ],
  ),
  ExerciseData(
    id: 'continuidade-inversa-dominio',
    title: 'Questão 20 de 20',
    contentLessonId: 'continuidade-07-sintese',
    skill: 'Roteiro completo de domínio e continuidade',
    difficulty: ExerciseDifficulty.challenge,
    statement: 'Em quais intervalos f(x) = 1/x é contínua?',
    correctOptionId: 'b',
    explanation:
        'Comece pelo domínio: 1/x não está definida em x=0. Como funções racionais são contínuas onde o denominador não zera, separe o domínio nesse ponto. Assim, os intervalos máximos de continuidade são (−∞,0) e (0,+∞).',
    options: [
      ExerciseOptionData(id: 'a', text: 'Somente em (0, +∞)'),
      ExerciseOptionData(id: 'b', text: 'Em (-∞, 0) e (0, +∞)'),
      ExerciseOptionData(id: 'c', text: 'Em todo ℝ'),
      ExerciseOptionData(id: 'd', text: 'Somente em x = 1'),
    ],
  ),
];
