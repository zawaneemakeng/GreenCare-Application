import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:rotnaam/utils/api_url.dart';
import 'package:rotnaam/utils/custom.dart';
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
  void getuserID() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    userID = pref.getInt('user');
    print(userID);
  }

  @override
  void initState() {
    super.initState();
    getuserID();
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
          const Padding(
            padding: EdgeInsets.only(top: 10, bottom: 25),
            child: Text(
              "เพิ่มข้อมูลการปลูกพืช",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Row(
            children: [
              Container(
                width: 285,
                child: TextField(
                  controller: plantname,
                  cursorColor: Colors.grey,
                  style: const TextStyle(
                    color: Colors.black54,
                  ),
                  decoration: const InputDecoration(
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
          const SizedBox(
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
            height: 10.0,
          ),
          Row(
            children: [
              Container(
                width: 270,
                child: TextField(
                  controller: moiture,
                  cursorColor: Colors.grey,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(
                    color: Colors.black54,
                  ),
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.water_drop_rounded,
                        size: 24, color: Colors.teal),
                    hintText: 'ความชื้นที่ต้องการ',
                    border: InputBorder.none,
                  ),
                ),
              ),
              showDialogPhoto()
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
                if (plantname.text == '' ||
                    detail.text == '' ||
                    moiture.text == '' ||
                    starttime == '' ||
                    endtime == '') {
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
                  addNewPlant();
                }
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  fixedSize: const Size(200, 30),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50))),
              child: const Text(
                'เพิ่มรายการ',
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
      locale: const Locale("th", "TH"),
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
    String v5 = '"setmoisture":"${double.parse(moiture.text)}"';
    String v6 = '"setstarttime":"${starttime.hour}:${starttime.minute}"';
    String v7 = '"setendtime":"${endtime.hour}:${endtime.minute}"';
    String jsondata = '{$v1,$v2,$v3,$v4,$v5,$v6,$v7}';
    var response = await http.post(url, headers: header, body: jsondata);
    print('--------result--------');
    print(response.body);
    final jsonResponse = json.decode(response.body);
    int plantid = jsonResponse['id'];

    setState(() {
      setSoilmoisture(plantid);
      setWaterlevel(plantid);
      setPlant(plantid);
      setMoiture(double.parse(moiture.text));
      setStartTime("${starttime.hour}:${starttime.minute}");
      setEndTime("${endtime.hour}:${endtime.minute}");
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

  Future setPlant(int pid) async {
    var url = Uri.http(urlDevice(), '/plant-id:$pid');
    Map<String, String> header = {"Content-type": "application/json"};
    var response = await http.post(url, headers: header);
    print(response.body);
  }

  Future setMoiture(double setmoiture) async {
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
    var url = Uri.http(urlDevice(), '/endtime:$endtime');
    Map<String, String> header = {"Content-type": "application/json"};
    var response = await http.post(url, headers: header);
    print(response.body);
  }

  Widget showDialogPhoto() {
    return IconButton(
      onPressed: () => showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16.0))),
          surfaceTintColor: const Color(0xff3AAA94),
          backgroundColor: Colors.white,
          content: Container(
            height: 120,
            child: Padding(
              padding: const EdgeInsets.only(top: 15, left: 10, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 15),
                  Text(
                    "    ดินแห้ง   : 0-40   %RH ",
                    style: TextStyle(color: Colors.grey[800], fontSize: 15),
                  ),
                  Text(
                    "    ดินเปียก : 45-70  %RH ",
                    style: TextStyle(color: Colors.grey[800], fontSize: 15),
                  ),
                  Text(
                    "    ดินเเฉะ   : 75-100 %RH ",
                    style: TextStyle(color: Colors.grey[800], fontSize: 15),
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('ปิด', style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
      icon: const Icon(
        Icons.info_outline,
        size: 26,
        color: Colors.grey,
      ),
    );
  }
}
