import 'package:flutter/material.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
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
                    height: 150,
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
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                        color: const Color(0xfff5F2EB),
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
                          bottom: 20,
                          right: 100,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xff72AC45),
                                fixedSize: const Size(120, 40),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50))),
                            child: const Text(
                              'ส่ง',
                              style: TextStyle(color: Color(0xfff5F2EB)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 155,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Image.asset(
                      'assets/smartfarm3.png',
                      width: 210,
                      height: 200,
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
