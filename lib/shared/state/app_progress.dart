import 'package:shared_preferences/shared_preferences.dart';

class AppProgress {
  static const String _algebraFundamentalKey = 'algebra_fundamental_completed';
  static const String _equationsAndInequationsKey =
      'equations_and_inequations_completed';
  static const String _functionsKey = 'functions_completed';
  static const String _limitsKey = 'limits_completed';

  static bool algebraFundamentalCompleted = false;
  static bool equationsAndInequationsCompleted = false;
  static bool functionsCompleted = false;
  static bool limitsCompleted = false;

  static Future<void> loadProgress() async {
    final preferences = await SharedPreferences.getInstance();

    algebraFundamentalCompleted =
        preferences.getBool(_algebraFundamentalKey) ?? false;

    equationsAndInequationsCompleted =
        preferences.getBool(_equationsAndInequationsKey) ?? false;

    functionsCompleted = preferences.getBool(_functionsKey) ?? false;

    limitsCompleted = preferences.getBool(_limitsKey) ?? false;
  }

  static Future<void> completeAlgebraFundamental() async {
    algebraFundamentalCompleted = true;

    final preferences = await SharedPreferences.getInstance();
    await preferences.setBool(_algebraFundamentalKey, true);
  }

  static Future<void> completeEquationsAndInequations() async {
    equationsAndInequationsCompleted = true;

    final preferences = await SharedPreferences.getInstance();
    await preferences.setBool(_equationsAndInequationsKey, true);
  }

  static Future<void> completeFunctions() async {
    functionsCompleted = true;

    final preferences = await SharedPreferences.getInstance();
    await preferences.setBool(_functionsKey, true);
  }

  static Future<void> completeLimits() async {
    limitsCompleted = true;

    final preferences = await SharedPreferences.getInstance();
    await preferences.setBool(_limitsKey, true);
  }

  static Future<void> resetProgress() async {
    algebraFundamentalCompleted = false;
    equationsAndInequationsCompleted = false;
    functionsCompleted = false;
    limitsCompleted = false;

    final preferences = await SharedPreferences.getInstance();
    await preferences.setBool(_algebraFundamentalKey, false);
    await preferences.setBool(_equationsAndInequationsKey, false);
    await preferences.setBool(_functionsKey, false);
    await preferences.setBool(_limitsKey, false);
  }
}