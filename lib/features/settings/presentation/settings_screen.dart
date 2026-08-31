import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:purchases_ui_flutter/purchases_ui_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:calcquest/l10n/app_localizations.dart';
import 'package:calcquest/shared/services/revenuecat_service.dart';
import 'package:calcquest/shared/state/app_locale_controller.dart';
import 'package:calcquest/shared/state/app_progress.dart';
import 'package:calcquest/shared/theme/app_colors.dart';
import 'package:calcquest/shared/theme/app_motion.dart';
import 'package:calcquest/shared/theme/app_spacing.dart';
import 'package:calcquest/shared/theme/app_typography.dart';
import 'package:calcquest/shared/widgets/app_bottom_navigation_bar.dart';
import 'package:calcquest/shared/widgets/app_icon.dart';
import 'package:calcquest/shared/widgets/primary_button.dart';

import '../../auth/presentation/login_screen.dart';
import '../../dashboard/presentation/dashboard_screen.dart';
import '../../learning_path/presentation/learning_path_screen.dart';
import '../../profile/presentation/profile_screen.dart';
import '../../statistics/presentation/statistics_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  static final Uri _privacyPolicyUri = Uri.parse(
    'https://calculo-trivial-app-646bb.web.app',
  );

  bool _processingSubscriptionAction = false;
  bool _isSigningOut = false;
  bool _isDeletingAccount = false;

  bool get _isBusy =>
      _processingSubscriptionAction || _isSigningOut || _isDeletingAccount;

  void _onMenuTap(BuildContext context, int index) {
    if (_isBusy) {
      return;
    }

    if (index == 0) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const DashboardScreen()),
      );
      return;
    }

    if (index == 1) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const LearningPathScreen()),
      );
      return;
    }

    if (index == 2) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const StatisticsScreen()),
      );
      return;
    }

    if (index == 3) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const ProfileScreen()),
      );
    }
  }

  void _showMessage(String message) {
    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _openPrivacyPolicy() async {
    try {
      final opened = await launchUrl(
        _privacyPolicyUri,
        mode: LaunchMode.externalApplication,
      );

      if (!opened) {
        _showMessage('Não foi possível abrir a página de privacidade.');
      }
    } catch (error) {
      debugPrint(
        'Configurações: erro ao abrir política de privacidade: $error',
      );

      _showMessage('Não foi possível abrir a página de privacidade.');
    }
  }

  Future<void> _restorePurchases() async {
    if (_isBusy) {
      return;
    }

    if (!RevenueCatService.isConfigured) {
      _showMessage('O sistema Premium está indisponível no momento.');
      return;
    }

    setState(() {
      _processingSubscriptionAction = true;
    });

    try {
      await RevenueCatService.restorePurchases();

      if (!mounted) {
        return;
      }

      if (RevenueCatService.isPremium) {
        _showMessage('Compras restauradas. Seu acesso Premium está ativo.');
      } else {
        _showMessage('Nenhuma compra Premium foi encontrada para esta conta.');
      }
    } catch (error) {
      debugPrint('Configurações: erro ao restaurar compras: $error');

      _showMessage('Não foi possível restaurar suas compras.');
    } finally {
      if (mounted) {
        setState(() {
          _processingSubscriptionAction = false;
        });
      }
    }
  }

  Future<void> _openCustomerCenter() async {
    if (_isBusy) {
      return;
    }

    if (!RevenueCatService.isConfigured) {
      _showMessage('O sistema Premium está indisponível no momento.');
      return;
    }

    setState(() {
      _processingSubscriptionAction = true;
    });

    try {
      await RevenueCatUI.presentCustomerCenter();
      await RevenueCatService.refreshPremiumStatus();
    } catch (error) {
      debugPrint(
        'Configurações: erro ao abrir '
        'a central de assinatura: $error',
      );

      _showMessage('Não foi possível abrir o gerenciamento da assinatura.');
    } finally {
      if (mounted) {
        setState(() {
          _processingSubscriptionAction = false;
        });
      }
    }
  }

  Future<void> _changeLanguage(Locale locale) async {
    await appLocaleController.setLocale(locale);

    if (!mounted) {
      return;
    }

    final l10n = AppLocalizations.of(context)!;
    final languageName = locale.languageCode == 'en'
        ? l10n.english
        : l10n.portuguese;

    _showMessage('${l10n.languageUpdated}: $languageName');
  }

  Future<void> _confirmSignOut() async {
    if (_isBusy) {
      return;
    }

    final shouldSignOut = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Sair da conta?'),
          content: const Text(
            'Seu progresso permanecerá salvo e poderá ser '
            'recuperado quando você entrar novamente.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop(false);
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop(true);
              },
              style: TextButton.styleFrom(foregroundColor: AppColors.error),
              child: const Text('Sair'),
            ),
          ],
        );
      },
    );

    if (shouldSignOut != true || !mounted) {
      return;
    }

    await _signOut();
  }

  Future<void> _signOut() async {
    setState(() {
      _isSigningOut = true;
    });

    try {
      if (RevenueCatService.isConfigured) {
        try {
          await RevenueCatService.logOutUser();
        } catch (error) {
          debugPrint(
            'Configurações: não foi possível desconectar '
            'o RevenueCat: $error',
          );
        }
      }

      await FirebaseAuth.instance.signOut();

      AppProgress.clearSession();

      if (!mounted) {
        return;
      }

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute<void>(builder: (_) => const LoginScreen()),
        (route) => false,
      );
    } on FirebaseAuthException catch (error) {
      debugPrint(
        'Configurações: erro do Firebase ao sair: '
        '${error.code} - ${error.message}',
      );

      _showMessage('Não foi possível sair da conta. Tente novamente.');
    } catch (error) {
      debugPrint('Configurações: erro inesperado ao sair: $error');

      _showMessage('Ocorreu um erro inesperado ao sair da conta.');
    } finally {
      if (mounted) {
        setState(() {
          _isSigningOut = false;
        });
      }
    }
  }

  Future<void> _confirmDeleteAccount() async {
    if (_isBusy) {
      return;
    }

    final passwordController = TextEditingController();

    final password = await showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Excluir conta permanentemente?'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Seu progresso, XP, moedas e conta serão apagados. '
                'Essa ação não poderá ser desfeita.',
              ),
              const SizedBox(height: AppSpacing.sm),
              const Text(
                'A exclusão não cancela uma assinatura ativa. '
                'Cancele-a em “Gerenciar assinatura” antes de continuar.',
              ),
              const SizedBox(height: AppSpacing.md),
              TextField(
                controller: passwordController,
                obscureText: true,
                autofocus: true,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(
                  labelText: 'Confirme sua senha',
                  border: OutlineInputBorder(),
                ),
                onSubmitted: (value) {
                  if (value.isNotEmpty) {
                    Navigator.of(dialogContext).pop(value);
                  }
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                final password = passwordController.text;

                if (password.isNotEmpty) {
                  Navigator.of(dialogContext).pop(password);
                }
              },
              style: TextButton.styleFrom(foregroundColor: AppColors.error),
              child: const Text('Excluir permanentemente'),
            ),
          ],
        );
      },
    );

    passwordController.dispose();

    if (password == null || password.isEmpty || !mounted) {
      return;
    }

    await _deleteAccount(password);
  }

  Future<void> _deleteAccount(String password) async {
    final user = FirebaseAuth.instance.currentUser;
    final email = user?.email;

    if (user == null || email == null || email.isEmpty) {
      _showMessage('Não foi possível identificar a conta atual.');
      return;
    }

    setState(() {
      _isDeletingAccount = true;
    });

    try {
      final credential = EmailAuthProvider.credential(
        email: email,
        password: password,
      );

      await user.reauthenticateWithCredential(credential);

      final callable = FirebaseFunctions.instanceFor(
        region: 'us-central1',
      ).httpsCallable(
        'deleteAccount',
        options: HttpsCallableOptions(
          timeout: const Duration(seconds: 30),
        ),
      );

      await callable.call<void>(const <String, dynamic>{});

      if (RevenueCatService.isConfigured) {
        try {
          await RevenueCatService.logOutUser();
        } catch (error) {
          debugPrint(
            'Configurações: não foi possível desconectar '
            'o RevenueCat após a exclusão: $error',
          );
        }
      }

      await FirebaseAuth.instance.signOut();
      AppProgress.clearSession();

      if (!mounted) {
        return;
      }

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute<void>(builder: (_) => const LoginScreen()),
        (route) => false,
      );
    } on FirebaseFunctionsException catch (error) {
      debugPrint(
        'Configurações: falha pública na exclusão: ${error.code}',
      );

      _showMessage(
        'Não foi possível concluir a exclusão. Tente novamente.',
      );
    } on FirebaseAuthException catch (error) {
      debugPrint(
        'Configurações: erro do Firebase ao excluir conta: '
        '${error.code} - ${error.message}',
      );

      final message = switch (error.code) {
        'invalid-credential' ||
        'wrong-password' => 'Senha incorreta. A conta não foi excluída.',
        'too-many-requests' =>
          'Muitas tentativas. Aguarde um pouco e tente novamente.',
        'network-request-failed' =>
          'Verifique sua conexão com a internet e tente novamente.',
        'requires-recent-login' =>
          'Entre novamente na conta antes de tentar excluí-la.',
        _ => 'Não foi possível excluir a conta. Tente novamente.',
      };

      _showMessage(message);
    } catch (error) {
      debugPrint('Configurações: erro inesperado ao excluir conta: $error');

      _showMessage('Não foi possível excluir a conta. Tente novamente.');
    } finally {
      if (mounted) {
        setState(() {
          _isDeletingAccount = false;
        });
      }
    }
  }

  Widget _buildSubscriptionStatus(bool isPremium) {
    final statusColor = isPremium ? AppColors.success : const Color(0xFFFFB300);

    final statusBackground = statusColor.withValues(alpha: 0.12);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.cardPaddingLarge),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusXLarge),
        border: Border.all(color: statusColor.withValues(alpha: 0.45)),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 12,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: statusBackground,
              borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
            ),
            child: AppIcon(
              icon: isPremium
                  ? Icons.workspace_premium_rounded
                  : Icons.lock_outline_rounded,
              size: AppIconSize.large,
              color: statusColor,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isPremium ? 'Premium ativo' : 'Plano gratuito',
                  style: AppTypography.titleMedium.copyWith(
                    color: statusColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: AppSpacing.xxs),
                Text(
                  isPremium
                      ? 'Você possui acesso aos recursos Premium.'
                      : 'Assine para liberar todos os recursos.',
                  style: AppTypography.bodySmall,
                ),
              ],
            ),
          ),
          Icon(
            isPremium
                ? Icons.verified_rounded
                : Icons.workspace_premium_outlined,
            color: statusColor,
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageSelector(AppLocalizations l10n) {
    return AnimatedBuilder(
      animation: appLocaleController,
      builder: (context, child) {
        final selectedLanguage = appLocaleController.locale.languageCode;

        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(AppSpacing.cardPaddingLarge),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.selectedBackground,
                      borderRadius: BorderRadius.circular(
                        AppSpacing.radiusMedium,
                      ),
                    ),
                    child: const AppIcon(
                      icon: Icons.language_rounded,
                      size: AppIconSize.large,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(l10n.language, style: AppTypography.titleMedium),
                        const SizedBox(height: AppSpacing.xxs),
                        Text(
                          l10n.languageSettingsSubtitle,
                          style: AppTypography.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              Row(
                children: [
                  Expanded(
                    child: _LanguageOption(
                      label: l10n.portuguese,
                      selected: selectedLanguage == 'pt',
                      onTap: () => _changeLanguage(const Locale('pt')),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: _LanguageOption(
                      label: l10n.english,
                      selected: selectedLanguage == 'en',
                      onTap: () => _changeLanguage(const Locale('en')),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final currentUser = FirebaseAuth.instance.currentUser;
    final userEmail = currentUser?.email ?? l10n.unidentifiedAccount;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.screenHorizontal,
            AppSpacing.screenTop,
            AppSpacing.screenHorizontal,
            AppSpacing.screenBottom,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.settings,
                style: AppTypography.labelMedium.copyWith(
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(l10n.accountSettings, style: AppTypography.headingMedium),
              const SizedBox(height: AppSpacing.xs),
              Text(
                l10n.accountSettingsSubtitle,
                style: AppTypography.bodyMedium,
              ),
              const SizedBox(height: AppSpacing.lg),
              _SettingsCard(
                icon: Icons.person_outline_rounded,
                title: l10n.account,
                subtitle: userEmail,
              ),
              const SizedBox(height: AppSpacing.md),
              _buildLanguageSelector(l10n),
              const SizedBox(height: AppSpacing.md),
              _SettingsCard(
                icon: Icons.privacy_tip_outlined,
                title: 'Privacidade e dados',
                subtitle: 'Política de privacidade e exclusão de conta',
                onTap: _openPrivacyPolicy,
              ),
              const SizedBox(height: AppSpacing.md),
              const _SettingsCard(
                icon: Icons.notifications_none_rounded,
                title: 'Notificações',
                subtitle: 'Lembretes de estudo e metas diárias',
              ),
              const SizedBox(height: AppSpacing.md),
              const _SettingsCard(
                icon: Icons.light_mode_outlined,
                title: 'Tema',
                subtitle: 'Modo claro ativado',
              ),
              const SizedBox(height: AppSpacing.lg),
              Text('Assinatura', style: AppTypography.titleLarge),
              const SizedBox(height: AppSpacing.sm),
              ValueListenableBuilder<bool>(
                valueListenable: RevenueCatService.premiumAccess,
                builder: (context, isPremium, child) {
                  return _buildSubscriptionStatus(isPremium);
                },
              ),
              const SizedBox(height: AppSpacing.md),
              _SettingsCard(
                icon: Icons.restore_rounded,
                title: 'Restaurar compras',
                subtitle: 'Recupere uma assinatura comprada anteriormente',
                onTap: _isBusy ? null : _restorePurchases,
                trailing: _processingSubscriptionAction
                    ? const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : null,
              ),
              const SizedBox(height: AppSpacing.md),
              _SettingsCard(
                icon: Icons.manage_accounts_outlined,
                title: 'Gerenciar assinatura',
                subtitle: 'Consulte, altere ou cancele seu plano',
                onTap: _isBusy ? null : _openCustomerCenter,
              ),
              const SizedBox(height: AppSpacing.lg),
              PrimaryButton(
                text: 'Sair da conta',
                icon: Icons.logout_rounded,
                variant: PrimaryButtonVariant.destructive,
                onPressed: _isBusy ? null : _confirmSignOut,
                isLoading: _isSigningOut,
              ),
              const SizedBox(height: AppSpacing.md),
              _SettingsCard(
                icon: Icons.delete_forever_outlined,
                title: 'Excluir minha conta',
                subtitle: 'Apague permanentemente sua conta e seu progresso',
                onTap: _isBusy ? null : _confirmDeleteAccount,
                trailing: _isDeletingAccount
                    ? const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : null,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: AppBottomNavigationBar(
        currentIndex: 3,
        onTap: (index) {
          _onMenuTap(context, index);
        },
      ),
    );
  }
}

class _LanguageOption extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _LanguageOption({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final foregroundColor = selected ? AppColors.primary : AppColors.textPrimary;

    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
        child: AnimatedContainer(
          duration: AppMotion.standard,
          curve: AppMotion.easeOut,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.sm,
            vertical: AppSpacing.sm,
          ),
          decoration: BoxDecoration(
            color: selected ? AppColors.selectedBackground : AppColors.surface,
            borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
            border: Border.all(
              color: selected ? AppColors.primary : AppColors.border,
              width: selected ? 2 : 1,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedSwitcher(
                duration: AppMotion.standard,
                child: selected
                    ? const Icon(
                        Icons.check_circle_rounded,
                        key: ValueKey<String>('selected-language'),
                        size: AppSpacing.iconMedium,
                        color: AppColors.primary,
                      )
                    : const SizedBox(
                        key: ValueKey<String>('unselected-language'),
                        width: AppSpacing.iconMedium,
                        height: AppSpacing.iconMedium,
                      ),
              ),
              const SizedBox(width: AppSpacing.xs),
              Flexible(
                child: Text(
                  label,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.labelMedium.copyWith(
                    color: foregroundColor,
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

class _SettingsCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;
  final Widget? trailing;

  const _SettingsCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.onTap,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(AppSpacing.cardPaddingLarge),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.surfaceSecondary,
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
                ),
                child: AppIcon(
                  icon: icon,
                  size: AppIconSize.large,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: AppTypography.titleMedium),
                    const SizedBox(height: AppSpacing.xxs),
                    Text(subtitle, style: AppTypography.bodySmall),
                  ],
                ),
              ),
              if (trailing != null)
                trailing!
              else if (onTap != null)
                const AppIcon(
                  icon: Icons.chevron_right_rounded,
                  size: AppIconSize.large,
                  color: AppColors.textMuted,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
