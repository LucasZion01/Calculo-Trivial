import 'package:shared_preferences/shared_preferences.dart';

class AppProgress {
  static const String _algebraFundamentalKey = 'algebra_fundamental_completed';

  static bool algebraFundamentalCompleted = false;

  static Future<void> loadProgress() async {
    final preferences = await SharedPreferences.getInstance();

    algebraFundamentalCompleted =
        preferences.getBool(_algebraFundamentalKey) ?? false;
  }

  static Future<void> completeAlgebraFundamental() async {
    algebraFundamentalCompleted = true;

    final preferences = await SharedPreferences.getInstance();
    await preferences.setBool(_algebraFundamentalKey, true);
  }

  static Future<void> resetProgress() async {
    algebraFundamentalCompleted = false;

    final preferences = await SharedPreferences.getInstance();
    await preferences.setBool(_algebraFundamentalKey, false);
  }
}