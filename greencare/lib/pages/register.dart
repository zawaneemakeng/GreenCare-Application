import 'package:flutter/material.dart';
import 'package:greencare/pages/login.dart';

class Register extends StatelessWidget {
  const Register({Key? key}) : super(key: key);

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
                    height: 20,
                  ),
                  Stack(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Image.asset(
                            'assets/smartfarm2.png',
                            width: 220,
                            height: 150,
                          ),
                        ),
                      ),
                      Container(
                          alignment: Alignment.topLeft,
                          child: Column(
                            children: [
                              Text(
                                'Your',
                                style: TextStyle(
                                  fontSize: 25,
                                  color: Color(0xff1C6946),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Your',
                                style: TextStyle(
                                  fontSize: 25,
                                  color: Color(0xff1C6946),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          )),
                    ],
                  ),
                  Container(
                    height: 480,
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
                            top: 180,
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
                            top: 245,
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
                            top: 310,
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
                            top: 360,
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
                                            child: Text(
                                              "เข้าสู่ระบบ ",
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
                                                    const Login()),
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
                            child: const Text('สมัครบัญชี'),
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
