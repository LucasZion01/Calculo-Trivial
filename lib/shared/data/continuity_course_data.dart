import 'package:calcquest/shared/domain/course_lesson_data.dart';

const List<CourseLessonData> continuityCourseLessons = [
  CourseLessonData(
    id: 'continuidade-01-significado',
    topicId: 'continuidade',
    trailTitle: 'Continuidade • Unidade 1',
    eyebrow: 'Aula 1 de 7 • Ideia central',
    title: 'Quando uma função é contínua?',
    description:
        'Conecte valor da função, limite e comportamento do gráfico em um ponto.',
    duration: '14–18 min',
    objective: 'verificar as três condições de continuidade em um ponto',
    symbol: 'C',
    sections: [
      LessonSectionData(
        number: '1',
        title: 'Pense em ausência de ruptura',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.route,
            title: 'Uma trajetória sem interrupção',
            content:
                'Uma função é contínua em x=a quando o valor previsto pela aproximação coincide com o valor realmente atribuído à função nesse ponto. No gráfico, não há furo, salto ou fuga para o infinito em a.',
            emphasis:
                'A ideia de “desenhar sem tirar o lápis” ajuda, mas a definição matemática é mais precisa.',
          ),
          ConceptBlockData(
            visual: LessonVisual.checklist,
            title: 'As três condições',
            content:
                '1) f(a) deve existir. 2) lim x→a f(x) deve existir. 3) O limite deve ser igual a f(a). Se apenas uma condição falhar, a função não é contínua em a.',
            tone: LearningCardTone.information,
          ),
        ],
      ),
      LessonSectionData(
        number: '2',
        title: 'Aplique a definição na ordem correta',
        blocks: [
          WorkedExampleBlockData(
            title: 'Verificação completa',
            problem: 'f(x)=x²+1. A função é contínua em x=2?',
            steps: [
              'Calcule f(2)=2²+1=5.',
              'Como polinômios aceitam substituição direta, lim x→2 (x²+1)=5.',
              'Compare: o limite existe e é igual a f(2).',
            ],
            result: 'f é contínua em x=2.',
            interpretation:
                'Valor, tendência pela esquerda e tendência pela direita encontram-se em 5.',
          ),
        ],
      ),
    ],
    check: LessonCheckData(
      question:
          'Se lim x→a f(x)=4, mas f(a)=7, a função é contínua em a?',
      choices: ['Sim', 'Não', 'Somente pela direita'],
      correctIndex: 1,
      explanation:
          'A terceira condição falha: o limite precisa coincidir com o valor da função.',
    ),
    takeaways: [
      'Continuidade é uma propriedade analisada em um ponto ou intervalo.',
      'O valor da função e o limite precisam existir.',
      'A igualdade lim x→a f(x)=f(a) completa a verificação.',
    ],
    closing:
        'Na próxima aula, você reconhecerá famílias contínuas sem refazer toda a definição.',
  ),
  CourseLessonData(
    id: 'continuidade-02-dominio',
    topicId: 'continuidade',
    trailTitle: 'Continuidade • Unidade 1',
    eyebrow: 'Aula 2 de 7 • Famílias e domínio',
    title: 'Continuidade no domínio',
    description:
        'Use propriedades de polinômios, racionais, raízes e trigonometria.',
    duration: '16–20 min',
    objective: 'determinar intervalos de continuidade a partir do domínio',
    symbol: 'D',
    sections: [
      LessonSectionData(
        number: '1',
        title: 'Reconheça funções conhecidas',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.checklist,
            title: 'Famílias contínuas',
            content:
                'Polinômios, seno, cosseno e exponenciais são contínuos em todos os reais. Funções racionais são contínuas onde o denominador não zera. Raízes de índice par são contínuas onde o radicando é não negativo.',
            emphasis:
                'Dizer “contínua em seu domínio” não inclui pontos onde a expressão nem sequer está definida.',
          ),
          ConceptBlockData(
            visual: LessonVisual.transform,
            title: 'Operações preservam continuidade',
            content:
                'Somas, produtos e composições de funções contínuas continuam contínuos onde as operações estão definidas. Quocientes também, desde que o denominador seja diferente de zero.',
            tone: LearningCardTone.information,
          ),
        ],
      ),
      LessonSectionData(
        number: '2',
        title: 'Encontre intervalos',
        blocks: [
          WorkedExampleBlockData(
            title: 'Uma função racional',
            problem: 'f(x)=(x+1)/(x−2)',
            steps: [
              'O numerador e o denominador são polinômios.',
              'Encontre onde o denominador zera: x−2=0, então x=2.',
              'Exclua esse ponto e separe o domínio em intervalos.',
            ],
            result: 'f é contínua em (−∞,2) e (2,+∞).',
            interpretation:
                'A expressão possui uma ruptura em x=2 porque a divisão deixa de estar definida.',
          ),
        ],
      ),
    ],
    check: LessonCheckData(
      question: 'Onde √(x−3) é contínua no conjunto dos reais?',
      choices: ['[3,+∞)', 'Todo ℝ', '(−∞,3]'],
      correctIndex: 0,
      explanation:
          'A raiz exige x−3≥0. A função é contínua em todo o domínio resultante.',
    ),
    takeaways: [
      'Comece encontrando o domínio da expressão.',
      'Funções racionais excluem zeros do denominador.',
      'Operações e composições preservam continuidade quando definidas.',
    ],
    closing:
        'Agora você classificará o que acontece nos pontos em que a continuidade falha.',
  ),
  CourseLessonData(
    id: 'continuidade-03-descontinuidades',
    topicId: 'continuidade',
    trailTitle: 'Continuidade • Unidade 2',
    eyebrow: 'Aula 3 de 7 • Classificação',
    title: 'Furos, saltos e assíntotas',
    description:
        'Diferencie descontinuidades removíveis, de salto e infinitas.',
    duration: '18–22 min',
    objective: 'classificar uma descontinuidade pelo comportamento dos limites',
    symbol: '!',
    sections: [
      LessonSectionData(
        number: '1',
        title: 'Observe como a aproximação falha',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.warning,
            title: 'Três tipos principais',
            content:
                'Removível: o limite existe e é finito, mas o valor está ausente ou diferente. Salto: os limites laterais são finitos e diferentes. Infinita: a função cresce em módulo sem limite perto do ponto.',
            emphasis:
                'A classificação depende dos limites, não apenas da aparência do gráfico.',
            tone: LearningCardTone.warning,
          ),
          ConceptBlockData(
            visual: LessonVisual.graph,
            title: 'A função parte inteira',
            content:
                'Em cada número inteiro, a função ⌊x⌋ muda de nível abruptamente. O valor que chega pela esquerda difere do valor pela direita, formando saltos.',
          ),
        ],
      ),
      LessonSectionData(
        number: '2',
        title: 'Classifique com evidências',
        blocks: [
          WorkedExampleBlockData(
            title: 'Assíntota vertical',
            problem: 'f(x)=1/(x−2), perto de x=2',
            steps: [
              'Pela direita, x−2 é positivo e muito pequeno: f(x)→+∞.',
              'Pela esquerda, x−2 é negativo e muito pequeno: f(x)→−∞.',
              'Os valores crescem sem limite em módulo.',
            ],
            result: 'Há uma descontinuidade infinita em x=2.',
            interpretation:
                'A reta x=2 funciona como assíntota vertical.',
          ),
        ],
      ),
    ],
    check: LessonCheckData(
      question:
          'O limite em a existe e vale 3, mas f(a) não existe. Qual é o tipo?',
      choices: ['Removível', 'Salto', 'Infinita'],
      correctIndex: 0,
      explanation:
          'Basta definir f(a)=3 para reparar a continuidade naquele ponto.',
    ),
    takeaways: [
      'Furos correspondem a descontinuidades removíveis.',
      'Limites laterais diferentes caracterizam saltos.',
      'Crescimento ilimitado perto do ponto indica descontinuidade infinita.',
    ],
    closing:
        'Na próxima aula, os limites laterais serão usados em funções definidas por partes.',
  ),
  CourseLessonData(
    id: 'continuidade-04-partes',
    topicId: 'continuidade',
    trailTitle: 'Continuidade • Unidade 2',
    eyebrow: 'Aula 4 de 7 • Funções por partes',
    title: 'Encontro entre duas regras',
    description:
        'Verifique continuidade em pontos de troca e nos extremos de intervalos.',
    duration: '18–22 min',
    objective: 'comparar limites laterais em funções definidas por partes',
    symbol: '{',
    sections: [
      LessonSectionData(
        number: '1',
        title: 'Cada lado usa sua própria regra',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.compare,
            title: 'O ponto de troca',
            content:
                'Para x<a, use a primeira expressão ao calcular o limite pela esquerda. Para x>a, use a segunda no limite pela direita. Depois confira qual regra contém o sinal de igualdade e determina f(a).',
            emphasis:
                'As três quantidades precisam coincidir: limite esquerdo, limite direito e valor no ponto.',
          ),
          ConceptBlockData(
            visual: LessonVisual.route,
            title: 'Extremos de um intervalo',
            content:
                'No extremo esquerdo [a,b], só faz sentido aproximar-se por valores do domínio, isto é, pela direita. No extremo direito, usamos o limite pela esquerda.',
            tone: LearningCardTone.information,
          ),
        ],
      ),
      LessonSectionData(
        number: '2',
        title: 'Faça as regras se encontrarem',
        blocks: [
          WorkedExampleBlockData(
            title: 'Duas expressões',
            problem: 'f(x)=x+1 se x<1; f(x)=2x se x≥1',
            steps: [
              'Pela esquerda, x+1 tende a 2.',
              'Pela direita, 2x tende a 2.',
              'Como a segunda regra inclui x=1, f(1)=2.',
            ],
            result: 'A função é contínua em x=1.',
            interpretation:
                'Os dois trechos encontram-se no mesmo ponto sem produzir salto.',
          ),
        ],
      ),
    ],
    check: LessonCheckData(
      question:
          'Em [0,4], qual lado verifica a continuidade no extremo x=4?',
      choices: ['Esquerda', 'Direita', 'Os dois obrigatoriamente'],
      correctIndex: 0,
      explanation:
          'Aproximamo-nos de 4 usando valores menores que pertencem ao intervalo.',
    ),
    takeaways: [
      'Use a regra correspondente a cada lado do ponto de troca.',
      'Confira separadamente o valor definido no ponto.',
      'Nos extremos do domínio, use continuidade unilateral.',
    ],
    closing:
        'A próxima aula transformará a continuidade em uma equação para descobrir parâmetros.',
  ),
  CourseLessonData(
    id: 'continuidade-05-parametros',
    topicId: 'continuidade',
    trailTitle: 'Continuidade • Unidade 3',
    eyebrow: 'Aula 5 de 7 • Reparação',
    title: 'Escolha valores que eliminam rupturas',
    description:
        'Determine parâmetros e redefina pontos para tornar funções contínuas.',
    duration: '18–22 min',
    objective: 'montar e resolver condições de continuidade com parâmetros',
    symbol: 'k',
    sections: [
      LessonSectionData(
        number: '1',
        title: 'Transforme a definição em equação',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.transform,
            title: 'Reparar uma descontinuidade removível',
            content:
                'Se o limite em a existe e é L, definir f(a)=L preenche o furo. Em funções por partes, igualamos as expressões laterais no ponto de troca e resolvemos a equação para o parâmetro.',
            emphasis:
                'Somente descontinuidades removíveis podem ser corrigidas alterando um único valor.',
          ),
        ],
      ),
      LessonSectionData(
        number: '2',
        title: 'Resolva o parâmetro',
        blocks: [
          WorkedExampleBlockData(
            title: 'Ajuste entre duas partes',
            problem: 'f(x)=2x+1 se x<1; f(x)=x+k se x≥1',
            steps: [
              'O limite esquerdo em 1 vale 2(1)+1=3.',
              'O limite direito e f(1) valem 1+k.',
              'Imponha continuidade: 1+k=3.',
              'Resolva a equação: k=2.',
            ],
            result: 'k=2 torna a função contínua.',
            interpretation:
                'O parâmetro desloca o segundo trecho até ele encontrar o primeiro.',
          ),
          WorkedExampleBlockData(
            title: 'Preenchendo um furo',
            problem: 'f(x)=(x²−1)/(x−1), x≠1. Defina f(1).',
            steps: [
              'Fatore x²−1=(x−1)(x+1).',
              'Perto de 1, simplifique para x+1.',
              'Calcule o limite: 1+1=2.',
            ],
            result: 'Defina f(1)=2.',
            interpretation:
                'A nova definição muda apenas o ponto ausente, preservando o restante da função.',
          ),
        ],
      ),
    ],
    check: LessonCheckData(
      question:
          'Se lim x→3 f(x)=8, qual valor deve ser atribuído a f(3) para garantir continuidade?',
      choices: ['3', '8', '0'],
      correctIndex: 1,
      explanation:
          'A continuidade exige que o valor no ponto seja igual ao limite.',
    ),
    takeaways: [
      'Calcule primeiro o valor que a aproximação exige.',
      'Iguale limites laterais para ajustar funções por partes.',
      'Redefinir um ponto corrige apenas descontinuidades removíveis.',
    ],
    closing:
        'Na próxima aula, a continuidade garantirá a existência de valores entre duas medições.',
  ),
  CourseLessonData(
    id: 'continuidade-06-valor-intermediario',
    topicId: 'continuidade',
    trailTitle: 'Continuidade • Unidade 3',
    eyebrow: 'Aula 6 de 7 • Existência',
    title: 'Teorema do Valor Intermediário',
    description:
        'Use continuidade para garantir valores e localizar raízes em intervalos.',
    duration: '16–20 min',
    objective: 'aplicar o Teorema do Valor Intermediário corretamente',
    symbol: '∃',
    sections: [
      LessonSectionData(
        number: '1',
        title: 'Uma função contínua não pula valores',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.route,
            title: 'A garantia do teorema',
            content:
                'Se f é contínua em [a,b], então ela assume todo valor N entre f(a) e f(b). Existe pelo menos um c em [a,b] tal que f(c)=N.',
            emphasis:
                'O teorema garante existência, mas não informa necessariamente onde está o ponto nem se ele é único.',
          ),
          ConceptBlockData(
            visual: LessonVisual.engineering,
            title: 'Detecção de mudança de sinal',
            content:
                'Se uma resposta contínua de um sistema passa de negativa para positiva, ela cruza zero em algum instante. Métodos numéricos usam essa garantia para localizar raízes e pontos de equilíbrio.',
            tone: LearningCardTone.success,
          ),
        ],
      ),
      LessonSectionData(
        number: '2',
        title: 'Verifique as hipóteses',
        blocks: [
          WorkedExampleBlockData(
            title: 'Existência de uma raiz',
            problem: 'f contínua em [1,2], f(1)=−3 e f(2)=4',
            steps: [
              'Confirme a continuidade em todo o intervalo fechado.',
              'Observe que 0 está entre −3 e 4.',
              'Aplique o Teorema do Valor Intermediário.',
            ],
            result: 'Existe pelo menos um c em (1,2) com f(c)=0.',
            interpretation:
                'Não podemos afirmar que c=1,5 nem que exista apenas uma raiz.',
          ),
        ],
      ),
    ],
    check: LessonCheckData(
      question:
          'O TVI garante exatamente uma raiz quando há mudança de sinal?',
      choices: ['Sim', 'Não, garante pelo menos uma', 'Somente para polinômios'],
      correctIndex: 1,
      explanation:
          'A função pode cruzar o eixo várias vezes; o teorema garante existência, não unicidade.',
    ),
    takeaways: [
      'A continuidade deve valer em todo o intervalo fechado.',
      'Todo valor entre f(a) e f(b) é atingido.',
      'Mudança de sinal garante ao menos uma raiz.',
      'O teorema não fornece localização exata nem unicidade.',
    ],
    closing:
        'A aula final reunirá definição, domínio, classificação e aplicações.',
  ),
  CourseLessonData(
    id: 'continuidade-07-sintese',
    topicId: 'continuidade',
    trailTitle: 'Continuidade • Unidade 3',
    eyebrow: 'Aula 7 de 7 • Síntese',
    title: 'Um roteiro para analisar continuidade',
    description:
        'Escolha uma estratégia confiável para pontos, intervalos e funções por partes.',
    duration: '14–18 min',
    objective: 'diagnosticar e justificar problemas de continuidade',
    symbol: '✓',
    sections: [
      LessonSectionData(
        number: '1',
        title: 'Comece pelo tipo de problema',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.checklist,
            title: 'Roteiro de decisão',
            content:
                '1) Encontre o domínio. 2) Se for uma família conhecida, identifique seus intervalos contínuos. 3) Em um ponto especial, verifique valor e limites laterais. 4) Classifique a falha. 5) Se houver parâmetro, transforme a igualdade dos limites em equação.',
            emphasis:
                'Escreva a justificativa: não basta responder apenas “sim” ou “não”.',
          ),
          ConceptBlockData(
            visual: LessonVisual.engineering,
            title: 'Continuidade em modelos reais',
            content:
                'Modelos contínuos representam grandezas que variam sem saltos instantâneos, como posição idealizada, temperatura e deformação. Saltos podem representar comandos, impactos ou mudanças de regime e precisam ser tratados conscientemente.',
            tone: LearningCardTone.success,
          ),
        ],
      ),
      LessonSectionData(
        number: '2',
        title: 'Faça uma verificação final',
        blocks: [
          WorkedExampleBlockData(
            title: 'Diagnóstico em um ponto',
            problem: 'lim x→a f(x)=5 e f(a)=5',
            steps: [
              'O valor f(a) existe.',
              'O limite bilateral existe e é finito.',
              'O limite coincide com o valor da função.',
            ],
            result: 'f é contínua em a.',
            interpretation:
                'A conclusão decorre explicitamente das três condições, não de uma suposição visual.',
          ),
        ],
      ),
    ],
    check: LessonCheckData(
      question:
          'Qual é a primeira verificação ao procurar intervalos de continuidade?',
      choices: ['O domínio', 'A derivada', 'O maior coeficiente'],
      correctIndex: 0,
      explanation:
          'Uma função só pode ser contínua nos pontos em que está definida.',
    ),
    takeaways: [
      'Domínio e família da função orientam a análise global.',
      'Em pontos especiais, aplique as três condições.',
      'Limites laterais classificam saltos e rupturas infinitas.',
      'Continuidade permite garantir valores intermediários.',
    ],
    closing:
        'Você concluiu a teoria essencial de Continuidade. Agora consolide cada decisão na prática.',
  ),
];
