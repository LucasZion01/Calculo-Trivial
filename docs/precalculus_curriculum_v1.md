# Currículo canônico de Pré-Cálculo — Cálculo Trivial

Status: versão 1 para implementação incremental

Objetivo: estabelecer a sequência pedagógica oficial de Pré-Cálculo que prepara o estudante para Limites, Continuidade, Derivadas e aplicações, preservando a arquitetura atual do Cálculo Trivial.

## Regra de fonte

O conteúdo deve ser autoral, mas fundamentado nos principais livros adotados pelo projeto. A redação não deve copiar trechos dos livros. As referências servem para validar definições, sequência conceitual, propriedades, exemplos-tipo e nível de rigor.

Referências-base do projeto:

- James Stewart — Cálculo, v. 1.
- George B. Thomas, Maurice D. Weir e Joel Hass — Cálculo, v. 1.
- Hamilton Luiz Guidorizzi — Um curso de cálculo, v. 1.
- Gelson Iezzi e colaboradores — Fundamentos de Matemática Elementar, volumes adequados a cada tema.

Antes de uma aula receber referência bibliográfica no backend, o `sourceId` e o `sectionId` precisam existir no catálogo bibliográfico e ser cobertos pelos testes de integridade.

## Estrutura padrão de cada aula

Cada aula deve conter, no mínimo:

1. objetivo de aprendizagem explícito;
2. pré-requisitos;
3. explicação intuitiva em linguagem simples;
4. formalização matemática;
5. definição dos símbolos utilizados;
6. pelo menos um exemplo resolvido linha a linha;
7. interpretação do resultado;
8. erro comum ou misconception relevante;
9. verificação curta de compreensão;
10. resumo dos pontos essenciais;
11. ligação explícita com conteúdos posteriores de Cálculo;
12. referência bibliográfica rastreável quando aplicável.

A duração exibida ao aluno deve refletir o conteúdo real. O projeto não deve forçar toda aula a caber em aproximadamente cinco minutos.

## Macrotrilha

A ordem oficial da trilha de Pré-Cálculo é:

1. Fundamentos numéricos e linguagem algébrica
2. Álgebra e fatoração
3. Equações e inequações
4. Funções: conceito, domínio, imagem, composição e inversa
5. Funções polinomiais e racionais
6. Funções exponenciais e logarítmicas
7. Trigonometria e círculo trigonométrico
8. Funções trigonométricas inversas
9. Transformações e leitura de gráficos
10. Geometria analítica e cônicas
11. Síntese de Pré-Cálculo e preparação para Limites

---

# Unidade 0 — Fundamentos numéricos e linguagem algébrica

Objetivo da unidade: assegurar que o estudante consiga ler, manipular e interpretar expressões antes de avançar para funções e Cálculo.

### Aula 0.1 — Conjuntos numéricos e reta real

Conteúdos:
- naturais, inteiros, racionais, irracionais e reais;
- inclusão entre conjuntos;
- intervalos abertos, fechados e semiabertos;
- notação de intervalos;
- desigualdades na reta real.

Conexão com Cálculo: domínio de funções, limites laterais e intervalos de crescimento.

### Aula 0.2 — Operações, sinais e prioridade

Conteúdos:
- ordem das operações;
- sinais em soma, produto, quociente e potência;
- uso correto de parênteses;
- frações numéricas e algébricas simples.

Conexão com Cálculo: simplificação algébrica e prevenção de erros de sinal.

### Aula 0.3 — Variáveis, constantes, coeficientes e expressões

Conteúdos:
- variável;
- constante;
- coeficiente;
- termo;
- expressão algébrica;
- valor numérico;
- convenções de notação.

Conexão com Cálculo: função como relação entre grandezas variáveis.

### Aula 0.4 — Potências, raízes e expoentes

Conteúdos:
- propriedades de potências;
- expoente zero e negativo;
- expoente racional;
- raízes e restrições no conjunto dos reais;
- notação científica quando útil.

Conexão com Cálculo: funções potência, radicais, limites e derivadas.

### Aula 0.5 — Valor absoluto e distância

Conteúdos:
- definição de valor absoluto;
- interpretação como distância;
- equações e inequações simples com módulo;
- leitura geométrica.

