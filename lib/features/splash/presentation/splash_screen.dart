import 'dart:async';

import 'package:flutter/material.dart';
import 'package:calcquest/features/auth/presentation/login_screen.dart';
import 'package:calcquest/shared/theme/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 2), () {
      if (!mounted) return;

      Navigator.of(context).pushReplacement(
        MaterialPageRoute<void>(
          builder: (_) => const LoginScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: Image(
            image: AssetImage(
              'assets/branding/calculo_trivial_icon_1024.png',
            ),
            width: 160,
            height: 160,
          ),
        ),
      ),
    );
  }
}