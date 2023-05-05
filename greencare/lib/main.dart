import 'package:flutter/material.dart';
import 'pages/welcome.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

void main() {
  Intl.defaultLocale = 'th';
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      home: Welcome(),
      theme: ThemeData(
        inputDecorationTheme: const InputDecorationTheme(
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xff72AC45))),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xff72AC45)),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
