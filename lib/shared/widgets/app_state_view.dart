import 'package:flutter/material.dart';

import 'package:calcquest/shared/theme/app_colors.dart';
import 'package:calcquest/shared/theme/app_spacing.dart';
import 'package:calcquest/shared/theme/app_typography.dart';
import 'package:calcquest/shared/widgets/app_icon.dart';
import 'package:calcquest/shared/widgets/primary_button.dart';

enum AppStateType {
  loading,
  empty,
  locked,
  offline,
  error,
}

class AppStateView extends StatelessWidget {
  final AppStateType type;
  final String? title;
  final String? message;
  final String? actionText;
  final VoidCallback? onAction;

  const AppStateView({
    super.key,
    required this.type,
    this.title,
    this.message,
    this.actionText,
    this.onAction,
  });

  String get _defaultTitle {
    switch (type) {
      case AppStateType.loading:
        return 'Carregando';
      case AppStateType.empty:
        return 'Nada por aqui ainda';
      case AppStateType.locked:
        return 'Conteúdo bloqueado';
      case AppStateType.offline:
        return 'Sem conexão';
      case AppStateType.error:
        return 'Algo deu errado';
    }
  }

  String get _defaultMessage {
    switch (type) {
      case AppStateType.loading:
        return 'Estamos preparando o conteúdo para você.';
      case AppStateType.empty:
        return 'Quando houver conteúdo disponível, ele aparecerá aqui.';
      case AppStateType.locked:
        return 'Conclua as etapas anteriores para desbloquear este conteúdo.';
      case AppStateType.offline:
        return 'Verifique sua conexão com a internet e tente novamente.';
      case AppStateType.error:
        return 'Não foi possível concluir esta ação. Tente novamente.';
    }
  }

  IconData get _icon {
    switch (type) {
      case AppStateType.loading:
        return Icons.hourglass_top_rounded;
      case AppStateType.empty:
        return Icons.inbox_outlined;
      case AppStateType.locked:
        return Icons.lock_outline_rounded;
      case AppStateType.offline:
        return Icons.wifi_off_rounded;
      case AppStateType.error:
        return Icons.error_outline_rounded;
    }
  }

  Color get _iconColor {
    switch (type) {
      case AppStateType.loading:
        return AppColors.loading;
      case AppStateType.empty:
        return AppColors.emptyStateIcon;
      case AppStateType.locked:
        return AppColors.locked;
      case AppStateType.offline:
        return AppColors.offline;
      case AppStateType.error:
        return AppColors.error;
    }
  }

  Color get _iconBackground {
    switch (type) {
      case AppStateType.loading:
        return AppColors.secondaryLight;
      case AppStateType.empty:
        return AppColors.emptyStateBackground;
      case AppStateType.locked:
        return AppColors.lockedBackground;
      case AppStateType.offline:
        return AppColors.offlineBackground;
      case AppStateType.error:
        return AppColors.errorLight;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(
          AppSpacing.lg,
        ),
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 360,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (type == AppStateType.loading)
                const SizedBox(
                  width: 44,
                  height: 44,
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      AppColors.loading,
                    ),
                  ),
                )
              else
                Container(
                  width: 72,
                  height: 72,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: _iconBackground,
                    borderRadius: BorderRadius.circular(
                      AppSpacing.radiusXLarge,
                    ),
                  ),
                  child: AppIcon(
                    icon: _icon,
                    size: AppIconSize.extraLarge,
                    color: _iconColor,
                  ),
                ),
              const SizedBox(
                height: AppSpacing.lg,
              ),
              Text(
                title ?? _defaultTitle,
                textAlign: TextAlign.center,
                style: AppTypography.headingSmall,
              ),
              const SizedBox(
                height: AppSpacing.xs,
              ),
              Text(
                message ?? _defaultMessage,
                textAlign: TextAlign.center,
                style: AppTypography.bodyMedium,
              ),
              if (actionText != null && onAction != null) ...[
                const SizedBox(
                  height: AppSpacing.lg,
                ),
                PrimaryButton(
                  text: actionText!,
                  onPressed: onAction,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}