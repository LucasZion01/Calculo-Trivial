# Roadmap do Cálculo Trivial — Progresso

Última atualização: 05/09/2026

Este documento registra o estado atual das principais etapas do projeto Cálculo Trivial.

## Legenda

- ✅ Concluído
- 🟡 Em andamento / parcialmente concluído
- ⏳ Pendente

## Etapas

1. ✅ **Monetização**
   - RevenueCat integrado.
   - Assinatura Premium configurada no Google Play.
   - Planos mensal e anual ativos.
   - Paywall publicado.
   - Compra sandbox validada com desbloqueio do Premium.

2. 🟡 **Hardening do Premium**
   - Fluxo básico de compra e entitlement funcionando.
   - Ainda revisar restauração de compras, falhas de rede, identidade entre contas e outros cenários de borda antes da produção.

3. ✅ **Login com Google**
   - Google Sign-In integrado no Android.
   - Firebase configurado com SHA-1 do Play App Signing.
   - Logout Google/Firebase corrigido.
   - Exclusão de conta Google com reautenticação implementada.
   - Observação: vínculo/mesclagem segura entre conta por senha e Google com o mesmo e-mail ainda é tarefa separada.

4. 🟡 **Revisão completa das telas**
   - Fluxo principal revisado: Dashboard → Trilha → Módulo → Prática → Resultado.
   - Tela compartilhada das aulas melhorada.
   - Responsividade, hierarquia visual, progresso e animações melhorados.
   - Falta validação visual final em aparelho real para diferentes tamanhos de tela e fluxos completos.

5. 🟡 **Aulas em nível universitário**
   - Estrutura de aulas consolidada e aprofundada nos módulos atuais.
   - Fluxo pedagógico adotado: Aula → exemplos resolvidos → prática → revisão dos erros → teste final.
   - Apoio visual conceitual já iniciado em Funções, Limites, Continuidade e Derivadas.

6. 🟡 **Expansão do currículo**
   - Conteúdo atual cobre base algébrica e tópicos iniciais de cálculo.
   - Expansão futura prevista para Pré-Cálculo, Cálculo I, II e III, Álgebra Linear, EDO, Probabilidade/Estatística e Métodos Numéricos.

7. ✅ **Exercícios e avaliação — estrutura principal**
   - Álgebra: prática guiada → revisão → teste final.
   - Equações: prática guiada → revisão → teste final.
   - Funções: prática guiada → revisão → teste final.
   - Limites: prática guiada → revisão → teste final.
   - Continuidade: prática guiada → revisão → teste final.
   - Derivadas: prática guiada → revisão → teste final.
   - Feedback imediato somente na prática.
   - Recompensa e conclusão somente após o teste final.
   - Pendente: histórico separado de prática e teste final para evitar repetição entre tentativas futuras.

8. 🟡 **Visualização matemática**
   - Infraestrutura reutilizável de visualização matemática implementada.
   - Funções: gráfico interativo de `f(x) = 2x + 1`, com slider, ponto destacado e relação entre entrada e saída.
   - Limites: aproximação interativa de `x → 3`, conectando a tendência de `f(x)` ao valor-limite.
   - Continuidade: comparação interativa entre ponto contínuo e descontinuidade removível.
   - Derivadas: parábola com ponto móvel, reta tangente e inclinação `f'(x)` atualizada dinamicamente.
   - Visualizações integradas às aulas correspondentes, com PT/EN e semântica de acessibilidade.
   - Próximas expansões visuais: domínio/imagem e transformações; limites laterais e assíntotas; saltos e outros tipos de descontinuidade; secante → tangente e interpretação geométrica ampliada.
   - Validação visual final em dispositivo real permanece pendente.

9. ⏳ **Tutor Trivial com IA**
   - Backend/protótipo com `@google/genai` já existe.
   - Ainda precisa ser integrado à experiência principal do app.

10. ⏳ **Aprendizagem adaptativa**
   - Futuro: adaptar exercícios, revisão e dificuldade ao desempenho do aluno.

11. 🟡 **Gamificação**
   - XP, ouro, progresso, desafios e recompensas já existem em parte.
   - Ainda revisar balanceamento e integração com a aprendizagem adaptativa.

12. 🟡 **Perfil e conta**
   - Autenticação, perfil básico e exclusão de conta implementados.
   - Ainda resolver continuidade/vínculo entre provedores de login sem perda de progresso.

13. 🟡 **Português + Inglês**
   - Interface e novos fluxos pedagógicos possuem suporte PT/EN.
   - Ainda fazer revisão final de consistência de todas as strings antes da produção.

14. 🟡 **Segurança e infraestrutura**
   - Firebase Auth e Firestore em uso.
   - Regras e segurança foram endurecidas em partes.
   - Fluxo de atualização no Android possui aviso, atualização imediata quando permitida e fallback para a Play Store.
   - O status de atualização detectado na splash é reutilizado no clique, evitando uma segunda consulta desnecessária à Play Store.
   - Ainda revisar App Check em produção, regras finais do Firestore, anti-cheat e cenários de conta/compra.

