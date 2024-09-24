import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rotnaam/controller/flutter_local_notification.dart';
import 'dart:async';
import 'package:rotnaam/utils/api_url.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class CurrentDevices extends StatefulWidget {
  final pid;
  const CurrentDevices({super.key, required this.pid});

  @override
  State<CurrentDevices> createState() => _CurrentDevicesState();
}

class _CurrentDevicesState extends State<CurrentDevices> {
  Map<String, dynamic> waterlevelItem = {};
  Map<String, dynamic> soilItem = {};
  int? plantID;
  double? waterlevel;
  Timer? timer;

  void _startTimer() {
    const duration = Duration(seconds: 5);
    timer = Timer.periodic(duration, (timer) {
      setState(() {
        getWaterlevel();
        getSoil();
      });
    });
  }

  @override
  void initState() {
    plantID = widget.pid;
    super.initState();
    getWaterlevel();
    getSoil();
    setNoti();
    _startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: soilItem.isNotEmpty || waterlevelItem.isNotEmpty
          ? Column(children: [
              currentWidget(),
            ])
          : Center(
              child: Lottie.asset('assets/animations/animation_lkuv6jxa.json',
                  width: 120, height: 120),
            ),
    );
  }

  Widget currentWidget() {
    return Column(
      children: [
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                height: 135,
                width: 135,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: const Color(0xffE6E6E6),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 3,
                    ),
                    Image.asset(
                      'assets/icons/humid.png',
                      width: 40,
                      height: 40,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    soilItem.isNotEmpty
                        ? Text(
                            "${soilItem['soilmoisture']} %RH",
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          )
                        : const Text(
                            "0",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                    const SizedBox(
                      height: 6,
                    ),
                    const Text(
                      'ความชื้นในดิน',
                      style: TextStyle(fontSize: 10),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Container(
                height: 135,
                width: 135,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: const Color(0xffE6E6E6),
                    borderRadius: BorderRadius.circular(15)),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 3,
                    ),
                    CircularPercentIndicator(
                      percent: waterlevel! / 100,
                      radius: 22,
                      lineWidth: 7,
                      animation: true,
                      progressColor: Colors.blueAccent,
                      backgroundColor: Colors.white,
                      center: Text(
                        "${waterlevelItem['water_remaining']}%",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 10.0),
                      ),
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Text(
                      "${waterlevel! * 10} มล.",
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    const Text(
                      'น้ำคงเหลือในเเทงค์',
                      style: TextStyle(fontSize: 10),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }

  Future getSoil() async {
    var url = Uri.http(host(), "${getsoilmoisture()}/$plantID");
    var response = await http.get(url);
    var result = utf8.decode(response.bodyBytes);
    setState(() {
      soilItem = json.decode(result);
    });
  }

  Future getWaterlevel() async {
    var url = Uri.http(host(), "${getwaterlevel()}/$plantID");
    var response = await http.get(url);
    var result = utf8.decode(response.bodyBytes);
    setState(() {
      waterlevelItem = json.decode(result);
      waterlevel = double.parse(waterlevelItem['water_remaining']);
    });
  }

  void setNoti() {
    const duration = Duration(seconds: 30);
    timer = Timer.periodic(duration, (timer) {
      setState(() {
        if (waterlevel! < 20) {
          LocalNotification.showBigTextNotification(
              title: "กรุณาเติมน้ำ น้ำในเเท้งค์เหลือน้อย",
              body: "หากระดับน้ำคงเหลือ 5% ระบบจะเติมอัตโนมัติ",
              flutterLocalNotificationsPlugin: flutterLocalNotificationsPlugin);
        }
      });
    });
  }
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
