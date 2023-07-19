import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greencare/controller/global_controller.dart';
import 'package:greencare/pages/summary_transection.dart';
import 'package:greencare/widgets/current_weather_widget.dart';
import 'package:greencare/widgets/header_widgets.dart';
import 'package:greencare/widgets/hourly_weather_widget.dart';
import 'package:greencare/widgets/money_widget.dart';
import 'package:greencare/widgets/myplant_widget.dart';

class HomeMain extends StatefulWidget {
  const HomeMain({super.key});

  @override
  State<HomeMain> createState() => _HomeMainState();
}

class _HomeMainState extends State<HomeMain> {
  final GlobalController globalController =
      Get.put(GlobalController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(
          () => globalController.checkLoading().isTrue
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Center(
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),

                      // const HeaderWidget(),
                      // // for our current temp ('current')
                      // CurrentWeatherWidget(
                      //   weatherDataCurrent:
                      //       globalController.getData().getCurrentWeather(),
                      // ),

                      // HourlyDataWidget(
                      //     weatherDataHourly:
                      //         globalController.getData().getHourlyWeather()),
                      // WaterLevel()
                      // MyPlantWidget(),
                      BarCharSample()
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
