import 'package:flutter/material.dart';

class IntroPage1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/leaf.png',
              width: 180,
              height: 180,
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              'GREENCARE',
              style: TextStyle(fontSize: 30),
            ),
            SizedBox(
              height: 80,
            ),
            Text(
              'ยินดีตอนรับ',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
