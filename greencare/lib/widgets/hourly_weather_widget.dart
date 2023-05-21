// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:greencare/controller/global_controller.dart';
import 'package:greencare/model/weather_data_hourly.dart';
import 'package:get/get.dart';
import 'package:greencare/utils/custom_color.dart';
import 'package:intl/intl.dart';

class HourlyDataWidget extends StatefulWidget {
  final WeatherDataHourly weatherDataHourly;
  HourlyDataWidget({Key? key, required this.weatherDataHourly})
      : super(key: key);

  @override
  State<HourlyDataWidget> createState() => _HourlyDataWidgetState();
}

class _HourlyDataWidgetState extends State<HourlyDataWidget> {
  //card index
  RxInt cardIndex = GlobalController().getIndex();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          alignment: Alignment.topCenter,
          child: Text(
            "วันนี้",
          ),
        ),
        hourlyList(),
      ],
    );
  }

  Widget hourlyList() {
    return Container(
      height: 150,
      padding: const EdgeInsets.only(bottom: 8, top: 8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal, //เเนวตั้ง
        itemCount: widget.weatherDataHourly.hourly.length + 1 > 12
            ? 12
            : widget.weatherDataHourly.hourly.length,
        itemBuilder: (context, index) {
          return Builder(builder: (context) {
            return Obx((() => GestureDetector(
                onTap: () {
                  cardIndex.value = index;
                },
                child: Container(
                  width: 80,
                  margin: const EdgeInsets.only(left: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                            offset: const Offset(0.5, 0),
                            blurRadius: 0,
                            spreadRadius: 0,
                            color: Color(0xff3AAA94).withAlpha(30))
                      ],
                      gradient: cardIndex.value == index
                          ? const LinearGradient(colors: [
                              Color.fromARGB(255, 77, 184, 162),
                              Color.fromARGB(255, 72, 190, 166),
                            ])
                          : null),
                  child: HourlyDetails(
                    index: index,
                    cardIndex: cardIndex.toInt(),
                    temp: widget.weatherDataHourly.hourly[index].temp!,
                    time: widget.weatherDataHourly.hourly[index].dt!,
                    weatherIcon: widget
                        .weatherDataHourly.hourly[index].weather![0].icon!,
                  ),
                ))));
          });
        },
      ),
    );
  }
}

class HourlyDetails extends StatelessWidget {
  double temp;
  int time;
  int index;
  int cardIndex;
  String weatherIcon;
  String getTime(final time) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(time * 1000);
    String x = DateFormat('HH:mm').format(dateTime);
    return x;
  }

  HourlyDetails(
      {Key? key,
      required this.cardIndex,
      required this.index,
      required this.temp,
      required this.time,
      required this.weatherIcon});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          child: Text(getTime(time) + ' น.',
              style: TextStyle(
                color: cardIndex == index
                    ? Colors.white
                    : CustomColors.textColorBlack,
              )),
        ),
        Container(
          child: Image.asset(
            "assets/weather/$weatherIcon.png",
            height: 40,
            width: 40,
          ),
        ),
        Container(
            child: Text("$temp °",
                style: TextStyle(
                  color: cardIndex == index
                      ? Colors.white
                      : CustomColors.textColorBlack,
                ))),
      ],
    );
  }
}
