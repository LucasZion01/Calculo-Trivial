# Atualização consolidada do projeto — 05/09/2026

## Estado geral

O Cálculo Trivial está com a fundação técnica e pedagógica de Cálculo I em estágio avançado. O app Flutter já possui autenticação real, sincronização de progresso, exercícios, revisão, estatísticas, Premium/RevenueCat, Firebase, recompensas, trilhas e conteúdo principal funcional.

A etapa mais recente concluída foi a fundação do diagnóstico pedagógico e das recomendações de revisão para os seis módulos principais:

- Álgebra Fundamental
- Equações e Inequações
- Funções
- Limites
- Continuidade
- Derivadas

Último merge antes desta atualização: `5af5c23a5fd0a4501dff5c8c4dcb524294141d77`.

## Etapas concluídas

### 1. Concepção e MVP
- trilhas de aprendizagem;
- exercícios e desafios;
- progresso;
- estrutura inicial do produto;
- base Flutter funcional.

### 2. Infraestrutura Firebase
- Firebase Auth;
- cadastro, login, logout e recuperação;
- Firestore;
- perfil e progresso persistidos;
- regras de segurança;
- sincronização entre dispositivos.

### 3. Produto educacional básico
- Dashboard;
- Learning Path;
- perfil e configurações;
- estatísticas;
- exercícios;
- XP e ouro;
- critério de aprovação;
- desbloqueios;
- revisão de erros;
- conteúdo de Álgebra até Derivadas.

### 4. Qualidade técnica
- testes automatizados;
- `flutter analyze`;
- GitHub Actions / CI;
- validações de integridade;
- regras de Firestore;
- APK/AAB em etapas anteriores do projeto.

### 5. Premium / RevenueCat
- integração RevenueCat;
- controle de Premium;
- bloqueios de recursos Premium;
- testes de estados Premium e indisponível.

### 6. Estrutura pedagógica dos módulos atuais
- conteúdos progressivos;
- práticas;
- testes finais;
- metadados de aula e habilidade nos módulos suportados;
- bancos de exercícios cobertos por testes de integridade.

### 7. Diagnóstico pedagógico de dificuldades
- registro de tentativas de prática;
- registro de tentativas do teste final;
- agrupamento por módulo, aula e habilidade;
- thresholds conservadores de evidência;
- persistência local separada do progresso principal;
- recomendação apenas após evidência suficiente;
- priorização entre dificuldades;
- roteamento correto da revisão para o módulo correspondente.

Critérios atuais de recomendação:
- pelo menos 3 tentativas;
- pelo menos 2 erros;
- taxa de erro de pelo menos 50%.

A priorização atual considera primeiro evidência do teste final e sua taxa de erro, reduzindo viés causado apenas pela quantidade bruta de erros.

## Etapas que ficaram para trás ou foram adiadas

### IA pedagógica inicial — “Explique meu erro”
Essa função estava prevista cedo no projeto, antes mesmo de RevenueCat em um dos planejamentos originais, mas não foi integrada ao app Flutter naquele momento.

Existe uma implementação web separada do Tutor Trivial com Gemini, porém ela não substitui a integração pedagógica planejada dentro do app Flutter.

Status: adiada, não cancelada.

### Validação sistemática com estudantes reais
O projeto já teve intenção e início de testes com estudantes, mas ainda não foi fechado um ciclo formal de:

1. teste com alunos;
2. coleta estruturada de feedback;
3. análise dos problemas;
4. correções;
5. nova validação.

Status: iniciado parcialmente, ainda não concluído como etapa formal.

### Publicação oficial
Parte da preparação já foi realizada, incluindo build, documentação e segurança, mas a publicação oficial e o ciclo final de validação ainda não foram tratados como etapa concluída.

Status: parcial.

## Roadmap pedagógico planejado daqui para frente

### Próxima etapa prioritária
**Validação real com estudantes** antes de continuar adicionando sistemas pedagógicos sofisticados em sequência.

Objetivo:
- observar o comportamento real do aluno;
- verificar clareza das aulas e exercícios;
- validar se as recomendações fazem sentido;
- identificar fricções de UX;
- confirmar onde o estudante realmente precisa de ajuda.

