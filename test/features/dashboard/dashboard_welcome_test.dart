import 'package:flutter_test/flutter_test.dart';

import 'package:calcquest/features/dashboard/domain/dashboard_welcome.dart';

void main() {
  group('DashboardWelcome', () {
    test('mostra mensagem especial no primeiro acesso', () {
      expect(
        DashboardWelcome.title(isFirstAccess: true, firstName: 'Lucas'),
        'Bem-vindo, futuro engenheiro!',
      );

      expect(
        DashboardWelcome.subtitle(isFirstAccess: true),
        'Sua jornada no C\u00e1lculo come\u00e7a agora.',
      );
    });

    test('mostra mensagem personalizada nos acessos seguintes', () {
      expect(
        DashboardWelcome.title(isFirstAccess: false, firstName: 'Lucas'),
        'Bem-vindo de volta, Lucas!',
      );

      expect(
        DashboardWelcome.subtitle(isFirstAccess: false),
        'Continue sua jornada no C\u00e1lculo.',
      );
    });

    test('remove espaços extras do nome', () {
      expect(
        DashboardWelcome.title(isFirstAccess: false, firstName: '  Lucas  '),
        'Bem-vindo de volta, Lucas!',
      );
    });

    test('usa Estudante quando o nome não está disponível', () {
      expect(
        DashboardWelcome.title(isFirstAccess: false),
        'Bem-vindo de volta, Estudante!',
      );
    });
  });
}
