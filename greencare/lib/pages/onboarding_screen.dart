import 'package:flutter/material.dart';
import 'package:greencare/pages/intro_screens/intro_page_1.dart';
import 'package:greencare/pages/intro_screens/intro_page_2.dart';
import 'package:greencare/pages/intro_screens/intro_page_3.dart';
import 'package:greencare/pages/login.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardScreen extends StatefulWidget {
  const OnBoardScreen({super.key});

  @override
  State<OnBoardScreen> createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreen> {
  //controller to keep track of
  PageController _controller = PageController();
  //keep
  bool onLastPage = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                onLastPage = (index == 2);
              });
            },
            children: [
              IntroPage1(),
              IntroPage2(),
              IntroPage3(),
            ],
          ),
          Container(
            alignment: const Alignment(0, 0.75),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //skip
                GestureDetector(
                  onTap: () {
                    _controller.jumpToPage(2);
                  },
                  child: Text('skip'),
                ),

                SmoothPageIndicator(
                  controller: _controller,
                  count: 3,
                  effect: ExpandingDotsEffect(
                    dotColor: const Color.fromARGB(255, 207, 206, 206),
                    activeDotColor: Colors.green,
                  ),
                ),
                // next or done
                onLastPage
                    ? GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()),
                          );
                        },
                        child: Text('done'),
                      )
                    : GestureDetector(
                        onTap: () {
                          _controller.nextPage(
                              duration: Duration(microseconds: 500),
                              curve: Curves.easeIn);
                        },
                        child: Text('Next'),
                      )
              ],
            ),
          )
        ],
      ),
    );
  }
}