15. 🟡 **Teste fechado**
   - Track fechado Alpha no Google Play ativo.
   - Versões de teste já distribuídas.
   - Fluxo de atualização dentro do app validado de 1.0.3 para 1.0.4.
   - Requisito dos 12 testadores por 14 dias precisa permanecer atendido até liberar produção.

16. ⏳ **Produção**
   - Só avançar após concluir validações finais de produto, segurança, conta, Premium, conteúdo e Play Console.

17. 🟡 **RevenueCat Shipathon**
   - Projeto já usa RevenueCat de forma funcional.
   - Ainda preparar submissão e apresentação final conforme requisitos do evento.

18. ⏳ **Pós-lançamento**
   - Monitoramento, métricas, feedback dos usuários, correções, retenção e evolução do currículo.

## Próxima sequência sugerida

1. Persistência separada de histórico de prática e teste final.
2. Expandir a cobertura das visualizações matemáticas já implantadas.
3. Revisão de continuidade de conta Google ↔ senha.
4. Hardening final do Premium.
5. Validação visual no aparelho.
6. Tutor Trivial com IA contextual.

## Estado atual do fluxo pedagógico

O padrão vigente para os módulos principais é:

**Aula → exemplos resolvidos → prática guiada → revisão dos erros → teste final → resultado/recompensa**

Esse padrão deve ser mantido nos novos módulos e nas futuras expansões do currículo.

## Backlog complementar — avaliação futura de uso com PostHog

Esta frente está registrada apenas para avaliação futura. **Não autoriza instalação de dependências, conexão de contas, alteração do aplicativo nem coleta de dados neste momento.**

O comando explícito para iniciar essa frente será:

**“Vamos avaliar a integração do PostHog no Cálculo Trivial”.**

### Antes de propor qualquer integração

Quando essa etapa for autorizada:

1. Inspecionar se o projeto já utiliza Firebase Analytics ou outra solução de análise de uso.
2. Identificar quais eventos já são coletados e evitar duplicidade.
3. Avaliar se o PostHog acrescenta benefícios suficientes para justificar manutenção, custos e mudanças de privacidade.
4. Diferenciar a conexão de um plugin para consultar dados da integração do SDK no Flutter: conectar um plugin não instrumenta o aplicativo automaticamente.
5. Apresentar um plano técnico e aguardar aprovação antes de implementar.

### Escopo inicial proposto

Coletar somente eventos necessários para responder:

- Quantos estudantes iniciam e concluem uma sessão?
- Quantos acessam a revisão dos erros?
- Quantos retornam ao aplicativo em outros dias?
- Quantos visualizam a oferta Premium?

Eventos candidatos:

- `learning_session_started`
- `learning_session_completed`
- `error_review_opened`
- `premium_offer_viewed`

Antes de implementar, definir precisamente o gatilho de cada evento, propriedades mínimas, regras de deduplicação e identificadores de sessão para relacionar início e conclusão.

Uma sessão sem evento de conclusão **não deve ser classificada automaticamente como abandono**, pois pode representar interrupção, uso offline ou falha de envio.

### Integração futura com diagnóstico de dificuldades

Somente após implementação e aprovação do piloto pedagógico, considerar eventos para:

- investigação de dificuldade iniciada e concluída;
- revisão recomendada aberta e concluída;
- tentativa de questão equivalente após a revisão;
- nova verificação da habilidade em outro momento.

Esses dados devem apoiar avaliação de adesão e resultados, sem tratar cliques, tempo de tela ou um único acerto como prova de aprendizagem.

Com poucos testadores, apresentar contagens, limitações e feedback qualitativo. Não afirmar causalidade sem desenho de avaliação adequado.

### Privacidade e segurança

- Não enviar nomes, e-mails, senhas, tokens, textos livres ou conteúdo de conversas.
- Usar apenas identificadores pseudônimos quando necessários, sem chamá-los de dados anônimos.
- Manter gravação de sessões e captura automática desativadas no escopo inicial.
- Revisar consentimento quando aplicável, política de privacidade e declarações de coleta na Google Play antes de ativar.
- Definir retenção, exclusão de dados, controle de acesso e comportamento após logout ou exclusão da conta.
- Nunca colocar credenciais administrativas do PostHog no aplicativo.
- Separar eventos de desenvolvimento, testes e produção.

### Confiabilidade e limites de responsabilidade

- A coleta de telemetria não pode bloquear exercícios, login ou sincronização de progresso.
- Prever funcionamento offline, tratamento de falhas e testes contra eventos duplicados.
- O PostHog não será a fonte oficial de progresso, aprovação, recompensas ou acesso Premium.
- Essas responsabilidades continuam nos componentes existentes do aplicativo.

### Objetivo

Usar evidências para orientar melhorias pedagógicas e de produto, sem transformar aumento de tempo de uso em objetivo principal.