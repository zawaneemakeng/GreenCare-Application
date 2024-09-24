import 'package:flutter/material.dart';
import 'package:rotnaam/controller/global_controller.dart';
import 'package:rotnaam/pages/history/all_histoty.dart';
import 'package:rotnaam/pages/question_answer/post.dart';
import 'package:rotnaam/pages/home.dart';
import 'package:rotnaam/pages/money_manage/transection.dart';
import 'package:rotnaam/pages/plant_manage/plant.dart';
import 'package:rotnaam/pages/user_manage/login.dart';
import 'package:rotnaam/pages/widgets/article.dart';
import 'package:rotnaam/pages/widgets/profile.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String firstname = '';
  int? userId;
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    HomeMain(),
    PlantPage(),
    AllTransection(),
    CommunityPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final GlobalController globalController =
      Get.put(GlobalController(), permanent: true);
  @override
  void initState() {
    super.initState();
    check(); //ตรวจสอบว่ามีชื่อหรือไป ถ้ามีสวัสดี
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color(0xFFefefef),
          scrolledUnderElevation: 0,
          toolbarHeight: 40,
          centerTitle: true,
          elevation: 0,
          title: const Text(
            'ROTNAAM',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          )),
      drawer: buildDrawer(),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: SalomonBottomBar(
        backgroundColor: Colors.grey[100],
        items: [
          /// Home
          SalomonBottomBarItem(
            icon: const Icon(Icons.home),
            title: const Text("Home"),
          ),

          /// Search
          SalomonBottomBarItem(
            icon: const Icon(Icons.grass_outlined),
            title: const Text("Plant"),
          ),

          /// Profile
          SalomonBottomBarItem(
            icon: const Icon(Icons.money),
            title: const Text("Money"),
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.question_answer_rounded),
            title: const Text("Q A"),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.teal,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget buildDrawer() {
    return Drawer(
      width: 250,
      backgroundColor: const Color(0xFFEFEFEF),
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              firstname,
              style: const TextStyle(fontSize: 20.0),
            ),
            accountEmail: null,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.teal,
                  Color.fromARGB(255, 147, 206, 190),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ListTile(
            leading: const Icon(
              Icons.person,
              color: Colors.teal,
            ),
            title: GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              ProfilePage(userID: userId!)));
                },
                child: const Text('โปรไฟล์')),
            onTap: () {
              //logout(context);
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.article,
              color: Colors.teal,
            ),
            title: GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => const Article()));
                },
                child: const Text('บทความ')),
            onTap: () {
              //logout(context);
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.history,
              color: Colors.teal,
            ),
            title: GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => const AllHistory()),
                  );
                },
                child: const Text('ประวัติ')),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(
              Icons.contact_mail,
              color: Colors.teal,
            ),
            title: const Text('ติดต่อเรา'),
            onTap: () async {
              String? encodeQueryParameters(Map<String, String> params) {
                return params.entries
                    .map((MapEntry<String, String> e) =>
                        '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                    .join('&');
              }

              final Uri email = Uri(
                scheme: 'mailto',
                path: 'rotnaamcontact@gmail.com',
                query: encodeQueryParameters(<String, String>{
                  'Rotnaam app สวัสดีค่ะ/ครับ':
                      'สามารถเขียนปัญหาเเละข้อสงสัยเเละส่งได้ทีอีเมล์ข้างต้นได้เลยค่ะ/ครับ',
                }),
              );
              if (await canLaunchUrl(email)) {
                launchUrl(email);
              } else {
                throw Exception('ไม่สามารถส่ง');
              }
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.logout,
              color: Colors.teal,
            ),
            title: const Text('ออกจากระบบ'),
            onTap: () {
              logout(context);
            },
          ),
        ],
      ),
    );
  }

  void getUsername() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      var fname = pref.getString('first_name');
      firstname = 'สวัสดีคุณ $fname';
      var userid = pref.getInt('user');
      userId = userid;
    });
  }

  void check() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final checkvalue = pref.get('first_name') ?? 0;
    if (checkvalue != 0) {
      getUsername();
    }
  }

  void logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    prefs.remove('first_name');
    prefs.remove('user');
    prefs.remove('profile_img');
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => LoginPage())); //ออกไปโดยไม่ลูกศรย้อนกลับ
  }
}
