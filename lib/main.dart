import 'package:flutter/material.dart';

import 'features/splash/presentation/splash_screen.dart';

void main() {
  runApp(const CalcQuestApp());
}

class CalcQuestApp extends StatelessWidget {
  const CalcQuestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CalcQuest',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF8FAFC),
        fontFamily: 'Roboto',
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}