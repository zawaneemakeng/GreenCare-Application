import 'package:flutter/material.dart';
import 'package:greencare/pages/home..dart';
import 'package:greencare/pages/login.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFEFEFEF),
      ),
      body: Center(
        child: ListView(
          children: [
            Image.asset('assets/smartfarm2.png', width: 200, height: 200),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                height: 430,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255),
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(255, 255, 255, 255).withAlpha(0),
                      spreadRadius: 0,
                      blurRadius: 5,
                      offset: const Offset(0.5, 0),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: Text(
                          'Register Here ',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                      ),
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
                                  color: Color.fromARGB(255, 133, 133, 133),
                                ),
                                hintText: 'example@gmail.com',
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Divider(
                          height: 1,
                          color: Colors.grey,
                          thickness: 1,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
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
                                prefixIcon: Icon(
                                  Icons.password,
                                  color: Color.fromARGB(255, 93, 93, 93),
                                ),
                                hintText: 'password',
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Divider(
                          height: 1,
                          color: Colors.grey,
                          thickness: 1,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
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
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: Color.fromARGB(255, 93, 93, 93),
                                ),
                                hintText: 'Name',
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Divider(
                          height: 1,
                          color: Colors.grey,
                          thickness: 1,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
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
                                prefixIcon: Icon(
                                  Icons.phone,
                                  color: Color.fromARGB(255, 93, 93, 93),
                                ),
                                hintText: 'Phone Number',
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Divider(
                          height: 1,
                          color: Colors.grey,
                          thickness: 1,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const LoginPage()),
                                );
                              },
                              child: Text(
                                'มีบัญชีเเล้ว',
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomePage()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xff3AAA94),
                              fixedSize: const Size(130, 20),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50))),
                          child: const Text(
                            'Register',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
