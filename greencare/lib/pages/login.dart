import 'package:flutter/material.dart';
import 'package:greencare/pages/register.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController weight = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5F2EB),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Center(
                child: Column(
              children: [
                Image.asset(
                  'assets/smartfarm2.png',
                  height: 300,
                  width: 360,
                ),
                const SizedBox(
                  height: 200,
                ),
                TextField(
                  controller: weight,
                  decoration: const InputDecoration(
                    labelText: 'กรอกน้ำหนักน้องเเงว (กิโลกรัม)',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            )),
          )
        ],
      ),
    );
  }
}
