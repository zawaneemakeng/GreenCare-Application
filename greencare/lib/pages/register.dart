import 'package:flutter/material.dart';

class Register extends StatelessWidget {
  const Register({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xfff5F2EB),
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.all(20),
        height: size.height,
        width: size.width,
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
                  ])),
            ),
            Image.asset('assets/smartfarm.png'),
            Container(
              height: 300,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
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
                      top: 60,
                      left: 15,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.mail_outline,
                                color: Colors.grey,
                              ),
                              Container(
                                padding: const EdgeInsets.only(left: 10),
                                width: 300,
                                child: const TextField(
                                  cursorColor: Colors.grey,
                                  style: TextStyle(
                                    color: Colors.black54,
                                  ),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'example@gmail.com',
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: size.width * .8,
                            child: const Divider(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      )),
                  Positioned(
                      top: 135,
                      left: 15,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.mail_outline,
                                color: Colors.grey,
                              ),
                              Container(
                                padding: const EdgeInsets.only(left: 10),
                                width: 300,
                                child: const TextField(
                                  obscureText: true,
                                  cursorColor: Colors.grey,
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 20,
                                    letterSpacing: 1.4,
                                  ),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: '...........',
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: size.width * .8,
                            child: const Divider(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      )),
                  Positioned(
                      top: 200,
                      left: 20,
                      child: SizedBox(
                        width: size.width * .8,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              'สมัครบัญชี',
                              style: TextStyle(
                                color: Colors.black54,
                              ),
                            ),
                            Text(
                              'ลืมรหัสผ่าน?',
                              style: TextStyle(
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      )),
                  Positioned(
                    bottom: 10,
                    right: 110,
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
      )),
    );
  }
}
