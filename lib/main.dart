import 'package:flutter/material.dart';
import 'package:purchases_ui_flutter/purchases_ui_flutter.dart';

import 'features/splash/presentation/splash_screen.dart';
import 'shared/services/revenuecat_service.dart';
import 'shared/state/app_progress.dart';
import 'shared/theme/app_colors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AppProgress.loadProgress();
  await RevenueCatService.initialize();

  runApp(const CalcQuestApp());
}

class CalcQuestApp extends StatelessWidget {
  const CalcQuestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cálculo Trivial',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.background,
        fontFamily: 'Roboto',
        useMaterial3: true,
      ),
      home: const RevenueCatPaywallTestLauncher(child: SplashScreen()),
    );
  }
}

class RevenueCatPaywallTestLauncher extends StatefulWidget {
  const RevenueCatPaywallTestLauncher({required this.child, super.key});

  final Widget child;

  @override
  State<RevenueCatPaywallTestLauncher> createState() =>
      _RevenueCatPaywallTestLauncherState();
}

class _RevenueCatPaywallTestLauncherState
    extends State<RevenueCatPaywallTestLauncher> {
  static const bool _showPaywall = bool.fromEnvironment(
    'SHOW_REVENUECAT_PAYWALL',
    defaultValue: false,
  );

  bool _paywallWasRequested = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _presentPaywallForTesting();
    });
  }

  Future<void> _presentPaywallForTesting() async {
    if (!_showPaywall ||
        _paywallWasRequested ||
        !RevenueCatService.isConfigured) {
      return;
    }

    _paywallWasRequested = true;

    try {
      final result = await RevenueCatUI.presentPaywall();

      debugPrint('RevenueCat paywall result: $result');
    } catch (error, stackTrace) {
      debugPrint('Erro ao apresentar paywall RevenueCat: $error');

      debugPrintStack(stackTrace: stackTrace);
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
