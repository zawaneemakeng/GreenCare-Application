import 'package:flutter/material.dart';

class IntroPage2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/intro2.png',
              ),
              SizedBox(
                height: 100,
              ),
              Text(
                'ยินดีตอนรับ ชาวดเา่ดสเนพทดเาดเดเ้อกดเีกพเแอื',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
