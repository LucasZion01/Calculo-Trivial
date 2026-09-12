import 'package:flutter/widgets.dart';

import 'package:calcquest/shared/domain/course_lesson_data.dart';

List<CourseLessonData> localizedPrecalculusFunctionsCourseLessons(Locale locale) {
  if (locale.languageCode == 'en') return _englishLessons;
  return precalculusFunctionsCourseLessons;
}

const List<CourseLessonData> precalculusFunctionsCourseLessons = [
  CourseLessonData(
    id: 'funcoes-01-conceito-dominio-imagem',
    topicId: 'funcoes',
    trailTitle: 'Funções — Pré-Cálculo',
    eyebrow: 'Fundamentos',
    title: 'Função, domínio e imagem',
    description: 'entrada, saída, notação e restrições',
    duration: '≈ 18 min',
    objective:
        'interpretar função como regra entre grandezas, distinguir domínio de imagem e reconhecer restrições algébricas básicas',
    symbol: 'f(x)',
    sections: [
      LessonSectionData(
        number: '1',
        title: 'Uma entrada, uma única saída',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.route,
            title: 'Função é uma correspondência',
            content:
                'Uma função associa cada entrada permitida x a exatamente uma saída f(x). Entradas diferentes podem produzir a mesma saída, mas uma mesma entrada não pode produzir duas saídas diferentes na mesma função.',
            emphasis:
                'f(3) significa o valor produzido quando a entrada é 3; não significa f multiplicado por 3.',
          ),
          ConceptBlockData(
            visual: LessonVisual.notation,
            title: 'Domínio é o conjunto de entradas permitidas',
            content:
                'Em expressões reais, denominadores não podem ser zero e radicandos de raízes pares não podem ser negativos. A imagem reúne os valores que a função realmente produz.',
            emphasis:
                'Antes de calcular, pergunte se a entrada pertence ao domínio.',
          ),
        ],
      ),
      LessonSectionData(
        number: '2',
        title: 'Veja funcionando',
        blocks: [
          WorkedExampleBlockData(
            title: 'Domínio com duas restrições',
            problem: 'Determine o domínio de f(x) = √(x − 1)/(x − 4).',
            steps: [
              'A raiz exige x − 1 ≥ 0, então x ≥ 1.',
              'O denominador exige x − 4 ≠ 0, então x ≠ 4.',
              'Combine as condições.',
            ],
            result: 'Domínio: [1, 4) ∪ (4, +∞).',
            interpretation:
                'O domínio é a interseção de todas as condições necessárias para a fórmula produzir um número real.',
          ),
        ],
      ),
      LessonSectionData(
        number: '3',
        title: 'Erro comum',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.warning,
            title: 'Domínio não é a mesma coisa que imagem',
            content:
                'Domínio descreve entradas permitidas; imagem descreve saídas efetivamente produzidas.',
            tone: LearningCardTone.warning,
          ),
        ],
      ),
    ],
    check: LessonCheckData(
      question: 'Qual valor deve ser excluído do domínio de g(x)=1/(x+2)?',
      choices: ['−2', '0', '2'],
      correctIndex: 0,
      explanation: 'x = −2 zera o denominador, então a função não está definida nesse ponto.',
    ),
    takeaways: [
      'Cada entrada do domínio possui uma única saída.',
      'Domínio reúne entradas permitidas.',
      'Imagem reúne saídas produzidas.',
      'Restrições de denominador e raiz devem ser combinadas.',
    ],
    closing:
        'Domínio e imagem serão usados continuamente em limites, continuidade e derivadas.',
  ),
  CourseLessonData(
    id: 'funcoes-02-composicao-inversa',
    topicId: 'funcoes',
    trailTitle: 'Funções — Pré-Cálculo',
    eyebrow: 'Estrutura',
    title: 'Composição e função inversa',
    description: 'processos sucessivos, injetividade e inversão',
    duration: '≈ 18 min',
    objective:
        'compor funções, interpretar a ordem da composição e reconhecer quando uma função admite inversa',
    symbol: 'f∘g',
    sections: [
      LessonSectionData(
        number: '1',
        title: 'Uma função pode alimentar outra',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.transform,
            title: 'Composição respeita ordem',
            content:
                '(f∘g)(x) = f(g(x)): primeiro calculamos g(x), depois usamos esse resultado como entrada de f. Em geral, f∘g e g∘f não são iguais.',
            emphasis: 'O domínio da composta precisa respeitar a entrada de g e a entrada permitida de f.',
          ),
          ConceptBlockData(
            visual: LessonVisual.compare,
            title: 'A inversa desfaz a função',
            content:
                'Se f é um-para-um, sua inversa f⁻¹ troca entradas e saídas. Graficamente, os gráficos de f e f⁻¹ são simétricos em relação à reta y = x.',
          ),
        ],
      ),
      LessonSectionData(
        number: '2',
        title: 'Veja funcionando',
        blocks: [
          WorkedExampleBlockData(
            title: 'Compor e inverter',
            problem: 'Se f(x)=2x+3 e g(x)=x², calcule (f∘g)(2) e encontre f⁻¹(x).',
            steps: [
              'g(2)=4.',
              'f(g(2))=f(4)=11.',
              'Para inverter f, escreva y=2x+3.',
              'Troque x e y: x=2y+3.',
              'Isole y: y=(x−3)/2.',
            ],
            result: '(f∘g)(2)=11 e f⁻¹(x)=(x−3)/2.',
            interpretation:
                'A composição encadeia processos; a inversa recupera a entrada a partir da saída.',
          ),
        ],
      ),
      LessonSectionData(
        number: '3',
        title: 'Teste gráfico',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.graph,
            title: 'Reta horizontal e injetividade',
            content:
                'Se alguma reta horizontal corta o gráfico de f em mais de um ponto, então duas entradas produzem a mesma saída e f não possui inversa global naquele domínio.',
            tone: LearningCardTone.information,
          ),
        ],
      ),
    ],
    check: LessonCheckData(
      question: 'Em (f∘g)(x), qual função é aplicada primeiro?',
      choices: ['f', 'g', 'As duas ao mesmo tempo'],
      correctIndex: 1,
      explanation: '(f∘g)(x)=f(g(x)); portanto g atua primeiro.',
    ),
    takeaways: [
      'Composição significa aplicar uma regra após outra.',
      'A ordem da composição importa.',
      'Função inversa troca entrada e saída.',
      'Injetividade é necessária para uma inversa global.',
    ],
    closing: 'Composição e inversão aparecem diretamente na regra da cadeia e em funções elementares.',
  ),
  CourseLessonData(
    id: 'funcoes-03-transformacoes-graficos',
    topicId: 'funcoes',
    trailTitle: 'Funções — Pré-Cálculo',
    eyebrow: 'Gráficos',
    title: 'Transformações de gráficos',
    description: 'translações, reflexões e escalas',
    duration: '≈ 16 min',
    objective:
        'prever como alterações algébricas deslocam, refletem e deformam o gráfico de uma função',
    symbol: 'f(x−h)',
    sections: [
      LessonSectionData(
        number: '1',
        title: 'Leia a transformação antes de desenhar',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.graph,
            title: 'Mudanças fora e dentro da função',
            content:
                'f(x)+k desloca o gráfico verticalmente; f(x−h) desloca horizontalmente para a direita em h. −f(x) reflete no eixo x e f(−x) reflete no eixo y. Multiplicadores externos alteram a escala vertical.',
            emphasis:
                'O sinal dentro do argumento parece invertido: f(x−3) desloca 3 unidades para a direita.',
          ),
        ],
      ),
      LessonSectionData(
        number: '2',
        title: 'Veja funcionando',
        blocks: [
          WorkedExampleBlockData(
            title: 'Partindo da parábola básica',
            problem: 'Descreva o gráfico de y = −2(x−3)² + 1 a partir de y=x².',
            steps: [
              'x−3 desloca 3 unidades para a direita.',
              'O fator −2 reflete no eixo x e produz alongamento vertical por 2.',
              '+1 desloca o resultado 1 unidade para cima.',
            ],
            result: 'Vértice em (3,1), parábola voltada para baixo e mais estreita que y=x².',
            interpretation:
                'A forma algébrica codifica diretamente a geometria do gráfico.',
          ),
        ],
      ),
      LessonSectionData(
        number: '3',
        title: 'Erro comum',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.warning,
            title: 'Não confunda −f(x) com f(−x)',
            content:
                '−f(x) muda as saídas e reflete no eixo x; f(−x) muda as entradas e reflete no eixo y.',
            tone: LearningCardTone.warning,
          ),
        ],
      ),
    ],
    check: LessonCheckData(
      question: 'O que f(x+4) faz com o gráfico de f(x)?',
      choices: ['Move 4 para a esquerda', 'Move 4 para a direita', 'Move 4 para cima'],
      correctIndex: 0,
      explanation: 'Somar 4 dentro do argumento desloca o gráfico 4 unidades para a esquerda.',
    ),
    takeaways: [
      'Mudanças externas alteram saídas.',
      'Mudanças internas alteram entradas.',
      'Sinais negativos podem produzir reflexões distintas.',
      'Transformações permitem esboçar famílias inteiras de funções.',
    ],
    closing: 'Transformações tornam leitura de gráficos muito mais rápida antes de entrar em Cálculo.',
  ),
  CourseLessonData(
    id: 'funcoes-04-polinomiais',
    topicId: 'funcoes',
    trailTitle: 'Funções — Pré-Cálculo',
    eyebrow: 'Funções clássicas',
    title: 'Funções polinomiais',
    description: 'grau, zeros, multiplicidade e comportamento',
    duration: '≈ 18 min',
    objective:
        'analisar zeros, grau, multiplicidade e comportamento nas extremidades de funções polinomiais',
    symbol: 'P(x)',
    sections: [
      LessonSectionData(
        number: '1',
        title: 'O grau controla o comportamento dominante',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.graph,
            title: 'Zeros ligam álgebra e gráfico',
            content:
                'Se P(a)=0, então x=a é um zero e, em condições usuais, (x−a) é fator do polinômio. A multiplicidade ajuda a prever se o gráfico cruza ou apenas toca o eixo x.',
            emphasis:
                'Para |x| muito grande, o termo de maior grau domina o comportamento do polinômio.',
          ),
        ],
      ),
      LessonSectionData(
        number: '2',
        title: 'Veja funcionando',
        blocks: [
          WorkedExampleBlockData(
            title: 'Zeros e multiplicidade',
            problem: 'Analise P(x)=(x−2)²(x+1).',
            steps: [
              'Os zeros são x=2 e x=−1.',
              'x=2 possui multiplicidade 2, então o gráfico tende a tocar o eixo e retornar.',
              'x=−1 possui multiplicidade 1, então o gráfico cruza o eixo.',
              'O grau total é 3 e o coeficiente líder é positivo.',
            ],
            result: 'Polinômio cúbico com zeros −1 e 2, sendo 2 um zero duplo.',
            interpretation:
                'A forma fatorada fornece informações geométricas sem calcular muitos pontos.',
          ),
        ],
      ),
      LessonSectionData(
        number: '3',
        title: 'Conexão com Cálculo',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.infinity,
            title: 'Termo dominante prepara limites no infinito',
            content:
                'A ideia de que o termo de maior grau domina será usada para limites no infinito e comparação de crescimento.',
            tone: LearningCardTone.information,
          ),
        ],
      ),
    ],
    check: LessonCheckData(
      question: 'Qual é um zero de P(x)=(x−5)(x+2)?',
      choices: ['5', '2', '−5'],
      correctIndex: 0,
      explanation: 'Quando x=5, o fator x−5 zera e portanto P(5)=0.',
    ),
    takeaways: [
      'Zeros de polinômios correspondem a fatores lineares.',
      'Multiplicidade afeta a forma do gráfico perto da raiz.',
      'O grau informa o termo dominante.',
      'A forma fatorada facilita leitura geométrica.',
    ],
    closing: 'Polinômios são modelos centrais para desenvolver intuição de comportamento de funções.',
  ),
  CourseLessonData(
    id: 'funcoes-05-racionais',
    topicId: 'funcoes',
    trailTitle: 'Funções — Pré-Cálculo',
    eyebrow: 'Funções clássicas',
    title: 'Funções racionais e assíntotas',
    description: 'domínio, zeros e comportamento assintótico',
    duration: '≈ 18 min',
    objective:
        'analisar domínio, zeros, descontinuidades e assíntotas de funções racionais simples',
    symbol: 'P/Q',
    sections: [
      LessonSectionData(
        number: '1',
        title: 'Denominador controla restrições',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.infinity,
            title: 'Zeros do denominador merecem atenção',
            content:
                'Uma função racional tem a forma P(x)/Q(x), com Q(x)≠0. Zeros de Q são excluídos do domínio e podem gerar assíntotas verticais ou descontinuidades removíveis, dependendo de fatores comuns.',
            emphasis:
                'Cancelar um fator simplifica a fórmula, mas não devolve ao domínio o ponto originalmente proibido.',
          ),
        ],
      ),
      LessonSectionData(
        number: '2',
        title: 'Veja funcionando',
        blocks: [
          WorkedExampleBlockData(
            title: 'Assíntota vertical e horizontal',
            problem: 'Analise f(x)=(2x+1)/(x−3).',
            steps: [
              'O domínio exclui x=3.',
              'Como o denominador tende a zero perto de 3 e não há cancelamento, x=3 é candidato a assíntota vertical.',
              'Numerador e denominador têm o mesmo grau.',
              'A razão dos coeficientes líderes é 2/1=2.',
            ],
            result: 'Assíntota vertical x=3 e horizontal y=2.',
            interpretation:
                'As assíntotas descrevem tendências do gráfico perto de pontos críticos e no infinito.',
          ),
        ],
      ),
      LessonSectionData(
        number: '3',
        title: 'Erro comum',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.warning,
            title: 'Ponto removível não volta ao domínio',
            content:
                'Se (x−2) cancela no numerador e denominador, a expressão simplificada pode ser definida em x=2, mas a função original continua sem valor nesse ponto.',
            tone: LearningCardTone.warning,
          ),
        ],
      ),
    ],
    check: LessonCheckData(
      question: 'Qual valor é excluído do domínio de (x+1)/(x−7)?',
      choices: ['−1', '1', '7'],
      correctIndex: 2,
      explanation: 'x=7 zera o denominador.',
    ),
    takeaways: [
      'Domínio exclui zeros do denominador.',
      'Fatores comuns podem criar descontinuidades removíveis.',
      'Assíntotas verticais aparecem perto de certas restrições.',
      'Graus ajudam a prever comportamento no infinito.',
    ],
    closing: 'Funções racionais formam uma ponte direta para limites e continuidade.',
  ),
  CourseLessonData(
    id: 'funcoes-06-exponenciais',
    topicId: 'funcoes',
    trailTitle: 'Funções — Pré-Cálculo',
    eyebrow: 'Funções clássicas',
    title: 'Funções exponenciais',
    description: 'crescimento, decaimento e número e',
    duration: '≈ 16 min',
    objective:
        'interpretar funções exponenciais e distinguir crescimento de decaimento a partir da base',
    symbol: 'aˣ',
    sections: [
      LessonSectionData(
        number: '1',
        title: 'A variável está no expoente',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.graph,
            title: 'Base determina crescimento',
            content:
                'Na função f(x)=aˣ, com a>0 e a≠1, se a>1 há crescimento exponencial; se 0<a<1 há decaimento. O domínio é ℝ e a imagem é (0,+∞).',
            emphasis: 'A função exponencial nunca assume valor zero.',
          ),
          ConceptBlockData(
            visual: LessonVisual.idea,
            title: 'A base e é natural no Cálculo',
            content:
                'O número e≈2,718 aparece naturalmente em crescimento contínuo. A função eˣ terá propriedades especialmente simples quando estudarmos derivadas.',
          ),
        ],
      ),
      LessonSectionData(
        number: '2',
        title: 'Veja funcionando',
        blocks: [
          WorkedExampleBlockData(
            title: 'Modelo de crescimento',
            problem: 'Uma quantidade é modelada por P(t)=100·2ᵗ. Qual o valor em t=3?',
            steps: ['Substitua t por 3: P(3)=100·2³.', 'Calcule 2³=8.', 'Multiplique: 100·8=800.'],
            result: 'P(3)=800.',
            interpretation: 'A quantidade dobra a cada unidade de tempo.',
          ),
        ],
      ),
      LessonSectionData(
        number: '3',
        title: 'Comparação',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.compare,
            title: 'Exponencial não é potência comum',
            content:
                'Em x², a variável está na base. Em 2ˣ, a variável está no expoente. Esses dois tipos de função têm comportamentos muito diferentes.',
            tone: LearningCardTone.information,
          ),
        ],
      ),
    ],
    check: LessonCheckData(
      question: 'Qual função representa decaimento exponencial?',
      choices: ['2ˣ', '(1/2)ˣ', 'x²'],
      correctIndex: 1,
      explanation: 'Uma base entre 0 e 1 produz decaimento exponencial.',
    ),
    takeaways: [
      'Na exponencial, a variável está no expoente.',
      'Base maior que 1 produz crescimento.',
      'Base entre 0 e 1 produz decaimento.',
      'eˣ será central no Cálculo.',
    ],
    closing: 'Exponenciais modelam processos em que a taxa de mudança acompanha o próprio tamanho da quantidade.',
  ),
  CourseLessonData(
    id: 'funcoes-07-logaritmos',
    topicId: 'funcoes',
    trailTitle: 'Funções — Pré-Cálculo',
    eyebrow: 'Funções clássicas',
    title: 'Logaritmos',
    description: 'definição, propriedades e função inversa',
    duration: '≈ 18 min',
    objective:
        'interpretar logaritmos como expoentes, usar propriedades básicas e relacionar logaritmos a funções exponenciais',
    symbol: 'logₐx',
    sections: [
      LessonSectionData(
        number: '1',
        title: 'Logaritmo responde qual expoente',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.notation,
            title: 'Definição fundamental',
            content:
                'logₐ(b)=c significa exatamente aᶜ=b, com a>0, a≠1 e b>0. A função logarítmica é a inversa da função exponencial de mesma base.',
            emphasis: 'Argumento de logaritmo deve ser positivo.',
          ),
          ConceptBlockData(
            visual: LessonVisual.calculate,
            title: 'Propriedades vêm das potências',
            content:
                'logₐ(xy)=logₐx+logₐy e logₐ(x/y)=logₐx−logₐy. Além disso, logₐ(xʳ)=r·logₐx quando as expressões estão definidas.',
          ),
        ],
      ),
      LessonSectionData(
        number: '2',
        title: 'Veja funcionando',
        blocks: [
          WorkedExampleBlockData(
            title: 'Equação logarítmica simples',
            problem: 'Resolva log₂(x)=5.',
            steps: ['Converta para forma exponencial: 2⁵=x.', 'Calcule 2⁵=32.', 'Verifique que 32>0.'],
            result: 'x=32.',
            interpretation: 'Resolver o logaritmo foi equivalente a descobrir o resultado de uma potência.',
          ),
        ],
      ),
      LessonSectionData(
        number: '3',
        title: 'Erro comum',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.warning,
            title: 'Logaritmo não distribui sobre soma',
            content: 'Em geral, log(x+y) não é igual a log x + log y.',
            tone: LearningCardTone.warning,
          ),
        ],
      ),
    ],
    check: LessonCheckData(
      question: 'log₁₀(1000) vale:',
      choices: ['2', '3', '10'],
      correctIndex: 1,
      explanation: '10³=1000, então log₁₀(1000)=3.',
    ),
    takeaways: [
      'Logaritmo é um expoente.',
      'Exponencial e logaritmo são funções inversas.',
      'O argumento do logaritmo deve ser positivo.',
      'Propriedades logarítmicas refletem propriedades de potências.',
    ],
    closing: 'Logaritmos transformam multiplicações em somas e aparecem naturalmente em taxas e escalas.',
  ),
  CourseLessonData(
    id: 'funcoes-08-radianos-circulo',
    topicId: 'funcoes',
    trailTitle: 'Funções — Pré-Cálculo',
    eyebrow: 'Trigonometria',
    title: 'Radianos e círculo trigonométrico',
    description: 'ângulos, arco e coordenadas no círculo unitário',
    duration: '≈ 20 min',
    objective:
        'converter graus e radianos e interpretar seno e cosseno pelo círculo trigonométrico',
    symbol: 'π rad',
    sections: [
      LessonSectionData(
        number: '1',
        title: 'Radiano mede ângulo por arco',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.route,
            title: 'π rad = 180°',
            content:
                'Uma volta completa mede 2π radianos ou 360°. Assim, 90°=π/2, 180°=π e 270°=3π/2. Em Cálculo, radianos são a unidade natural para funções trigonométricas.',
            emphasis: 'As fórmulas de derivadas trigonométricas pressupõem ângulos em radianos.',
          ),
          ConceptBlockData(
            visual: LessonVisual.graph,
            title: 'Círculo unitário transforma ângulo em coordenadas',
            content:
                'No círculo de raio 1, o ponto associado ao ângulo θ tem coordenadas (cos θ, sen θ). Isso amplia seno e cosseno para qualquer ângulo real.',
          ),
        ],
      ),
      LessonSectionData(
        number: '2',
        title: 'Veja funcionando',
        blocks: [
          WorkedExampleBlockData(
            title: 'Converter e localizar',
            problem: 'Converta 150° para radianos.',
            steps: ['Multiplique por π/180: 150·π/180.', 'Simplifique 150/180=5/6.'],
            result: '150°=5π/6 rad.',
            interpretation: 'O ângulo fica no segundo quadrante, onde seno é positivo e cosseno negativo.',
          ),
        ],
      ),
      LessonSectionData(
        number: '3',
        title: 'Valores notáveis',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.table,
            title: 'Reconheça 0, π/6, π/4, π/3 e π/2',
            content:
                'Os ângulos notáveis fornecem valores exatos de seno e cosseno e servem como referências para sinais e simetrias nos outros quadrantes.',
            tone: LearningCardTone.information,
          ),
        ],
      ),
    ],
    check: LessonCheckData(
      question: 'Quanto vale 90° em radianos?',
      choices: ['π/4', 'π/2', 'π'],
      correctIndex: 1,
      explanation: '90° corresponde a um quarto de volta, isto é, π/2 radianos.',
    ),
    takeaways: [
      '2π rad correspondem a 360°.',
      'No círculo unitário, cos θ é a coordenada x.',
      'sen θ é a coordenada y.',
      'Radianos são a unidade natural da trigonometria no Cálculo.',
    ],
    closing: 'O círculo trigonométrico conecta geometria, gráficos e funções periódicas.',
  ),
  CourseLessonData(
    id: 'funcoes-09-trigonometricas-graficos',
    topicId: 'funcoes',
    trailTitle: 'Funções — Pré-Cálculo',
    eyebrow: 'Trigonometria',
    title: 'Funções trigonométricas e gráficos',
    description: 'seno, cosseno, tangente, período e amplitude',
    duration: '≈ 20 min',
    objective:
        'interpretar domínio, imagem, período, amplitude e gráficos de seno, cosseno e tangente',
    symbol: 'sen x',
    sections: [
      LessonSectionData(
        number: '1',
        title: 'Periodicidade repete comportamento',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.graph,
            title: 'Seno e cosseno oscilam',
            content:
                'sen x e cos x têm período 2π e imagem [−1,1]. Em A·sen(Bx), |A| controla a amplitude e 2π/|B| controla o período.',
            emphasis: 'Tangente tem período π e não está definida onde cos x=0.',
          ),
        ],
      ),
      LessonSectionData(
        number: '2',
        title: 'Veja funcionando',
        blocks: [
          WorkedExampleBlockData(
            title: 'Amplitude e período',
            problem: 'Analise y=3sen(2x).',
            steps: ['Amplitude: |3|=3.', 'Período: 2π/2=π.', 'A imagem é [−3,3].'],
            result: 'Amplitude 3 e período π.',
            interpretation: 'O gráfico oscila mais alto e completa ciclos duas vezes mais rápido que sen x.',
          ),
        ],
      ),
      LessonSectionData(
        number: '3',
        title: 'Domínios diferentes',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.warning,
            title: 'Tangente possui assíntotas',
            content:
                'tan x=sen x/cos x, então pontos onde cos x=0 são excluídos e aparecem como assíntotas verticais.',
            tone: LearningCardTone.warning,
          ),
        ],
      ),
    ],
    check: LessonCheckData(
      question: 'Qual é o período de cos x?',
      choices: ['π/2', 'π', '2π'],
      correctIndex: 2,
      explanation: 'O cosseno repete seus valores a cada 2π radianos.',
    ),
    takeaways: [
      'Seno e cosseno têm período 2π.',
      'Tangente tem período π.',
      'Amplitude mede a oscilação vertical de seno e cosseno.',
      'Tangente não existe onde cosseno é zero.',
    ],
    closing: 'Gráficos trigonométricos são essenciais para limites, derivadas e modelos periódicos.',
  ),
  CourseLessonData(
    id: 'funcoes-10-identidades-equacoes-trig',
    topicId: 'funcoes',
    trailTitle: 'Funções — Pré-Cálculo',
    eyebrow: 'Trigonometria',
    title: 'Identidades e equações trigonométricas',
    description: 'relações fundamentais e resolução por ciclos',
    duration: '≈ 20 min',
    objective:
        'usar identidades trigonométricas fundamentais e resolver equações trigonométricas básicas',
    symbol: 'sen²+cos²',
    sections: [
      LessonSectionData(
        number: '1',
        title: 'Identidades são igualdades sempre válidas',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.notation,
            title: 'Identidade fundamental',
            content:
                'sen²x + cos²x = 1 é a identidade pitagórica básica. Também tan x = sen x/cos x quando cos x≠0. Fórmulas de soma, diferença e ângulo duplo permitem reescrever expressões.',
            emphasis: 'Uma identidade não é uma equação para descobrir x; ela vale em todo ponto onde ambos os lados estão definidos.',
          ),
        ],
      ),
      LessonSectionData(
        number: '2',
        title: 'Veja funcionando',
        blocks: [
          WorkedExampleBlockData(
            title: 'Resolver em um intervalo',
            problem: 'Resolva sen x = 1/2 em 0 ≤ x < 2π.',
            steps: ['O ângulo de referência é π/6.', 'Seno é positivo nos quadrantes I e II.', 'As soluções são π/6 e 5π/6.'],
            result: 'x=π/6 ou x=5π/6.',
            interpretation: 'Periodicidade e quadrantes determinam todas as soluções do ciclo.',
          ),
        ],
      ),
      LessonSectionData(
        number: '3',
        title: 'Estratégia',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.checklist,
            title: 'Simplifique antes de resolver',
            content:
                'Quando uma equação contém várias funções trigonométricas, procure reescrever tudo em seno e cosseno ou aplicar uma identidade adequada antes de isolar a variável.',
            tone: LearningCardTone.information,
          ),
        ],
      ),
    ],
    check: LessonCheckData(
      question: 'Qual identidade é sempre verdadeira?',
      choices: ['sen x + cos x = 1', 'sen²x + cos²x = 1', 'tan x = cos x/sen x'],
      correctIndex: 1,
      explanation: 'sen²x + cos²x = 1 é a identidade pitagórica fundamental.',
    ),
    takeaways: [
      'Identidades valem para todos os valores do domínio.',
      'sen²x+cos²x=1 é a relação fundamental.',
      'Equações trigonométricas usam quadrantes e periodicidade.',
      'Simplificação estratégica reduz a dificuldade.',
    ],
    closing: 'Identidades permitem transformar expressões sem alterar seu valor.',
  ),
  CourseLessonData(
    id: 'funcoes-11-inversas-trig',
    topicId: 'funcoes',
    trailTitle: 'Funções — Pré-Cálculo',
    eyebrow: 'Trigonometria',
    title: 'Funções trigonométricas inversas',
    description: 'arco seno, arco cosseno e arco tangente',
    duration: '≈ 18 min',
    objective:
        'interpretar arcsen, arccos e arctan como funções inversas com domínios e imagens restritos',
    symbol: 'arctan',
    sections: [
      LessonSectionData(
        number: '1',
        title: 'É preciso restringir para inverter',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.compare,
            title: 'Funções periódicas não são injetoras globalmente',
            content:
                'Seno e cosseno repetem valores, então restringimos seus domínios antes de definir inversas. arcsen x retorna um ângulo em [−π/2,π/2], arccos x em [0,π] e arctan x em (−π/2,π/2).',
            emphasis: 'sen⁻¹x significa arcsen x, não 1/sen x.',
          ),
        ],
      ),
      LessonSectionData(
        number: '2',
        title: 'Veja funcionando',
        blocks: [
          WorkedExampleBlockData(
            title: 'Recuperar o ângulo principal',
            problem: 'Calcule arcsen(1/2).',
            steps: ['Procure o ângulo no intervalo principal [−π/2,π/2].', 'sen(π/6)=1/2.'],
            result: 'arcsen(1/2)=π/6.',
            interpretation: 'A função inversa devolve o representante escolhido no intervalo principal.',
          ),
        ],
      ),
      LessonSectionData(
        number: '3',
        title: 'Domínio e imagem',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.table,
            title: 'Memorize restrições com significado',
            content:
                'arcsen e arccos recebem apenas valores em [−1,1], pois seno e cosseno nunca saem desse intervalo. arctan aceita qualquer real.',
            tone: LearningCardTone.information,
          ),
        ],
      ),
    ],
    check: LessonCheckData(
      question: 'Qual é o domínio de arcsen x?',
      choices: ['ℝ', '[−1,1]', '(0,+∞)'],
      correctIndex: 1,
      explanation: 'Seno só produz valores entre −1 e 1, então sua inversa só pode receber valores nesse intervalo.',
    ),
    takeaways: [
      'Restringimos funções trigonométricas para torná-las invertíveis.',
      'arcsen e arccos têm domínio [−1,1].',
      'arctan tem domínio ℝ.',
      'Notação inversa não significa recíproco.',
    ],
    closing: 'Funções trigonométricas inversas aparecem em integrais, geometria e resolução de problemas.',
  ),
  CourseLessonData(
    id: 'funcoes-12-geometria-analitica',
    topicId: 'funcoes',
    trailTitle: 'Funções — Pré-Cálculo',
    eyebrow: 'Geometria analítica',
    title: 'Pontos, distância e retas',
    description: 'plano cartesiano, inclinação e equações da reta',
    duration: '≈ 18 min',
    objective:
        'usar distância, ponto médio e inclinação para interpretar retas no plano cartesiano',
    symbol: 'm=Δy/Δx',
    sections: [
      LessonSectionData(
        number: '1',
        title: 'Inclinação mede variação',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.graph,
            title: 'Reta como taxa constante',
            content:
                'Entre dois pontos (x₁,y₁) e (x₂,y₂), a inclinação é m=(y₂−y₁)/(x₂−x₁), se x₂≠x₁. A forma y=mx+b mostra inclinação m e intercepto vertical b.',
            emphasis: 'Inclinação é uma taxa média de variação constante para funções lineares.',
          ),
        ],
      ),
      LessonSectionData(
        number: '2',
        title: 'Veja funcionando',
        blocks: [
          WorkedExampleBlockData(
            title: 'Reta por dois pontos',
            problem: 'Encontre a reta que passa por (1,2) e (4,8).',
            steps: ['m=(8−2)/(4−1)=6/3=2.', 'Use y−2=2(x−1).', 'Expanda: y=2x.'],
            result: 'A reta é y=2x.',
            interpretation: 'A cada unidade acrescentada a x, y cresce 2 unidades.',
          ),
        ],
      ),
      LessonSectionData(
        number: '3',
        title: 'Distância no plano',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.calculate,
            title: 'Pitágoras em coordenadas',
            content:
                'A distância entre dois pontos é √[(x₂−x₁)²+(y₂−y₁)²]. O ponto médio é ((x₁+x₂)/2,(y₁+y₂)/2).',
            tone: LearningCardTone.information,
          ),
        ],
      ),
    ],
    check: LessonCheckData(
      question: 'Qual é a inclinação entre (0,1) e (2,5)?',
      choices: ['1', '2', '4'],
      correctIndex: 1,
      explanation: 'm=(5−1)/(2−0)=4/2=2.',
    ),
    takeaways: [
      'Inclinação é Δy/Δx.',
      'Reta linear possui taxa de variação constante.',
      'Distância vem do teorema de Pitágoras.',
      'Geometria analítica conecta fórmulas e gráficos.',
    ],
    closing: 'A inclinação da reta prepara diretamente a interpretação geométrica da derivada.',
  ),
  CourseLessonData(
    id: 'funcoes-13-conicas',
    topicId: 'funcoes',
    trailTitle: 'Funções — Pré-Cálculo',
    eyebrow: 'Geometria analítica',
    title: 'Cônicas em duas dimensões',
    description: 'circunferência, parábola, elipse e hipérbole',
    duration: '≈ 20 min',
    objective:
        'reconhecer as formas padrão das principais cônicas e interpretar seus parâmetros geométricos',
    symbol: 'x²+y²',
    sections: [
      LessonSectionData(
        number: '1',
        title: 'Quatro famílias geométricas',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.compare,
            title: 'A forma algébrica revela a curva',
            content:
                'Circunferência: (x−h)²+(y−k)²=r². Elipse: soma de dois termos quadráticos positivos normalizados por eixos distintos. Hipérbole: diferença entre termos quadráticos. Parábola: uma variável aparece ao quadrado e a outra, em forma padrão, aparece linearmente.',
            emphasis: 'Completar quadrados ajuda a transformar equações gerais em formas padrão.',
          ),
        ],
      ),
      LessonSectionData(
        number: '2',
        title: 'Veja funcionando',
        blocks: [
          WorkedExampleBlockData(
            title: 'Ler uma circunferência',
            problem: 'Interprete (x−2)²+(y+1)²=9.',
            steps: ['Compare com (x−h)²+(y−k)²=r².', 'h=2 e k=−1.', 'r²=9, então r=3.'],
            result: 'Centro (2,−1) e raio 3.',
            interpretation: 'A equação codifica diretamente posição e tamanho da circunferência.',
          ),
        ],
      ),
      LessonSectionData(
        number: '3',
        title: 'Nem toda cônica é função y=f(x)',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.warning,
            title: 'Teste da reta vertical continua valendo',
            content:
                'Uma circunferência completa não é gráfico de uma única função y=f(x), pois algumas retas verticais cortam a curva em dois pontos.',
            tone: LearningCardTone.warning,
          ),
        ],
      ),
    ],
    check: LessonCheckData(
      question: 'Em x²+y²=25, qual é o raio?',
      choices: ['5', '25', '√50'],
      correctIndex: 0,
      explanation: 'r²=25, então r=5.',
    ),
    takeaways: [
      'Cônicas têm formas padrão reconhecíveis.',
      'Circunferência codifica centro e raio.',
      'Elipse e hipérbole usam dois termos quadráticos.',
      'Uma curva pode não ser função global de x.',
    ],
    closing: 'Cônicas ampliam a leitura geométrica antes de estudar curvas e superfícies mais avançadas.',
  ),
  CourseLessonData(
    id: 'funcoes-14-taxa-media-sintese',
    topicId: 'funcoes',
    trailTitle: 'Funções — Pré-Cálculo',
    eyebrow: 'Ponte para Cálculo',
    title: 'Taxa média de variação e síntese',
    description: 'secantes, comportamento e preparação para limites',
    duration: '≈ 20 min',
    objective:
        'calcular taxa média de variação e conectar álgebra, gráficos e funções à ideia que dará origem à derivada',
    symbol: 'Δy/Δx',
    sections: [
      LessonSectionData(
        number: '1',
        title: 'Variação de saída por variação de entrada',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.graph,
            title: 'Taxa média é inclinação de secante',
            content:
                'Entre x=a e x=b, a taxa média de variação de f é [f(b)−f(a)]/(b−a). Geometricamente, ela é a inclinação da reta secante que passa pelos pontos (a,f(a)) e (b,f(b)).',
            emphasis: 'A derivada nascerá quando fizermos b se aproximar de a.',
          ),
        ],
      ),
      LessonSectionData(
        number: '2',
        title: 'Veja funcionando',
        blocks: [
          WorkedExampleBlockData(
            title: 'Taxa média em uma quadrática',
            problem: 'Para f(x)=x², calcule a taxa média de variação entre x=1 e x=3.',
            steps: ['f(1)=1 e f(3)=9.', 'Δy=9−1=8.', 'Δx=3−1=2.', 'Taxa média=8/2=4.'],
            result: 'A taxa média é 4.',
            interpretation: 'A secante entre (1,1) e (3,9) possui inclinação 4.',
          ),
        ],
      ),
      LessonSectionData(
        number: '3',
        title: 'Mapa do que você construiu',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.checklist,
            title: 'Pré-Cálculo vira linguagem para Cálculo',
            content:
                'Domínio diz onde a função existe; gráficos mostram comportamento; álgebra permite simplificar; trigonometria amplia modelos periódicos; exponenciais e logaritmos descrevem crescimento; taxa média prepara a ideia de taxa instantânea.',
            tone: LearningCardTone.success,
          ),
        ],
      ),
    ],
    check: LessonCheckData(
      question: 'A taxa média [f(b)−f(a)]/(b−a) representa geometricamente:',
      choices: ['Inclinação da secante', 'Área sob o gráfico', 'Valor máximo da função'],
      correctIndex: 0,
      explanation: 'Ela é a inclinação da reta que une os dois pontos do gráfico.',
    ),
    takeaways: [
      'Taxa média mede Δsaída/Δentrada.',
      'Geometricamente, é a inclinação de uma secante.',
      'A derivada surge de um limite dessa taxa.',
      'Todo o Pré-Cálculo converge para interpretação de funções.',
    ],
    closing: 'Com esta base, Limites deixam de ser um assunto isolado e passam a ser a próxima etapa natural.',
  ),
];

