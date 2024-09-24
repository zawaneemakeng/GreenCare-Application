import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rotnaam/pages/user_manage/login.dart';
import 'package:rotnaam/utils/styles.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final int _numPages = 3;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.symmetric(horizontal: 5.0),
      height: 14.0,
      width: isActive ? 40.0 : 16.0,
      decoration: BoxDecoration(
        color: isActive ? Colors.teal : const Color(0xFFefefef),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0.3, 0.6, 0.9],
              colors: [
                Colors.teal,
                Color(0xFF4cb6b6),
                Color(0xFF99d5d5),
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()),
                      );
                    },
                    child: const Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Text(
                        'ข้าม',
                        style: TextStyle(
                          color: Color(0xFFefefef),
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 550.0,
                  child: PageView(
                    physics: const ClampingScrollPhysics(),
                    controller: _pageController,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(40.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Center(
                              child: Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.shade600.withAlpha(70),
                                      spreadRadius: 15,
                                      blurRadius: 15,
                                      offset: const Offset(20, 8),
                                    ),
                                  ],
                                  shape: BoxShape.circle,
                                ),
                                child: Image.asset(
                                  'assets/logo.png',
                                  height: 200.0,
                                  width: 200.0,
                                ),
                              ),
                            ),
                            const SizedBox(height: 90.0),
                            const Text(
                              'ROTNAAM',
                              style: kTitleStyle,
                            ),
                            const SizedBox(height: 15.0),
                            const Text(
                              'เพื่อนร่วมทางที่ตอบโจทย์\nเกษตรอัจฉริยะของคุณ.',
                              style: kSubtitleStyle,
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Center(
                            child: Image.asset(
                              'assets/monitering.png',
                              height: 300.0,
                              width: 300.0,
                            ),
                          ),
                          const Padding(
                            padding:
                                EdgeInsets.only(left: 30, right: 30, top: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'ROTNAAM',
                                  style: kTitleStyle,
                                ),
                                SizedBox(height: 15.0),
                                Text(
                                  'ตรวจสอบความชื้นในดิน\nแบบเรียลไทม์',
                                  style: kSubtitleStyle,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 25, right: 30, top: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Center(
                              child: Image.asset(
                                'assets/control.png',
                                height: 250.0,
                                width: 350.0,
                              ),
                            ),
                            const SizedBox(height: 35.0),
                            const Text(
                              'ROTNAAM',
                              style: kTitleStyle,
                            ),
                            const SizedBox(height: 15.0),
                            const Text(
                              'ควบคุมการเปิด-ปิดไฟ\nเเละปั้มน้ำด้วยมือของคุณ',
                              style: kSubtitleStyle,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildPageIndicator(),
                ),
                _currentPage != _numPages - 1
                    ? Expanded(
                        child: Align(
                          alignment: FractionalOffset.bottomRight,
                          child: TextButton(
                            onPressed: () {
                              _pageController.nextPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.ease,
                              );
                            },
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                  'ต่อไป',
                                  style: TextStyle(
                                    color: Color(0xFFefefef),
                                    fontSize: 20.0,
                                  ),
                                ),
                                SizedBox(width: 10.0),
                                Icon(
                                  Icons.arrow_forward,
                                  color: Color(0xFFefefef),
                                  size: 30.0,
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : const Text(''),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: _currentPage == _numPages - 1
          ? GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: const Color(0xFFefefef),
                ),
                height: 60.0,
                width: double.infinity,
                child: const Center(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      'เริ่มเลย !',
                      style: TextStyle(
                        color: Colors.teal,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            )
          : const Text(''),
    );
  }
}
