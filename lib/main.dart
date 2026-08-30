import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'debug/tutor_callable_probe.dart';
import 'features/splash/presentation/splash_screen.dart';
import 'firebase_options.dart';
import 'l10n/app_localizations.dart';
import 'shared/theme/app_colors.dart';

const bool _useFirebaseEmulators = bool.fromEnvironment(
  'USE_FIREBASE_EMULATORS',
  defaultValue: false,
);

const bool _runTutorProbe = bool.fromEnvironment(
  'RUN_TUTOR_PROBE',
  defaultValue: false,
);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  if (_useFirebaseEmulators) {
    await _configureFirebaseEmulators();
  }

  try {
    await FirebaseAppCheck.instance
        .activate(
          providerAndroid: kDebugMode
              ? const AndroidDebugProvider()
              : const AndroidPlayIntegrityProvider(),
        )
        .timeout(const Duration(seconds: 5));

    debugPrint('Firebase App Check inicializado.');
  } catch (error) {
    debugPrint('Firebase App Check não pôde ser inicializado: $error');
  }

  if (_useFirebaseEmulators && _runTutorProbe) {
    await runTutorCallableProbe();
  }

  runApp(const CalcQuestApp());
}

Future<void> _configureFirebaseEmulators() async {
  final host = _firebaseEmulatorHost();

  await FirebaseAuth.instance.useAuthEmulator(host, 9099);

  FirebaseFirestore.instance.useFirestoreEmulator(host, 8080);

  FirebaseFunctions.instanceFor(
    region: 'us-central1',
  ).useFunctionsEmulator(host, 5001);

  debugPrint('Firebase Emulators configurados em $host.');
}

String _firebaseEmulatorHost() {
  return const String.fromEnvironment(
    'FIREBASE_EMULATOR_HOST',
    defaultValue: '127.0.0.1',
  );
}

class CalcQuestApp extends StatelessWidget {
  final Widget? home;

  const CalcQuestApp({super.key, this.home});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateTitle: (context) => AppLocalizations.of(context)!.appName,
      debugShowCheckedModeBanner: false,
      locale: const Locale('pt'),
      supportedLocales: const [Locale('pt'), Locale('en')],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.background,
        fontFamily: 'Roboto',
        useMaterial3: true,
      ),
      home: home ?? const SplashScreen(),
    );
  }
}