Conexão com Cálculo: definição formal de limite e estimativas.

---

# Unidade 1 — Álgebra e fatoração

Objetivo da unidade: dominar manipulações que aparecem repetidamente em equações, funções, limites e derivadas.

### Aula 1.1 — Termos semelhantes e simplificação

Conteúdos:
- identificação de termos semelhantes;
- redução algébrica;
- organização por grau.

### Aula 1.2 — Propriedade distributiva e sinais

Conteúdos:
- distributiva simples e dupla;
- remoção de parênteses;
- sinais negativos;
- erros comuns.

### Aula 1.3 — Produtos notáveis

Conteúdos:
- quadrado da soma;
- quadrado da diferença;
- produto da soma pela diferença;
- reconhecimento de padrões.

### Aula 1.4 — Fator comum

Conteúdos:
- máximo fator comum numérico e literal;
- colocação em evidência;
- verificação pela distributiva.

### Aula 1.5 — Fatoração por agrupamento

Conteúdos:
- agrupamento estratégico;
- fator comum em duas etapas.

### Aula 1.6 — Diferença de quadrados

Conteúdos:
- reconhecimento;
- fatoração;
- condições de aplicação.

### Aula 1.7 — Trinômio quadrado perfeito

Conteúdos:
- reconhecimento estrutural;
- reconstrução do binômio.

### Aula 1.8 — Trinômios do segundo grau

Conteúdos:
- fatoração de x² + bx + c;
- fatoração de ax² + bx + c em casos adequados;
- relação com raízes.

### Aula 1.9 — Frações algébricas

Conteúdos:
- restrições de domínio;
- simplificação por fatores;
- denominador comum;
- operações básicas.

### Aula 1.10 — Racionalização

Conteúdos:
- conjugado;
- racionalização de numerador e denominador;
- diferença de quadrados associada.

Conexão da unidade com Cálculo: limites algébricos, simplificação de quocientes incrementais e manipulação de expressões antes de derivar.

---

# Unidade 2 — Equações e inequações

Objetivo da unidade: compreender solução como conjunto de valores que satisfazem uma condição e dominar os principais tipos necessários ao Pré-Cálculo.

### Aula 2.1 — Equações lineares

Conteúdos:
- equivalência entre equações;
- operações permitidas;
- equações com parênteses e frações;
- verificação da solução.

### Aula 2.2 — Problemas modelados por equações lineares

Conteúdos:
- tradução de linguagem verbal para álgebra;
- definição de incógnita;
- interpretação da resposta.

### Aula 2.3 — Equações quadráticas

Conteúdos:
- fatoração;
- completar quadrados;
- fórmula quadrática;
- discriminante;
- interpretação das raízes.

### Aula 2.4 — Equações polinomiais simples

Conteúdos:
- produto nulo;
- fatoração;
- raízes e multiplicidade introdutória.

### Aula 2.5 — Equações racionais

Conteúdos:
- domínio antes da resolução;
- mínimo múltiplo comum;
- soluções extranhas.

### Aula 2.6 — Equações com radicais

Conteúdos:
- isolamento do radical;
- potenciação;
- necessidade de verificar soluções.

### Aula 2.7 — Inequações lineares

Conteúdos:
- operações equivalentes;
- inversão do sinal ao multiplicar/dividir por número negativo;
- solução em intervalos.

### Aula 2.8 — Inequações quadráticas e estudo de sinal

Conteúdos:
- raízes críticas;
- tabela de sinais;
- interpretação gráfica.

### Aula 2.9 — Inequações racionais

Conteúdos:
- zeros do numerador;
- zeros do denominador;
- pontos excluídos;
- tabela de sinais.

### Aula 2.10 — Equações e inequações com valor absoluto

Conteúdos:
- interpretação por distância;
- casos;
- representação na reta.

Conexão com Cálculo: domínio, intervalos, sinais de funções, otimização e análise de gráficos.

---

# Unidade 3 — Funções: conceito, domínio, imagem, composição e inversa

Objetivo da unidade: construir a noção de função como objeto central do Cálculo.

### Aula 3.1 — Relações e definição de função

