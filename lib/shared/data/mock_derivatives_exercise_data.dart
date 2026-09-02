import 'package:calcquest/shared/data/mock_exercise_data.dart';

const List<ExerciseData> mockDerivativesExercises = [
  ExerciseData(
    id: 'derivada-significado',
    title: 'Questão 1 de 20',
    contentLessonId: 'derivadas-01-significado',
    skill: 'Interpretação geométrica da derivada',
    statement:
        'Qual é a principal interpretação geométrica da derivada f\'(a)?',
    correctOptionId: 'b',
    explanation:
        'A derivada f′(a) é o limite das inclinações das retas secantes quando o segundo ponto se aproxima de a. Geometricamente, esse limite fornece a inclinação da reta tangente ao gráfico em (a,f(a)); em aplicações, representa uma taxa instantânea.',
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
    contentLessonId: 'derivadas-02-regras-basicas',
    skill: 'Regra da potência',
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
    contentLessonId: 'derivadas-02-regras-basicas',
    skill: 'Derivação termo a termo',
    statement: 'Calcule a derivada de f(x) = 5x² - 3x + 4.',
    correctOptionId: 'a',
    explanation:
        'Use a linearidade e derive cada termo: (5x²)′=5·2x=10x; (−3x)′=−3; e a constante 4 tem derivada zero porque não varia. Somando as taxas, obtemos f′(x)=10x−3.',
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
    contentLessonId: 'derivadas-02-regras-basicas',
    skill: 'Derivada de constante',
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
    contentLessonId: 'derivadas-02-regras-basicas',
    skill: 'Derivada da função identidade',
    statement: 'Se f(x) = x, qual é o valor de f\'(x)?',
    correctOptionId: 'b',
    explanation:
        'Na função f(x)=x, cada aumento Δx na entrada produz o mesmo aumento Δx na saída. A razão Δf/Δx é sempre 1; portanto, a reta possui inclinação constante e f′(x)=1 em todo ponto.',
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
    contentLessonId: 'derivadas-02-regras-basicas',
    skill: 'Potência com expoente fracionário',
    difficulty: ExerciseDifficulty.intermediate,
    statement: 'Para x > 0, qual é a derivada de f(x) = √x?',
    correctOptionId: 'c',
    explanation:
        'Reescreva √x como x¹ᐟ². Pela regra da potência, o expoente 1/2 desce multiplicando e diminui uma unidade: (1/2)x⁻¹ᐟ². Como x⁻¹ᐟ²=1/√x, resulta f′(x)=1/(2√x), válida para x>0.',
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
    contentLessonId: 'derivadas-02-regras-basicas',
    skill: 'Potência com expoente negativo',
    difficulty: ExerciseDifficulty.intermediate,
    statement: 'Para x ≠ 0, qual é a derivada de f(x) = 1/x?',
    correctOptionId: 'a',
    explanation:
        'Como 1/x=x⁻¹, use a regra da potência: o expoente −1 desce multiplicando e diminui uma unidade. Assim, (x⁻¹)\'=−x⁻²=−1/x². O sinal negativo mostra que 1/x decresce em cada intervalo do domínio.',
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
    contentLessonId: 'derivadas-03-produto-quociente',
    skill: 'Produto ou expansão algébrica',
    difficulty: ExerciseDifficulty.intermediate,
    statement: 'Calcule a derivada de f(x) = x²(x + 1).',
    correctOptionId: 'd',
    explanation:
        'Você pode expandir antes: x²(x+1)=x³+x², então f′(x)=3x²+2x. Pela regra do produto, 2x(x+1)+x²·1 produz a mesma expressão. Essa conferência ajuda a detectar a alternativa que esqueceu uma parcela.',
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
    contentLessonId: 'derivadas-03-produto-quociente',
    skill: 'Simplificação antes de derivar',
    difficulty: ExerciseDifficulty.intermediate,
    statement: 'Para x ≠ 0, derive f(x) = (x² + 1)/x.',
    correctOptionId: 'b',
    explanation:
        'Separe o quociente preservando x≠0: (x²+1)/x=x+1/x=x+x⁻¹. Derive termo a termo: 1−x⁻². Portanto, f′(x)=1−1/x². Simplificar primeiro evita uma aplicação desnecessária da regra do quociente.',
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
    contentLessonId: 'derivadas-04-cadeia',
    skill: 'Regra da cadeia',
    difficulty: ExerciseDifficulty.intermediate,
    statement: 'Calcule a derivada de f(x) = (2x + 1)³.',
    correctOptionId: 'c',
    explanation:
        'Separe as camadas: a externa é u³ e a interna é u=2x+1. Derive a externa mantendo a interna, obtendo 3(2x+1)². Depois multiplique pela derivada interna 2. Logo, f′(x)=6(2x+1)².',
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
    contentLessonId: 'derivadas-05-elementares',
    skill: 'Derivada do seno',
    statement: 'Qual é a derivada de f(x) = sen(x)?',
    correctOptionId: 'a',
    explanation:
        'A taxa instantânea de sen(x) segue cos(x): quando o seno cresce mais rapidamente, o cosseno é positivo; nos máximos e mínimos do seno, o cosseno vale zero. Assim, d/dx[sen(x)]=cos(x).',
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
    contentLessonId: 'derivadas-05-elementares',
    skill: 'Derivada do cosseno',
    statement: 'Qual é a derivada de f(x) = cos(x)?',
    correctOptionId: 'd',
    explanation:
        'A derivada do cosseno é −sen(x). O sinal negativo registra que, partindo de x=0, o cosseno começa a diminuir enquanto o seno é positivo. Portanto, d/dx[cos(x)]=−sen(x).',
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
    contentLessonId: 'derivadas-05-elementares',
    skill: 'Derivada da exponencial natural',
    statement: 'Qual é a derivada de f(x) = eˣ?',
    correctOptionId: 'b',
    explanation:
        'A base e é definida de forma que a taxa instantânea de crescimento de eˣ seja igual ao próprio valor da função. Por isso, d/dx[eˣ]=eˣ, uma propriedade central em modelos de crescimento e decaimento.',
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
    contentLessonId: 'derivadas-05-elementares',
    skill: 'Derivada do logaritmo natural',
    statement: 'Para x > 0, qual é a derivada de f(x) = ln(x)?',
    correctOptionId: 'c',
    explanation:
        'Para x>0, o logaritmo natural possui derivada 1/x. A taxa é positiva, mas diminui conforme x cresce, coerente com um gráfico que continua aumentando e fica progressivamente menos inclinado.',
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
    contentLessonId: 'derivadas-06-tangente',
    skill: 'Inclinação da tangente em um ponto',
    statement:
        'Qual é a inclinação da reta tangente a f(x) = x² no ponto em que x = 2?',
    correctOptionId: 'a',
    explanation:
        'Primeiro derive a função: f\'(x)=2x. A inclinação da tangente no ponto pedido é o valor da derivada em x=2. Portanto, f\'(2)=2·2=4; a parábola sobe quatro unidades verticalmente por unidade horizontal naquele instante.',
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
    contentLessonId: 'derivadas-06-tangente',
    skill: 'Equação da reta tangente',
    difficulty: ExerciseDifficulty.challenge,
    statement: 'Qual é a reta tangente a f(x) = x² no ponto (1, 1)?',
    correctOptionId: 'c',
    explanation:
        'Derive f(x)=x² para obter f′(x)=2x. No ponto x=1, a inclinação é m=2 e o ponto dado é (1,1). Use a forma ponto-inclinação y−1=2(x−1) e simplifique: y=2x−1.',
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
    contentLessonId: 'derivadas-07-derivabilidade',
    skill: 'Localização de ponto crítico',
    difficulty: ExerciseDifficulty.intermediate,
    statement:
        'Em qual valor de x a função f(x) = x² - 4x possui derivada igual a zero?',
    correctOptionId: 'd',
    explanation:
        'Derive termo a termo: f\'(x)=2x−4. Um ponto crítico com tangente horizontal satisfaz f\'(x)=0. Resolva 2x−4=0, obtendo 2x=4 e x=2. Esse valor é candidato a extremo e deve ser analisado no contexto da função.',
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
    contentLessonId: 'derivadas-07-derivabilidade',
    skill: 'Relação entre derivabilidade e continuidade',
    statement:
        'Se uma função é derivável em x = a, o que obrigatoriamente podemos afirmar?',
    correctOptionId: 'b',
    explanation:
        'Se a derivada existe em a, a função necessariamente é contínua nesse ponto. A recíproca é falsa: continuidade não garante uma inclinação única, como mostra |x| em zero. Portanto, derivabilidade é uma condição mais forte.',
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
    contentLessonId: 'derivadas-07-derivabilidade',
    skill: 'Derivadas laterais em um canto',
    difficulty: ExerciseDifficulty.intermediate,
    statement: 'Por que f(x) = |x| não é derivável em x = 0?',
    correctOptionId: 'a',
    explanation:
        'Para x<0, |x|=−x e a inclinação é −1. Para x>0, |x|=x e a inclinação é 1. Como as derivadas laterais em zero são diferentes, não existe uma única reta tangente e f não é derivável nesse ponto, embora seja contínua.',
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
    contentLessonId: 'derivadas-08-aplicacoes',
    skill: 'Velocidade instantânea',
    difficulty: ExerciseDifficulty.challenge,
    statement:
        'A posição de um móvel é s(t) = t² + 3t, em metros. Qual é sua velocidade instantânea em t = 2 s?',
    correctOptionId: 'c',
    explanation:
        'A velocidade instantânea é a derivada da posição. Derive s(t)=t²+3t para obter v(t)=2t+3. Avalie no instante pedido: v(2)=2·2+3=7. Como posição está em metros e tempo em segundos, a unidade é m/s.',
    options: [
      ExerciseOptionData(id: 'a', text: '4 m/s'),
      ExerciseOptionData(id: 'b', text: '5 m/s'),
      ExerciseOptionData(id: 'c', text: '7 m/s'),
      ExerciseOptionData(id: 'd', text: '10 m/s'),
    ],
  ),
];