const List<CourseLessonData> _englishLessons = [
  CourseLessonData(
    id: 'funcoes-01-conceito-dominio-imagem',
    topicId: 'funcoes',
    trailTitle: 'Functions — Precalculus',
    eyebrow: 'Foundations',
    title: 'Functions, domain, and range',
    description: 'inputs, outputs, notation, and restrictions',
    duration: '≈ 18 min',
    objective:
        'interpret a function as a rule between quantities, distinguish domain from range, and recognize basic algebraic restrictions',
    symbol: 'f(x)',
    sections: [
      LessonSectionData(
        number: '1',
        title: 'One input, exactly one output',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.route,
            title: 'A function is a correspondence',
            content:
                'A function assigns each allowed input x exactly one output f(x). Different inputs may share an output, but one input cannot have two different outputs in the same function.',
            emphasis: 'f(3) is a function value, not f multiplied by 3.',
          ),
          ConceptBlockData(
            visual: LessonVisual.notation,
            title: 'The domain contains allowed inputs',
            content:
                'Over the real numbers, denominators cannot be zero and even roots require nonnegative radicands. The range contains the outputs the function actually produces.',
          ),
        ],
      ),
      LessonSectionData(
        number: '2',
        title: 'See it in action',
        blocks: [
          WorkedExampleBlockData(
            title: 'Domain with two restrictions',
            problem: 'Find the domain of f(x)=√(x−1)/(x−4).',
            steps: ['Require x−1≥0, so x≥1.', 'Require x−4≠0, so x≠4.', 'Combine both conditions.'],
            result: 'Domain: [1,4) ∪ (4,+∞).',
            interpretation: 'The domain is the intersection of all conditions required by the formula.',
          ),
        ],
      ),
      LessonSectionData(
        number: '3',
        title: 'Common mistake',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.warning,
            title: 'Domain and range are different',
            content: 'Domain describes allowed inputs; range describes produced outputs.',
            tone: LearningCardTone.warning,
          ),
        ],
      ),
    ],
    check: LessonCheckData(
      question: 'Which value is excluded from g(x)=1/(x+2)?',
      choices: ['−2', '0', '2'],
      correctIndex: 0,
      explanation: 'x=−2 makes the denominator zero.',
    ),
    takeaways: ['Each domain input has one output.', 'Domain contains allowed inputs.', 'Range contains produced outputs.', 'Restrictions must be combined.'],
    closing: 'Domain and range remain central in limits, continuity, and derivatives.',
  ),
  CourseLessonData(
    id: 'funcoes-02-composicao-inversa',
    topicId: 'funcoes',
    trailTitle: 'Functions — Precalculus',
    eyebrow: 'Structure',
    title: 'Composition and inverse functions',
    description: 'successive processes, one-to-one behavior, and inversion',
    duration: '≈ 18 min',
    objective: 'compose functions and determine when a function has an inverse',
    symbol: 'f∘g',
    sections: [
      LessonSectionData(number: '1', title: 'One function can feed another', blocks: [
        ConceptBlockData(visual: LessonVisual.transform, title: 'Composition has an order', content: '(f∘g)(x)=f(g(x)): apply g first, then feed its output into f. In general f∘g and g∘f are different.', emphasis: 'The composite domain must satisfy both stages.'),
        ConceptBlockData(visual: LessonVisual.compare, title: 'The inverse undoes a function', content: 'For a one-to-one function, f⁻¹ exchanges inputs and outputs. Its graph is the reflection of f across y=x.'),
      ]),
      LessonSectionData(number: '2', title: 'See it in action', blocks: [
        WorkedExampleBlockData(title: 'Compose and invert', problem: 'If f(x)=2x+3 and g(x)=x², find (f∘g)(2) and f⁻¹(x).', steps: ['g(2)=4.', 'f(4)=11.', 'Write y=2x+3, swap x and y, then solve for y.'], result: '(f∘g)(2)=11 and f⁻¹(x)=(x−3)/2.', interpretation: 'Composition chains rules; an inverse recovers the input.'),
      ]),
      LessonSectionData(number: '3', title: 'Graph test', blocks: [
        ConceptBlockData(visual: LessonVisual.graph, title: 'Horizontal-line test', content: 'If a horizontal line meets the graph more than once, the function is not globally one-to-one on that domain.', tone: LearningCardTone.information),
      ]),
    ],
    check: LessonCheckData(question: 'In (f∘g)(x), which function acts first?', choices: ['f', 'g', 'Both at once'], correctIndex: 1, explanation: '(f∘g)(x)=f(g(x)), so g acts first.'),
    takeaways: ['Composition chains functions.', 'Order matters.', 'An inverse swaps input and output.', 'One-to-one behavior is required for a global inverse.'],
    closing: 'Composition and inversion return directly in the chain rule and elementary functions.',
  ),
  CourseLessonData(
    id: 'funcoes-03-transformacoes-graficos', topicId: 'funcoes', trailTitle: 'Functions — Precalculus', eyebrow: 'Graphs', title: 'Graph transformations', description: 'translations, reflections, and scaling', duration: '≈ 16 min', objective: 'predict graph changes from algebraic transformations', symbol: 'f(x−h)',
    sections: [
      LessonSectionData(number: '1', title: 'Read the transformation before drawing', blocks: [ConceptBlockData(visual: LessonVisual.graph, title: 'Outside versus inside', content: 'f(x)+k shifts vertically; f(x−h) shifts right by h; −f(x) reflects across the x-axis; f(−x) reflects across the y-axis.', emphasis: 'Inside horizontal shifts use the opposite-looking sign.')]),
      LessonSectionData(number: '2', title: 'See it in action', blocks: [WorkedExampleBlockData(title: 'From the basic parabola', problem: 'Describe y=−2(x−3)²+1 from y=x².', steps: ['Shift right 3.', 'Reflect across x-axis and stretch vertically by 2.', 'Shift up 1.'], result: 'Vertex (3,1), opening downward.', interpretation: 'The algebraic form encodes the graph geometry.')]),
      LessonSectionData(number: '3', title: 'Common mistake', blocks: [ConceptBlockData(visual: LessonVisual.warning, title: '−f(x) and f(−x) are different', content: 'The first reflects outputs across x-axis; the second reflects inputs across y-axis.', tone: LearningCardTone.warning)]),
    ],
    check: LessonCheckData(question: 'What does f(x+4) do?', choices: ['Shift left 4', 'Shift right 4', 'Shift up 4'], correctIndex: 0, explanation: 'Adding inside the argument shifts left.'),
    takeaways: ['Outside changes affect outputs.', 'Inside changes affect inputs.', 'Negative signs produce different reflections.', 'Transformations help sketch families of functions.'],
    closing: 'Graph transformations make later function analysis faster.',
  ),
  CourseLessonData(
    id: 'funcoes-04-polinomiais', topicId: 'funcoes', trailTitle: 'Functions — Precalculus', eyebrow: 'Classical functions', title: 'Polynomial functions', description: 'degree, zeros, multiplicity, and end behavior', duration: '≈ 18 min', objective: 'analyze zeros, degree, multiplicity, and end behavior of polynomial functions', symbol: 'P(x)',
    sections: [
      LessonSectionData(number: '1', title: 'Degree controls dominant behavior', blocks: [ConceptBlockData(visual: LessonVisual.graph, title: 'Zeros connect algebra and graphs', content: 'If P(a)=0, then x=a is a zero and x−a is a factor. Multiplicity helps predict whether the graph crosses or only touches the x-axis.', emphasis: 'For large |x|, the leading term dominates.')]),
      LessonSectionData(number: '2', title: 'See it in action', blocks: [WorkedExampleBlockData(title: 'Zeros and multiplicity', problem: 'Analyze P(x)=(x−2)²(x+1).', steps: ['Zeros are 2 and −1.', '2 has multiplicity 2, so the graph tends to touch.', '−1 has multiplicity 1, so the graph crosses.', 'Total degree is 3.'], result: 'Cubic with zeros −1 and 2, with 2 a double zero.', interpretation: 'Factored form exposes geometry quickly.')]),
      LessonSectionData(number: '3', title: 'Calculus connection', blocks: [ConceptBlockData(visual: LessonVisual.infinity, title: 'Leading terms prepare limits at infinity', content: 'Dominant-term reasoning will return in limits at infinity and growth comparison.', tone: LearningCardTone.information)]),
    ],
    check: LessonCheckData(question: 'Which is a zero of (x−5)(x+2)?', choices: ['5', '2', '−5'], correctIndex: 0, explanation: 'x=5 makes x−5 equal zero.'),
    takeaways: ['Zeros correspond to factors.', 'Multiplicity affects local graph shape.', 'Degree identifies dominant behavior.', 'Factored form supports graph reading.'],
    closing: 'Polynomials are core models for function behavior.',
  ),
  CourseLessonData(
    id: 'funcoes-05-racionais', topicId: 'funcoes', trailTitle: 'Functions — Precalculus', eyebrow: 'Classical functions', title: 'Rational functions and asymptotes', description: 'domain, zeros, and asymptotic behavior', duration: '≈ 18 min', objective: 'analyze domains, zeros, discontinuities, and simple asymptotes of rational functions', symbol: 'P/Q',
    sections: [
      LessonSectionData(number: '1', title: 'The denominator controls restrictions', blocks: [ConceptBlockData(visual: LessonVisual.infinity, title: 'Denominator zeros matter', content: 'A rational function is P(x)/Q(x) with Q(x)≠0. Zeros of Q are excluded and may create vertical asymptotes or removable discontinuities.', emphasis: 'Canceling a factor does not restore an originally forbidden point.')]),
      LessonSectionData(number: '2', title: 'See it in action', blocks: [WorkedExampleBlockData(title: 'Vertical and horizontal asymptotes', problem: 'Analyze f(x)=(2x+1)/(x−3).', steps: ['Exclude x=3.', 'No cancellation occurs, so x=3 is a vertical-asymptote candidate.', 'Both polynomials have degree 1.', 'Leading-coefficient ratio is 2.'], result: 'Vertical asymptote x=3 and horizontal asymptote y=2.', interpretation: 'Asymptotes describe trends near restrictions and at infinity.')]),
      LessonSectionData(number: '3', title: 'Common mistake', blocks: [ConceptBlockData(visual: LessonVisual.warning, title: 'A hole stays outside the original domain', content: 'A canceled factor may simplify the formula but not the original domain.', tone: LearningCardTone.warning)]),
    ],
    check: LessonCheckData(question: 'Which value is excluded from (x+1)/(x−7)?', choices: ['−1', '1', '7'], correctIndex: 2, explanation: 'x=7 makes the denominator zero.'),
    takeaways: ['Exclude denominator zeros.', 'Common factors can create holes.', 'Vertical asymptotes occur near some restrictions.', 'Degrees help predict end behavior.'],
    closing: 'Rational functions connect directly to limits and continuity.',
  ),
  CourseLessonData(
    id: 'funcoes-06-exponenciais', topicId: 'funcoes', trailTitle: 'Functions — Precalculus', eyebrow: 'Classical functions', title: 'Exponential functions', description: 'growth, decay, and the number e', duration: '≈ 16 min', objective: 'interpret exponential functions and distinguish growth from decay', symbol: 'aˣ',
    sections: [
      LessonSectionData(number: '1', title: 'The variable is in the exponent', blocks: [ConceptBlockData(visual: LessonVisual.graph, title: 'The base controls growth', content: 'For f(x)=aˣ with a>0 and a≠1, a>1 gives growth and 0<a<1 gives decay. Domain is ℝ and range is (0,+∞).', emphasis: 'An exponential function never equals zero.'), ConceptBlockData(visual: LessonVisual.idea, title: 'e is natural in Calculus', content: 'The number e≈2.718 appears in continuous growth and gives especially simple derivative rules.')]),
      LessonSectionData(number: '2', title: 'See it in action', blocks: [WorkedExampleBlockData(title: 'Growth model', problem: 'P(t)=100·2ᵗ. Find P(3).', steps: ['P(3)=100·2³.', '2³=8.', '100·8=800.'], result: 'P(3)=800.', interpretation: 'The quantity doubles each time unit.')]),
      LessonSectionData(number: '3', title: 'Compare', blocks: [ConceptBlockData(visual: LessonVisual.compare, title: 'Exponential versus power', content: 'x² has the variable in the base, while 2ˣ has it in the exponent.', tone: LearningCardTone.information)]),
    ],
    check: LessonCheckData(question: 'Which function represents exponential decay?', choices: ['2ˣ', '(1/2)ˣ', 'x²'], correctIndex: 1, explanation: 'A base between 0 and 1 produces decay.'),
    takeaways: ['The variable is in the exponent.', 'Base >1 gives growth.', '0<base<1 gives decay.', 'eˣ is central in Calculus.'],
    closing: 'Exponentials model processes whose change scales with current size.',
  ),
  CourseLessonData(
    id: 'funcoes-07-logaritmos', topicId: 'funcoes', trailTitle: 'Functions — Precalculus', eyebrow: 'Classical functions', title: 'Logarithms', description: 'definition, properties, and inverse relationship', duration: '≈ 18 min', objective: 'interpret logarithms as exponents and use basic logarithmic properties', symbol: 'logₐx',
    sections: [
      LessonSectionData(number: '1', title: 'A logarithm asks for an exponent', blocks: [ConceptBlockData(visual: LessonVisual.notation, title: 'Core definition', content: 'logₐ(b)=c means aᶜ=b, where a>0, a≠1, and b>0. The logarithm is the inverse of the exponential function.', emphasis: 'A logarithm argument must be positive.'), ConceptBlockData(visual: LessonVisual.calculate, title: 'Properties come from exponents', content: 'logₐ(xy)=logₐx+logₐy, logₐ(x/y)=logₐx−logₐy, and logₐ(xʳ)=r logₐx when defined.')]),
      LessonSectionData(number: '2', title: 'See it in action', blocks: [WorkedExampleBlockData(title: 'Simple logarithmic equation', problem: 'Solve log₂x=5.', steps: ['Rewrite as 2⁵=x.', '2⁵=32.', 'Check x>0.'], result: 'x=32.', interpretation: 'The logarithm asks which exponent produces the argument.')]),
      LessonSectionData(number: '3', title: 'Common mistake', blocks: [ConceptBlockData(visual: LessonVisual.warning, title: 'Logs do not distribute over sums', content: 'In general log(x+y) ≠ log x + log y.', tone: LearningCardTone.warning)]),
    ],
    check: LessonCheckData(question: 'What is log₁₀(1000)?', choices: ['2', '3', '10'], correctIndex: 1, explanation: '10³=1000.'),
    takeaways: ['A logarithm is an exponent.', 'Logs and exponentials are inverses.', 'The argument must be positive.', 'Log properties mirror exponent rules.'],
    closing: 'Logarithms are natural tools for growth, rates, and scales.',
  ),
  CourseLessonData(
    id: 'funcoes-08-radianos-circulo', topicId: 'funcoes', trailTitle: 'Functions — Precalculus', eyebrow: 'Trigonometry', title: 'Radians and the unit circle', description: 'angles, arcs, and unit-circle coordinates', duration: '≈ 20 min', objective: 'convert degrees and radians and interpret sine and cosine on the unit circle', symbol: 'π rad',
    sections: [
      LessonSectionData(number: '1', title: 'Radians measure angle through arc length', blocks: [ConceptBlockData(visual: LessonVisual.route, title: 'π rad = 180°', content: 'A full turn is 2π radians or 360°. Thus 90°=π/2, 180°=π, and 270°=3π/2.', emphasis: 'Calculus trigonometric formulas assume radians.'), ConceptBlockData(visual: LessonVisual.graph, title: 'The unit circle converts angle to coordinates', content: 'At angle θ, the unit-circle point is (cos θ, sin θ).')]),
      LessonSectionData(number: '2', title: 'See it in action', blocks: [WorkedExampleBlockData(title: 'Convert and locate', problem: 'Convert 150° to radians.', steps: ['Multiply by π/180.', '150π/180 simplifies to 5π/6.'], result: '150°=5π/6.', interpretation: 'This angle lies in quadrant II.')]),
      LessonSectionData(number: '3', title: 'Reference values', blocks: [ConceptBlockData(visual: LessonVisual.table, title: 'Know the main angles', content: '0, π/6, π/4, π/3, and π/2 anchor exact sine and cosine values.', tone: LearningCardTone.information)]),
    ],
    check: LessonCheckData(question: '90° equals:', choices: ['π/4', 'π/2', 'π'], correctIndex: 1, explanation: '90° is one quarter turn, equal to π/2 radians.'),
    takeaways: ['2π rad=360°.', 'cos θ is the x-coordinate.', 'sin θ is the y-coordinate.', 'Radians are natural in Calculus.'],
    closing: 'The unit circle connects geometry, graphs, and periodic functions.',
  ),
  CourseLessonData(
    id: 'funcoes-09-trigonometricas-graficos', topicId: 'funcoes', trailTitle: 'Functions — Precalculus', eyebrow: 'Trigonometry', title: 'Trigonometric functions and graphs', description: 'sine, cosine, tangent, period, and amplitude', duration: '≈ 20 min', objective: 'interpret domains, ranges, periods, amplitudes, and graphs of sine, cosine, and tangent', symbol: 'sin x',
    sections: [
      LessonSectionData(number: '1', title: 'Periodicity repeats behavior', blocks: [ConceptBlockData(visual: LessonVisual.graph, title: 'Sine and cosine oscillate', content: 'sin x and cos x have period 2π and range [−1,1]. In A sin(Bx), |A| controls amplitude and 2π/|B| controls period.', emphasis: 'Tangent has period π and is undefined where cos x=0.')]),
      LessonSectionData(number: '2', title: 'See it in action', blocks: [WorkedExampleBlockData(title: 'Amplitude and period', problem: 'Analyze y=3sin(2x).', steps: ['Amplitude is 3.', 'Period is 2π/2=π.', 'Range is [−3,3].'], result: 'Amplitude 3, period π.', interpretation: 'The graph oscillates higher and cycles twice as fast as sin x.')]),
      LessonSectionData(number: '3', title: 'Different domains', blocks: [ConceptBlockData(visual: LessonVisual.warning, title: 'Tangent has asymptotes', content: 'tan x=sin x/cos x, so zeros of cosine are excluded.', tone: LearningCardTone.warning)]),
    ],
    check: LessonCheckData(question: 'What is the period of cos x?', choices: ['π/2', 'π', '2π'], correctIndex: 2, explanation: 'Cosine repeats every 2π radians.'),
    takeaways: ['Sine and cosine have period 2π.', 'Tangent has period π.', 'Amplitude controls vertical oscillation.', 'Tangent excludes cosine zeros.'],
    closing: 'Trigonometric graphs are essential for limits, derivatives, and periodic models.',
  ),
  CourseLessonData(
    id: 'funcoes-10-identidades-equacoes-trig', topicId: 'funcoes', trailTitle: 'Functions — Precalculus', eyebrow: 'Trigonometry', title: 'Trigonometric identities and equations', description: 'fundamental identities and periodic solutions', duration: '≈ 20 min', objective: 'use basic identities and solve elementary trigonometric equations', symbol: 'sin²+cos²',
    sections: [
      LessonSectionData(number: '1', title: 'Identities are always-valid equations', blocks: [ConceptBlockData(visual: LessonVisual.notation, title: 'Fundamental identity', content: 'sin²x+cos²x=1 and tan x=sin x/cos x when cos x≠0. Sum, difference, and double-angle formulas provide further rewrites.', emphasis: 'An identity is not an equation with isolated solution values.')]),
      LessonSectionData(number: '2', title: 'See it in action', blocks: [WorkedExampleBlockData(title: 'Solve on one cycle', problem: 'Solve sin x=1/2 for 0≤x<2π.', steps: ['Reference angle is π/6.', 'Sine is positive in quadrants I and II.', 'Solutions are π/6 and 5π/6.'], result: 'x=π/6 or 5π/6.', interpretation: 'Quadrants and periodicity determine solutions.')]),
      LessonSectionData(number: '3', title: 'Strategy', blocks: [ConceptBlockData(visual: LessonVisual.checklist, title: 'Simplify before solving', content: 'Rewrite in common functions or use an identity before isolating the variable.', tone: LearningCardTone.information)]),
    ],
    check: LessonCheckData(question: 'Which identity is always true?', choices: ['sin x+cos x=1', 'sin²x+cos²x=1', 'tan x=cos x/sin x'], correctIndex: 1, explanation: 'sin²x+cos²x=1 is the fundamental identity.'),
    takeaways: ['Identities hold throughout their domain.', 'sin²+cos²=1 is fundamental.', 'Equations use quadrants and periodicity.', 'Strategic rewriting simplifies problems.'],
    closing: 'Identities transform expressions without changing their value.',
  ),
  CourseLessonData(
    id: 'funcoes-11-inversas-trig', topicId: 'funcoes', trailTitle: 'Functions — Precalculus', eyebrow: 'Trigonometry', title: 'Inverse trigonometric functions', description: 'arcsine, arccosine, and arctangent', duration: '≈ 18 min', objective: 'interpret inverse trig functions with restricted domains and ranges', symbol: 'arctan',
    sections: [
      LessonSectionData(number: '1', title: 'Restriction makes inversion possible', blocks: [ConceptBlockData(visual: LessonVisual.compare, title: 'Periodic functions are not globally one-to-one', content: 'We restrict sine and cosine before defining inverses. arcsin returns values in [−π/2,π/2], arccos in [0,π], and arctan in (−π/2,π/2).', emphasis: 'sin⁻¹x means arcsin x, not 1/sin x.')]),
      LessonSectionData(number: '2', title: 'See it in action', blocks: [WorkedExampleBlockData(title: 'Recover the principal angle', problem: 'Find arcsin(1/2).', steps: ['Use the principal interval.', 'sin(π/6)=1/2.'], result: 'arcsin(1/2)=π/6.', interpretation: 'The inverse returns the chosen principal representative.')]),
      LessonSectionData(number: '3', title: 'Domain and range', blocks: [ConceptBlockData(visual: LessonVisual.table, title: 'Restrictions have meaning', content: 'arcsin and arccos accept inputs only in [−1,1]; arctan accepts all real inputs.', tone: LearningCardTone.information)]),
    ],
    check: LessonCheckData(question: 'What is the domain of arcsin x?', choices: ['ℝ', '[−1,1]', '(0,+∞)'], correctIndex: 1, explanation: 'Sine outputs only values from −1 to 1.'),
    takeaways: ['Trig functions need restrictions before inversion.', 'arcsin and arccos have domain [−1,1].', 'arctan has domain ℝ.', 'Inverse notation is not reciprocal notation.'],
    closing: 'Inverse trig functions appear in geometry, integration, and applied problems.',
  ),
  CourseLessonData(
    id: 'funcoes-12-geometria-analitica', topicId: 'funcoes', trailTitle: 'Functions — Precalculus', eyebrow: 'Analytic geometry', title: 'Points, distance, and lines', description: 'coordinate plane, slope, and line equations', duration: '≈ 18 min', objective: 'use distance, midpoint, and slope to interpret lines in the plane', symbol: 'm=Δy/Δx',
    sections: [
      LessonSectionData(number: '1', title: 'Slope measures change', blocks: [ConceptBlockData(visual: LessonVisual.graph, title: 'A line has constant rate', content: 'Between (x₁,y₁) and (x₂,y₂), m=(y₂−y₁)/(x₂−x₁). The form y=mx+b displays slope and y-intercept.', emphasis: 'Slope is a constant average rate of change for linear functions.')]),
      LessonSectionData(number: '2', title: 'See it in action', blocks: [WorkedExampleBlockData(title: 'Line through two points', problem: 'Find the line through (1,2) and (4,8).', steps: ['m=(8−2)/(4−1)=2.', 'Use y−2=2(x−1).', 'Expand to y=2x.'], result: 'y=2x.', interpretation: 'y increases 2 units for each unit of x.')]),
      LessonSectionData(number: '3', title: 'Distance in the plane', blocks: [ConceptBlockData(visual: LessonVisual.calculate, title: 'Pythagoras in coordinates', content: 'Distance is √[(x₂−x₁)²+(y₂−y₁)²], and midpoint is ((x₁+x₂)/2,(y₁+y₂)/2).', tone: LearningCardTone.information)]),
    ],
    check: LessonCheckData(question: 'Slope between (0,1) and (2,5)?', choices: ['1', '2', '4'], correctIndex: 1, explanation: '(5−1)/(2−0)=2.'),
    takeaways: ['Slope is Δy/Δx.', 'Lines have constant rate.', 'Distance comes from Pythagoras.', 'Analytic geometry connects formulas and graphs.'],
    closing: 'Slope prepares the geometric meaning of derivative.',
  ),
  CourseLessonData(
    id: 'funcoes-13-conicas', topicId: 'funcoes', trailTitle: 'Functions — Precalculus', eyebrow: 'Analytic geometry', title: 'Conic sections in 2D', description: 'circle, parabola, ellipse, and hyperbola', duration: '≈ 20 min', objective: 'recognize standard forms of major conics and interpret their geometric parameters', symbol: 'x²+y²',
    sections: [
      LessonSectionData(number: '1', title: 'Four geometric families', blocks: [ConceptBlockData(visual: LessonVisual.compare, title: 'Algebraic form reveals the curve', content: 'Circle: (x−h)²+(y−k)²=r². Ellipses use a sum of normalized squared terms; hyperbolas use a difference; parabolas have one squared variable in standard orientation.', emphasis: 'Completing the square helps recover standard forms.')]),
      LessonSectionData(number: '2', title: 'See it in action', blocks: [WorkedExampleBlockData(title: 'Read a circle', problem: 'Interpret (x−2)²+(y+1)²=9.', steps: ['Compare with standard form.', 'Center is (2,−1).', 'Radius is 3.'], result: 'Center (2,−1), radius 3.', interpretation: 'The equation directly encodes position and size.')]),
      LessonSectionData(number: '3', title: 'Not every conic is y=f(x)', blocks: [ConceptBlockData(visual: LessonVisual.warning, title: 'The vertical-line test still applies', content: 'A complete circle is not the graph of a single function y=f(x).', tone: LearningCardTone.warning)]),
    ],
    check: LessonCheckData(question: 'What is the radius of x²+y²=25?', choices: ['5', '25', '√50'], correctIndex: 0, explanation: 'r²=25, so r=5.'),
    takeaways: ['Conics have recognizable standard forms.', 'A circle encodes center and radius.', 'Ellipses and hyperbolas use two squared terms.', 'A curve need not be a function of x globally.'],
    closing: 'Conics broaden geometric interpretation before more advanced curves.',
  ),
  CourseLessonData(
    id: 'funcoes-14-taxa-media-sintese', topicId: 'funcoes', trailTitle: 'Functions — Precalculus', eyebrow: 'Bridge to Calculus', title: 'Average rate of change and synthesis', description: 'secant lines, behavior, and preparation for limits', duration: '≈ 20 min', objective: 'compute average rate of change and connect Precalculus to the idea of derivative', symbol: 'Δy/Δx',
    sections: [
      LessonSectionData(number: '1', title: 'Output change per input change', blocks: [ConceptBlockData(visual: LessonVisual.graph, title: 'Average rate is secant slope', content: 'Between a and b, average rate is [f(b)−f(a)]/(b−a), the slope of the secant through (a,f(a)) and (b,f(b)).', emphasis: 'Derivative emerges as b approaches a.')]),
      LessonSectionData(number: '2', title: 'See it in action', blocks: [WorkedExampleBlockData(title: 'Average rate for a quadratic', problem: 'For f(x)=x², find the average rate from x=1 to x=3.', steps: ['f(1)=1 and f(3)=9.', 'Δy=8.', 'Δx=2.', 'Rate=4.'], result: 'Average rate=4.', interpretation: 'The secant through (1,1) and (3,9) has slope 4.')]),
      LessonSectionData(number: '3', title: 'Your Precalculus map', blocks: [ConceptBlockData(visual: LessonVisual.checklist, title: 'Everything now feeds Calculus', content: 'Domain tells where functions exist; algebra simplifies; graphs show behavior; trig models periodicity; exponentials and logs model growth; average rate prepares instantaneous rate.', tone: LearningCardTone.success)]),
    ],
    check: LessonCheckData(question: 'Geometrically, average rate of change is:', choices: ['Secant slope', 'Area under the graph', 'Maximum function value'], correctIndex: 0, explanation: 'It is the slope of the line through two graph points.'),
    takeaways: ['Average rate is Δoutput/Δinput.', 'It is secant slope.', 'Derivative is a limit of this rate.', 'Precalculus converges on function interpretation.'],
    closing: 'With this foundation, Limits become the natural next step.',
  ),
];