Conteúdos:
- entrada e saída;
- variável independente e dependente;
- notação f(x);
- teste conceitual do que é ou não função.

### Aula 3.2 — Domínio

Conteúdos:
- domínio natural de uma expressão;
- denominadores;
- raízes pares;
- logaritmos como preparação;
- interseção de restrições.

### Aula 3.3 — Imagem e valores de função

Conteúdos:
- imagem de um elemento;
- conjunto imagem;
- distinção entre contradomínio e imagem quando relevante.

### Aula 3.4 — Representações de uma função

Conteúdos:
- fórmula;
- tabela;
- gráfico;
- descrição verbal;
- contexto aplicado.

### Aula 3.5 — Gráfico de função e teste da reta vertical

Conteúdos:
- pares ordenados;
- leitura de pontos;
- zeros;
- interceptos;
- teste da reta vertical.

### Aula 3.6 — Funções definidas por partes

Conteúdos:
- leitura por intervalos;
- avaliação;
- construção e interpretação gráfica.

### Aula 3.7 — Composição de funções

Conteúdos:
- (f∘g)(x);
- ordem da composição;
- domínio da composta;
- interpretação de processos sucessivos.

### Aula 3.8 — Função injetora e teste da reta horizontal

Conteúdos:
- ideia de um-para-um;
- leitura gráfica;
- importância para função inversa.

### Aula 3.9 — Função inversa

Conteúdos:
- definição;
- cálculo algébrico em casos simples;
- domínio e imagem trocados;
- simetria em relação a y=x.

### Aula 3.10 — Taxa média de variação

Conteúdos:
- razão Δy/Δx;
- inclinação da secante;
- interpretação contextual.

Conexão com Cálculo: a derivada nasce do limite da taxa média de variação.

---

# Unidade 4 — Funções polinomiais e racionais

### Aula 4.1 — Função constante, identidade e linear
### Aula 4.2 — Inclinação e equação da reta
### Aula 4.3 — Função quadrática e parábola
### Aula 4.4 — Forma padrão, fatorada e de vértice
### Aula 4.5 — Funções polinomiais de grau superior
### Aula 4.6 — Zeros, fatores e multiplicidade
### Aula 4.7 — Comportamento nas extremidades
### Aula 4.8 — Funções racionais
### Aula 4.9 — Assíntotas verticais
### Aula 4.10 — Assíntotas horizontais e oblíquas introdutórias
### Aula 4.11 — Esboço de gráficos racionais

Conexão com Cálculo: comportamento local e global, limites no infinito e assíntotas.

---

# Unidade 5 — Funções exponenciais e logarítmicas

### Aula 5.1 — Função exponencial
### Aula 5.2 — Crescimento e decaimento exponencial
### Aula 5.3 — Número e e exponencial natural
### Aula 5.4 — Definição de logaritmo
### Aula 5.5 — Propriedades dos logaritmos
### Aula 5.6 — Função logarítmica
### Aula 5.7 — Exponencial e logaritmo como funções inversas
### Aula 5.8 — Equações exponenciais
### Aula 5.9 — Equações logarítmicas
### Aula 5.10 — Modelagem exponencial básica

Conexão com Cálculo: derivadas e integrais de exponenciais/logaritmos e modelos de crescimento.

---

# Unidade 6 — Trigonometria e círculo trigonométrico

### Aula 6.1 — Ângulos, graus e radianos
### Aula 6.2 — Comprimento de arco e radiano
### Aula 6.3 — Círculo trigonométrico
### Aula 6.4 — Seno e cosseno
### Aula 6.5 — Tangente e demais razões trigonométricas
### Aula 6.6 — Valores notáveis
### Aula 6.7 — Sinais por quadrante
### Aula 6.8 — Periodicidade
### Aula 6.9 — Gráficos de seno e cosseno
### Aula 6.10 — Gráfico da tangente
### Aula 6.11 — Identidades fundamentais
### Aula 6.12 — Fórmulas de soma e diferença
### Aula 6.13 — Ângulo duplo e relações derivadas essenciais
### Aula 6.14 — Equações trigonométricas básicas

Conexão com Cálculo: limites trigonométricos, derivadas trigonométricas e movimento periódico.

---

# Unidade 7 — Funções trigonométricas inversas

