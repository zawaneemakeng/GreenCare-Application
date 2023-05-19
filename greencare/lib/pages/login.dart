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
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 150,
                    height: 120,
                    child: RichText(
                      text: const TextSpan(
                        text: 'Your',
                        style: TextStyle(
                          fontSize: 30,
                          color: Color(0xff1C6946),
                          fontWeight: FontWeight.bold,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                              text: ' workout partner',
                              style: TextStyle(
                                color: Colors.black87,
                              ))
                        ],
                      ),
                    ),
                  ),
                  Image.asset('assets/smartfarm.png'),
                  Container(
                    height: 300,
                    decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        boxShadow: [
                          BoxShadow(
                            color:
                                Color.fromARGB(255, 255, 255, 255).withAlpha(0),
                            spreadRadius: 0,
                            blurRadius: 5,
                            offset: const Offset(0.5, 0),
                          )
                        ]),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        const Positioned(
                          top: 10,
                          left: 20,
                          child: Text(
                            'Login Here',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Positioned(
                            top: 50,
                            left: 15,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 285,
                                      child: const TextField(
                                        cursorColor: Colors.grey,
                                        style: TextStyle(
                                          color: Colors.black54,
                                        ),
                                        decoration: InputDecoration(
                                          prefixIcon: Icon(
                                            Icons.email,
                                            color: Color(0xff72AC45),
                                          ),
                                          hintText: 'example@gmail.com',
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )),
                        Positioned(
                            top: 115,
                            left: 15,
                            right: 15,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 285,
                                      child: const TextField(
                                        obscureText: true,
                                        cursorColor: Colors.grey,
                                        style: TextStyle(
                                          color: Colors.black54,
                                        ),
                                        decoration: InputDecoration(
                                          prefixIcon: Icon(Icons.password,
                                              color: Color(0xff72AC45)),
                                          hintText: 'your password',
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            )),
                        Positioned(
                            top: 170,
                            left: 15,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    GestureDetector(
                                        child: const Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Padding(
                                            padding:
                                                EdgeInsets.only(bottom: 20.0),
                                            child: Text("ยังไม่มีบัญชี",
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 13)),
                                          ),
                                        ),
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const RegisterPage()),
                                          );
                                        }),
                                    GestureDetector(
                                        child: const Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                155, 0, 0, 20),
                                            child: Text(
                                              "ลืมรหัสผ่าน",
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 13),
                                            ),
                                          ),
                                        ),
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const ResetPasswordPage()),
                                          );
                                        }),
                                  ],
                                )
                              ],
                            )),
                        Positioned(
                          bottom: 20,
                          right: 100,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const HomePage()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xff72AC45),
                                fixedSize: const Size(120, 40),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50))),
                            child: const Text(
                              'Login',
                              style: TextStyle(color: Color(0xfff5F2EB)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
