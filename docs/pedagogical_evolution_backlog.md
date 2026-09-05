# Evolução pedagógica futura do Cálculo Trivial

Última atualização: 05/09/2026

Status: backlog futuro, sem autorização de implementação.

Este documento é o registro canônico da evolução pedagógica futura do Cálculo Trivial. Ele consolida as propostas anteriores sobre recuperação ativa, prática espaçada, autoexplicação, diagnóstico de dificuldades, exemplos resolvidos, prática intercalada, múltiplas representações, Blurting, Cornell, SQ3R, Segundo Cérebro e a relação futura com avaliação de uso. O objetivo é evitar que essas ideias se fragmentem em funcionalidades isoladas ou duplicadas.

## Regra de governança

Este registro autoriza apenas documentação, organização, consolidação e priorização. Não autoriza alterações de código, dependências, APIs, banco de dados, Firebase, RevenueCat, PostHog, collections, migrações, XP, ouro, recompensas, Premium ou fluxos atualmente em teste.

A etapa atual do produto deve continuar preservando testes, correções, autenticação, sincronização, publicação e estabilidade. Quando chegar o momento de implementação, avançar em uma pequena etapa por vez e aguardar autorização explícita antes de executar cada mudança.

## Visão pedagógica

O Cálculo Trivial não deve se tornar apenas um banco de exercícios, aplicativo de fórmulas, chatbot resolvedor, coleção de técnicas de estudo, sistema de anotações ou plataforma orientada por tempo de tela.

O objetivo é ajudar o estudante a compreender conceitos, recuperar conhecimentos sem consulta, reconhecer estratégias e estruturas matemáticas, localizar dificuldades de pré-requisitos, analisar erros, justificar procedimentos, resolver com menos ajuda, aplicar em problemas novos e manter a aprendizagem ao longo do tempo.

A aplicação deve distinguir, sempre que houver evidência suficiente, entre simplesmente acertar e aspectos como estratégia utilizada, necessidade de ajuda, capacidade de explicar, transferência e retenção. Um único acerto não deve ser tratado como domínio.

## Princípios transversais

1. **Aprendizagem acima de engajamento.** Separar engajamento, desempenho, aprendizagem, retenção e transferência. Tempo de tela, cliques, frequência, XP ou sessões concluídas não são evidência direta de aprendizagem.
2. **Evidência acumulada.** Representar habilidades por múltiplas evidências ao longo do tempo. Estados futuros podem distinguir não praticado, praticado, resolvido com ajuda, com pouca ajuda, sem ajuda, aplicado em questão equivalente e recuperado em sessão posterior. Critérios e nomes devem ser validados antes de aparecer ao usuário.
3. **Sem rótulos de capacidade.** Não criar classificações sobre inteligência, talento ou capacidade do estudante.
4. **Carga cognitiva.** Quanto maior a carga matemática, mais simples deve ser a interface ao redor da resolução. Reduzir carga irrelevante sem simplificar a própria matemática.
5. **IA auxiliar, não autoridade final.** O núcleo pedagógico deve funcionar mesmo sem IA. Respostas matemáticas críticas devem permanecer verificáveis. IA não altera sozinha progresso, domínio, aprovação, XP, ouro, recompensas ou Premium.
6. **Sem inferências fortes a partir de sinais fracos.** Um erro isolado não identifica causa; um acerto isolado não demonstra domínio; tempo de tela não demonstra aprendizagem; correlação de uso e desempenho não demonstra causalidade.

## Métodos de prioridade muito alta

### Recuperação ativa — Retrieval Practice

Oferecer oportunidade adequada para tentar recuperar conhecimento antes de revelar explicação ou solução, tanto em questões conceituais quanto procedimentais. Não obrigar iniciantes a descobrir conteúdo ainda não ensinado e não transformar toda interação em teste.

### Prática espaçada — Spaced Practice

