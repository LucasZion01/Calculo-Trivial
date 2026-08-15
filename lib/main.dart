import 'package:flutter/material.dart';

import 'features/splash/presentation/splash_screen.dart';
import 'shared/state/app_progress.dart';
import 'shared/theme/app_colors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AppProgress.loadProgress();

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