### Aula 7.1 — Por que restringir domínio
### Aula 7.2 — Arco seno
### Aula 7.3 — Arco cosseno
### Aula 7.4 — Arco tangente
### Aula 7.5 — Domínio e imagem das inversas trigonométricas
### Aula 7.6 — Composição entre trigonométricas e inversas

Conexão com Cálculo: derivadas de funções trigonométricas inversas e substituições futuras.

---

# Unidade 8 — Transformações e leitura de gráficos

### Aula 8.1 — Translação vertical
### Aula 8.2 — Translação horizontal
### Aula 8.3 — Reflexões
### Aula 8.4 — Alongamentos e compressões
### Aula 8.5 — Combinação de transformações
### Aula 8.6 — Simetria par e ímpar
### Aula 8.7 — Crescimento e decrescimento pela leitura gráfica
### Aula 8.8 — Máximos e mínimos pela leitura gráfica
### Aula 8.9 — Comportamento local versus global

Conexão com Cálculo: interpretação geométrica de continuidade, derivada e extremos.

---

# Unidade 9 — Geometria analítica e cônicas

### Aula 9.1 — Distância entre dois pontos
### Aula 9.2 — Ponto médio
### Aula 9.3 — Equações da reta
### Aula 9.4 — Retas paralelas e perpendiculares
### Aula 9.5 — Circunferência
### Aula 9.6 — Parábola
### Aula 9.7 — Elipse
### Aula 9.8 — Hipérbole
### Aula 9.9 — Reconhecimento por equações
### Aula 9.10 — Translações de cônicas

Conexão com Cálculo: geometria de gráficos, curvas e futuros problemas de otimização e parametrização.

---

# Unidade 10 — Síntese de Pré-Cálculo e preparação para Limites

### Aula 10.1 — Revisão de domínio e restrições
### Aula 10.2 — Revisão de fatoração aplicada a funções
### Aula 10.3 — Revisão de racionalização
### Aula 10.4 — Revisão de gráficos e assíntotas
### Aula 10.5 — Taxa média de variação e secantes
### Aula 10.6 — Aproximação e comportamento perto de um ponto
### Aula 10.7 — Introdução intuitiva à ideia de limite
### Aula 10.8 — Diagnóstico final de prontidão para Cálculo

A Unidade 10 não substitui o módulo formal de Limites. Ela apenas cria a ponte pedagógica necessária.

## Padrão de exercícios

Cada conjunto de aulas deve possuir exercícios em pelo menos três níveis:

- Fundamento: verifica definição, notação e procedimento básico.
- Aplicação: exige selecionar e aplicar a técnica correta.
- Integração: mistura conceitos ou apresenta o mesmo conhecimento em representação diferente.

Quando o estudante ainda está aprendendo uma técnica, exemplos resolvidos e exercícios equivalentes devem preceder questões de transferência.

## Futuro Tutor Trivial dentro das aulas

A estrutura deve permitir posteriormente que o Tutor participe sem ser a autoridade do progresso. Pontos de interação candidatos:

1. após um bloco conceitual: “Até aqui fez sentido?”;
2. antes de revelar um exemplo: pequena previsão ou tentativa;
3. após um passo crítico: “Por que este passo é válido?”;
4. após erro: dica progressiva antes da solução;
5. ao final: questão curta de recuperação sem consulta;
6. se houver dificuldade repetida: recomendação de pré-requisito;
7. posteriormente: revisão espaçada e questão de transferência.

O aluno deve poder continuar a aula sem depender de uma chamada de IA. Conteúdo, respostas, critérios de correção e progresso permanecem estruturados e verificáveis.

## Critério para considerar uma unidade pronta para publicação

Uma unidade somente deve ser considerada pronta quando:

- todas as aulas previstas estiverem implementadas;
- conteúdo matemático tiver sido revisado;
- referências bibliográficas relevantes resolverem no catálogo;
- testes de integridade passarem;
- exercícios tiverem gabarito e explicação verificados;
- português e notação matemática estiverem consistentes;
- navegação não quebrar módulos existentes;
- progresso, XP, ouro e testes finais permanecerem preservados;
- a unidade tiver uma ponte explícita para o conteúdo seguinte.
