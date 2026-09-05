import 'dart:async';
import 'dart:math' as math;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:calcquest/features/auth/presentation/login_screen.dart';
import 'package:calcquest/features/dashboard/presentation/dashboard_screen.dart';
import 'package:calcquest/l10n/app_localizations.dart';
import 'package:calcquest/shared/services/app_update_service.dart';
import 'package:calcquest/shared/services/revenuecat_service.dart';
import 'package:calcquest/shared/state/app_progress.dart';
import 'package:calcquest/shared/theme/app_colors.dart';
import 'package:calcquest/shared/theme/app_motion.dart';
import 'package:calcquest/shared/theme/app_typography.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _entranceController;
  late final AnimationController _motionController;

  late final Animation<double> _fadeAnimation;
  late final Animation<double> _iconScaleAnimation;
  late final Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _entranceController = AnimationController(
      vsync: this,
      duration: AppMotion.entrance,
      animationBehavior: AnimationBehavior.preserve,
    );

    _motionController = AnimationController(
      vsync: this,
      duration: AppMotion.ambient,
      animationBehavior: AnimationBehavior.preserve,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _entranceController,
      curve: const Interval(0, 0.85, curve: AppMotion.easeOut),
    );

    _iconScaleAnimation = Tween<double>(begin: 0.65, end: 1).animate(
      CurvedAnimation(
        parent: _entranceController,
        curve: AppMotion.easeOutBack,
      ),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.12), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _entranceController,
            curve: AppMotion.easeOutCubic,
          ),
        );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }

      _entranceController.forward();
      _motionController.repeat();
    });

    _openNextScreen();
  }

  @override
  void dispose() {
    _entranceController.dispose();
    _motionController.dispose();
    super.dispose();
  }

  Future<void> _openNextScreen() async {
    final updateCheck = AppUpdateService.checkForUpdate();

    await Future.wait<void>([
      Future<void>.delayed(const Duration(milliseconds: 2400)),
      _initializeServices(),
    ]);

    final updateStatus = await updateCheck;

    if (!mounted) {
      return;
    }

    if (updateStatus.available) {
      final shouldUpdate = await _showUpdateDialog();

      if (!mounted) {
        return;
      }

      if (shouldUpdate) {
        await AppUpdateService.updateNow(updateStatus);

        if (!mounted) {
          return;
        }
      }
    }

    final currentUser = FirebaseAuth.instance.currentUser;

    final destination = currentUser == null
        ? const LoginScreen()
        : const DashboardScreen();

    Navigator.of(context).pushReplacement(
      PageRouteBuilder<void>(
        pageBuilder: (_, animation, secondaryAnimation) {
          return destination;
        },
        transitionDuration: AppMotion.route,
        transitionsBuilder: (_, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }

  Future<bool> _showUpdateDialog() async {
    final isEnglish = Localizations.localeOf(context).languageCode == 'en';

    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(
            isEnglish ? 'Update available' : 'Atualização disponível',
          ),
          content: Text(
            isEnglish
                ? 'A new version of Cálculo Trivial is available on Google Play. Update now to get the latest improvements.'
                : 'Uma nova versão do Cálculo Trivial está disponível na Google Play. Atualize agora para receber as melhorias mais recentes.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: Text(isEnglish ? 'Later' : 'Agora não'),
            ),
            FilledButton(
              onPressed: () => Navigator.of(dialogContext).pop(true),
              child: Text(isEnglish ? 'Update now' : 'Atualizar agora'),
            ),
          ],
        );
      },
    );

    return result ?? false;
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
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.navy,
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppColors.navy, Color(0xFF07172E), Color(0xFF0A2140)],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              Positioned.fill(
                child: _FloatingMathSymbols(animation: _motionController),
              ),
              Center(
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
                            animation: _motionController,
                            builder: (context, child) {
                              final phase =
                                  _motionController.value * math.pi * 2;

                              final wave = math.sin(phase);

                              return Transform.translate(
                                offset: Offset(0, wave * 9),
                                child: Transform.scale(
                                  scale: 1 + (wave * 0.045),
                                  child: Container(
                                    width: 144,
                                    height: 144,
                                    padding: const EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(34),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color.lerp(
                                            const Color(0x4006B6D4),
                                            const Color(0xA006B6D4),
                                            (wave + 1) / 2,
                                          )!,
                                          blurRadius: 30 + ((wave + 1) * 10),
                                          spreadRadius: 2 + ((wave + 1) * 2),
                                        ),
                                      ],
                                    ),
                                    child: child,
                                  ),
                                ),
                              );
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(28),
                              child: Image.asset(
                                'assets/branding/calculo_trivial_icon_1024.png',
                                fit: BoxFit.cover,
                                semanticLabel: l10n.appSymbolSemanticLabel,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 28),
                        Text(
                          l10n.appName,
                          style: AppTypography.headingLarge.copyWith(
                            color: AppColors.white,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          l10n.appTagline,
                          textAlign: TextAlign.center,
                          style: AppTypography.bodyMedium.copyWith(
                            color: AppColors.primaryLight,
                          ),
                        ),
                        const SizedBox(height: 36),
                        SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            color: AppColors.secondary,
                            semanticsLabel: l10n.loading,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FloatingMathSymbols extends StatelessWidget {
  final Animation<double> animation;

  const _FloatingMathSymbols({required this.animation});

  static const List<_FloatingMathSymbolSpec> _symbols =
      <_FloatingMathSymbolSpec>[
        _FloatingMathSymbolSpec(
          value: '∫',
          alignment: Alignment(-0.78, -0.72),
          size: 46,
          phase: 0.2,
          opacity: 0.16,
        ),
        _FloatingMathSymbolSpec(
          value: 'π',
          alignment: Alignment(0.72, -0.62),
          size: 40,
          phase: 1.4,
          opacity: 0.14,
        ),
        _FloatingMathSymbolSpec(
          value: '√x',
          alignment: Alignment(-0.68, 0.48),
          size: 30,
          phase: 2.3,
          opacity: 0.13,
        ),
        _FloatingMathSymbolSpec(
          value: 'f′',
          alignment: Alignment(0.68, 0.36),
          size: 34,
          phase: 3.2,
          opacity: 0.15,
        ),
        _FloatingMathSymbolSpec(
          value: 'lim',
          alignment: Alignment(0.02, -0.88),
          size: 28,
          phase: 4.1,
          opacity: 0.12,
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: AnimatedBuilder(
        animation: animation,
        builder: (context, child) {
          final progress = animation.value * math.pi * 2;

          return Stack(
            children: [
              for (final symbol in _symbols)
                Align(
                  alignment: symbol.alignment,
                  child: Transform.translate(
                    offset: Offset(
                      math.cos(progress + symbol.phase) * 8,
                      math.sin(progress + symbol.phase) * 14,
                    ),
                    child: Transform.rotate(
                      angle: math.sin(progress + symbol.phase) * 0.08,
                      child: Opacity(
                        opacity: symbol.opacity,
                        child: Text(
                          symbol.value,
                          style: AppTypography.headingLarge.copyWith(
                            color: AppColors.white,
                            fontSize: symbol.size,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

class _FloatingMathSymbolSpec {
  final String value;
  final Alignment alignment;
  final double size;
  final double phase;
  final double opacity;

  const _FloatingMathSymbolSpec({
    required this.value,
    required this.alignment,
    required this.size,
    required this.phase,
    required this.opacity,
  });
}
