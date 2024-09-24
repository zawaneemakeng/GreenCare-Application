import 'package:flutter/material.dart';
import 'package:rotnaam/pages/intro_screens/onboarding_screen.dart';
import 'package:rotnaam/pages/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

var token; //สำหรับเก็บโทเค้นของยูเซอร์
void main() async {
  WidgetsFlutterBinding.ensureInitialized(); //รับเเอบเเบบเบื้องหลัง
  SharedPreferences pref = await SharedPreferences.getInstance();
  token = pref.getString('token');
  runApp(MaterialApp(
    localizationsDelegates: const [GlobalMaterialLocalizations.delegate],
    supportedLocales: const [Locale('en'), Locale('th')],
    home: token == null ? const MyApp() : const HomePage(),
    title: 'ROTNAAM',
    theme: ThemeData(
      colorSchemeSeed: Colors.teal,
      useMaterial3: true,
      fontFamily: 'PK',
      scaffoldBackgroundColor: const Color(0xFFEFEFEF),
    ),
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', 'US'), // English
        Locale('th', 'TH'), // Thai
      ],
      title: 'ROTNAAM',
      theme: ThemeData(
        colorSchemeSeed: Colors.teal,
        useMaterial3: true,
        fontFamily: 'PK',
        scaffoldBackgroundColor: const Color(0xFFefefef),
      ),
      home: OnboardingScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
