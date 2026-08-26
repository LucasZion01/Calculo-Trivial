import 'dart:math' as math;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:calcquest/features/auth/presentation/register_screen.dart';
import 'package:calcquest/features/dashboard/presentation/dashboard_screen.dart';
import 'package:calcquest/shared/services/revenuecat_service.dart';
import 'package:calcquest/shared/state/app_progress.dart';
import 'package:calcquest/shared/theme/app_colors.dart';
import 'package:calcquest/shared/theme/app_spacing.dart';
import 'package:calcquest/shared/theme/app_typography.dart';
import 'package:calcquest/shared/widgets/app_text_field.dart';
import 'package:calcquest/shared/widgets/primary_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  late final AnimationController _entranceController;
  late final AnimationController _ambientController;
  late final Animation<double> _fadeAnimation;
  late final Animation<double> _logoScaleAnimation;
  late final Animation<Offset> _slideAnimation;

  bool _isPasswordVisible = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
      animationBehavior: AnimationBehavior.preserve,
    );

    _ambientController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3600),
      animationBehavior: AnimationBehavior.preserve,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _entranceController,
      curve: Curves.easeOut,
    );

    _logoScaleAnimation = Tween<double>(begin: 0.70, end: 1).animate(
      CurvedAnimation(parent: _entranceController, curve: Curves.easeOutBack),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.10), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _entranceController,
            curve: Curves.easeOutCubic,
          ),
        );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }

      _entranceController.forward();
      _ambientController.repeat();
    });
  }

  @override
  void dispose() {
    _entranceController.dispose();
    _ambientController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _showMessage(String message) {
    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  String _firebaseErrorMessage(FirebaseAuthException error) {
    switch (error.code) {
      case 'invalid-email':
        return 'Digite um endere\u00e7o de e-mail v\u00e1lido.';
      case 'user-disabled':
        return 'Esta conta foi desativada.';
      case 'user-not-found':
      case 'wrong-password':
      case 'invalid-credential':
        return 'E-mail ou senha incorretos.';
      case 'too-many-requests':
        return 'Muitas tentativas. Aguarde um pouco e tente novamente.';
      case 'network-request-failed':
        return 'Verifique sua conex\u00e3o com a internet.';
      default:
        return 'N\u00e3o foi poss\u00edvel entrar. Tente novamente.';
    }
  }

  Future<void> _identifyRevenueCatUser(String userId) async {
    if (!RevenueCatService.isConfigured) {
      return;
    }

    try {
      await RevenueCatService.identifyUser(userId);
    } catch (error) {
      debugPrint(
        'Login: n\u00e3o foi poss\u00edvel identificar o usu\u00e1rio no RevenueCat: $error',
      );
    }
  }

  Future<void> _login() async {
    if (_isLoading) {
      return;
    }

    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      _showMessage('Preencha o e-mail e a senha.');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = credential.user;

      if (user == null) {
        throw StateError(
          'Firebase n\u00e3o retornou o usu\u00e1rio autenticado.',
        );
      }

      await AppProgress.loadProgress();
      await _identifyRevenueCatUser(user.uid);

      if (!mounted) {
        return;
      }

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute<void>(builder: (_) => const DashboardScreen()),
        (route) => false,
      );
    } on FirebaseAuthException catch (error) {
      _showMessage(_firebaseErrorMessage(error));
    } catch (error) {
      debugPrint('Login: erro inesperado: $error');
      _showMessage('Ocorreu um erro inesperado ao entrar.');
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _resetPassword() async {
    final email = _emailController.text.trim();

    if (email.isEmpty) {
      _showMessage(
        'Digite seu e-mail para receber a recupera\u00e7\u00e3o de senha.',
      );
      return;
    }

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

      _showMessage(
        'Enviamos as instru\u00e7\u00f5es de recupera\u00e7\u00e3o para o seu e-mail.',
      );
    } on FirebaseAuthException catch (error) {
      _showMessage(_firebaseErrorMessage(error));
    } catch (error) {
      debugPrint('Recupera\u00e7\u00e3o de senha: erro inesperado: $error');
      _showMessage(
        'N\u00e3o foi poss\u00edvel enviar a recupera\u00e7\u00e3o de senha.',
      );
    }
  }

  void _openRegister() {
    Navigator.of(
      context,
    ).push(MaterialPageRoute<void>(builder: (_) => const RegisterScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.navy,
      body: Stack(
        children: [
          const Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.navy,
                    Color(0xFF07172E),
                    Color(0xFF0A2140),
                  ],
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: _AnimatedLoginBackground(animation: _ambientController),
          ),
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.lg,
                    vertical: AppSpacing.lg,
                  ),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight - (2 * AppSpacing.lg),
                    ),
                    child: Center(
                      child: FadeTransition(
                        opacity: _fadeAnimation,
                        child: SlideTransition(
                          position: _slideAnimation,
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 420),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                ScaleTransition(
                                  scale: _logoScaleAnimation,
                                  child: Center(
                                    child: AnimatedBuilder(
                                      animation: _ambientController,
                                      builder: (context, child) {
                                        final phase =
                                            _ambientController.value *
                                            math.pi *
                                            2;

                                        return Transform.translate(
                                          offset: Offset(
                                            0,
                                            math.sin(phase) * 7,
                                          ),
                                          child: Transform.scale(
                                            scale:
                                                1 + (math.cos(phase) * 0.025),
                                            child: child,
                                          ),
                                        );
                                      },
                                      child: Container(
                                        width: 88,
                                        height: 88,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            22,
                                          ),
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Color(0x292563EB),
                                              blurRadius: 22,
                                              offset: Offset(0, 10),
                                            ),
                                          ],
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            22,
                                          ),
                                          child: Image.asset(
                                            'assets/branding/calculo_trivial_icon_1024.png',
                                            fit: BoxFit.cover,
                                            semanticLabel:
                                                'S\u00edmbolo do C\u00e1lculo Trivial',
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: AppSpacing.md),
                                Text(
                                  'C\u00e1lculo Trivial',
                                  textAlign: TextAlign.center,
                                  style: AppTypography.headingMedium.copyWith(
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.white,
                                  ),
                                ),
                                const SizedBox(height: AppSpacing.xs),
                                Text(
                                  'Domine o c\u00e1lculo. Evolua al\u00e9m.',
                                  textAlign: TextAlign.center,
                                  style: AppTypography.bodyMedium.copyWith(
                                    color: AppColors.primaryLight,
                                  ),
                                ),
                                const SizedBox(height: AppSpacing.lg),
                                Container(
                                  padding: const EdgeInsets.all(
                                    AppSpacing.cardPaddingLarge,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.surface,
                                    borderRadius: BorderRadius.circular(
                                      AppSpacing.radiusXXLarge,
                                    ),
                                    border: Border.all(color: AppColors.border),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: AppColors.shadow,
                                        blurRadius: 24,
                                        offset: Offset(0, 12),
                                      ),
                                    ],
                                  ),
                                  child: AutofillGroup(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Text(
                                          'Bem-vindo de volta',
                                          style: AppTypography.titleLarge,
                                        ),
                                        const SizedBox(height: AppSpacing.xs),
                                        Text(
                                          'Entre para continuar sua jornada.',
                                          style: AppTypography.bodyMedium,
                                        ),
                                        const SizedBox(height: AppSpacing.lg),
                                        AppTextField(
                                          controller: _emailController,
                                          labelText: 'E-mail',
                                          hintText: 'Digite seu e-mail',
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          prefixIcon: Icons.email_outlined,
                                          enabled: !_isLoading,
                                        ),
                                        const SizedBox(height: AppSpacing.md),
                                        AppTextField(
                                          controller: _passwordController,
                                          labelText: 'Senha',
                                          hintText: 'Digite sua senha',
                                          obscureText: !_isPasswordVisible,
                                          prefixIcon: Icons.lock_outline,
                                          enabled: !_isLoading,
                                          suffixIcon: IconButton(
                                            onPressed: _isLoading
                                                ? null
                                                : () {
                                                    setState(() {
                                                      _isPasswordVisible =
                                                          !_isPasswordVisible;
                                                    });
                                                  },
                                            icon: Icon(
                                              _isPasswordVisible
                                                  ? Icons
                                                        .visibility_off_outlined
                                                  : Icons.visibility_outlined,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: AppSpacing.lg),
                                        PrimaryButton(
                                          text: 'Entrar',
                                          onPressed: _login,
                                          isLoading: _isLoading,
                                        ),
                                        const SizedBox(height: AppSpacing.sm),
                                        TextButton(
                                          onPressed: _isLoading
                                              ? null
                                              : _resetPassword,
                                          child: const Text(
                                            'Esqueci minha senha',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: AppSpacing.sm),
                                Wrap(
                                  alignment: WrapAlignment.center,
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [
                                    Text(
                                      'Ainda n\u00e3o tem uma conta?',
                                      style: AppTypography.bodyMedium.copyWith(
                                        color: AppColors.primaryLight,
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: _isLoading
                                          ? null
                                          : _openRegister,
                                      style: TextButton.styleFrom(
                                        foregroundColor: AppColors.secondary,
                                      ),
                                      child: const Text('Criar conta'),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _AnimatedLoginBackground extends StatelessWidget {
  final Animation<double> animation;

  const _AnimatedLoginBackground({required this.animation});

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: AnimatedBuilder(
        animation: animation,
        builder: (context, child) {
          final phase = animation.value * math.pi * 2;
          final horizontal = math.sin(phase);
          final vertical = math.cos(phase);

          return Stack(
            children: [
              Positioned(
                top: 50 + (vertical * 35),
                left: -90 + (horizontal * 45),
                child: const _GlowOrb(size: 250, color: Color(0x3322D3EE)),
              ),
              Positioned(
                right: -100 - (horizontal * 40),
                bottom: 80 + (vertical * 45),
                child: const _GlowOrb(size: 280, color: Color(0x2E2563EB)),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _GlowOrb extends StatelessWidget {
  final double size;
  final Color color;

  const _GlowOrb({required this.size, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(colors: [color, color.withValues(alpha: 0)]),
      ),
    );
  }
}
