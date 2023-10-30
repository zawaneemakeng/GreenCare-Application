import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:lottie/lottie.dart';
import 'package:rotnaam/utils/api_url.dart';

class DevicesPlant extends StatefulWidget {
  final pid;
  const DevicesPlant({super.key, required this.pid});

  @override
  State<DevicesPlant> createState() => _DevicesPlantState();
}

class _DevicesPlantState extends State<DevicesPlant> {
  Map<String, dynamic> ledplantItem = {};
  Map<String, dynamic> pumpplantItem = {};
  List waterlevelList = [];
  List soilList = [];
  bool lightstatus = false;
  bool pumpstatus = false;
  int? plantID;
  Timer? timer;

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
  void _startTimer() {
    const duration = Duration(seconds: 20);
    timer = Timer.periodic(duration, (timer) {
      setState(() {
        getLEDStatus();
        getPumpStatus();
      });
    });
  }

  @override
  void initState() {
    super.initState();
    plantID = widget.pid;
    getLEDStatus();
    getPumpStatus();
    // _startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ledplantItem.isNotEmpty || pumpplantItem.isNotEmpty
            ? DevicesControl()
            : Center(
                child: Lottie.asset('assets/animations/animation_lkuv6jxa.json',
                    width: 120, height: 120),
              ),
      ],
    );
  }

  Widget DevicesControl() {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            height: 130,
            width: 130,
            padding: const EdgeInsets.only(top: 15),
            decoration: BoxDecoration(
              color: Color(0xffE6E6E6),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: [
                pumpstatus == true
                    ? Image.asset(
                        "assets/droplet.png",
                        width: 30,
                        height: 30,
                      )
                    : Image.asset(
                        "assets/droplet_off.png",
                        width: 30,
                        height: 30,
                      ),
                const SizedBox(
                  height: 10,
                ),
                pumpstatus == true
                    ? const Text(
                        "ปั้มน้ำเปิด",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    : const Text("ปั้มน้ำปิด",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                Transform.scale(
                  scale: 0.7,
                  child: Switch(
                    value: pumpstatus,
                    activeColor: Colors.teal,
                    inactiveTrackColor: Colors.grey[300],
                    onChanged: (bool value) {
                      setState(() {
                        pumpstatus = value;
                        if (pumpstatus == true) {
                          openPUMP("PUMP=ON");
                          postwaterplantdb(pumpstatus);
                        } else {
                          openPUMP("PUMP=OFF");
                          postwaterplantdb(pumpstatus);
                        }
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 130,
            width: 130,
            padding: const EdgeInsets.only(top: 15),
            decoration: BoxDecoration(
                color: Color(0xffE6E6E6),
                borderRadius: BorderRadius.circular(15)),
            child: Column(
              children: [
                lightstatus == true
                    ? Image.asset(
                        "assets/power.png",
                        width: 35,
                        height: 35,
                      )
                    : Image.asset(
                        "assets/power_off.png",
                        width: 35,
                        height: 35,
                      ),
                SizedBox(
                  height: 6,
                ),
                lightstatus == true
                    ? Text("ไฟเปิด",
                        style: TextStyle(fontWeight: FontWeight.bold))
                    : Text("ไฟปิด",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                Transform.scale(
                  scale: 0.7,
                  child: Switch(
                    value: lightstatus,
                    activeColor: Color(0xff3AAA94),
                    inactiveTrackColor: Colors.grey[300],
                    onChanged: (bool value) {
                      setState(() {
                        lightstatus = value;
                        if (lightstatus == true) {
                          openLED("LED=ON");
                          postledplantdb(lightstatus);
                        } else {
                          openLED("LED=OFF");
                          postledplantdb(lightstatus);
                        }
                      });
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Future getLEDStatus() async {
    var url = Uri.http(host(), 'api/get-ledplant/$plantID/');
    var response = await http.get(url);
    var result = utf8.decode(response.bodyBytes);
    setState(() {
      ledplantItem = json.decode(result);
      lightstatus = ledplantItem['status'];
    });
  }

  Future getPumpStatus() async {
    var url = Uri.http(host(), 'api/get-wateringplant/$plantID/');
    var response = await http.get(url);
    var result = utf8.decode(response.bodyBytes);
    setState(() {
      pumpplantItem = json.decode(result);
      pumpstatus = pumpplantItem['status'];
    });
  }

  Future openLED(String status) async {
    var url = Uri.http(urlDevice(), '$status');
    print(url);
    var response = await http.post(url);
    print(response.body);
  }

  Future openPUMP(String s) async {
    var url = Uri.http(urlDevice(), '$s');
    // ignore: avoid_print
    print(url);
    var response = await http.post(url);
    print(response.body);
  }

  String formattedDateTime() {
    DateTime now = DateTime.now();
    return now.day.toString() +
        " " +
        months[now.month - 1] +
        " " +
        (now.year + 543).toString() +
        " " +
        now.hour.toString() +
        ":" +
        now.minute.toString();
  }

  Future postwaterplantdb(bool w) async {
    var url = Uri.http(host(), waterplant());
    Map<String, String> header = {"Content-type": "application/json"};
    String v1 = '"plant":"$plantID"';
    String v2 = '"status":"$w"';

    String jsondata = '{$v1,$v2}';
    var response = await http.post(url, headers: header, body: jsondata);
    print('--------result--------');
    print(response.body);
  }

  Future postledplantdb(bool l) async {
    var url = Uri.http(host(), ledplant());
    Map<String, String> header = {"Content-type": "application/json"};
    String v1 = '"plant":"$plantID"';
    String v2 = '"status":"$l"';

    String jsondata = '{$v1,$v2}';
    var response = await http.post(url, headers: header, body: jsondata);
    print('--------result--------');
    print(response.body);
  }
}
