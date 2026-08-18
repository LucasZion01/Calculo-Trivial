import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:calcquest/features/auth/presentation/login_screen.dart';
import 'package:calcquest/features/dashboard/presentation/dashboard_screen.dart';
import 'package:calcquest/shared/services/revenuecat_service.dart';
import 'package:calcquest/shared/state/app_progress.dart';
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
    await Future.wait<void>([
      Future<void>.delayed(const Duration(seconds: 2)),
      _initializeServices(),
    ]);

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

  Future<void> _initializeServices() async {
    final currentUser = FirebaseAuth.instance.currentUser;

    await Future.wait<void>([
      _runWithTimeout(AppProgress.loadProgress(), serviceName: 'progresso'),
      _runWithTimeout(
        RevenueCatService.initialize(appUserId: currentUser?.uid),
        serviceName: 'RevenueCat',
      ),
    ]);
  }

  Future<void> _runWithTimeout(
    Future<void> operation, {
    required String serviceName,
  }) async {
    try {
      await operation.timeout(const Duration(seconds: 6));
    } catch (error) {
      debugPrint(
        'SplashScreen: $serviceName indisponível durante a inicialização: '
        '$error',
      );
    }
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
