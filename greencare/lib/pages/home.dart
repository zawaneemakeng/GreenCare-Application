import 'package:flutter/material.dart';
import 'package:greencare/main.dart';
import 'package:greencare/pages/home_main.dart';
import 'package:get/get.dart';
import 'package:greencare/controller/global_controller.dart';
import 'package:greencare/pages/login.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String username1 = '';
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    HomeMain(),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
    Text(
      'Index 3: School',
      style: optionStyle,
    ),
    Text(
      'Index 4: School',
      style: optionStyle,
    ),
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
    // TODO: implement initState
    super.initState();
    //getTodolist();

    check(); //ตรวจสอบว่ามีชื่อหรือไป ถ้ามีสวัสดี
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color(0xFFEFEFEF),
          toolbarHeight: 40,
          centerTitle: true,
          title: const Text(
            'All todolist',
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
            icon: Icon(Icons.home),
            title: Text("Home"),
          ),

          /// Search
          SalomonBottomBarItem(
            icon: Icon(Icons.search),
            title: Text("Search"),
          ),

          /// Profile
          SalomonBottomBarItem(
            icon: Icon(Icons.person),
            title: Text("Profile"),
          ),
          SalomonBottomBarItem(
            icon: Icon(Icons.chat_bubble),
            title: Text("Profile"),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xff3AAA94),
        onTap: _onItemTapped,
      ),
    );
  }

  Widget buildDrawer() {
    return Drawer(
      backgroundColor: const Color(0xFFEFEFEF),
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              username1,
              style: TextStyle(fontSize: 24.0),
            ),
            accountEmail: null,
            decoration: BoxDecoration(
              color: Color(0xff3AAA94),
            ),
          ),
          Container(
            color: Colors.blueAccent,
            child: Column(children: []),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('home'),
            onTap: () {
              // Navigator.push(context,
              // MaterialPageRoute(builder: (context) => const AboutPage()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.contact_mail),
            title: const Text('contact'),
            onTap: () {
              //launchUrl();
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: GestureDetector(
                onTap: () {
                  logout(context);
                },
                child: const Text('logout')),
            onTap: () {
              //logout(context);
            },
          ),
        ],
      ),
    );
  }

  void getUsername() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      var username = pref.getString('username');
      username1 = 'สวัสดีคุณ $username';
    });
  }

  void check() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final checkvalue = pref.get('username') ?? 0;
    if (checkvalue != 0) {
      getUsername();
    }
  }

  void logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => LoginPage())); //ออกไปโดยไม่ลูกศรย้อนกลับ
  }
}
