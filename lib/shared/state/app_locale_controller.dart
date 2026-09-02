import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppLocaleController extends ChangeNotifier {
  static const String _localePreferenceKey = 'app_locale_code';
  static const Locale defaultLocale = Locale('pt');
  static const List<Locale> supportedLocales = <Locale>[
    Locale('pt'),
    Locale('en'),
  ];

  Locale _locale = defaultLocale;

  Locale get locale => _locale;

  Future<void> load() async {
    final preferences = await SharedPreferences.getInstance();
    final storedCode = preferences.getString(_localePreferenceKey);
    final storedLocale = _localeFromCode(storedCode);

    if (storedLocale == null) {
      return;
    }

    _locale = storedLocale;
    notifyListeners();
  }

  Future<void> setLocale(Locale locale) async {
    final supportedLocale = _supportedLocaleFor(locale);

    if (supportedLocale == null || supportedLocale == _locale) {
      return;
    }

    _locale = supportedLocale;
    notifyListeners();

    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(_localePreferenceKey, _locale.languageCode);
  }

  static Locale? _localeFromCode(String? languageCode) {
    if (languageCode == null || languageCode.trim().isEmpty) {
      return null;
    }

    return _supportedLocaleFor(Locale(languageCode));
  }

  static Locale? _supportedLocaleFor(Locale locale) {
    for (final supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return supportedLocale;
      }
    }

    return null;
  }
}

final AppLocaleController appLocaleController = AppLocaleController();
