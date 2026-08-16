import 'package:flutter/foundation.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class RevenueCatService {
  RevenueCatService._();

  static const String entitlementPremium = 'Cálculo Trivial Premium';

  static const String _apiKey = String.fromEnvironment('REVENUECAT_API_KEY');

  static bool _isConfigured = false;

  static bool get isConfigured => _isConfigured;

  static Future<void> initialize() async {
    if (_isConfigured) {
      return;
    }

    if (_apiKey.isEmpty) {
      debugPrint(
        'RevenueCat não configurado: '
        'REVENUECAT_API_KEY não foi informada.',
      );
      return;
    }

    if (kDebugMode) {
      await Purchases.setLogLevel(LogLevel.debug);
    }

    final configuration = PurchasesConfiguration(_apiKey);

    await Purchases.configure(configuration);

    _isConfigured = true;

    debugPrint('RevenueCat SDK inicializado.');
  }

  static Future<bool> hasPremiumAccess() async {
    if (!_isConfigured) {
      return false;
    }

    final customerInfo = await Purchases.getCustomerInfo();

    final hasPremium = customerInfo.entitlements.active.containsKey(
      entitlementPremium,
    );

    debugPrint(
      hasPremium
          ? 'RevenueCat: acesso Premium ATIVO.'
          : 'RevenueCat: acesso Premium INATIVO.',
    );

    return hasPremium;
  }

  static Future<CustomerInfo?> getCustomerInfo() async {
    if (!_isConfigured) {
      return null;
    }

    return Purchases.getCustomerInfo();
  }

  static Future<CustomerInfo?> restorePurchases() async {
    if (!_isConfigured) {
      return null;
    }

    return Purchases.restorePurchases();
  }
}
