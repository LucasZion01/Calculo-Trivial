import 'package:calcquest/shared/domain/course_lesson_data.dart';

const List<CourseLessonData> derivativesCourseLessons = [
  CourseLessonData(
    id: 'derivadas-01-significado',
    topicId: 'derivadas',
    trailTitle: 'Derivadas • Unidade 1',
    eyebrow: 'Aula 1 de 8 • Ideia central',
    title: 'Taxa de variação e reta tangente',
    description:
        'Entenda a derivada como velocidade instantânea e inclinação local.',
    duration: '18–22 min',
    objective: 'interpretar a derivada geometricamente e em situações reais',
    symbol: "f'",
    sections: [
      LessonSectionData(
        number: '1',
        title: 'Da média ao instante',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.engineering,
            title: 'Taxa média de variação',
            content:
                'Entre x=a e x=b, a taxa média é [f(b)−f(a)]/(b−a). Ela mede quanto a saída varia, em média, para cada unidade acrescentada à entrada.',
            emphasis:
                'Em posição versus tempo, essa razão representa velocidade média.',
          ),
          ConceptBlockData(
            visual: LessonVisual.graph,
            title: 'Aproximando a reta secante',
            content:
                'Quando b se aproxima de a, a reta que corta o gráfico em dois pontos tende à reta tangente. O limite das inclinações das secantes é a derivada f′(a).',
            tone: LearningCardTone.information,
          ),
        ],
      ),
      LessonSectionData(
        number: '2',
        title: 'Leia a definição por limite',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.notation,
            title: 'f′(a)=lim h→0 [f(a+h)−f(a)]/h',
            content:
                'O incremento h separa dois pontos. O numerador mede a variação da função e o denominador mede a variação da entrada. Fazer h→0 produz uma taxa instantânea.',
          ),
          WorkedExampleBlockData(
            title: 'Derivada de x² no ponto a',
            problem: 'f(x)=x²',
            steps: [
              'Substitua na definição: [(a+h)²−a²]/h.',
              'Expanda: [a²+2ah+h²−a²]/h.',
              'Simplifique h: 2a+h.',
              'Faça h→0 e obtenha 2a.',
            ],
            result: 'f′(a)=2a.',
            interpretation:
                'A inclinação muda com o ponto: quanto maior a, mais inclinada é a parábola.',
          ),
        ],
      ),
    ],
    check: LessonCheckData(
      question: 'Geometricamente, o que f′(a) representa?',
      choices: [
        'A inclinação da tangente em a',
        'A área até a',
        'O valor máximo de f',
      ],
      correctIndex: 0,
      explanation:
          'A derivada é o limite das inclinações de retas secantes quando os pontos se aproximam.',
    ),
    takeaways: [
      'Taxa média compara dois pontos; derivada descreve um instante.',
      'A derivada é definida por um limite.',
      'Geometricamente, f′(a) é a inclinação da reta tangente.',
    ],
    closing:
        'Na próxima aula, regras de derivação tornarão esses cálculos mais rápidos.',
  ),
  CourseLessonData(
    id: 'derivadas-02-regras-basicas',
    topicId: 'derivadas',
    trailTitle: 'Derivadas • Unidade 1',
    eyebrow: 'Aula 2 de 8 • Regras básicas',
    title: 'Constantes, potências e polinômios',
    description:
        'Derive termo a termo e trabalhe com expoentes inteiros e fracionários.',
    duration: '18–22 min',
    objective: 'aplicar linearidade e regra da potência com segurança',
    symbol: 'xⁿ',
    sections: [
      LessonSectionData(
        number: '1',
        title: 'Construa o repertório essencial',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.calculate,
            title: 'Três regras fundamentais',
            content:
                'A derivada de uma constante é 0. A derivada de x é 1. Para qualquer potência admissível, d/dx(xⁿ)=n·xⁿ⁻¹: o expoente desce multiplicando e diminui uma unidade.',
            emphasis:
                'Uma constante não varia; por isso, sua taxa de variação é zero.',
          ),
          ConceptBlockData(
            visual: LessonVisual.transform,
            title: 'Reescreva antes de derivar',
            content:
                'Raízes e frações podem virar potências: √x=x¹ᐟ² e 1/x=x⁻¹. Essa transformação permite usar a mesma regra da potência.',
            tone: LearningCardTone.information,
          ),
        ],
      ),
      LessonSectionData(
        number: '2',
        title: 'Derive termo a termo',
        blocks: [
          WorkedExampleBlockData(
            title: 'Polinômio completo',
            problem: 'f(x)=5x³−2x²+7x−4',
            steps: [
              'd/dx(5x³)=15x².',
              'd/dx(−2x²)=−4x.',
              'd/dx(7x)=7.',
              'd/dx(−4)=0.',
            ],
            result: 'f′(x)=15x²−4x+7.',
            interpretation:
                'A soma das taxas de cada termo fornece a taxa da função inteira.',
          ),
          WorkedExampleBlockData(
            title: 'Expoente fracionário',
            problem: 'f(x)=√x=x¹ᐟ², com x>0',
            steps: [
              'Faça o expoente 1/2 descer.',
              'Subtraia 1: 1/2−1=−1/2.',
              'Escreva (1/2)x⁻¹ᐟ².',
            ],
            result: 'f′(x)=1/(2√x).',
            interpretation:
                'O domínio da derivada pode ser menor que o domínio original.',
          ),
        ],
      ),
    ],
    check: LessonCheckData(
      question: 'Qual é a derivada de 3x⁴−5?',
      choices: ['12x³', '12x³−5', '3x³'],
      correctIndex: 0,
      explanation:
          'A potência produz 3·4x³=12x³ e a constante desaparece.',
    ),
    takeaways: [
      'Constantes têm derivada zero e d/dx(x)=1.',
      'Na regra da potência, multiplique pelo expoente e reduza-o em um.',
      'Reescreva raízes e inversos como potências.',
    ],
    closing:
        'Agora você aprenderá a derivar produtos e quocientes sem expandir tudo.',
  ),
  CourseLessonData(
    id: 'derivadas-03-produto-quociente',
    topicId: 'derivadas',
    trailTitle: 'Derivadas • Unidade 2',
    eyebrow: 'Aula 3 de 8 • Combinações',
    title: 'Regras do produto e do quociente',
    description:
        'Combine funções preservando todos os termos necessários.',
    duration: '20–24 min',
    objective: 'aplicar e conferir as regras do produto e do quociente',
    symbol: 'u·v',
    sections: [
      LessonSectionData(
        number: '1',
        title: 'Não derive fatores isoladamente',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.notation,
            title: 'Produto: (uv)′=u′v+uv′',
            content:
                'Derive o primeiro e conserve o segundo; depois conserve o primeiro e derive o segundo. Some os dois resultados.',
            emphasis:
                'Em geral, a derivada de um produto não é u′v′.',
          ),
          ConceptBlockData(
            visual: LessonVisual.notation,
            title: 'Quociente: (u/v)′=(u′v−uv′)/v²',
            content:
                'Multiplique a derivada de cima pela função de baixo, subtraia a função de cima vezes a derivada de baixo e divida pelo quadrado do denominador.',
            tone: LearningCardTone.information,
          ),
        ],
      ),
      LessonSectionData(
        number: '2',
        title: 'Escolha entre simplificar e aplicar a regra',
        blocks: [
          WorkedExampleBlockData(
            title: 'Regra do produto',
            problem: 'f(x)=x²(x+1)',
            steps: [
              'Defina u=x² e v=x+1.',
              'Calcule u′=2x e v′=1.',
              'Aplique u′v+uv′=2x(x+1)+x².',
              'Simplifique: 3x²+2x.',
            ],
            result: 'f′(x)=3x²+2x.',
            interpretation:
                'Expandir antes também funcionaria; as duas estratégias devem coincidir.',
          ),
          WorkedExampleBlockData(
            title: 'Simplifique um quociente',
            problem: 'f(x)=(x²+1)/x, x≠0',
            steps: [
              'Separe os termos: f(x)=x+1/x.',
              'Reescreva 1/x=x⁻¹.',
              'Derive: 1−x⁻².',
            ],
            result: 'f′(x)=1−1/x².',
            interpretation:
                'Simplificar primeiro pode reduzir erros, desde que o domínio seja preservado.',
          ),
        ],
      ),
    ],
    check: LessonCheckData(
      question: 'Qual estrutura inicia a derivada de u(x)v(x)?',
      choices: ['u′v+uv′', 'u′v′', 'u′/v′'],
      correctIndex: 0,
      explanation:
          'Cada parcela deriva um fator e conserva o outro.',
    ),
    takeaways: [
      'A regra do produto gera duas parcelas.',
      'A ordem e o sinal de subtração importam no quociente.',
      'Simplifique antes quando isso reduzir a complexidade.',
    ],
    closing:
        'A próxima aula tratará de funções colocadas dentro de outras funções.',
  ),
  CourseLessonData(
    id: 'derivadas-04-cadeia',
    topicId: 'derivadas',
    trailTitle: 'Derivadas • Unidade 2',
    eyebrow: 'Aula 4 de 8 • Composição',
    title: 'Regra da cadeia por camadas',
    description:
        'Derive funções compostas da camada externa para a interna.',
    duration: '20–24 min',
    objective: 'identificar função externa, interna e aplicar a cadeia',
    symbol: 'f∘g',
    sections: [
      LessonSectionData(
        number: '1',
        title: 'Enxergue as camadas',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.transform,
            title: 'A função de fora recebe a de dentro',
            content:
                'Em y=[g(x)]ⁿ, a potência é a camada externa e g(x) é a interna. Derive a camada externa mantendo a interna e multiplique por g′(x).',
            emphasis:
                'Regra da cadeia: d/dx f(g(x))=f′(g(x))·g′(x).',
          ),
          ConceptBlockData(
            visual: LessonVisual.warning,
            title: 'O fator que costuma ser esquecido',
            content:
                'Derivar apenas a camada externa produz uma resposta incompleta. Sempre pergunte: “o que está ocupando o lugar de x?” e derive essa expressão também.',
            tone: LearningCardTone.warning,
          ),
        ],
      ),
      LessonSectionData(
        number: '2',
        title: 'Derive de fora para dentro',
        blocks: [
          WorkedExampleBlockData(
            title: 'Potência de uma função linear',
            problem: 'f(x)=(2x+1)³',
            steps: [
              'Camada externa: u³. Sua derivada é 3u².',
              'Mantenha u=2x+1: 3(2x+1)².',
              'Derive a camada interna: d/dx(2x+1)=2.',
              'Multiplique os fatores.',
            ],
            result: 'f′(x)=6(2x+1)².',
            interpretation:
                'O fator 2 registra a velocidade com que a expressão interna varia.',
          ),
        ],
      ),
    ],
    check: LessonCheckData(
      question: 'Qual é a derivada de (3x−2)⁴?',
      choices: ['12(3x−2)³', '4(3x−2)³', '12(3x−2)⁴'],
      correctIndex: 0,
      explanation:
          'A camada externa fornece 4(3x−2)³ e a interna fornece o fator 3.',
    ),
    takeaways: [
      'Identifique explicitamente a função externa e a interna.',
      'Derive a externa mantendo a expressão interna.',
      'Multiplique pela derivada de cada camada interna.',
    ],
    closing:
        'A seguir, você ampliará o repertório com trigonometria, exponenciais e logaritmos.',
  ),
  CourseLessonData(
    id: 'derivadas-05-elementares',
    topicId: 'derivadas',
    trailTitle: 'Derivadas • Unidade 2',
    eyebrow: 'Aula 5 de 8 • Funções elementares',
    title: 'Seno, cosseno, exponencial e logaritmo',
    description:
        'Memorize com significado as derivadas elementares mais usadas.',
    duration: '18–22 min',
    objective: 'derivar funções trigonométricas, exponenciais e logarítmicas',
    symbol: 'eˣ',
    sections: [
      LessonSectionData(
        number: '1',
        title: 'Organize o repertório',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.checklist,
            title: 'Quatro pares fundamentais',
            content:
                'd/dx[sen(x)]=cos(x); d/dx[cos(x)]=−sen(x); d/dx[eˣ]=eˣ; d/dx[ln(x)]=1/x para x>0.',
            emphasis:
                'O sinal negativo pertence à derivada do cosseno, não à do seno.',
          ),
          ConceptBlockData(
            visual: LessonVisual.graph,
            title: 'Por que eˣ é especial?',
            content:
                'A base e é escolhida de modo que a taxa instantânea de crescimento de eˣ seja igual ao próprio valor da função. Isso simplifica modelos de crescimento e decaimento.',
            tone: LearningCardTone.information,
          ),
        ],
      ),
      LessonSectionData(
        number: '2',
        title: 'Combine com a cadeia',
        blocks: [
          WorkedExampleBlockData(
            title: 'Seno de uma função',
            problem: 'f(x)=sen(2x)',
            steps: [
              'A derivada externa de sen(u) é cos(u).',
              'Mantenha u=2x: cos(2x).',
              'Multiplique pela derivada interna, que é 2.',
            ],
            result: 'f′(x)=2cos(2x).',
            interpretation:
                'A oscilação interna duas vezes mais rápida produz um fator 2 na taxa.',
          ),
          WorkedExampleBlockData(
            title: 'Logaritmo composto',
            problem: 'g(x)=ln(x²+1)',
            steps: [
              'A derivada externa de ln(u) é 1/u.',
              'Use u=x²+1 no denominador.',
              'Multiplique por u′=2x.',
            ],
            result: 'g′(x)=2x/(x²+1).',
            interpretation:
                'A cadeia conecta a taxa do logaritmo à taxa da expressão interna.',
          ),
        ],
      ),
    ],
    check: LessonCheckData(
      question: 'Qual é d/dx[cos(x)]?',
      choices: ['−sen(x)', 'sen(x)', '−cos(x)'],
      correctIndex: 0,
      explanation:
          'A taxa do cosseno segue o seno com sinal negativo.',
    ),
    takeaways: [
      'A derivada de sen(x) é cos(x).',
      'A derivada de cos(x) é −sen(x).',
      'eˣ permanece igual e ln(x) produz 1/x.',
      'Em argumentos compostos, aplique também a cadeia.',
    ],
    closing:
        'Na próxima aula, a derivada será convertida em uma equação de reta tangente.',
  ),
  CourseLessonData(
    id: 'derivadas-06-tangente',
    topicId: 'derivadas',
    trailTitle: 'Derivadas • Unidade 3',
    eyebrow: 'Aula 6 de 8 • Geometria local',
    title: 'Inclinação e equação da tangente',
    description:
        'Use f′(a) para construir a reta que melhor aproxima o gráfico.',
    duration: '18–22 min',
    objective: 'calcular inclinação e equação da reta tangente',
    symbol: 'y=mx+b',
    sections: [
      LessonSectionData(
        number: '1',
        title: 'Encontre ponto e inclinação',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.graph,
            title: 'A fórmula ponto-inclinação',
            content:
                'No ponto x=a, a inclinação é m=f′(a) e o ponto do gráfico é (a,f(a)). Substitua em y−f(a)=f′(a)(x−a).',
            emphasis:
                'Calcular somente f′(a) fornece a inclinação, não a equação completa da reta.',
          ),
          ConceptBlockData(
            visual: LessonVisual.engineering,
            title: 'Aproximação linear',
            content:
                'Perto de a, a função pode ser aproximada por L(x)=f(a)+f′(a)(x−a). Essa linearização simplifica estimativas e análise de pequenos erros.',
            tone: LearningCardTone.success,
          ),
        ],
      ),
      LessonSectionData(
        number: '2',
        title: 'Monte a reta',
        blocks: [
          WorkedExampleBlockData(
            title: 'Tangente à parábola',
            problem: 'f(x)=x² no ponto (1,1)',
            steps: [
              'Derive: f′(x)=2x.',
              'Avalie a inclinação: f′(1)=2.',
              'Use y−1=2(x−1).',
              'Simplifique a equação.',
            ],
            result: 'y=2x−1.',
            interpretation:
                'A reta e a parábola compartilham o ponto e a direção instantânea em x=1.',
          ),
        ],
      ),
    ],
    check: LessonCheckData(
      question: 'Para f(x)=x², qual é a inclinação em x=3?',
      choices: ['6', '3', '9'],
      correctIndex: 0,
      explanation:
          'Como f′(x)=2x, temos f′(3)=6.',
    ),
    takeaways: [
      'f′(a) fornece a inclinação da tangente.',
      'O ponto de tangência é (a,f(a)).',
      'Use y−f(a)=f′(a)(x−a).',
      'A reta tangente aproxima a função localmente.',
    ],
    closing:
        'A seguir, você estudará quando a derivada existe e o que seus zeros revelam.',
  ),
  CourseLessonData(
    id: 'derivadas-07-derivabilidade',
    topicId: 'derivadas',
    trailTitle: 'Derivadas • Unidade 3',
    eyebrow: 'Aula 7 de 8 • Existência e análise',
    title: 'Derivabilidade e pontos críticos',
    description:
        'Reconheça cantos, derivadas laterais e candidatos a extremos.',
    duration: '20–24 min',
    objective: 'analisar existência da derivada e localizar pontos críticos',
    symbol: 'f′=0',
    sections: [
      LessonSectionData(
        number: '1',
        title: 'Derivável implica contínua',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.warning,
            title: 'A recíproca é falsa',
            content:
                'Se f é derivável em a, então é contínua em a. Porém, uma função pode ser contínua e não derivável: cantos, cúspides e tangentes verticais impedem uma inclinação finita única.',
            emphasis:
                'Continuidade é necessária para derivabilidade, mas não é suficiente.',
            tone: LearningCardTone.warning,
          ),
          ConceptBlockData(
            visual: LessonVisual.compare,
            title: 'Derivadas laterais',
            content:
                'A derivada existe somente quando as taxas pela esquerda e pela direita existem e coincidem. Para |x| em zero, elas são −1 e 1, por isso há um canto.',
          ),
        ],
      ),
      LessonSectionData(
        number: '2',
        title: 'Encontre pontos críticos',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.checklist,
            title: 'Candidatos a mudança',
            content:
                'Um número c no domínio é crítico quando f′(c)=0 ou quando f′(c) não existe. Pontos críticos são candidatos a máximos e mínimos, mas ainda precisam ser analisados.',
            emphasis:
                'Derivada zero não garante automaticamente um máximo ou mínimo.',
          ),
          WorkedExampleBlockData(
            title: 'Derivada igual a zero',
            problem: 'f(x)=x²−4x',
            steps: [
              'Derive: f′(x)=2x−4.',
              'Imponha f′(x)=0.',
              'Resolva 2x−4=0.',
            ],
            result: 'x=2 é um ponto crítico.',
            interpretation:
                'A tangente horizontal indica um candidato a mudança de crescimento.',
          ),
        ],
      ),
    ],
    check: LessonCheckData(
      question: 'Uma função contínua é sempre derivável?',
      choices: ['Não', 'Sim', 'Somente se f′=0'],
      correctIndex: 0,
      explanation:
          '|x| é contínua em zero, mas suas derivadas laterais são diferentes.',
    ),
    takeaways: [
      'Derivabilidade garante continuidade no ponto.',
      'Continuidade sozinha não garante derivabilidade.',
      'Cantos podem ser detectados por derivadas laterais diferentes.',
      'Pontos críticos ocorrem quando f′=0 ou não existe.',
    ],
    closing:
        'A aula final aplicará derivadas a movimento e interpretação de unidades.',
  ),
  CourseLessonData(
    id: 'derivadas-08-aplicacoes',
    topicId: 'derivadas',
    trailTitle: 'Derivadas • Unidade 3',
    eyebrow: 'Aula 8 de 8 • Aplicações',
    title: 'Movimento, unidades e modelagem',
    description:
        'Interprete derivadas em problemas físicos e organize o método completo.',
    duration: '18–22 min',
    objective: 'modelar taxas instantâneas e interpretar seus resultados',
    symbol: 'v(t)',
    sections: [
      LessonSectionData(
        number: '1',
        title: 'A derivada carrega unidades',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.engineering,
            title: 'Posição, velocidade e aceleração',
            content:
                'Se s(t) mede posição em metros e t está em segundos, v(t)=s′(t) é medida em m/s. Derivar novamente produz a(t)=v′(t)=s″(t), em m/s².',
            emphasis:
                'As unidades ajudam a verificar se a resposta representa a grandeza pedida.',
            tone: LearningCardTone.success,
          ),
          ConceptBlockData(
            visual: LessonVisual.checklist,
            title: 'Roteiro de modelagem',
            content:
                '1) Identifique entrada, saída e unidades. 2) Derive o modelo. 3) Avalie no instante solicitado. 4) Inclua a unidade. 5) Interprete sinal e magnitude no contexto.',
          ),
        ],
      ),
      LessonSectionData(
        number: '2',
        title: 'Calcule e interprete',
        blocks: [
          WorkedExampleBlockData(
            title: 'Velocidade instantânea',
            problem: 's(t)=t²+3t metros; encontre v(2)',
            steps: [
              'Derive a posição: v(t)=s′(t)=2t+3.',
              'Substitua t=2: v(2)=2·2+3.',
              'Calcule e anexe a unidade de velocidade.',
            ],
            result: 'v(2)=7 m/s.',
            interpretation:
                'No instante de 2 segundos, a posição aumenta a uma taxa de 7 metros por segundo.',
          ),
          ConceptBlockData(
            visual: LessonVisual.idea,
            title: 'Derivada além do movimento',
            content:
                'Em Engenharia, derivadas descrevem corrente como taxa de carga, vazão como taxa de volume, deformação ao longo de uma peça e sensibilidade de uma saída a mudanças de entrada.',
            tone: LearningCardTone.information,
          ),
        ],
      ),
    ],
    check: LessonCheckData(
      question:
          'Se s está em metros e t em segundos, qual é a unidade de s′(t)?',
      choices: ['m/s', 'm·s', 'm/s²'],
      correctIndex: 0,
      explanation:
          'A derivada divide a variação da posição pela variação do tempo.',
    ),
    takeaways: [
      'A derivada deve ser interpretada com suas unidades.',
      'Velocidade é a derivada da posição; aceleração deriva a velocidade.',
      'Avaliar a derivada em um ponto fornece uma taxa instantânea.',
      'O método termina com interpretação, não apenas com álgebra.',
    ],
    closing:
        'Você concluiu a base de Derivadas. Agora pratique reconhecimento, cálculo e interpretação.',
  ),
];
