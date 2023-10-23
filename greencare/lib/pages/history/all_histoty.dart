import 'package:flutter/material.dart';
import 'package:rotnaam/pages/history/plant_history.dart';
import 'package:rotnaam/pages/history/qa_histoty.dart';
import 'package:rotnaam/pages/history/transaction_history.dart';
import 'package:rotnaam/pages/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AllHistory extends StatefulWidget {
  const AllHistory({super.key});

  @override
  State<AllHistory> createState() => _AllHistoryState();
}

class _AllHistoryState extends State<AllHistory> {
  int? userID;
  List history = ['ประวัติการปลูก', 'ประวัติการเงิน', 'ประวัติการโพสต์'];
  String? profileImg;

  @override
  void initState() {
    super.initState();
    check();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15, top: 30),
                child: IconButton(
                  icon: Image.asset('assets/back.png', height: 35, width: 35),
                  iconSize: 50,
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const HomePage()));
                  },
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => PlantHistory(
                          userid: userID,
                        )),
              );
            },
            child: historyTail("${history[0]}", Icons.grass_outlined,
                Icons.arrow_forward_ios_sharp),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => TransactionHistory(
                          userid: userID,
                        )),
              );
            },
            child: historyTail("${history[1]}", Icons.money_outlined,
                Icons.arrow_forward_ios_sharp),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => QAHistory(
                          userid: userID,
                        )),
              );
            },
            child: historyTail("${history[2]}", Icons.question_answer_outlined,
                Icons.arrow_forward_ios_sharp),
          )
        ],
      ),
    );
  }

  Widget historyTail(title, icon1, icon2) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
      child: Container(
        height: 90,
        decoration: BoxDecoration(
            color: Colors.grey[300], borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    icon1,
                    color: Colors.teal,
                    size: 35,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    title,
                    style: const TextStyle(
                        fontWeight: FontWeight.w700, fontSize: 16),
                  ),
                ],
              ),
              Icon(
                icon2,
                color: Colors.teal,
                size: 25,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void check() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final checkvalue = pref.get('user') ?? 0;
    if (checkvalue != 0) {
      getUsernameProfile();
    }
  }

  void getUsernameProfile() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      var username = pref.getInt('user');
      userID = username;
      var profile = pref.getString('profile_img');
      profileImg = profile;
      print(profileImg);
      ;
    });
  }
}
