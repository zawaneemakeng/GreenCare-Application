import 'package:flutter/material.dart';
import 'package:greencare/pages/home_main.dart';
import 'package:get/get.dart';
import 'package:greencare/controller/global_controller.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
      'Index 2: School',
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.grey[100],
          toolbarHeight: 40,
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => const AboutPage()));
                },
                icon: const Icon(
                  Icons.chat,
                  color: Color.fromARGB(255, 12, 12, 12),
                ))
          ],
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
            selectedColor: Colors.purple,
          ),

          /// Search
          SalomonBottomBarItem(
            icon: Icon(Icons.search),
            title: Text("Search"),
            selectedColor: Colors.orange,
          ),

          /// Profile
          SalomonBottomBarItem(
            icon: Icon(Icons.person),
            title: Text("Profile"),
            selectedColor: Colors.teal,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }

  Widget buildDrawer() {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
              accountName: Text("fullname"), accountEmail: null),
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
            title: const Text('logout'),
            onTap: () {
              //logout(context);
            },
          ),
        ],
      ),
    );
  }
}
