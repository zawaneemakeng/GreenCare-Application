import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class IntroPage3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset('assets/animations/animation_lkuuqzk9.json'),
              SizedBox(
                height: 10,
              ),
              Text('Page3 someting')
            ],
          ),
        ),
      ),
    );
  }
}
