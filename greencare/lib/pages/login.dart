import 'package:flutter/material.dart';
import 'package:greencare/pages/home..dart';
import 'package:greencare/pages/register.dart';
import 'package:greencare/pages/reset_password.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFEFEFEF),
      ),
      body: Center(
        child: ListView(
          children: [
            Image.asset('assets/smartfarm2.png', width: 250, height: 250),
            Padding(
              padding: const EdgeInsets.all(.0),
              child: Container(
                height: 300,
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 255, 255, 255),
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromARGB(255, 255, 255, 255).withAlpha(0),
                        spreadRadius: 0,
                        blurRadius: 5,
                        offset: const Offset(0.5, 0),
                      )
                    ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
