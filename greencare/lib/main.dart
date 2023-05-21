import 'package:flutter/material.dart';
import 'package:greencare/pages/onboarding_screen.dart';
import 'package:greencare/pages/welcome.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'PK',
        scaffoldBackgroundColor: const Color(0xFFEFEFEF),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const OnBoardScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
