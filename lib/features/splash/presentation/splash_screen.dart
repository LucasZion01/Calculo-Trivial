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

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _entranceController;
  late final AnimationController _pulseController;

  late final Animation<double> _fadeAnimation;
  late final Animation<double> _iconScaleAnimation;
  late final Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1300),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _entranceController,
      curve: const Interval(0, 0.75, curve: Curves.easeOut),
    );

    _iconScaleAnimation = Tween<double>(begin: 0.82, end: 1).animate(
      CurvedAnimation(parent: _entranceController, curve: Curves.easeOutBack),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.08), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _entranceController,
            curve: Curves.easeOutCubic,
          ),
        );

    _entranceController.forward();

    Future<void>.delayed(const Duration(milliseconds: 650), () {
      if (mounted) {
        _pulseController.repeat(reverse: true);
      }
    });

    _openNextScreen();
  }

  @override
  void dispose() {
    _entranceController.dispose();
    _pulseController.dispose();
    super.dispose();
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
    return Scaffold(
      backgroundColor: AppColors.navy,
      body: SafeArea(
        child: Center(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ScaleTransition(
                    scale: _iconScaleAnimation,
                    child: AnimatedBuilder(
                      animation: _pulseController,
                      builder: (context, child) {
                        final pulse = _pulseController.value;

                        return Transform.scale(
                          scale: 1 + (pulse * 0.025),
                          child: Container(
                            width: 144,
                            height: 144,
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(34),
                              boxShadow: [
                                BoxShadow(
                                  color: Color.lerp(
                                    const Color(0x3306B6D4),
                                    const Color(0x8006B6D4),
                                    pulse,
                                  )!,
                                  blurRadius: 24 + (pulse * 16),
                                  spreadRadius: 1 + (pulse * 3),
                                ),
                              ],
                            ),
                            child: child,
                          ),
                        );
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(28),
                        child: Image.asset(
                          'assets/branding/calculo_trivial_icon_1024.png',
                          fit: BoxFit.cover,
                          semanticLabel: 'Símbolo do Cálculo Trivial',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),
                  Text(
                    'Cálculo Trivial',
                    style: AppTypography.headingLarge.copyWith(
                      color: AppColors.white,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Domine o cálculo. Evolua além.',
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
        ),
      ),
    );
  }
}
