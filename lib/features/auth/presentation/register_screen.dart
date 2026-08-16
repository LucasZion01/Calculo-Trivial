import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:calcquest/features/dashboard/presentation/dashboard_screen.dart';
import 'package:calcquest/shared/services/revenuecat_service.dart';
import 'package:calcquest/shared/state/app_progress.dart';
import 'package:calcquest/shared/theme/app_colors.dart';
import 'package:calcquest/shared/theme/app_spacing.dart';
import 'package:calcquest/shared/theme/app_typography.dart';
import 'package:calcquest/shared/widgets/app_text_field.dart';
import 'package:calcquest/shared/widgets/primary_button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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
      case 'email-already-in-use':
        return 'Já existe uma conta cadastrada com este e-mail.';
      case 'invalid-email':
        return 'Digite um endereço de e-mail válido.';
      case 'weak-password':
        return 'Crie uma senha mais forte, com pelo menos 6 caracteres.';
      case 'operation-not-allowed':
        return 'O cadastro por e-mail não está disponível.';
      case 'too-many-requests':
        return 'Muitas tentativas. Aguarde um pouco e tente novamente.';
      case 'network-request-failed':
        return 'Verifique sua conexão com a internet.';
      default:
        return 'Não foi possível criar sua conta.';
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
        'Cadastro: não foi possível identificar o usuário no RevenueCat: $error',
      );
    }
  }

  Future<void> _register() async {
    if (_isLoading) {
      return;
    }

    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    if (name.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      _showMessage('Preencha todos os campos.');
      return;
    }

    if (name.length < 2) {
      _showMessage('Digite seu nome.');
      return;
    }

    if (password.length < 6) {
      _showMessage('A senha precisa ter pelo menos 6 caracteres.');
      return;
    }

    if (password != confirmPassword) {
      _showMessage('As senhas não coincidem.');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      final user = credential.user;

      if (user == null) {
        throw StateError('Firebase não retornou o usuário criado.');
      }

      await user.updateDisplayName(name);
      await user.reload();

      await AppProgress.resetProgress();
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
      debugPrint('Cadastro: erro inesperado: $error');
      _showMessage('Ocorreu um erro inesperado ao criar sua conta.');
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.xl,
              vertical: AppSpacing.xxl,
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      onPressed: _isLoading
                          ? null
                          : () {
                              Navigator.of(context).pop();
                            },
                      icon: const Icon(Icons.arrow_back_rounded),
                      color: AppColors.textPrimary,
                      tooltip: 'Voltar',
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Center(
                    child: Image.asset(
                      'assets/branding/calculo_trivial_icon_1024.png',
                      width: 96,
                      height: 96,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Text(
                    'Cálculo Trivial',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    'Domine o cálculo. Evolua além.',
                    textAlign: TextAlign.center,
                    style: AppTypography.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xxxl),
                  Text(
                    'Crie sua conta',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    'Comece sua jornada de aprendizagem.',
                    style: AppTypography.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  AppTextField(
                    controller: _nameController,
                    labelText: 'Nome',
                    hintText: 'Digite seu nome',
                    keyboardType: TextInputType.name,
                    prefixIcon: Icons.person_outline,
                    enabled: !_isLoading,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  AppTextField(
                    controller: _emailController,
                    labelText: 'E-mail',
                    hintText: 'Digite seu e-mail',
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: Icons.email_outlined,
                    enabled: !_isLoading,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  AppTextField(
                    controller: _passwordController,
                    labelText: 'Senha',
                    hintText: 'Crie uma senha',
                    obscureText: !_isPasswordVisible,
                    prefixIcon: Icons.lock_outline,
                    enabled: !_isLoading,
                    suffixIcon: IconButton(
                      onPressed: _isLoading
                          ? null
                          : () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                      icon: Icon(
                        _isPasswordVisible
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  AppTextField(
                    controller: _confirmPasswordController,
                    labelText: 'Confirmar senha',
                    hintText: 'Digite sua senha novamente',
                    obscureText: !_isConfirmPasswordVisible,
                    prefixIcon: Icons.lock_outline,
                    enabled: !_isLoading,
                    suffixIcon: IconButton(
                      onPressed: _isLoading
                          ? null
                          : () {
                              setState(() {
                                _isConfirmPasswordVisible =
                                    !_isConfirmPasswordVisible;
                              });
                            },
                      icon: Icon(
                        _isConfirmPasswordVisible
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  PrimaryButton(
                    text: 'Criar conta',
                    onPressed: _register,
                    isLoading: _isLoading,
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Já possui uma conta?',
                        style: AppTypography.bodyMedium.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      TextButton(
                        onPressed: _isLoading
                            ? null
                            : () {
                                Navigator.of(context).pop();
                              },
                        child: const Text('Entrar'),
                      ),
                    ],
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