### Depois da validação

#### Feedback explicativo progressivo
Evoluir de “certo/errado + explicação” para uma sequência como:

1. dica curta;
2. princípio matemático relevante;
3. indicação do próximo passo;
4. solução completa quando necessário.

Evitar inferir com certeza a causa do erro apenas pela alternativa escolhida.

#### Detetive Matemático
O estudante analisa uma solução fictícia incorreta e deve:
- identificar o primeiro erro;
- explicar o erro;
- corrigir;
- continuar a solução;
- comparar com uma solução correta.

#### Dois caminhos, uma resposta
Comparação de dois métodos válidos para o mesmo problema, com foco em estratégia, clareza, eficiência e generalização.

#### Relearning / revisão adaptativa
Reapresentar habilidades frágeis ao longo do tempo com base em:
- erros recorrentes;
- desempenho posterior;
- necessidade de ajuda;
- histórico de prática;
- desempenho em teste final.

Não criar um score de domínio artificial de 0 a 100 nesta fase.

#### Recuperação ativa, espaçamento e autoexplicação
Integrar esses mecanismos às aulas e revisões, em vez de tratá-los apenas como recursos isolados.

#### Productive Failure
Manter como recurso experimental para uma fase posterior, depois que a base pedagógica estiver validada.

#### Tutor de IA integrado
A IA deve atuar como apoio pedagógico, não como substituta da estrutura do curso. Possíveis funções futuras:
- perguntas socráticas;
- explicações adaptadas ao contexto;
- análise de estratégias;
- apoio à revisão;
- “Explique meu erro”.

#### Analytics pedagógico / PostHog
Continua deliberadamente adiado.

Diretrizes futuras:
- IDs pseudônimos;
- sem texto livre do aluno quando desnecessário;
- sem respostas completas ou PII;
- consentimento e política de privacidade;
- foco em eventos pedagógicos úteis;
- separar analytics pedagógico de analytics comercial.

## Expansão futura de conteúdo

Depois de consolidar e validar Cálculo I, considerar expansão gradual para:
- Cálculo II / multivariável;
- vetores e Álgebra Linear;
- Probabilidade e Estatística;
- Métodos Numéricos;
- Equações Diferenciais;
- outros conteúdos de Engenharia.

## Ordem recomendada atual

1. Fundação técnica — concluída.
2. Produto base — concluído.
3. Conteúdo principal de Cálculo I — concluído no escopo atual.
4. Premium e infraestrutura comercial — concluídos no escopo atual.
5. Diagnóstico pedagógico — concluído na fundação atual.
6. Validação estruturada com estudantes — próxima prioridade.
7. Feedback explicativo progressivo.
8. Detetive Matemático.
9. Comparação de estratégias.
10. Relearning / revisão adaptativa.
11. Recuperação ativa, espaçamento e autoexplicação integrados.
12. Productive Failure experimental.
13. Tutor de IA integrado ao app.
14. Analytics pedagógico, se necessário e com privacidade adequada.
15. Expansão de conteúdo.
16. Publicação/escala e ciclos contínuos de validação.

## Decisões de arquitetura que permanecem válidas

- Não misturar sinais pedagógicos com `AppProgress`/Firestore sem necessidade clara.
- Diagnóstico atual permanece local e pseudônimo por escopo.
- Não adicionar PostHog agora.
- Não fazer grandes refactors sem necessidade.
- Evoluir uma funcionalidade por vez.
- Cada mudança deve ter testes automatizados.
- Trabalhar por branch, PR e CI antes do merge.
- Preservar autenticação, progresso, sincronização, Premium, RevenueCat, Firebase, exercícios, revisão e estatísticas existentes.

## Conclusão desta atualização

Nenhuma etapa técnica essencial foi ignorada, mas duas etapas históricas precisam continuar visíveis no roadmap:

1. validação sistemática com estudantes reais;
2. IA pedagógica inicial / “Explique meu erro”, adiada para uma fase em que a base pedagógica já esteja mais madura.

A prioridade atual passa a ser **validar o produto com estudantes antes de continuar a próxima onda de sofisticação pedagógica**.
