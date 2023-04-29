import 'package:flutter/material.dart';
import 'package:greencare/pages/register.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5F2EB),
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
                        color: Colors.white,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(.2),
                            spreadRadius: 2,
                            blurRadius: 20,
                            offset: const Offset(0, 0),
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
                                            child: Text("ยังไม่มีบัญชี ?",
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
                                                    const Register()),
                                          );
                                        }),
                                    GestureDetector(
                                        child: const Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                95, 0, 0, 20),
                                            child: Text(
                                              "ลืมรหัสผ่าน ?",
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
                                                    const Register()),
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
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xff72AC45),
                                fixedSize: const Size(120, 40),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50))),
                            child: const Text('Login'),
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
