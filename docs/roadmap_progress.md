# Roadmap do Cálculo Trivial — Progresso

Última atualização: 04/09/2026

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
   - Próxima melhoria relevante: apoio visual por conceito quando necessário.

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

8. ⏳ **Visualização matemática** — PRÓXIMA ETAPA RECOMENDADA
   - Adicionar suporte visual reutilizável dentro das aulas.
   - Prioridades:
     1. Funções — gráficos, domínio, imagem e transformações.
     2. Limites — aproximação, limites laterais e assíntotas.
     3. Continuidade — furos, saltos e tipos de descontinuidade.
     4. Derivadas — reta tangente, inclinação e taxa de variação.
   - Regra: usar figuras e gráficos quando contribuírem diretamente para a compreensão, não apenas como decoração.

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

1. Visualização matemática.
2. Persistência separada de histórico de prática e teste final.
3. Revisão de continuidade de conta Google ↔ senha.
4. Hardening final do Premium.
5. Validação visual no aparelho.
6. Tutor Trivial com IA.

## Estado atual do fluxo pedagógico

O padrão vigente para os módulos principais é:

**Aula → exemplos resolvidos → prática guiada → revisão dos erros → teste final → resultado/recompensa**

Esse padrão deve ser mantido nos novos módulos e nas futuras expansões do currículo.
