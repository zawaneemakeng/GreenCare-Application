import 'package:flutter/material.dart';

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
              // Image.asset('assets/smartfarm.png'),
              SizedBox(
                height: 100,
              ),
              Text('Page3 someting')
            ],
          ),
        ),
      ),
    );
  }
}
