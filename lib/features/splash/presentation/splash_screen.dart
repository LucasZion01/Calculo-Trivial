import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:calcquest/features/auth/presentation/login_screen.dart';
import 'package:calcquest/features/dashboard/presentation/dashboard_screen.dart';
import 'package:calcquest/shared/services/revenuecat_service.dart';
import 'package:calcquest/shared/state/app_progress.dart';
import 'package:calcquest/shared/theme/app_colors.dart';
import 'package:calcquest/shared/theme/app_typography.dart';

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
        'SplashScreen: $serviceName indisponÃƒÂ­vel durante a inicializaÃƒÂ§ÃƒÂ£o: '
        '$error',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.navy,
      body: Stack(
        children: [
          SafeArea(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 144,
                    height: 144,
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(34),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x4D06B6D4),
                          blurRadius: 32,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(28),
                      child: Image.asset(
                        'assets/branding/calculo_trivial_icon_1024.png',
                        fit: BoxFit.cover,
                        semanticLabel: 'SÃƒÂ­mbolo do CÃƒÂ¡lculo Trivial',
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),
                  Text(
                    'CÃƒÂ¡lculo Trivial',
                    style: AppTypography.headingLarge.copyWith(
                      color: AppColors.white,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Domine o cÃƒÂ¡lculo. Evolua alÃƒÂ©m.',
                    style: AppTypography.bodyMedium.copyWith(
                      color: AppColors.primaryLight,
                    ),
                  ),
                  const SizedBox(height: 36),
                  const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      color: AppColors.secondary,
                      semanticsLabel: 'Carregando',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