Retomar habilidades em sessões posteriores considerando histórico de respostas, quantidade de ajuda, erros recorrentes, desempenho em questões equivalentes e tempo desde a última prática. Evitar intervalos rígidos tratados como universalmente ideais. Permitir adiar ou pular revisões sem punição. Notificações e lembretes exigem autorização específica.

### Exemplos resolvidos — Worked Examples

Usar principalmente na introdução de habilidades. Cada etapa deve possuir justificativa matemática clara, evitando o padrão fórmula → substituição → resposta sem raciocínio. Depois, oferecer problema estruturalmente semelhante para tentativa.

### Retirada gradual de ajuda — Fading

Avaliar progressão de exemplo totalmente resolvido para etapas parcialmente completadas, dica disponível, ajuda mínima e resolução independente. Registrar separadamente desempenho com ajuda e sem ajuda. Uma questão resolvida com explicação aberta não equivale a resolução independente.

### Diagnóstico de dificuldades

Evoluir futuramente o conceito “Descubra o que está travando seu Cálculo”, preservando o comportamento atual em que o estudante continua após errar. A investigação deve ser opcional e baseada em padrões suficientes.

Fluxo candidato: detectar padrão → levantar hipótese → poucas questões diagnósticas → verificar evidência → microexplicação → exemplo resolvido → exercício equivalente → nova verificação posterior.

O diagnóstico deve admitir resultado inconclusivo e, quando possível, distinguir erro de cálculo, erro algébrico, sinal, interpretação, escolha de estratégia, pré-requisito, falha conceitual, distração e inconclusivo. Hipóteses não devem ser apresentadas como certeza.

Primeiro piloto recomendado: **limites algébricos que exigem fatoração**.

### Análise de erros e misconceptions

Criar futuramente atividades com resoluções incorretas matematicamente verificadas, nas quais o estudante identifique o primeiro erro, explique por que é inválido e corrija a resolução. Não gerar erros aleatórios por IA e tratá-los como material confiável.

### Comparação de estratégias

Permitir comparar métodos e decidir em que contextos cada um funciona, por exemplo: fatoração × racionalização, análise algébrica × gráfica, regra do produto × simplificação prévia, substituição direta × manipulação algébrica, diferentes parametrizações e estratégias de derivação. Nenhuma estratégia deve ser apresentada como universalmente superior fora de contexto.

## Metacognição e autorregulação

Integrar intervenções curtas e contextuais ao próprio exercício, sem necessariamente criar um módulo separado:

- Planejar: o que a questão pede? Qual estratégia parece adequada?
- Resolver: executar a estratégia.
- Monitorar: o passo continua coerente?
- Verificar: a resposta faz sentido? Há restrições de domínio? É possível verificar por outro caminho?
- Refletir: o que foi decisivo nesta questão?

Evitar interrupções excessivas.

## Julgamento de confiança

Avaliar futuramente uma pergunta opcional de confiança — baixa, média ou alta — em algumas respostas. Confiança isolada não determina domínio. Um erro com alta confiança pode justificar investigação, mas não deve ser automaticamente classificado como misconception.

## Variabilidade de exemplos e reconhecimento de estrutura

Variar números, símbolos, formato, contexto, representação e ordem das informações preservando a habilidade matemática central. O objetivo é ensinar o estudante a reconhecer a mesma estrutura em aparências diferentes e reduzir dependência de pistas superficiais.

## Transferência

Distinguir:

- repetição: questão muito semelhante;
- transferência próxima: mesma habilidade em estrutura ligeiramente diferente;
- transferência mais distante: habilidade integrada a outro tipo de problema.

Não considerar domínio apenas por resolver versões quase idênticas. Sempre que possível, avaliar com questões novas.

## Prática intercalada — Interleaving

Após base inicial suficiente, misturar tipos relacionados de problemas sem informar previamente qual técnica aplicar. O objetivo é treinar reconhecimento e seleção de estratégia. Não misturar assuntos aleatoriamente nem introduzir interleaving antes da prática inicial necessária. Diferenciar interleaving de alternância entre exemplo resolvido e exercício.

## Autoexplicação e elaboração

