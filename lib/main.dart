import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'features/splash/presentation/splash_screen.dart';
import 'firebase_options.dart';
import 'shared/services/revenuecat_service.dart';
import 'shared/state/app_progress.dart';
import 'shared/theme/app_colors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final currentUser = FirebaseAuth.instance.currentUser;

  await AppProgress.loadProgress();

  await RevenueCatService.initialize(appUserId: currentUser?.uid);

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
      home: const SplashScreen(),
    );
  }
}
