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

  static Future<void> initialize({String? appUserId}) async {
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

    final normalizedAppUserId = appUserId?.trim();

    if (normalizedAppUserId != null && normalizedAppUserId.isNotEmpty) {
      configuration.appUserID = normalizedAppUserId;
    }

    await Purchases.configure(configuration);

    _isConfigured = true;

    Purchases.addCustomerInfoUpdateListener(_handleCustomerInfoUpdate);

    debugPrint(
      normalizedAppUserId != null && normalizedAppUserId.isNotEmpty
          ? 'RevenueCat SDK inicializado com usuário autenticado.'
          : 'RevenueCat SDK inicializado com usuário anônimo.',
    );

    await refreshPremiumStatus();
  }

  static Future<CustomerInfo?> identifyUser(String appUserId) async {
    if (!_isConfigured) {
      premiumAccess.value = false;
      return null;
    }

    final normalizedAppUserId = appUserId.trim();

    if (normalizedAppUserId.isEmpty) {
      throw ArgumentError('O App User ID do RevenueCat não pode estar vazio.');
    }

    try {
      final result = await Purchases.logIn(normalizedAppUserId);

      _updatePremiumStatus(result.customerInfo);

      debugPrint('RevenueCat: usuário identificado com Firebase UID.');

      return result.customerInfo;
    } catch (error) {
      premiumAccess.value = false;

      debugPrint('RevenueCat: erro ao identificar usuário: $error');

      rethrow;
    }
  }

  static Future<CustomerInfo?> logOutUser() async {
    if (!_isConfigured) {
      premiumAccess.value = false;
      return null;
    }

    try {
      final isAnonymous = await Purchases.isAnonymous;

      if (isAnonymous) {
        premiumAccess.value = false;
        return Purchases.getCustomerInfo();
      }

      final customerInfo = await Purchases.logOut();

      _updatePremiumStatus(customerInfo);

      debugPrint('RevenueCat: usuário desconectado.');

      return customerInfo;
    } catch (error) {
      premiumAccess.value = false;

      debugPrint('RevenueCat: erro ao desconectar usuário: $error');

      rethrow;
    }
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