Perguntar ocasionalmente por que um passo é válido, qual propriedade foi usada, quando ela pode ou não ser aplicada, o que mudaria em outra condição e por que determinada estratégia foi escolhida.

No primeiro piloto, priorizar respostas estruturadas e matematicamente revisadas. Texto livre pode servir para reflexão, mas não deve ser automaticamente avaliado como evidência de domínio sem sistema validado. Não confundir dificuldade de escrita com dificuldade matemática.

## Múltiplas representações

Conectar fórmula, gráfico, linguagem verbal, geometria, tabela e situação aplicada quando houver função pedagógica clara. Exemplo: relacionar derivada a taxa instantânea, inclinação da tangente, comportamento local e velocidade instantânea. Toda representação deve justificar sua presença e possuir alternativa acessível quando visual.

## Controle de carga cognitiva

Tratar Cognitive Load como princípio transversal. Evitar combinar simultaneamente, sem necessidade, animações decorativas, recompensas, pop-ups, longos textos, chat, gráficos, dicas, moedas, XP, sons e informações secundárias. O objetivo é reduzir carga irrelevante, não remover suporte necessário à compreensão.

## Métodos experimentais ou de prioridade inferior

### Pretesting / Prequestioning

Avaliar pequenas perguntas antes da explicação em alguns conteúdos, sem punição, perda de XP ou interpretação do erro como deficiência. Tratar como recurso experimental.

### Productive Failure

Registrar como pesquisa futura. Não interpretar como deixar o estudante errando até descobrir sozinho. Só considerar com desenho pedagógico adequado e prioridade inferior aos métodos centrais.

## Métodos complementares já consolidados

### Blurting

Manter como forma opcional de recuperação ativa: escrever sem consultar o que lembra, comparar depois com conceitos essenciais e identificar lacunas. Não tornar obrigatório nem analisar texto livre sem autorização.

### Cornell

Manter como ferramenta complementar para conteúdos que realmente envolvam anotações, usando notas, perguntas e síntese. Não criar agora um editor completo de notas.

### SQ3R

Manter apenas para leituras suficientemente longas, como textos, capítulos e materiais complementares. Não aplicar a cada microaula.

### Segundo Cérebro

Manter em baixa prioridade e, se um dia implementado, limitar inicialmente a notas ligadas a habilidades, conceitos, referências e conteúdos estudados. Não transformar o Cálculo Trivial em Notion, Obsidian, gerenciador de documentos ou biblioteca geral.

## IA generativa e Tutor Trivial

O Tutor Trivial deve apoiar o processo pedagógico, não substituí-lo. O núcleo futuro deve caminhar por:

**identificar → compreender → observar → tentar → explicar → comparar → analisar o erro → receber ajuda → reduzir ajuda → resolver sozinho → transferir → recuperar novamente depois.**

A IA pode futuramente apoiar reformulação de explicações, diálogo socrático, perguntas complementares, feedback de linguagem, personalização contextual e identificação de possíveis padrões. Exercícios, respostas, explicações críticas e diagnósticos devem permanecer verificáveis e estruturados.

## PostHog permanece uma frente separada

A avaliação futura do PostHog continua regida pelo registro existente em `docs/roadmap_progress.md` e não é autorizada por este documento.

Antes de qualquer integração, deve-se verificar analytics existentes, evitar duplicidade, avaliar custo/manutenção/privacidade, definir eventos e pedir autorização específica. Analytics jamais será a fonte oficial de progresso, XP, Premium, recompensas ou domínio. Session replay e captura automática permanecem fora do escopo inicial.

## Ordem de prioridade futura

### Fase 1 — Núcleo
1. Recuperação ativa.
2. Exemplos resolvidos.
3. Autoexplicação curta.
4. Retirada gradual de ajuda.

### Fase 2 — Diagnóstico
5. Piloto de diagnóstico em limites com fatoração.
6. Análise de erros.
7. Microaula de pré-requisito.
8. Questão equivalente.

