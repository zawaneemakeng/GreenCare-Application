import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rotnaam/utils/api_url.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';

class AddPlants extends StatefulWidget {
  const AddPlants({super.key});

  @override
  State<AddPlants> createState() => _AddPlantsState();
}

class _AddPlantsState extends State<AddPlants> {
  TimeOfDay starttime = const TimeOfDay(hour: 19, minute: 30);
  TimeOfDay endtime = const TimeOfDay(hour: 1, minute: 30);
  var moiture = TextEditingController();
  DateTime selectedDate = DateTime.now();
  var plantname = TextEditingController();
  var detail = TextEditingController();

  bool status = false;
  String startdate = "";
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
                    Navigator.pop(context, 'refresh');
                  },
                ),
              ],
            ),
            const Text(
              "เพิ่มข้อมูลการปลูกผัก",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            addPlantForm()
          ],
        ),
      ),
    );
  }

  Widget addPlantForm() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding:
            const EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 20),
        child: Column(children: [
          Row(
            children: [
              Container(
                width: 285,
                child: TextField(
                  controller: plantname,
                  cursorColor: Colors.grey,
                  style: TextStyle(
                    color: Colors.black54,
                  ),
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.grass_outlined,
                      color: Colors.teal,
                    ),
                    hintText: 'ชื่อพืช',
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
                  style: const TextStyle(
                    color: Colors.black54,
                  ),
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.note, color: Colors.teal),
                    hintText: 'โน้ต',
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
                  SizedBox(
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
            height: 10.0,
          ),
          Row(
            children: [
              Container(
                width: 285,
                child: TextField(
                  controller: moiture,
                  cursorColor: Colors.grey,
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                    color: Colors.black54,
                  ),
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.mark_chat_unread_rounded,
                        size: 24, color: Colors.teal),
                    hintText: 'ความชื้นที่ต้องการ',
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
              onPressed: () async {
                TimeOfDay? newTime = await showTimePicker(
                    context: context, initialTime: starttime);
                if (newTime == null) return;
                setState(() {
                  starttime = newTime;
                });
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
                        Icons.timelapse_rounded,
                        size: 24.0,
                        color: Colors.teal,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 12.0,
                  ),
                  Text(
                    "เวลาเปิดไฟ ${starttime.hour}:${starttime.minute}",
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
            height: 10.0,
          ),
          SizedBox(
            height: 50.0,
            child: TextButton(
              onPressed: () async {
                TimeOfDay? newTime = await showTimePicker(
                    context: context, initialTime: endtime);
                if (newTime == null) return;
                setState(() {
                  endtime = newTime;
                });
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
                        Icons.timelapse_rounded,
                        size: 24.0,
                        color: Colors.teal,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 12.0,
                  ),
                  Text(
                    "เวลาปิดไฟ ${endtime.hour}:${endtime.minute}",
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
                setState(() {
                  startdate =
                      "${selectedDate.day} ${months[selectedDate.month - 1]} ${selectedDate.year + 543 - 2500}";
                });
                addNewPlant();
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  fixedSize: const Size(200, 20),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50))),
              child: const Text(
                'บันทึก',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ]),
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
      theme: ThemeData(
        primarySwatch: Colors.teal,
        fontFamily: 'PK',
      ),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future addNewPlant() async {
    var url = Uri.http(host(), 'add-newplant');
    Map<String, String> header = {"Content-type": "application/json"};
    String v1 = '"user":"$userID"';
    String v2 = '"plantname":"${plantname.text}"';
    String v3 = '"detail":"${detail.text}"';
    String v4 = '"startdate":"$startdate"';
    String jsondata = '{$v1,$v2,$v3,$v4}';
    var response = await http.post(url, headers: header, body: jsondata);
    print('--------result--------');
    print(response.body);
    final jsonResponse = json.decode(response.body);
    int plantid = jsonResponse['id'];

    setState(() {
      setSoilmoisture(plantid);
      setWaterlevel(plantid);
      // toDevicePlant(id);
      // setMoiture(moiture.text);
      // setStartTime("${starttime.hour}${starttime.minute}");
      // setEndTime("${endtime.hour}${endtime.minute}");
      Navigator.pop(context, 'refresh');
    });
  }

  Future setSoilmoisture(int pid) async {
    var url = Uri.http(host(), 'api/post-soilmoisture');
    Map<String, String> header = {"Content-type": "application/json"};
    String jsondata = '{"plant":"$pid"}';
    var response = await http.post(url, headers: header, body: jsondata);
    print(response.body);
  }

  Future setWaterlevel(int pid) async {
    var url = Uri.http(host(), 'api/post-waterlevel');
    Map<String, String> header = {"Content-type": "application/json"};
    String jsondata = '{"plant":"$pid"}';
    var response = await http.post(url, headers: header, body: jsondata);
    print(response.body);
  }

  Future toDevicePlant(int pid) async {
    var url = Uri.http(urlDevice(), '/plant-id:$pid');
    Map<String, String> header = {"Content-type": "application/json"};
    var response = await http.post(url, headers: header);
    print(response.body);
  }

  Future setMoiture(setmoiture) async {
    var url = Uri.http(urlDevice(), '/setmoiture:$setmoiture');
    Map<String, String> header = {"Content-type": "application/json"};
    var response = await http.post(url, headers: header);
    print(response.body);
  }

  Future setStartTime(starttime) async {
    var url = Uri.http(urlDevice(), '/starttime:$starttime');
    Map<String, String> header = {"Content-type": "application/json"};
    var response = await http.post(url, headers: header);
    print(response.body);
  }

  Future setEndTime(endtime) async {
    var url = Uri.http(urlDevice(), '/endtime:$endtime}');
    Map<String, String> header = {"Content-type": "application/json"};
    var response = await http.post(url, headers: header);
    print(response.body);
  }
}
