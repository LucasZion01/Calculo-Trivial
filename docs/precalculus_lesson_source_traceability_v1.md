# Rastreabilidade bibliográfica das aulas — Pré-Cálculo v1

Status: matriz pedagógica da branch `content/precalculus-v1`.

Este documento relaciona as aulas da trilha de Pré-Cálculo às fontes canônicas cadastradas em `functions/src/data/bibliography.ts`. Ele não autoriza reprodução de texto ou exercícios dos livros. O conteúdo exibido no Cálculo Trivial permanece autoral; as obras servem para sequência conceitual, terminologia, cobertura, rigor e tipos de raciocínio matemático.

## Regras

- Uma referência só pode aparecer aqui se o respectivo `sourceId:sectionId` existir no catálogo bibliográfico.
- Quando duas ou mais obras cobrem o mesmo núcleo, a aula deve ser conferida contra mais de uma fonte.
- Exemplos e questões do aplicativo devem ser autorais, mesmo quando treinam a mesma habilidade encontrada nas referências.
- A ausência de uma obra específica para um subtema deve ser registrada, não preenchida com metadados inventados.

## Bloco A — Fundamentos e Álgebra

| Aula | Conteúdo central | Referências canônicas |
|---|---|---|
| `precalculo-00-01-reais` | números reais, reta real, intervalos | `guidorizzi_calculo_v1_6ed:numeros_reais`; `iezzi_fme_v1_9ed:conjuntos_numericos` |
| `precalculo-00-02-operacoes` | operações, sinais, prioridade | `guidorizzi_calculo_v1_6ed:numeros_reais`; `iezzi_fme_v1_9ed:conjuntos_numericos` |
| `precalculo-00-03-linguagem` | variáveis, constantes, expressões | `iezzi_fme_v1_9ed:funcoes_elementares`; `guidorizzi_calculo_v1_6ed:funcoes` |
| `precalculo-00-04-potencias-raizes` | potências, raízes, expoentes | `guidorizzi_calculo_v1_6ed:numeros_reais`; `iezzi_fme_v1_9ed:conjuntos_numericos` |
| `precalculo-00-05-modulo` | valor absoluto como distância | `guidorizzi_calculo_v1_6ed:numeros_reais`; `iezzi_fme_v1_9ed:conjuntos_numericos` |
| `algebra-01-linguagem` | linguagem algébrica | `iezzi_fme_v1_9ed:funcoes_elementares`; `guidorizzi_calculo_v1_6ed:funcoes` |
| `algebra-02-termos-semelhantes` | redução algébrica | `iezzi_fme_v1_9ed:funcoes_elementares` |
| `algebra-03-distributiva` | distributiva e sinais | `iezzi_fme_v1_9ed:funcoes_elementares` |
| `algebra-04-potencias` | propriedades de potências | `guidorizzi_calculo_v1_6ed:numeros_reais`; `iezzi_fme_v1_9ed:conjuntos_numericos` |
| `algebra-05-produtos-notaveis` | padrões algébricos | `iezzi_fme_v1_9ed:funcoes_elementares` |
| `algebra-06-fatoracao` | fatoração e zeros | `iezzi_fme_v1_9ed:funcoes_elementares`; `guidorizzi_calculo_v1_6ed:funcoes` |
| `algebra-07-fracoes-algebricas` | simplificação racional e restrições | `guidorizzi_calculo_v1_6ed:funcoes`; `thomas_calculo_v1_12ed:funcoes_graficos` |
| `algebra-08-sintese` | síntese algébrica para Cálculo | `stewart_calculo_v1_8ed:funcoes_modelos`; `guidorizzi_calculo_v1_6ed:funcoes` |

## Bloco B — Equações e Inequações

| Aula | Conteúdo central | Referências canônicas |
|---|---|---|
| `equations-01-equilibrio` | princípio de equivalência | `iezzi_fme_v1_9ed:funcoes_elementares` |
| `equations-02-primeiro-grau` | equações lineares | `iezzi_fme_v1_9ed:funcoes_elementares` |
| `equations-03-parenteses-fracoes` | equações com agrupamentos e frações | `iezzi_fme_v1_9ed:funcoes_elementares` |
| `equations-04-casos-especiais` | identidade e impossibilidade | `iezzi_fme_v1_9ed:funcoes_elementares` |
| `equations-05-sistemas-lineares` | sistemas lineares | `iezzi_fme_v1_9ed:funcoes_elementares` |
| `equations-06-quadraticas` | equações quadráticas | `iezzi_fme_v1_9ed:funcoes_elementares`; `thomas_calculo_v1_12ed:funcoes_graficos` |
| `equations-07-inequacoes` | desigualdades e intervalos | `iezzi_fme_v1_9ed:funcoes_elementares`; `guidorizzi_calculo_v1_6ed:numeros_reais` |
| `equations-08-modulo-revisao` | módulo e revisão | `guidorizzi_calculo_v1_6ed:numeros_reais`; `iezzi_fme_v1_9ed:conjuntos_numericos` |
| `equations-09-radicais` | equações irracionais e soluções estranhas | `iezzi_fme_v1_9ed:equacoes_inequacoes_irracionais` |
| `equations-10-inequacoes-quadraticas` | estudo de sinal quadrático | `iezzi_fme_v1_9ed:funcoes_elementares`; `thomas_calculo_v1_12ed:funcoes_graficos` |
| `equations-11-inequacoes-racionais` | estudo de sinal racional e domínio | `iezzi_fme_v1_9ed:equacoes_inequacoes_irracionais`; `guidorizzi_calculo_v1_6ed:funcoes` |

