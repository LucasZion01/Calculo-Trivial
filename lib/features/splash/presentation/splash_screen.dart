import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:calcquest/features/auth/presentation/login_screen.dart';
import 'package:calcquest/features/dashboard/presentation/dashboard_screen.dart';
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
    _openNextScreen();
  }

  Future<void> _openNextScreen() async {
    await Future<void>.delayed(const Duration(seconds: 2));

    if (!mounted) {
      return;
    }

    final currentUser = FirebaseAuth.instance.currentUser;

    final destination = currentUser == null
        ? const LoginScreen()
        : const DashboardScreen();

    Navigator.of(
      context,
    ).pushReplacement(MaterialPageRoute<void>(builder: (_) => destination));
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: Image(
            image: AssetImage('assets/branding/calculo_trivial_icon_1024.png'),
            width: 160,
            height: 160,
          ),
        ),
      ),
    );
  }
}
