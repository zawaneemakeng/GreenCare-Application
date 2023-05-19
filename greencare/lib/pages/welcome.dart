import 'package:flutter/material.dart';
import 'package:greencare/pages/login.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [2.0, 1.0],
          tileMode: TileMode.clamp,
          colors: [
            Color(0xff1C6946),
            Color(0xff00DD73),
          ],
        )),
        child: Center(
          child: Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 20.0),
                      child: Text(
                        "มีบัญชีอยู่เเล้ว? ",
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xfff5F2EB),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                      child: const Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 20.0),
                          child: Text(
                            "  Login",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xfff5F2EB),
                            ),
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginPage()),
                        );
                      }),
                ],
              ),
              Positioned(
                bottom: 250,
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    Image.asset(
                      'assets/green3.png',
                      width: 130,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'GREEN CARE',
                      style: TextStyle(
                        fontSize: 29,
                        color: Color(0xfff5F2EB),
                      ),
                    ),
                    const SizedBox(
                      height: 70,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 25, right: 25),
                      child: Text(
                        'fdgkljdfklghjdfjkghrseiktudoglh;jgfklhjidfkgudfkolgjfkldiodfgjkdfgudfhk',
                        style: TextStyle(
                          fontSize: 20,
                          color: Color(0xfff5F2EB),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Positioned(
                bottom: 100,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (_) => const LoginPage()));
                    },
                    child: Container(
                      height: 50,
                      decoration: const BoxDecoration(
                        color: Color(0xfff5F2EB),
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                      child: const Center(
                        child: Text(
                          'Get Started',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