## Bloco C — Funções e famílias clássicas

| Aula | Conteúdo central | Referências canônicas |
|---|---|---|
| `funcoes-01-conceito-dominio-imagem` | função, domínio e imagem | `stewart_calculo_v1_8ed:funcoes_modelos`; `thomas_calculo_v1_12ed:funcoes_graficos`; `guidorizzi_calculo_v1_6ed:funcoes`; `iezzi_fme_v1_9ed:introducao_funcoes` |
| `funcoes-02-composicao-inversa` | composição e inversa | `guidorizzi_calculo_v1_6ed:operacoes_funcoes`; `guidorizzi_calculo_v1_6ed:funcoes_inversas`; `iezzi_fme_v1_9ed:composicao_inversa` |
| `funcoes-03-transformacoes-graficos` | translações, reflexões e escalas | `thomas_calculo_v1_12ed:transformacoes_graficos`; `stewart_calculo_v1_8ed:funcoes_modelos` |
| `funcoes-04-polinomiais` | zeros, multiplicidade e termo dominante | `iezzi_fme_v1_9ed:funcoes_elementares`; `stewart_calculo_v1_8ed:funcoes_modelos`; `thomas_calculo_v1_12ed:funcoes_graficos` |
| `funcoes-05-racionais` | domínio e assíntotas | `stewart_calculo_v1_8ed:funcoes_modelos`; `thomas_calculo_v1_12ed:funcoes_graficos`; `guidorizzi_calculo_v1_6ed:funcoes` |
| `funcoes-06-exponenciais` | crescimento, decaimento e base e | `guidorizzi_calculo_v1_6ed:exponenciais_logaritmos`; `iezzi_fme_v2_10ed:exponenciais_logaritmos` |
| `funcoes-07-logaritmos` | definição e propriedades de logaritmos | `guidorizzi_calculo_v1_6ed:exponenciais_logaritmos`; `iezzi_fme_v2_10ed:exponenciais_logaritmos` |
| `funcoes-08-radianos-circulo` | radianos e círculo trigonométrico | `thomas_calculo_v1_12ed:trigonometria`; `guidorizzi_calculo_v1_6ed:trigonometria`; `iezzi_fme_v3_9ed:trigonometria` |
| `funcoes-09-trigonometricas-graficos` | seno, cosseno, tangente e gráficos | `thomas_calculo_v1_12ed:trigonometria`; `guidorizzi_calculo_v1_6ed:trigonometria`; `iezzi_fme_v3_9ed:trigonometria` |
| `funcoes-10-identidades-equacoes-trig` | identidades e equações trigonométricas | `guidorizzi_calculo_v1_6ed:trigonometria`; `iezzi_fme_v3_9ed:trigonometria` |
| `funcoes-11-inversas-trig` | funções trigonométricas inversas | `guidorizzi_calculo_v1_6ed:funcoes_inversas`; `iezzi_fme_v3_9ed:trigonometria` |
| `funcoes-12-geometria-analitica` | pontos, distância, reta e inclinação | `iezzi_fme_v7_6ed:geometria_analitica`; `thomas_calculo_v1_12ed:funcoes_graficos` |
| `funcoes-13-conicas` | circunferência, parábola, elipse e hipérbole | `iezzi_fme_v7_6ed:conicas` |
| `funcoes-14-taxa-media-sintese` | taxa média, secante e ponte para Cálculo | `stewart_calculo_v1_8ed:funcoes_modelos`; `thomas_calculo_v1_12ed:funcoes_graficos`; `guidorizzi_calculo_v1_6ed:funcoes` |

## Cobertura da versão

A trilha de Pré-Cálculo desta versão contém 38 microaulas:

- Álgebra e fundamentos: 13;
- Equações e inequações: 11;
- Funções e famílias clássicas: 14.

A conclusão pedagógica da versão não depende apenas da existência desta matriz. Antes de release ainda são obrigatórios:

1. análise/compilação Flutter;
2. testes unitários e de integridade;
3. testes das regras do Firestore;
4. revisão visual no Android;
5. verificação de sincronização de `completedContentLessonIds`;
6. integração controlada com a branch da P1, sem perder hardening de segurança;
7. novo teste completo após essa integração.
