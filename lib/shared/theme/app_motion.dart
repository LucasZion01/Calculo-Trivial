import 'package:flutter/animation.dart';

class AppMotion {
  AppMotion._();

  static const Duration quick = Duration(milliseconds: 120);
  static const Duration standard = Duration(milliseconds: 180);
  static const Duration route = Duration(milliseconds: 500);
  static const Duration entrance = Duration(milliseconds: 1200);
  static const Duration ambient = Duration(milliseconds: 3600);

  static const Curve easeOut = Curves.easeOut;
  static const Curve easeOutCubic = Curves.easeOutCubic;
  static const Curve easeOutBack = Curves.easeOutBack;
}
