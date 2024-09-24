import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:rotnaam/controller/global_controller.dart';
import 'package:rotnaam/pages/plant_manage/control_plant.dart';
import 'package:rotnaam/pages/plant_manage/current_devices.dart';
import 'package:rotnaam/pages/widgets/current_weather_widget.dart';
import 'package:rotnaam/pages/widgets/header_widgets.dart';
import 'package:rotnaam/pages/widgets/hourly_weather_widget.dart';
import 'package:rotnaam/pages/widgets/noplant.dart';
import 'package:rotnaam/pages/money_manage/summary_transection.dart';
import 'package:rotnaam/utils/api_url.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeMain extends StatefulWidget {
  const HomeMain({super.key});

  @override
  State<HomeMain> createState() => _HomeMainState();
}

class _HomeMainState extends State<HomeMain> {
  List plantsItems = [];
  int? userID;
  int? plantID;
  final GlobalController globalController =
      Get.put(GlobalController(), permanent: true);
  @override
  void initState() {
    super.initState();
    check();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(
          () => globalController.checkLoading().isTrue
              ? Center(
                  child: Lottie.asset(
                      'assets/animations/animation_lkuv6jxa.json',
                      width: 120,
                      height: 120),
                )
              : Center(
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      const HeaderWidget(),
                      CurrentWeatherWidget(
                        weatherDataCurrent:
                            globalController.getData().getCurrentWeather(),
                      ),
                      HourlyDataWidget(
                          weatherDataHourly:
                              globalController.getData().getHourlyWeather()),
                      const Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Center(
                          child: Text(
                            "ฟาร์มของคุณ",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      plantsItems.isNotEmpty
                          ? Column(
                              children: [
                                CurrentDevices(
                                  pid: plantID,
                                ),
                                DevicesPlant(
                                  pid: plantID,
                                )
                              ],
                            )
                          : noPlant(),
                      const BarCharSample()
                    ],
                  ),
                ),
        ),
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
      getPlants();
    });
  }

  Future getPlants() async {
    var url = Uri.http(host(), 'get-plants/$userID');
    var response = await http.get(url);
    // var result = json.decode(response.body);
    var result = utf8.decode(response.bodyBytes);
    setState(() {
      plantsItems = json.decode(result);
      final reversedIndex = plantsItems.length - 1;
      plantID = plantsItems[reversedIndex]['id'];
    });
  }
}