### Fase 3 — Estratégia
9. Comparação de estratégias.
10. Variabilidade de exemplos.
11. Reconhecimento de estrutura.
12. Prática intercalada.

### Fase 4 — Aprendizagem ao longo do tempo
13. Prática espaçada.
14. Evidências por habilidade.
15. Testes de transferência.
16. Retenção em sessões futuras.

### Fase 5 — Metacognição
17. Planejar → Resolver → Verificar.
18. Julgamento de confiança.
19. Reflexão pós-resolução.

### Fase 6 — Complementos
20. Blurting.
21. Cornell.
22. SQ3R.
23. Segundo Cérebro.

### Pesquisa experimental
24. Pretesting.
25. Productive Failure.

A avaliação do PostHog permanece paralela e não bloqueia essas fases.

## Primeiro piloto recomendado

Tema: **limites algébricos com fatoração**.

Fluxo candidato futuro, somente após autorização:

1. aluno responde normalmente;
2. erra;
3. continua o exercício, preservando o comportamento atual;
4. revisão identifica oportunidade de investigação;
5. estudante aceita investigar;
6. responde poucas questões de pré-requisito;
7. sistema apresenta hipótese, se houver evidência;
8. mostra microexplicação;
9. mostra exemplo resolvido;
10. oferece exercício parcialmente guiado;
11. oferece exercício independente;
12. futuramente apresenta questão equivalente;
13. posteriormente revisita a habilidade.

O fluxo deve ser avaliado antes de qualquer expansão para outros conteúdos.

## Critérios de validação futura

Avaliar separadamente:

- correção matemática de questões, soluções e feedbacks;
- usabilidade;
- carga e número de interrupções;
- aprendizagem imediata em questão equivalente sem ajuda;
- transferência para estrutura diferente;
- retenção em sessão posterior;
- integridade do progresso após reinício, logout, sincronização, troca de dispositivo, offline e reconexão;
- preservação de autenticação, Firebase, sincronização, aprovação, Premium, XP, ouro, estatísticas e bloqueios existentes.

## Interpretação de resultados

Não afirmar que uma implementação específica “funciona cientificamente” apenas porque o princípio pedagógico possui suporte acadêmico. Diferenciar evidência científica do princípio, recomendação pedagógica, hipótese de design e funcionalidade experimental.

Com poucos usuários, tratar resultados como exploratórios. Não inferir causalidade apenas porque o desempenho melhorou depois de uma intervenção. Combinar desempenho, retenção, transferência, observação, feedback do estudante e dados de uso.

## Referências conceituais para planejamento futuro

Quando houver autorização de implementação, pesquisar prioritariamente revisões sistemáticas, meta-análises, estudos experimentais relevantes, practice guides institucionais, artigos revisados por pares e pesquisadores reconhecidos sobre retrieval practice, spaced practice, worked-example effect, fading, self-explanation, interleaving, metacognition, self-regulated learning, comparison of solution methods, incorrect examples, algebraic misconceptions, variability of examples, transfer of learning, multiple representations, cognitive load theory, pretesting effect e productive failure.

Distinguir sempre evidência estabelecida, recomendação pedagógica, hipótese de design e recurso experimental. Evitar expressões de marketing como “cientificamente comprovado” sem respaldo específico para a implementação do Cálculo Trivial.

## Princípios que não devem ser quebrados

- Não transformar o Cálculo Trivial em catálogo de métodos.
- Não aumentar complexidade sem necessidade.
- Não adicionar recursos apenas por popularidade.
- Não confundir gamificação com aprendizagem.
- Não confundir engajamento com domínio.
- Não penalizar o estudante por utilizar ajuda.
- Não diagnosticar a partir de um único erro.
- Não declarar domínio a partir de um único acerto.
- Não permitir que IA determine sozinha a resposta matemática oficial.
- Não adicionar coleta de dados sem necessidade e autorização.
- Não alterar regras de recompensas sem decisão explícita.
- Não implementar múltiplas grandes mudanças simultaneamente.
