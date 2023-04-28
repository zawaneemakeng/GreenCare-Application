import 'package:flutter/material.dart';
import 'pages/welcome.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xffD5EBFD), //<-- SEE HERE
      ),
      home: Welcome(),
      debugShowCheckedModeBanner: false,
    );
  }
}
