import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:rotnaam/utils/api_url.dart';
import 'package:rotnaam/utils/custom.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'dart:async';

class AddTransection extends StatefulWidget {
  const AddTransection({super.key});

  @override
  State<AddTransection> createState() => _AddTransectionState();
}

class _AddTransectionState extends State<AddTransection> {
  DateTime selectedDate = DateTime.now();
  var amount = TextEditingController();
  var note = TextEditingController();
  String type = "Income";
  var userID;
  String fulldate = "";
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

  @override
  void initState() {
    super.initState();
    check();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: ListView(
          children: [
            Row(
              children: [
                IconButton(
                  icon: Image.asset('assets/back.png', height: 35, width: 35),
                  iconSize: 50,
                  onPressed: () {
                    Navigator.pop(context, 'refresh');
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 20.0,
            ),
            addFormTransaction()
          ],
        ),
      ),
    );
  }

  Widget addFormTransaction() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(children: [
          const Padding(
            padding: EdgeInsets.only(top: 20, bottom: 25),
            child: Text(
              "เพิ่มรายการการเงิน",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          //
          Row(
            children: [
              Container(
                width: 285,
                child: TextField(
                  controller: amount,
                  keyboardType: TextInputType.number,
                  cursorColor: Colors.grey,
                  style: const TextStyle(
                    color: Colors.black54,
                  ),
                  decoration: const InputDecoration(
                    prefixIcon: Icon(
                      Icons.money,
                      color: Colors.teal,
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
          const SizedBox(
            height: 10.0,
          ),

          Row(
            children: [
              Container(
                child: const Padding(
                  padding: EdgeInsets.only(left: 12),
                  child: Icon(
                    Icons.moving_sharp,
                    size: 24.0,
                    color: Colors.teal,
                  ),
                ),
              ),
              const SizedBox(
                width: 12.0,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: ChoiceChip(
                  avatar: CircleAvatar(
                    backgroundColor: Colors.grey[500],
                    backgroundImage: null,
                  ),
                  label: Text(
                    "รายรับ",
                    style: TextStyle(
                      fontSize: 14.0,
                      color: type == "Income" ? Colors.white : Colors.black,
                    ),
                  ),
                  selectedColor: Colors.teal,
                  backgroundColor: Colors.grey[300],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  onSelected: (val) {
                    if (val) {
                      setState(() {
                        type = "Income";
                      });
                    }
                  },
                  selected: type == "Income" ? true : false,
                ),
              ),
              const SizedBox(
                width: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: ChoiceChip(
                  avatar: CircleAvatar(
                    backgroundColor: Colors.grey[500],
                    backgroundImage: null,
                  ),
                  label: Text(
                    "รายจ่าย",
                    style: TextStyle(
                      fontSize: 14.0,
                      color: type == "Income" ? Colors.white : Colors.black,
                    ),
                  ),
                  selectedColor: Colors.teal,
                  backgroundColor: Colors.grey[300],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  onSelected: (val) {
                    if (val) {
                      setState(() {
                        type = "Expense";
                      });
                    }
                  },
                  selected: type == "Expense" ? true : false,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
            ],
          ),
          //
          const Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Divider(
              height: 1,
              color: Colors.grey,
              thickness: 1,
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Row(
            children: [
              Container(
                width: 285,
                child: TextField(
                  controller: note,
                  cursorColor: Colors.grey,
                  style: const TextStyle(
                    color: Colors.black54,
                  ),
                  decoration: const InputDecoration(
                    prefixIcon: Icon(
                      Icons.note,
                      color: Colors.teal,
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
          const SizedBox(
            height: 10.0,
          ),
          SizedBox(
            height: 50.0,
            child: TextButton(
              onPressed: () {
                _selectDate(context);

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
                    child: const Padding(
                      padding: EdgeInsets.only(left: 12),
                      child: Icon(
                        Icons.date_range,
                        size: 24.0,
                        color: Colors.teal,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 12.0,
                  ),
                  Text(
                    "${selectedDate.day} ${months[selectedDate.month - 1]} ${selectedDate.year + 543 - 2500}",
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
          const SizedBox(
            height: 30.0,
          ),
          Padding(
              padding: const EdgeInsets.only(left: 80.0, right: 80.0),
              child: ElevatedButton(
                onPressed: () {
                  if (note.text == "") {
                    note.text = type;
                  }
                  setState(() {
                    fulldate =
                        "${selectedDate.day} ${months[selectedDate.month - 1]} ${selectedDate.year + 543 - 2500}";
                  });
                  if (amount.text == '' || note.text == '') {
                    final snackBar = SnackBar(
                      backgroundColor: SnackBarColor.bgcolor,
                      content: const Text('กรุณากรอกข้อมูลให้ครบถ้วน'),
                      action: SnackBarAction(
                        label: 'รับทราบ',
                        onPressed: () {},
                      ),
                    );

                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  } else {
                    addTransaction(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    fixedSize: const Size(200, 20),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50))),
                child: const Text(
                  'เพิ่มรายการ',
                  style: TextStyle(color: Colors.white),
                ),
              ))
        ]),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showRoundedDatePicker(
      context: context,
      locale: const Locale("th", "TH"),
      era: EraMode.BUDDHIST_YEAR,
      initialDate: selectedDate,
      firstDate: DateTime(2017, 1),
      lastDate: DateTime(2037),
      borderRadius: 15,
      theme: ThemeData(primarySwatch: Colors.teal, fontFamily: 'PK'),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future addTransaction(BuildContext context) async {
    var url = Uri.http(host(), addtransaction());
    Map<String, String> header = {"Content-type": "application/json"};
    String v1 = '"user":"$userID"';
    String v2 = '"amount":"${amount.text}"';
    String v3 = '"detail":"${note.text}"';
    String v4 = '"transtype":"$type"';
    String v5 = '"date":"$fulldate"';
    String jsondata = '{$v1,$v2,$v3,$v4,$v5}';
    var response = await http.post(url, headers: header, body: jsondata);
    print('--------result--------');
    print(response.body);
    Navigator.pop(context, 'refresh');
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
    });
  }
}
