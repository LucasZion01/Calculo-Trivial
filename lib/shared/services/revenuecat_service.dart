import 'package:flutter/foundation.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class RevenueCatService {
  RevenueCatService._();

  static const String entitlementPremium = 'Cálculo Trivial Premium';

  static const String _apiKey = String.fromEnvironment('REVENUECAT_API_KEY');

  static bool _isConfigured = false;

  static final ValueNotifier<bool> premiumAccess = ValueNotifier<bool>(false);

  static bool get isConfigured => _isConfigured;

  static bool get isPremium => premiumAccess.value;

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

    Purchases.addCustomerInfoUpdateListener(_handleCustomerInfoUpdate);

    debugPrint('RevenueCat SDK inicializado.');

    await refreshPremiumStatus();
  }

  static void _handleCustomerInfoUpdate(CustomerInfo customerInfo) {
    _updatePremiumStatus(customerInfo);
  }

  static void _updatePremiumStatus(CustomerInfo customerInfo) {
    final hasPremium = customerInfo.entitlements.active.containsKey(
      entitlementPremium,
    );

    premiumAccess.value = hasPremium;

    debugPrint(
      hasPremium
          ? 'RevenueCat: acesso Premium ATIVO.'
          : 'RevenueCat: acesso Premium INATIVO.',
    );
  }

  static Future<bool> refreshPremiumStatus() async {
    if (!_isConfigured) {
      premiumAccess.value = false;
      return false;
    }

    try {
      final customerInfo = await Purchases.getCustomerInfo();

      _updatePremiumStatus(customerInfo);

      return premiumAccess.value;
    } catch (error) {
      debugPrint('RevenueCat: erro ao verificar Premium: $error');

      return premiumAccess.value;
    }
  }

  static Future<bool> hasPremiumAccess() async {
    return refreshPremiumStatus();
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

    try {
      final customerInfo = await Purchases.restorePurchases();

      _updatePremiumStatus(customerInfo);

      return customerInfo;
    } catch (error) {
      debugPrint('RevenueCat: erro ao restaurar compras: $error');

      rethrow;
    }
  }
}
