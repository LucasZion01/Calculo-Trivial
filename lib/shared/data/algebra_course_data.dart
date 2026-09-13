import 'package:calcquest/shared/domain/course_lesson_data.dart';

const List<CourseLessonData> algebraCourseLessons = [
  CourseLessonData(
    id: 'algebra-01-linguagem',
    topicId: 'algebra-fundamental',
    trailTitle: 'Álgebra Fundamental',
    eyebrow: 'Fundamentos',
    title: 'A linguagem da Álgebra',
    description: 'variáveis, constantes e expressões',
    duration: '≈ 5 min',
    objective:
        'interpretar letras como números variáveis e reconhecer a estrutura de uma expressão algébrica',
    symbol: 'x',
    sections: [
      LessonSectionData(
        number: '1',
        title: 'Entenda a ideia',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.notation,
            title: 'A variável guarda uma possibilidade',
            content:
                'Quando escrevemos 3x + 2, a letra x representa um número que pode variar. A expressão não pede uma resposta única; ela descreve uma regra que produz valores diferentes conforme x muda.',
            emphasis:
                'Em Cálculo, quase tudo começa assim: uma quantidade varia e outra responde a essa variação.',
          ),
        ],
      ),
      LessonSectionData(
        number: '2',
        title: 'Veja funcionando',
        blocks: [
          WorkedExampleBlockData(
            title: 'Valor numérico sem mistério',
            problem: 'Calcule 2x² − 3x + 1 para x = 4.',
            steps: [
              'Substitua x por 4: 2(4)² − 3(4) + 1.',
              'Resolva a potência antes da multiplicação: 2·16 − 12 + 1.',
              'Calcule da esquerda para a direita: 32 − 12 + 1 = 21.',
            ],
            result: 'O valor numérico é 21.',
            interpretation:
                'A expressão é a mesma, mas o valor aparece quando escolhemos uma entrada.',
          ),
        ],
      ),
    ],
    check: LessonCheckData(
      question: 'Na expressão 5a² − 7, qual parte varia?',
      choices: ['O número 5', 'A letra a', 'O número −7'],
      correctIndex: 1,
      explanation: 'A letra a é a variável. Os números 5 e −7 são constantes.',
    ),
    takeaways: [
      'Variável representa um número que pode mudar.',
      'Coeficientes multiplicam partes literais.',
      'Substituir um valor na variável produz um valor numérico.',
      'A ordem das operações evita leituras erradas.',
    ],
    closing:
        'Entender a linguagem algébrica transforma símbolos em instruções claras.',
  ),
  CourseLessonData(
    id: 'algebra-02-termos-semelhantes',
    topicId: 'algebra-fundamental',
    trailTitle: 'Álgebra Fundamental',
    eyebrow: 'Fundamentos',
    title: 'Termos semelhantes',
    description: 'coeficientes, constantes e redução',
    duration: '≈ 5 min',
    objective:
        'simplificar somas e subtrações combinando apenas termos com a mesma parte literal',
    symbol: '3x',
    sections: [
      LessonSectionData(
        number: '1',
        title: 'Entenda a ideia',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.compare,
            title: 'Só combina quem é da mesma família',
            content:
                'Termos semelhantes possuem exatamente a mesma parte literal, com as mesmas variáveis e os mesmos expoentes. Por isso 4x e −7x podem ser combinados, mas 4x e 4x² não podem.',
            emphasis:
                'A regra é simples: some os coeficientes e preserve a parte literal.',
          ),
        ],
      ),
      LessonSectionData(
        number: '2',
        title: 'Veja funcionando',
        blocks: [
          WorkedExampleBlockData(
            title: 'Agrupando com cuidado',
            problem: 'Simplifique 6x² − 3x + 5x² + 8x − 4.',
            steps: [
              'Agrupe os termos x²: 6x² + 5x² = 11x².',
              'Agrupe os termos x: −3x + 8x = 5x.',
              'A constante −4 permanece como está.',
            ],
            result: 'A forma simplificada é 11x² + 5x − 4.',
            interpretation:
                'Nenhum termo mudou de natureza; apenas juntamos partes compatíveis.',
          ),
        ],
      ),
    ],
    check: LessonCheckData(
      question: 'Qual expressão é equivalente a 2x + 5x − 3?',
      choices: ['7x − 3', '10x − 3', '4x'],
      correctIndex: 0,
      explanation:
          'Somamos apenas 2x e 5x, obtendo 7x. A constante −3 permanece.',
    ),
    takeaways: [
      'Termos semelhantes têm a mesma parte literal.',
      'Expoentes diferentes impedem a combinação.',
      'Constantes combinam apenas com constantes.',
      'Escrever por grupos deixa a conta mais segura.',
    ],
    closing:
        'Dominar termos semelhantes deixa equações, funções e derivadas muito mais leves.',
  ),
  CourseLessonData(
    id: 'algebra-03-distributiva',
    topicId: 'algebra-fundamental',
    trailTitle: 'Álgebra Fundamental',
    eyebrow: 'Fundamentos',
    title: 'Distributiva e sinais',
    description: 'parênteses, produtos e sinais negativos',
    duration: '≈ 5 min',
    objective:
        'aplicar a propriedade distributiva sem perder sinais dentro dos parênteses',
    symbol: 'a(b+c)',
    sections: [
      LessonSectionData(
        number: '1',
        title: 'Entenda a ideia',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.transform,
            title: 'Distribuir é atravessar o parêntese',
            content:
                'Na forma a(b + c), o fator a multiplica cada termo interno. Assim, a(b + c) = ab + ac. Se houver subtração, o sinal do termo também participa da multiplicação.',
            emphasis:
                'O erro clássico é multiplicar apenas o primeiro termo e esquecer o segundo.',
          ),
        ],
      ),
      LessonSectionData(
        number: '2',
        title: 'Veja funcionando',
        blocks: [
          WorkedExampleBlockData(
            title: 'Parêntese com sinal negativo',
            problem: 'Simplifique −2(x − 5) + 3x.',
            steps: [
              'Distribua −2: −2x + 10.',
              'Some o termo restante: −2x + 10 + 3x.',
              'Combine termos semelhantes: x + 10.',
            ],
            result: 'A expressão simplificada é x + 10.',
            interpretation:
                'O termo −5 virou +10 porque negativo vezes negativo é positivo.',
          ),
        ],
      ),
    ],
    check: LessonCheckData(
      question: 'Qual é a forma de 3(x − 4)?',
      choices: ['3x − 4', '3x − 12', 'x − 12'],
      correctIndex: 1,
      explanation: 'O 3 multiplica x e também −4, então 3(x − 4) = 3x − 12.',
    ),
    takeaways: [
      'Distributiva conecta multiplicação e soma.',
      'Todos os termos internos devem ser multiplicados.',
      'Sinais negativos precisam ser carregados com atenção.',
      'Depois da distributiva, reduza termos semelhantes.',
    ],
    closing:
        'A distributiva é uma das ferramentas mais usadas para preparar expressões antes do Cálculo.',
  ),
  CourseLessonData(
    id: 'algebra-04-potencias',
    topicId: 'algebra-fundamental',
    trailTitle: 'Álgebra Fundamental',
    eyebrow: 'Fundamentos',
    title: 'Potências e expoentes',
    description: 'regras de multiplicação e divisão',
    duration: '≈ 5 min',
    objective:
        'usar propriedades de potências para simplificar monômios e expressões algébricas',
    symbol: 'x²',
    sections: [
      LessonSectionData(
        number: '1',
        title: 'Entenda a ideia',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.calculate,
            title: 'Mesma base, regra certa',
            content:
                'Em produtos de potências de mesma base, somamos expoentes: x²·x³ = x⁵. Em quocientes, subtraímos expoentes, desde que a base não seja zero: x⁵/x² = x³.',
            emphasis: 'Não some bases. O que muda é o expoente.',
          ),
        ],
      ),
      LessonSectionData(
        number: '2',
        title: 'Veja funcionando',
        blocks: [
          WorkedExampleBlockData(
            title: 'Coeficiente e variável',
            problem: 'Simplifique (−2x³)².',
            steps: [
              'Eleve o coeficiente: (−2)² = 4.',
              'Multiplique o expoente da variável: (x³)² = x⁶.',
              'Junte as partes: 4x⁶.',
            ],
            result: 'A forma simplificada é 4x⁶.',
            interpretation:
                'O quadrado torna o coeficiente positivo e dobra o expoente da variável.',
          ),
        ],
      ),
    ],
    check: LessonCheckData(
      question: 'Qual é o resultado de x⁴·x²?',
      choices: ['x⁶', 'x⁸', '2x⁶'],
      correctIndex: 0,
      explanation:
          'As bases são iguais, então somamos os expoentes: 4 + 2 = 6.',
    ),
    takeaways: [
      'Produto de mesma base soma expoentes.',
      'Quociente de mesma base subtrai expoentes.',
      'Potência de potência multiplica expoentes.',
      'Coeficientes também seguem as regras de sinais.',
    ],
    closing:
        'Potências bem dominadas simplificam polinômios, funções e limites.',
  ),
  CourseLessonData(
    id: 'algebra-09-monomios-polinomios',
    topicId: 'algebra-fundamental',
    trailTitle: 'Álgebra Fundamental',
    eyebrow: 'Fundamentos',
    title: 'Monômios e polinômios',
    description: 'termos, coeficientes, grau e classificação',
    duration: '≈ 10 min',
    objective:
        'reconhecer monômios e polinômios, identificar seus elementos, classificá-los e determinar seus graus',
    symbol: 'P(x)',
    sections: [
      LessonSectionData(
        number: '1',
        title: 'Entenda a estrutura',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.notation,
            title: 'Um polinômio é formado por termos',
            content:
                'Expressões como 4x³ − 2x + 7 são formadas por termos separados por adição ou subtração. Cada termo pode conter um coeficiente numérico e uma parte literal formada por variáveis elevadas a expoentes inteiros não negativos.',
            emphasis:
                'Antes de operar com polinômios, é preciso saber reconhecer exatamente quais são seus termos e como cada termo é construído.',
          ),
          ConceptBlockData(
            visual: LessonVisual.notation,
            title: 'Coeficiente e parte literal',
            content:
                'No monômio −5x²y, o coeficiente é −5 e a parte literal é x²y. Se não aparece número escrito antes da parte literal, o coeficiente pode ser 1 ou −1, dependendo do sinal.',
            emphasis: 'Em x³, o coeficiente é 1. Em −x², o coeficiente é −1.',
          ),
        ],
      ),
      LessonSectionData(
        number: '2',
        title: 'Classifique corretamente',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.checklist,
            title: 'Monômio, binômio, trinômio e polinômio',
            content:
                'Uma expressão com um único termo é um monômio. Com dois termos, é um binômio. Com três termos, é um trinômio. A palavra polinômio é usada de forma geral para expressões formadas por um ou mais termos polinomiais.',
            emphasis: '3x² é monômio; x + 4 é binômio; x² − 3x + 2 é trinômio.',
          ),
        ],
      ),
      LessonSectionData(
        number: '3',
        title: 'Determine o grau',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.notation,
            title: 'Grau de um monômio',
            content:
                'O grau de um monômio é a soma dos expoentes de suas variáveis. Em 4x³y², o grau é 3 + 2 = 5.',
            emphasis: 'Uma constante não nula, como 7, tem grau 0.',
          ),
          ConceptBlockData(
            visual: LessonVisual.notation,
            title: 'Grau de um polinômio',
            content:
                'O grau de um polinômio é o maior grau entre seus termos depois que termos semelhantes já foram combinados.',
            emphasis:
                'Em 2x⁴ − 3x² + x − 9, o maior expoente de x é 4; portanto, o polinômio tem grau 4.',
          ),
        ],
      ),
      LessonSectionData(
        number: '4',
        title: 'Veja funcionando',
        blocks: [
          WorkedExampleBlockData(
            title: 'Analisando um polinômio completo',
            problem: 'Analise 3x³ − 5x² + 2x − 8.',
            steps: [
              'Identifique os termos: 3x³, −5x², 2x e −8.',
              'Identifique os coeficientes: 3, −5, 2 e −8.',
              'Conte os termos: existem quatro termos.',
              'Compare os graus: 3, 2, 1 e 0.',
              'O maior grau é 3.',
            ],
            result: 'É um polinômio de grau 3 com quatro termos.',
            interpretation:
                'Reconhecer essa estrutura será essencial para somar, multiplicar, fatorar e estudar funções polinomiais.',
          ),
        ],
      ),
      LessonSectionData(
        number: '5',
        title: 'Forma reduzida e ordenada',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.checklist,
            title: 'Primeiro reduza, depois organize',
            content:
                'Um polinômio está na forma reduzida quando não há termos semelhantes que ainda possam ser combinados. Ele costuma ser escrito em ordem decrescente de grau para facilitar leitura e operações.',
            emphasis:
                '2x + 3x² − x + 4 pode ser reduzido e ordenado como 3x² + x + 4.',
          ),
        ],
      ),
      LessonSectionData(
        number: '6',
        title: 'Erro comum',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.warning,
            title: 'Nem toda expressão algébrica é um polinômio',
            content:
                'Expressões com variável no denominador, expoente negativo ou variável dentro de uma raiz não são polinômios na variável considerada.',
            emphasis: '1/x, x⁻² e √x não são polinômios em x.',
          ),
        ],
      ),
    ],
    check: LessonCheckData(
      question: 'Qual é o grau do polinômio 5x⁴ − 2x² + 7x − 3?',
      choices: ['2', '3', '4'],
      correctIndex: 2,
      explanation:
          'O grau do polinômio é o maior expoente presente após a expressão estar reduzida. O maior expoente é 4.',
    ),
    takeaways: [
      'Monômios possuem um único termo.',
      'Coeficiente é a parte numérica do termo.',
      'O grau de um monômio é a soma dos expoentes de suas variáveis.',
      'O grau de um polinômio é o maior grau entre seus termos.',
      'Polinômios devem ser reduzidos e podem ser organizados por grau.',
      'Nem toda expressão algébrica é um polinômio.',
    ],
    closing:
        'Agora que você reconhece a estrutura dos polinômios, o próximo passo é aprender a operar com eles.',
  ),
  CourseLessonData(
    id: 'algebra-10-operacoes-polinomios',
    topicId: 'algebra-fundamental',
    trailTitle: 'Álgebra Fundamental',
    eyebrow: 'Fundamentos',
    title: 'Operações com polinômios',
    description: 'soma, subtração e multiplicação',
    duration: '≈ 12 min',
    objective:
        'somar, subtrair e multiplicar polinômios usando termos semelhantes, distributiva e propriedades de potências',
    symbol: 'P(x)+Q(x)',
    sections: [
      LessonSectionData(
        number: '1',
        title: 'Somar e subtrair polinômios',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.compare,
            title: 'Combine apenas termos semelhantes',
            content:
                'Na soma ou subtração de polinômios, agrupamos apenas termos que possuem a mesma parte literal e os mesmos expoentes. Os coeficientes são somados ou subtraídos, enquanto a parte literal permanece.',
            emphasis:
                '3x² + 5x² = 8x², mas 3x² + 5x não pode ser reduzido a um único termo.',
          ),
          WorkedExampleBlockData(
            title: 'Somando dois polinômios',
            problem: 'Calcule (3x² + 2x − 4) + (x² − 5x + 7).',
            steps: [
              'Agrupe os termos de mesmo grau.',
              'Some os termos quadráticos: 3x² + x² = 4x².',
              'Some os termos lineares: 2x − 5x = −3x.',
              'Some as constantes: −4 + 7 = 3.',
            ],
            result: 'O resultado é 4x² − 3x + 3.',
            interpretation:
                'A soma de polinômios depende diretamente do reconhecimento de termos semelhantes.',
          ),
        ],
      ),
      LessonSectionData(
        number: '2',
        title: 'Cuidado com a subtração',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.warning,
            title: 'O sinal negativo afeta todo o segundo polinômio',
            content:
                'Ao subtrair um polinômio, o sinal negativo deve ser distribuído para todos os seus termos antes de combinar termos semelhantes.',
            emphasis:
                '(2x² + 3x) − (x² − 4x + 1) = 2x² + 3x − x² + 4x − 1.',
          ),
        ],
      ),
      LessonSectionData(
        number: '3',
        title: 'Multiplicação por monômio',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.transform,
            title: 'Distribua e use as propriedades das potências',
            content:
                'Quando um monômio multiplica um polinômio, ele deve multiplicar cada termo. Multiplicamos os coeficientes e, para bases iguais, somamos os expoentes.',
            emphasis:
                '2x(3x² − 4x + 5) = 6x³ − 8x² + 10x.',
          ),
          WorkedExampleBlockData(
            title: 'Multiplicando monômios',
            problem: 'Calcule (−3x²)(2x).',
            steps: [
              'Multiplique os coeficientes: −3·2 = −6.',
              'Multiplique as potências de mesma base: x²·x = x³.',
              'Junte coeficiente e parte literal.',
            ],
            result: 'O produto é −6x³.',
            interpretation:
                'Essa operação combina regra de sinais com propriedade de potências.',
          ),
        ],
      ),
      LessonSectionData(
        number: '4',
        title: 'Multiplicação de polinômios',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.transform,
            title: 'Cada termo multiplica cada termo',
            content:
                'Na multiplicação de dois polinômios, aplicamos a propriedade distributiva repetidamente. Depois, reduzimos os termos semelhantes.',
            emphasis:
                '(x + 2)(x + 3) = x² + 3x + 2x + 6 = x² + 5x + 6.',
          ),
          WorkedExampleBlockData(
            title: 'Binômio vezes binômio',
            problem: 'Multiplique (2x − 1)(x + 4).',
            steps: [
              'Multiplique 2x por x: 2x².',
              'Multiplique 2x por 4: 8x.',
              'Multiplique −1 por x: −x.',
              'Multiplique −1 por 4: −4.',
              'Combine os termos semelhantes: 8x − x = 7x.',
            ],
            result: 'O produto é 2x² + 7x − 4.',
            interpretation:
                'A distributiva organiza a multiplicação antes da redução dos termos semelhantes.',
          ),
        ],
      ),
      LessonSectionData(
        number: '5',
        title: 'Divisão de monômios',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.calculate,
            title: 'Divida coeficientes e subtraia expoentes',
            content:
                'Quando dividimos monômios, dividimos os coeficientes e usamos a regra do quociente para bases iguais, sempre respeitando a condição de que o denominador não seja zero.',
            emphasis:
                '(12x³y²)/(3xy) = 4x²y, com x ≠ 0 e y ≠ 0.',
          ),
        ],
      ),
      LessonSectionData(
        number: '6',
        title: 'Erro comum',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.warning,
            title: 'Não combine termos diferentes',
            content:
                'Depois de uma multiplicação, só podemos reduzir termos realmente semelhantes. Expoentes diferentes representam termos diferentes.',
            emphasis:
                'x² + 3x não é 4x² nem 4x³.',
          ),
        ],
      ),
    ],
    check: LessonCheckData(
      question: 'Qual é o resultado de (x + 2)(x + 5)?',
      choices: [
        'x² + 7x + 10',
        'x² + 10x + 7',
        'x² + 7',
      ],
      correctIndex: 0,
      explanation:
          'Aplicando a distributiva: x² + 5x + 2x + 10 = x² + 7x + 10.',
    ),
    takeaways: [
      'Soma e subtração exigem termos semelhantes.',
      'Na subtração, distribua corretamente o sinal negativo.',
      'Um monômio deve multiplicar todos os termos do polinômio.',
      'Na multiplicação de polinômios, cada termo multiplica cada termo.',
      'Depois da multiplicação, reduza os termos semelhantes.',
      'Na divisão de monômios, divida coeficientes e subtraia expoentes de bases iguais.',
    ],
    closing:
        'Com as operações dominadas, produtos notáveis deixam de parecer fórmulas isoladas e passam a ser padrões da própria multiplicação algébrica.',
  ),
  CourseLessonData(
    id: 'algebra-05-produtos-notaveis',
    topicId: 'algebra-fundamental',
    trailTitle: 'Álgebra Fundamental',
    eyebrow: 'Fundamentos',
    title: 'Produtos notáveis',
    description: 'padrões que aceleram cálculos',
    duration: '≈ 5 min',
    objective:
        'reconhecer quadrados, diferença de quadrados e produtos binomiais comuns',
    symbol: '(a+b)²',
    sections: [
      LessonSectionData(
        number: '1',
        title: 'Entenda a ideia',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.idea,
            title: 'Produto notável é distributiva memorizada com sentido',
            content:
                'Produtos notáveis não são truques soltos. Eles nascem da distributiva e aparecem tantas vezes que vale reconhecer o padrão rapidamente.',
            emphasis: '(a + b)² = a² + 2ab + b², não apenas a² + b².',
          ),
        ],
      ),
      LessonSectionData(
        number: '2',
        title: 'Veja funcionando',
        blocks: [
          WorkedExampleBlockData(
            title: 'Expandindo com padrão',
            problem: 'Desenvolva (x − 5)².',
            steps: [
              'Use (a − b)² = a² − 2ab + b².',
              'Aqui, a = x e b = 5.',
              'Substitua: x² − 2·x·5 + 25.',
            ],
            result: 'O resultado é x² − 10x + 25.',
            interpretation:
                'O termo do meio aparece porque o binômio foi multiplicado por ele mesmo.',
          ),
        ],
      ),
    ],
    check: LessonCheckData(
      question: 'Qual é o desenvolvimento de (x + 3)²?',
      choices: ['x² + 9', 'x² + 6x + 9', 'x² + 3x + 9'],
      correctIndex: 1,
      explanation:
          'O termo do meio é 2·x·3 = 6x. Por isso, (x + 3)² = x² + 6x + 9.',
    ),
    takeaways: [
      'Produtos notáveis vêm da distributiva.',
      'Quadrado da soma possui termo do meio.',
      'Diferença de quadrados fatora como (a − b)(a + b).',
      'Reconhecer padrões acelera simplificações.',
    ],
    closing:
        'Produtos notáveis são atalhos seguros quando você sabe de onde eles vieram.',
  ),
  CourseLessonData(
    id: 'algebra-06-fatoracao',
    topicId: 'algebra-fundamental',
    trailTitle: 'Álgebra Fundamental',
    eyebrow: 'Fundamentos',
    title: 'Fatoração',
    description: 'colocar expressões em forma de produto',
    duration: '≈ 5 min',
    objective:
        'fatorar expressões por fator comum, agrupamento e padrões notáveis',
    symbol: '(x−a)',
    sections: [
      LessonSectionData(
        number: '1',
        title: 'Entenda a ideia',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.transform,
            title: 'Da soma para o produto',
            content:
                'Fatorar significa escrever uma expressão como multiplicação de fatores. Isso revela raízes, cancela frações algébricas e resolve limites com indeterminação.',
            emphasis:
                'Em Cálculo, fatorar muitas vezes transforma um problema travado em uma conta simples.',
          ),
        ],
      ),
      LessonSectionData(
        number: '2',
        title: 'Veja funcionando',
        blocks: [
          WorkedExampleBlockData(
            title: 'Fator comum em evidência',
            problem: 'Fatore 8x² − 12x.',
            steps: [
              'Encontre o maior fator comum: 4x.',
              'Divida cada termo por 4x: 8x²/(4x) = 2x e −12x/(4x) = −3.',
              'Escreva o produto: 4x(2x − 3).',
            ],
            result: 'A fatoração é 4x(2x − 3).',
            interpretation:
                'Se distribuir 4x de volta, recuperamos a expressão original.',
          ),
        ],
      ),
    ],
    check: LessonCheckData(
      question: 'Qual é a fatoração de x² − 16?',
      choices: ['(x − 4)(x + 4)', '(x − 8)(x + 8)', '(x − 4)²'],
      correctIndex: 0,
      explanation: 'É uma diferença de quadrados: x² − 4² = (x − 4)(x + 4).',
    ),
    takeaways: [
      'Fatorar reescreve somas como produtos.',
      'Fator comum é o primeiro padrão a procurar.',
      'Diferença de quadrados é muito frequente.',
      'Sempre confira distribuindo de volta.',
    ],
    closing:
        'A fatoração é uma ponte direta entre Álgebra, equações, funções e limites.',
  ),
  CourseLessonData(
    id: 'algebra-07-fracoes-algebricas',
    topicId: 'algebra-fundamental',
    trailTitle: 'Álgebra Fundamental',
    eyebrow: 'Fundamentos',
    title: 'Frações algébricas',
    description: 'restrições, simplificação e denominadores',
    duration: '≈ 5 min',
    objective:
        'simplificar frações algébricas preservando restrições de domínio',
    symbol: 'x/y',
    sections: [
      LessonSectionData(
        number: '1',
        title: 'Entenda a ideia',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.warning,
            title: 'Nem todo cancelamento é permitido',
            content:
                'Só podemos cancelar fatores multiplicativos comuns. Não se cancela termo dentro de soma como se fosse fator. Além disso, denominadores nunca podem ser zero.',
            emphasis:
                'Em (x + 2)/x, o x não cancela com parte do numerador, porque x + 2 é uma soma.',
          ),
        ],
      ),
      LessonSectionData(
        number: '2',
        title: 'Veja funcionando',
        blocks: [
          WorkedExampleBlockData(
            title: 'Cancelamento correto',
            problem: 'Simplifique (x² − 9)/(x − 3), com x ≠ 3.',
            steps: [
              'Fatore o numerador: x² − 9 = (x − 3)(x + 3).',
              'Reescreva a fração: [(x − 3)(x + 3)]/(x − 3).',
              'Cancele o fator comum x − 3, mantendo a restrição x ≠ 3.',
            ],
            result: 'A forma simplificada é x + 3, com x ≠ 3.',
            interpretation:
                'A expressão simplificada parece livre, mas a restrição original continua valendo.',
          ),
        ],
      ),
    ],
    check: LessonCheckData(
      question: 'Em qual expressão o cancelamento de x é correto?',
      choices: ['(x + 5)/x', '(3x)/(x)', '(x − 2)/x'],
      correctIndex: 1,
      explanation:
          'Em 3x/x, o x é fator comum no numerador e no denominador. Nas outras, x aparece dentro de soma ou diferença.',
    ),
    takeaways: [
      'Denominador zero é proibido.',
      'Cancele apenas fatores, não parcelas.',
      'Fatorar antes de cancelar evita erro.',
      'Restrições originais continuam importantes.',
    ],
    closing:
        'Frações algébricas explicam muitos detalhes de domínio, continuidade e limites.',
  ),
  CourseLessonData(
    id: 'algebra-08-sintese',
    topicId: 'algebra-fundamental',
    trailTitle: 'Álgebra Fundamental',
    eyebrow: 'Fundamentos',
    title: 'Síntese algébrica',
    description: 'escolher a ferramenta certa',
    duration: '≈ 5 min',
    objective:
        'decidir quando simplificar, expandir, fatorar ou substituir valores',
    symbol: '✓',
    sections: [
      LessonSectionData(
        number: '1',
        title: 'Entenda a ideia',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.checklist,
            title: 'Não existe uma forma sempre melhor',
            content:
                'Expandir ajuda a combinar termos. Fatorar ajuda a enxergar produtos, raízes e cancelamentos. Substituir valores ajuda a conferir resultados e interpretar expressões.',
            emphasis:
                'O bom aluno de Cálculo não decora só contas; ele escolhe a forma que revela a ideia.',
          ),
        ],
      ),
      LessonSectionData(
        number: '2',
        title: 'Veja funcionando',
        blocks: [
          WorkedExampleBlockData(
            title: 'Do caos à forma útil',
            problem: 'Simplifique 2(x + 1) + (x − 3)(x + 3).',
            steps: [
              'Distribua o primeiro termo: 2x + 2.',
              'Use diferença de quadrados: (x − 3)(x + 3) = x² − 9.',
              'Combine: x² + 2x − 7.',
            ],
            result: 'A expressão simplificada é x² + 2x − 7.',
            interpretation:
                'Usamos distributiva e produto notável na mesma expressão.',
          ),
        ],
      ),
    ],
    check: LessonCheckData(
      question:
          'Para simplificar (x² − 25)/(x − 5), qual ferramenta vem primeiro?',
      choices: [
        'Fatorar x² − 25',
        'Substituir x = 5',
        'Somar 25 ao denominador',
      ],
      correctIndex: 0,
      explanation:
          'A diferença de quadrados permite escrever x² − 25 como (x − 5)(x + 5), revelando o fator comum.',
    ),
    takeaways: [
      'Expandir, fatorar e substituir têm objetivos diferentes.',
      'A forma fatorada revela cancelamentos e raízes.',
      'A forma expandida facilita combinação de termos.',
      'Conferir o caminho reduz erros invisíveis.',
    ],
    closing:
        'Com essa caixa de ferramentas pronta, as próximas aulas deixam de parecer mágica e começam a parecer estratégia.',
  ),
];
