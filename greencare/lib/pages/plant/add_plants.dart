import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';

class AddPlants extends StatefulWidget {
  const AddPlants({super.key});

  @override
  State<AddPlants> createState() => _AddPlantsState();
}

class _AddPlantsState extends State<AddPlants> {
  DateTime selectedDate = DateTime.now();
  var plantstype = TextEditingController();
  var detail = TextEditingController();
  bool status = false;
  String fulldate = "";
  var userID;
  List<String> months = [
    "ม.ค.",
    "ก.พ.",
    "มี.ค.",
    "เม.ย.",
    "พ.ค.",
    "มิ.ย.",
    "ก.ค.",
    "ส.ค.",
    "ก.ย.",
    "ต.ค.",
    "พ.ย.",
    "ธ.ค."
  ];
  void getuser_id() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    userID = pref.getInt('user');
    print(userID);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getuser_id();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            Row(
              children: [
                IconButton(
                  icon: Image.asset('assets/back.png', height: 35, width: 35),
                  iconSize: 50,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            Text(
              "Add Transaction",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 32.0,
                fontWeight: FontWeight.w700,
              ),
            ),
            //
            SizedBox(
              height: 20.0,
            ),
            Row(
              children: [
                Container(
                  width: 285,
                  child: TextField(
                    controller: plantstype,
                    keyboardType: TextInputType.number,
                    cursorColor: Colors.grey,
                    style: TextStyle(
                      color: Colors.black54,
                    ),
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.money,
                        color: Color.fromARGB(255, 133, 133, 133),
                      ),
                      hintText: 'จำนวนเงิน',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Divider(
                height: 1,
                color: Colors.grey,
                thickness: 1,
              ),
            ),

            SizedBox(
              height: 10.0,
            ),
            Row(
              children: [
                Container(
                  width: 285,
                  child: TextField(
                    controller: detail,
                    cursorColor: Colors.grey,
                    style: TextStyle(
                      color: Colors.black54,
                    ),
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.note,
                        color: Color.fromARGB(255, 133, 133, 133),
                      ),
                      hintText: 'โน้ตค่าใช้จ่าย',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Divider(
                height: 1,
                color: Colors.grey,
                thickness: 1,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            SizedBox(
              height: 50.0,
              child: TextButton(
                onPressed: () {
                  _selectDate(context);

                  //
                  // to make sure that no keyboard is shown after selecting Date
                  FocusScope.of(context).unfocus();
                },
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                    EdgeInsets.zero,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12),
                        child: Icon(
                          Icons.date_range,
                          size: 24.0,
                          // color: Colors.grey[700],
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12.0,
                    ),
                    Text(
                      "วันที่ปลูก",
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Divider(
                height: 1,
                color: Colors.grey,
                thickness: 1,
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Checkbox(
              value: status,
              onChanged: (value) {
                setState(() {
                  status = true;
                  print(status);
                });
              },
            ),

            Padding(
              padding: const EdgeInsets.only(left: 80.0, right: 80.0),
              child: ElevatedButton(
                onPressed: () {
                  postTodo();
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff3AAA94),
                    fixedSize: const Size(130, 20),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50))),
                child: const Text(
                  'Submit',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showRoundedDatePicker(
      context: context,
      locale: Locale("th", "TH"),
      era: EraMode.BUDDHIST_YEAR,
      initialDate: selectedDate,
      firstDate: DateTime(2017, 1),
      lastDate: DateTime(2037),
      borderRadius: 15,
      theme: ThemeData(primaryColor: const Color(0xff3AAA94), fontFamily: 'PK'),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future postTodo() async {
    // var url = Uri.https('abcd.ngrok.io', '/api/post-todolist');
    var url = Uri.http('8000:8000', 'add/newplants');
    Map<String, String> header = {"Content-type": "application/json"};
    String t2 = "ผักชี";
    String t3 = "บลาๆ";
    String t4 = "5 มี.ค. 66";
    bool t5 = true;

    String v1 = '"user":"${6}"';
    String v2 = '"plantstype":"${t2}"';
    String v3 = '"detail":"${t3}"';
    String v4 = '"date":"${t4}"';
    String v5 = '"status":"${t5}"';
    String jsondata = '{$v1,$v2,$v3,$v4,$v5}';
    var response = await http.post(url, headers: header, body: jsondata);
    print('--------result--------');
    print(response.body);
    Navigator.pop(context, 'refresh');
  }
}
