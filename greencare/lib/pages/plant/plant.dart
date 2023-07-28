import 'dart:async';

import 'package:flutter/material.dart';
import 'package:greencare/pages/plant/add_plants.dart';
import 'package:greencare/pages/plant/show_my_plant.dart';
import 'package:greencare/pages/plant/update_plant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:greencare/utils/api_url.dart';
import 'package:percent_indicator/percent_indicator.dart';

class PlantPage extends StatefulWidget {
  const PlantPage({super.key});

  @override
  State<PlantPage> createState() => _PlantPageState();
}

class _PlantPageState extends State<PlantPage> {
  List plantsItems = [];
  int? userID;
  bool isButtonEnabled = false;
  double water_level = 0.0;
  List waterlevelList = [];
  List imageList = [];
  List soilList = [];
  bool light = false;
  bool watering = false;
  String? status;
  Timer? timer;
  Future refresh() async {
    timer = Timer.periodic(
        Duration(seconds: 10),
        (Timer t) => setState(() {
              getWaterlevel();
            }));
  }

  @override
  void initState() {
    super.initState();
    getWaterlevel();
    getSoil();
    check();
    timer = Timer.periodic(
        Duration(seconds: 10),
        (Timer t) => setState(() {
              getWaterlevel();
            }));
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
                  if (plantsItems.isEmpty ||
                      plantsItems[reversedIndex]['status'] == true) {
                    String refresh = await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddPlants()),
                    );
                    if (refresh == 'refresh') {
                      check();
                    }
                  } else {
                    final snackBar = SnackBar(
                      content: const Text(
                          'ไม่สามารถเพิ่มได้ กรุณาเปลี่ยนสถานะเก็บเกี่ยว!'),
                      action: SnackBarAction(
                        label: 'รับทราบ',
                        onPressed: () {
                          // Some code to undo the change.
                        },
                      ),
                    );

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
              child: Text('ฟาร์มของคุณ',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
            ),
            CurrentWeatherDetailWidget(),
            Plants(),
          ],
        ),
      ),
    );
  }

  Widget noPlant() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 15,
        ),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: Colors.grey[300], borderRadius: BorderRadius.circular(8.0)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.qr_code,
                  color: Colors.green,
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "กรุณาเพิ่มข้อมูลการปลูกผัก",
                      style: TextStyle(color: Colors.grey[600], fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget Plants() {
    return Expanded(
      child: ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: plantsItems.length.clamp(0, 6),
          shrinkWrap: false,
          itemBuilder: (context, int index) {
            final reversedIndex = plantsItems.length - 1 - index;
            plantsItems.isNotEmpty
                ? Container(
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
                                Text(
                                    "${plantsItems[reversedIndex]['plantstype']}"),
                                Text(
                                  "${plantsItems[reversedIndex]['detail']}",
                                  style: TextStyle(
                                      color: Colors.grey[600], fontSize: 12),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Text("+ ${plantsItems[reversedIndex]['detail']}",
                            style: TextStyle(fontSize: 14)),
                      ],
                    ),
                  )
                : Container(
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
                                Text("กรุณาเพิ่มข้อมูลการปลูกผัก"),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
          }),
    );
  }

  Widget CurrentWeatherDetailWidget() {
    return Column(
      children: [
        SizedBox(height: 20),
        Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Container(
            height: 65,
            width: 65,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Color(0xffE6E6E6),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Image.asset('assets/icons/humid.png'),
          ),
          Container(
            height: 65,
            width: 65,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
                color: Color(0xffE6E6E6),
                borderRadius: BorderRadius.circular(15)),
            child: Image.asset('assets/leaf.png'),
          ),
          Container(
            height: 65,
            width: 65,
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: Color(0xffE6E6E6),
                borderRadius: BorderRadius.circular(15)),
            child: CircularPercentIndicator(
              percent: water_level / 100,
              radius: 20,
              lineWidth: 7,
              animation: true,
              progressColor: Colors.blueAccent,
              backgroundColor: Colors.white,
            ),
          ),
        ]),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: 20,
              width: 70,
              child: Text(
                'ความชื้นในดิน',
                style: TextStyle(fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 20,
              width: 70,
              child: Text(
                'ความชื้นในดิน',
                style: TextStyle(fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 20,
              width: 70,
              child: Text(
                'น้ำคงเหลือ',
                style: TextStyle(fontSize: 12),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: 20,
              width: 60,
              child: ListView.builder(
                itemCount: soilList.length.clamp(0, 1),
                itemBuilder: (context, int index) {
                  final reversedIndex = soilList.length - 1 - index;
                  return Text(
                    "${soilList[reversedIndex]['soilmoisture']}%",
                    style: TextStyle(fontSize: 12),
                    textAlign: TextAlign.center,
                  );
                },
              ),
            ),
            SizedBox(
              height: 20,
              width: 60,
              child: Text(
                "weatherDataCurrent.current.windSpeed",
                style: TextStyle(fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 20,
              width: 60,
              child: ListView.builder(
                itemCount: waterlevelList.length.clamp(0, 1),
                itemBuilder: (context, int index) {
                  final reversedIndex = waterlevelList.length - 1 - index;
                  return Text(
                    "${waterlevelList[reversedIndex]['waterl_remaining']}%",
                    style: TextStyle(fontSize: 12),
                    textAlign: TextAlign.center,
                  );
                },
              ),
            )
          ],
        )
      ],
    );
  }

  Future getSoil() async {
    var url = Uri.http(urlH(), '/api/get-soilmoisture/');
    var response = await http.get(url);
    // var result = json.decode(response.body);
    var result = utf8.decode(response.bodyBytes);
    setState(() {
      soilList = json.decode(result);
      print(soilList);
    });
  }

  Future getWaterlevel() async {
    var url = Uri.http(urlH(), '/api/get-waterlevel/');
    var response = await http.get(url);
    // var result = json.decode(response.body);
    var result = utf8.decode(response.bodyBytes);
    setState(() {
      waterlevelList = json.decode(result);
      final reversedIndex = waterlevelList.length - 1;
      double a =
          double.parse(waterlevelList[reversedIndex]['waterl_remaining']);
      water_level = a;
      print(" WATERLEVEL : ${water_level}");
    });
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
    var url = Uri.http(urlH(), '/api/plants/$userID');
    var response = await http.get(url);
    // var result = json.decode(response.body);
    var result = utf8.decode(response.bodyBytes);
    setState(() {
      plantsItems = json.decode(result);
      print(plantsItems);
      print(plantsItems.length);
      // final reversedIndex = plantsItems.length - 1;
      // if (plantsItems[reversedIndex]['stutus'] == false) {}
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
