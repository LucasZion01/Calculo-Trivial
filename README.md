# Cálculo Trivial

**Aprender Cálculo como uma jornada, não como uma sequência de fórmulas.**

Cálculo Trivial é um aplicativo educacional desenvolvido em Flutter para tornar o estudo de Cálculo mais progressivo, organizado e envolvente.

O projeto combina conteúdos de aprendizagem, exercícios, progressão por módulos e elementos de gamificação em uma experiência pensada especialmente para estudantes que estão construindo sua base matemática para disciplinas de Cálculo.

> O Cálculo Trivial está em desenvolvimento ativo. Este repositório representa a evolução técnica do projeto e ainda não corresponde a uma versão final de produção.

---

## Sobre o projeto

Cálculo costuma representar uma das primeiras grandes dificuldades na formação de estudantes das áreas de ciência, tecnologia e engenharia.

O Cálculo Trivial nasceu da ideia de transformar esse processo em uma jornada de aprendizagem estruturada: o estudante avança por fundamentos matemáticos, conteúdos de Cálculo, exercícios e desafios enquanto acompanha sua própria evolução.

Em vez de funcionar apenas como uma coleção de questões, o aplicativo busca conectar três elementos:

- aprendizagem progressiva;
- prática por meio de exercícios e desafios;
- acompanhamento do progresso do estudante.

O objetivo é construir uma experiência na qual estudar, praticar e evoluir façam parte do mesmo fluxo.

---

## Funcionalidades em desenvolvimento

A estrutura atual do aplicativo já contempla áreas para:

- autenticação;
- dashboard do estudante;
- trilha de aprendizagem;
- módulos educacionais;
- aulas;
- exercícios de múltipla escolha;
- mini desafios;
- sistema de resultados;
- recompensas;
- acompanhamento de progresso;
- estatísticas;
- perfil;
- configurações;
- conteúdos introdutórios de Cálculo.

A arquitetura foi organizada para permitir a expansão gradual dessas funcionalidades conforme o projeto evolui.

---

## Trilha de aprendizagem

O Cálculo Trivial utiliza uma estrutura progressiva de conteúdos.

Entre os conteúdos atualmente representados no projeto estão fundamentos necessários para avançar em Cálculo, como:

- Álgebra Fundamental;
- Equações e Inequações;
- Funções;
- Limites.

A proposta é expandir progressivamente a trilha para outros conteúdos de Cálculo.

---

## Gamificação

O projeto incorpora elementos de gamificação para tornar a progressão mais perceptível e incentivar a continuidade dos estudos.

A estrutura atual inclui conceitos como:

- XP;
- ouro;
- recompensas;
- progressão;
- desbloqueio de conteúdos;
- desafios;
- acompanhamento de desempenho.

Esses sistemas ainda estão sendo desenvolvidos e refinados.

---

## Design System

O Cálculo Trivial possui um Design System próprio para manter consistência visual e facilitar a evolução da interface.

A estrutura compartilhada inclui componentes e definições para:

- cores;
- tipografia;
- espaçamentos;
- botões;
- campos de texto;
- cards;
- barras de progresso;
- ícones;
- navegação inferior;
- estados globais da interface.

Entre os estados previstos estão carregamento, conteúdo vazio, conteúdo bloqueado, ausência de conexão e erro.

---

## Tecnologias

O projeto utiliza atualmente:

- **Flutter** — desenvolvimento multiplataforma;
- **Dart** — linguagem principal;
- **Shared Preferences** — persistência local;
- **RevenueCat SDK** — infraestrutura preparada para recursos de monetização;
- **Material Design** — base para componentes de interface.

### Dependências principais

```yaml
shared_preferences: ^2.5.5
purchases_flutter: ^10.9.0
purchases_ui_flutter: ^10.9.0