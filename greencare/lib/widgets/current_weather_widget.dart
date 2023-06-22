import 'package:flutter/material.dart';
import 'package:greencare/model/weather_data_current.dart';
import 'package:percent_indicator/percent_indicator.dart';

class CurrentWeatherWidget extends StatelessWidget {
  double water_level = 70.7;
  final WeatherDataCurrent weatherDataCurrent;
  CurrentWeatherWidget({Key? key, required this.weatherDataCurrent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SoilTempWidget(),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }

  Widget SoilTempWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Image.asset(
          "assets/weather/${weatherDataCurrent.current.weather![0].icon}.png",
          height: 80,
          width: 80,
        ),
        Container(
            height: 50, width: 1, color: Color.fromARGB(255, 130, 130, 130)),
        RichText(
            text: TextSpan(children: [
          TextSpan(
              text: "${weatherDataCurrent.current.temp!.toInt()}°",
              style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 68,
                  color: Colors.grey)),
        ]))
      ],
    );
  }
}
