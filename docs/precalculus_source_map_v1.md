# Mapa bibliográfico canônico — Pré-Cálculo v1

Status: base pedagógica da branch `content/precalculus-v1`.

Este documento liga cada unidade do currículo de Pré-Cálculo às fontes bibliográficas cadastradas em `functions/src/data/bibliography.ts`. O conteúdo do Cálculo Trivial deve ser autoral: as fontes orientam sequência conceitual, rigor, terminologia, exemplos e cobertura, sem reprodução extensa de texto ou exercícios protegidos.

## Regra de uso

Cada aula nova deve:

1. possuir objetivo de aprendizagem explícito;
2. declarar pré-requisitos;
3. partir de uma explicação intuitiva e chegar à forma matemática correta;
4. conter exemplo resolvido passo a passo;
5. conter checagem de compreensão;
6. explicitar erros comuns;
7. ligar o conteúdo ao Cálculo quando essa ligação for pedagogicamente natural;
8. usar pelo menos duas referências quando o assunto estiver coberto por mais de uma obra cadastrada.

## Unidade 0 — Fundamentos numéricos

Conteúdos: números reais, reta real, ordem, intervalos, valor absoluto, potências, raízes e propriedades elementares.

Referências principais:
- `guidorizzi_calculo_v1_6ed:numeros_reais`
- `iezzi_fme_v1_9ed:conjuntos_numericos`

Função pedagógica: estabelecer a linguagem numérica usada posteriormente em domínio, inequações, limites e continuidade.

## Unidade 1 — Álgebra e fatoração

Conteúdos: expressões algébricas, distributiva, produtos notáveis, fator comum, agrupamento, diferença de quadrados, trinômios, frações algébricas e simplificação.

Referências principais:
- `iezzi_fme_v1_9ed:funcoes_elementares` como apoio de linguagem e manipulação algébrica aplicada a funções.
- `guidorizzi_calculo_v1_6ed:funcoes` como ponte para o uso da álgebra em Cálculo.

Observação: a técnica de fatoração deve ser ensinada com foco posterior em zeros de funções, simplificação racional e limites algébricos.

## Unidade 2 — Equações e inequações

Conteúdos: equações lineares, quadráticas, racionais, irracionais, modulares, sistemas básicos; inequações lineares, quadráticas, racionais e irracionais.

Referências principais:
- `iezzi_fme_v1_9ed:equacoes_inequacoes_irracionais`
- `iezzi_fme_v1_9ed:funcoes_elementares`

Função pedagógica: conectar solução algébrica, zeros, sinal, domínio e representação gráfica.

## Unidade 3 — Funções: conceito, domínio e imagem

Conteúdos: definição, notação, domínio, contradomínio, imagem, zeros, tabelas, gráficos e interpretação.

Referências principais:
- `stewart_calculo_v1_8ed:funcoes_modelos`
- `thomas_calculo_v1_12ed:funcoes_graficos`
- `guidorizzi_calculo_v1_6ed:funcoes`
- `iezzi_fme_v1_9ed:introducao_funcoes`

Função pedagógica: esta é a unidade central de Pré-Cálculo e deve preparar diretamente Limites, Continuidade e Derivadas.

## Unidade 4 — Transformações, composição e inversa

Conteúdos: translações, reflexões, escalas, operações com funções, composição, injetividade e função inversa.

Referências principais:
- `thomas_calculo_v1_12ed:transformacoes_graficos`
- `guidorizzi_calculo_v1_6ed:operacoes_funcoes`
- `guidorizzi_calculo_v1_6ed:funcoes_inversas`
- `iezzi_fme_v1_9ed:composicao_inversa`

## Unidade 5 — Funções polinomiais e racionais

Conteúdos: funções afim e quadrática, polinômios de grau superior, raízes, multiplicidade, comportamento gráfico, funções racionais, domínio e assíntotas em nível de Pré-Cálculo.

Referências principais:
- `iezzi_fme_v1_9ed:funcoes_elementares`
- `stewart_calculo_v1_8ed:funcoes_modelos`
- `thomas_calculo_v1_12ed:funcoes_graficos`

Observação: uma fonte específica de polinômios poderá ser acrescentada ao catálogo em revisão futura; não inventar metadados bibliográficos para preencher essa lacuna.

## Unidade 6 — Funções exponenciais e logarítmicas

Conteúdos: potências de expoente real, crescimento e decrescimento exponencial, logaritmos, propriedades, mudança de base, equações e relação de inversão.

Referências principais:
- `guidorizzi_calculo_v1_6ed:exponenciais_logaritmos`
- `iezzi_fme_v2_10ed:exponenciais_logaritmos`

## Unidade 7 — Trigonometria e círculo trigonométrico

Conteúdos: graus e radianos, círculo trigonométrico, seno, cosseno, tangente, demais razões, sinais, periodicidade, identidades fundamentais, gráficos e equações básicas.

Referências principais:
- `thomas_calculo_v1_12ed:trigonometria`
- `guidorizzi_calculo_v1_6ed:trigonometria`
- `iezzi_fme_v3_9ed:trigonometria`

## Unidade 8 — Funções trigonométricas inversas

Conteúdos: restrição de domínio, arcsen, arccos, arctan, gráficos, domínio e imagem.

Referências principais:
- `guidorizzi_calculo_v1_6ed:funcoes_inversas`
- `iezzi_fme_v3_9ed:trigonometria`

## Unidade 9 — Geometria analítica e cônicas

Conteúdos: plano cartesiano, distância, ponto médio, reta, inclinação, circunferência, parábola, elipse e hipérbole.

Referências principais:
- `iezzi_fme_v7_6ed:geometria_analitica`
- `iezzi_fme_v7_6ed:conicas`

## Unidade 10 — Ponte para Cálculo

Conteúdos: taxa média de variação, reta secante, ideia de reta tangente, comportamento local, aproximação, infinito e preparação conceitual para limite.

Referências principais:
- `stewart_calculo_v1_8ed:funcoes_modelos`
- `thomas_calculo_v1_12ed:funcoes_graficos`
- `guidorizzi_calculo_v1_6ed:funcoes`

A transição formal passa então para as referências já existentes de Limites e Continuidade.

## Critério de conclusão desta base

A base bibliográfica de Pré-Cálculo v1 está pronta para produção de aulas quando:
- os IDs usados aqui existem no catálogo;
- IDs são únicos;
- seções são únicas por fonte;
- referências desconhecidas continuam sendo rejeitadas;
- nenhuma referência bibliográfica foi inventada apenas para preencher cobertura.

A execução automatizada dos testes do backend continua necessária antes de integração ou merge.
