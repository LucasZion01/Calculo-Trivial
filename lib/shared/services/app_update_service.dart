import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:in_app_update/in_app_update.dart';

class AppUpdateService {
  AppUpdateService._();

  static Future<bool> isUpdateAvailable() async {
    if (!Platform.isAndroid) {
      return false;
    }

    try {
      final info = await InAppUpdate.checkForUpdate().timeout(
        const Duration(seconds: 5),
      );

      return info.updateAvailability == UpdateAvailability.updateAvailable &&
          info.immediateUpdateAllowed;
    } catch (error) {
      debugPrint('Atualização: não foi possível consultar a Play Store: $error');
      return false;
    }
  }

  static Future<void> performImmediateUpdate() async {
    if (!Platform.isAndroid) {
      return;
    }

    try {
      await InAppUpdate.performImmediateUpdate();
    } catch (error) {
      debugPrint('Atualização: falha ao iniciar atualização imediata: $error');
    }
  }
}
