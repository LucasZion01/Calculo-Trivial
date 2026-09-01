# Checklist Play Store e Segurança

Última revisão: 2026-09-01

Este inventário resume o que já está pronto para o envio do Cálculo Trivial ao Google Play e o que ainda precisa ser concluído antes de publicar em produção.

## Status Geral

| Área | Status | Evidência | Próxima ação |
| --- | --- | --- | --- |
| Conta Play Console | Bloqueado externamente | A conta pessoal ainda está em verificação pelo Google Play | Concluir identidade, dispositivo Android e telefone no Play Console |
| Nome público do app | Pronto para Android | `android/app/src/main/AndroidManifest.xml` usa `Cálculo Trivial` | Conferir título, descrição curta e descrição completa no cadastro do app |
| Package name Android | Pronto | `applicationId = "com.lucaszion01.calculotrivial"` | Manter imutável após publicar |
| Assinatura Android | Preparado | Workflow `play_release.yml` restaura keystore por secrets e remove arquivos ao final | Confirmar secrets corretos antes do primeiro AAB oficial |
| Build Play AAB | Preparado no CI | Workflow manual gera e verifica `app-release.aab` | Rodar após corrigir a chave pública Android do RevenueCat |
| Política de privacidade | Presente | `public/index.html` contém privacidade e exclusão de conta | Informar a URL pública no Play Console |
| Exclusão de conta | Presente | App chama `deleteAccount`; backend apaga dados do usuário e Auth | Testar em build release com usuário real de teste |
| Data Safety | Pendente no Play Console | O app usa Firebase, RevenueCat, compras e autenticação | Preencher o formulário conforme dados realmente coletados |
| Teste fechado | Pendente | Conta pessoal nova pode exigir teste fechado antes de produção | Planejar pelo menos 12 testadores por 14 dias, se exigido na conta |
| RevenueCat | Pendente de credencial | O app lê `REVENUECAT_API_KEY` via `--dart-define` | Usar a Public SDK Key Android correta, não chave secreta |
| Tutor Trivial | Seguro para não expor agora | Backend existe, mas UI ainda não está conectada aos botões | Alinhar catálogo Flutter/backend antes de ativar no app |

## Correções Feitas Nesta Revisão

- `firestore.rules` agora aceita os 8 IDs de conteúdo da trilha de Equações e Inequações.
- O limite de `completedContentLessonIds` foi atualizado de 31 para 39 itens.
- Foi criado um teste para impedir que IDs de aulas do app fiquem fora da allowlist do Firestore.

## Play Store

Antes de criar o envio de produção, a conta de desenvolvedor precisa terminar a verificação. Em contas pessoais recém-criadas, o Google Play pode exigir um teste fechado com pelo menos 12 testadores inscritos continuamente por 14 dias antes de liberar produção.

Checklist do cadastro do app:

- nome do app: `Cálculo Trivial`;
- idioma padrão: `Português (Brasil)`;
- categoria: Educação;
- presença de anúncios: não, se o app continuar sem anúncios;
- compras no app: sim, se o Premium via RevenueCat/Google Play Billing estiver ativo;
- política de privacidade: `https://calculo-trivial-app-646bb.web.app`;
- URL de exclusão de conta: mesma página, seção de exclusão;
- conta de teste para revisão: preparar um login de demonstração se o app exigir autenticação para avaliar recursos principais.

## Segurança Android e CI

O workflow manual `.github/workflows/play_release.yml` está preparado para gerar um AAB assinado sem versionar credenciais.

Pontos já protegidos:

- keystore e `android/key.properties` estão ignorados pelo Git;
- o workflow exige `ANDROID_KEYSTORE_BASE64`, senhas e alias via GitHub Secrets;
- `REVENUECAT_API_KEY` é recebida por secret e passada por `--dart-define`;
- o AAB é verificado com `jarsigner`;
- o workflow remove o keystore e o `key.properties` ao final.

Antes do primeiro AAB oficial, confirmar:

- `REVENUECAT_API_KEY` é a Public SDK Key Android do RevenueCat;
- a chave de upload corresponde à configuração que será cadastrada no Google Play;
- nenhuma chave secreta do RevenueCat foi colocada no app;
- o build foi executado pelo workflow limpo, não por arquivos locais soltos.

## Firebase, App Check e Backend

Pontos fortes atuais:

- Firebase App Check é ativado no app com Play Integrity em release;
- `tutor` e `deleteAccount` usam `enforceAppCheck: true`;
- as callables rejeitam usuários sem autenticação;
- a chave Gemini é declarada com `defineSecret("GEMINI_API_KEY")`;
- o Tutor tem validação Zod, idempotência, rate limit, sessões e resposta estruturada;
- a probe local do Tutor ficou restrita aos emuladores.

Pontos para testar antes da publicação:

- App Check em aparelho Android real usando build release;
- exclusão de conta fim a fim;
- recuperação de senha;
- restauração de compras;
- login/cadastro em rede instável;
- comportamento quando RevenueCat está indisponível.

## Firestore e Progresso

As regras atuais restringem leitura e escrita ao usuário autenticado e validam formato, limites numéricos e IDs permitidos.

Ainda assim, o progresso continua sendo escrito pelo cliente. Para uma versão pública ampla, o ideal é mover a concessão de XP, ouro e desbloqueios para funções de backend. Para teste fechado e MVP, a regra atual reduz abuso casual, mas não deve ser tratada como autoridade perfeita contra cliente modificado.

## Privacidade e Exclusão de Conta

A página pública `public/index.html` cobre:

- dados de conta;
- progresso educacional;
- dados de compra processados por Google Play e RevenueCat;
- dados técnicos e de segurança;
- exclusão pelo app;
- alternativa por e-mail;
- retenções necessárias por obrigação legal ou antifraude.

Antes do envio, revisar se o formulário Data Safety do Play Console coincide exatamente com essa página e com os SDKs instalados.

## Bloqueios Restantes Para Publicar

1. Terminar a verificação da conta no Play Console.
2. Confirmar a Public SDK Key Android correta no RevenueCat.
3. Atualizar o GitHub Secret `REVENUECAT_API_KEY` com essa chave pública Android.
4. Rodar o workflow manual `Build signed Play AAB`.
5. Testar o AAB em aparelho Android real.
6. Preencher Data Safety e política de privacidade no Play Console.
7. Preparar conta de teste ou instruções de acesso para revisão.
8. Criar teste fechado se a conta exigir.
9. Só conectar o Tutor Trivial aos botões depois de alinhar os IDs do catálogo Flutter/backend.
10. Antes de produção ampla, migrar recompensas e desbloqueios críticos para backend confiável.

