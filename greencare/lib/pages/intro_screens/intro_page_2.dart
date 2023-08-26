import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

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
              Lottie.asset('assets/animations/animation_lkuujn1a.json'),
              SizedBox(
                height: 10,
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
