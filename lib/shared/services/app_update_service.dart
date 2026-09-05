import 'package:flutter/foundation.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:url_launcher/url_launcher.dart';

class AppUpdateStatus {
  final bool available;
  final bool immediateUpdateAllowed;

  const AppUpdateStatus({
    required this.available,
    required this.immediateUpdateAllowed,
  });

  static const unavailable = AppUpdateStatus(
    available: false,
    immediateUpdateAllowed: false,
  );
}

class AppUpdateService {
  AppUpdateService._();

  static const _packageName = 'com.lucaszion01.calculotrivial';

  static bool get _isAndroidApp =>
      !kIsWeb && defaultTargetPlatform == TargetPlatform.android;

  static Future<AppUpdateStatus> checkForUpdate() async {
    if (!_isAndroidApp) {
      return AppUpdateStatus.unavailable;
    }

    try {
      final info = await InAppUpdate.checkForUpdate().timeout(
        const Duration(seconds: 5),
      );

      return AppUpdateStatus(
        available:
            info.updateAvailability == UpdateAvailability.updateAvailable,
        immediateUpdateAllowed: info.immediateUpdateAllowed,
      );
    } catch (error) {
      debugPrint('Atualização: não foi possível consultar a Play Store: $error');
      return AppUpdateStatus.unavailable;
    }
  }

  static Future<bool> isUpdateAvailable() async {
    final status = await checkForUpdate();
    return status.available;
  }

  static Future<void> performImmediateUpdate() async {
    final status = await checkForUpdate();
    await updateNow(status);
  }

  static Future<void> updateNow(AppUpdateStatus status) async {
    if (!_isAndroidApp || !status.available) {
      return;
    }

    if (status.immediateUpdateAllowed) {
      try {
        await InAppUpdate.performImmediateUpdate();
        return;
      } catch (error) {
        debugPrint(
          'Atualização: falha no fluxo imediato, abrindo Play Store: $error',
        );
      }
    }

    await openPlayStore();
  }

  static Future<void> openPlayStore() async {
    if (!_isAndroidApp) {
      return;
    }

    final marketUri = Uri.parse('market://details?id=$_packageName');
    final webUri = Uri.parse(
      'https://play.google.com/store/apps/details?id=$_packageName',
    );

    try {
      final openedMarket = await launchUrl(
        marketUri,
        mode: LaunchMode.externalApplication,
      );

      if (openedMarket) {
        return;
      }
    } catch (error) {
      debugPrint('Atualização: Play Store nativa indisponível: $error');
    }

    try {
      await launchUrl(webUri, mode: LaunchMode.externalApplication);
    } catch (error) {
      debugPrint('Atualização: não foi possível abrir a Play Store: $error');
    }
  }
}
