# Inventário de `calcquest`

Este documento registra onde o nome técnico `calcquest` ainda aparece no projeto e qual decisão tomar antes da publicação Android.

## Estado para Play Store Android

O Android já usa os identificadores corretos para publicação:

| Item | Arquivo | Estado |
| --- | --- | --- |
| Nome exibido | `android/app/src/main/AndroidManifest.xml` | `Cálculo Trivial` |
| Application ID | `android/app/build.gradle.kts` | `com.lucaszion01.calculotrivial` |
| Firebase Android package | `android/app/google-services.json` | `com.lucaszion01.calculotrivial` |

Esses itens não precisam ser alterados para seguir com a preparação da Play Store.

## Ocorrências técnicas que devem permanecer por enquanto

| Grupo | Exemplos | Decisão |
| --- | --- | --- |
| Pacote Dart | `pubspec.yaml`, imports `package:calcquest/...` | Manter. Renomear exige migração ampla de imports e não melhora a publicação Android. |
| Classe raiz Flutter | `CalcQuestApp` em `lib/main.dart` e testes | Manter por enquanto. É nome interno de código. |
| Windows/Linux | `BINARY_NAME`, `project(calcquest)`, `calcquest.exe`, `APPLICATION_ID` | Manter. São nomes técnicos de desktop e não bloqueiam a Play Store. |
| iOS/macOS bundle IDs | `com.example.calcquest` em Xcode/Firebase iOS | Manter até configurar iOS oficialmente no Firebase/Apple. Alterar agora sem app iOS configurado pode quebrar build futuro. |
| macOS app product | `calcquest.app`, `PRODUCT_NAME = calcquest` | Tratar junto com a etapa macOS, se ela virar alvo real. |

## Ocorrências visíveis já migradas

| Plataforma | Arquivo | Valor novo |
| --- | --- | --- |
| Web | `web/index.html` | `Cálculo Trivial` |
| Web manifest | `web/manifest.json` | `Cálculo Trivial` / `Cálculo` |
| iOS display | `ios/Runner/Info.plist` | `Cálculo Trivial` |
| Linux window title | `linux/runner/my_application.cc` | `Calculo Trivial` |
| Windows window title/product | `windows/runner/main.cpp`, `windows/runner/Runner.rc` | `Calculo Trivial` |

## Próxima decisão recomendada

Antes da Play Store, priorizar:

1. manter Android como fonte oficial de publicação;
2. não renomear o pacote Dart ainda;
3. revisar textos, política de privacidade, login, premium e segurança;
4. só migrar iOS/macOS quando esses destinos forem configurados de verdade.
