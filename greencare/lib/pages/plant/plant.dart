import 'package:flutter/material.dart';
import 'package:greencare/pages/plant/add_plants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class PlantPage extends StatefulWidget {
  const PlantPage({super.key});

  @override
  State<PlantPage> createState() => _PlantPageState();
}

class _PlantPageState extends State<PlantPage> {
  List plantsItems = [];
  int? userID;
  bool isButtonEnabled = true;
  @override
  void initState() {
    super.initState();
    check();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: SizedBox(
            height: 45,
            width: 45,
            child: FittedBox(
              child: FloatingActionButton(
                onPressed: () async {
                  final reversedIndex = plantsItems.length - 1;
                  if (plantsItems[reversedIndex]['status'] == true) {
                    String refresh = await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddPlants()),
                    );
                    if (refresh == 'refresh') {
                      check();
                    }
                  } else {
                    final snackBar = SnackBar(
                      content: const Text('Yay! A SnackBar!'),
                      action: SnackBarAction(
                        label: 'Undo',
                        onPressed: () {
                          // Some code to undo the change.
                        },
                      ),
                    );

                    // Find the ScaffoldMessenger in the widget tree
                    // and use it to show a SnackBar.
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
                backgroundColor: Color(0xff3AAA94),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0)),
                child: Icon(
                  Icons.add,
                  size: 30.0,
                  color: Colors.white,
                ),
              ),
            )),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
              child: Text('ค่าใช้จ่ายล่าสุด',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
            ),
            Plants(),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }

  Widget Plants() {
    return Expanded(
      child: ListView.builder(
        itemCount: plantsItems.length.clamp(0, 6),
        shrinkWrap: false,
        itemBuilder: (context, int index) {
          final reversedIndex = plantsItems.length - 1 - index;
          return Container(
            margin: EdgeInsets.only(
              left: 20,
              right: 20,
              top: 15,
            ),
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(8.0)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.arrow_circle_down_outlined,
                      color: Colors.green,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${plantsItems[reversedIndex]['plantstype']}"),
                        Text(
                          "${plantsItems[reversedIndex]['detail']}",
                          style:
                              TextStyle(color: Colors.grey[600], fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
                Text("+ ${plantsItems[reversedIndex]['detail']}",
                    style: TextStyle(fontSize: 14)),
              ],
            ),
          );
        },
      ),
    );
  }

  void check() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final checkvalue = pref.get('user') ?? 0;
    if (checkvalue != 0) {
      getUsername();
    }
  }

  void getUsername() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      var username = pref.getInt('user');
      userID = username;
      print(userID);
      getPlants();
    });
  }

  Future getPlants() async {
    var url = Uri.http('00000:8000', '/api/plants/$userID');
    var response = await http.get(url);
    // var result = json.decode(response.body);
    var result = utf8.decode(response.bodyBytes);
    setState(() {
      plantsItems = json.decode(result);
      final reversedIndex = plantsItems.length - 1;
      if (plantsItems[reversedIndex]['stutus'] == false) {}
      // for (int i = 0; i < incomeItem.length; i++) {
      //   if (incomeItem[i]['transtype'] == 'Income') {
      //     totalIncome += double.parse(incomeItem[i]['amount']);
      //   } else if (incomeItem[i]['transtype'] == 'Expense') {
      //     totalExpense += double.parse(incomeItem[i]['amount']);
      //   }
      // }
      // print(totalIncome);
      // print(totalExpense);
      // totalBalance = totalIncome - totalExpense;
      // print(totalBalance);
    });
  }
}
