import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:calcquest/shared/state/app_locale_controller.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AppLocaleController', () {
    test('restaura o idioma salvo localmente', () async {
      SharedPreferences.setMockInitialValues(<String, Object>{
        'app_locale_code': 'en',
      });

      final controller = AppLocaleController();

      await controller.load();

      expect(controller.locale, const Locale('en'));
    });

    test('persiste apenas idiomas suportados', () async {
      SharedPreferences.setMockInitialValues(<String, Object>{});

      final controller = AppLocaleController();

      await controller.setLocale(const Locale('en'));

      expect(controller.locale, const Locale('en'));

      await controller.setLocale(const Locale('es'));

      expect(controller.locale, const Locale('en'));

      final preferences = await SharedPreferences.getInstance();
      expect(preferences.getString('app_locale_code'), 'en');
    });
  });
}
