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
          height: 20,
        ),
        CurrentWeatherDetailWidget(),
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

  Widget CurrentWeatherDetailWidget() {
    return Column(
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Container(
            height: 65,
            width: 65,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
                color: Color(0xffE6E6E6),
                borderRadius: BorderRadius.circular(15)),
            child: Image.asset('assets/icons/humid.png'),
          ),
          Container(
            height: 65,
            width: 65,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
                color: Color(0xffE6E6E6),
                borderRadius: BorderRadius.circular(15)),
            child: Image.asset('assets/icons/windspeed.png'),
          ),
          Container(
            height: 65,
            width: 65,
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: Color(0xffE6E6E6),
                borderRadius: BorderRadius.circular(15)),
            child: CircularPercentIndicator(
              percent: water_level / 100,
              radius: 20,
              lineWidth: 7,
              animation: true,
              progressColor: Colors.blueAccent,
              backgroundColor: Colors.white,
            ),
          ),
        ]),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: 20,
              width: 60,
              child: Text(
                'ความชื้นในดิน',
                style: TextStyle(fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 20,
              width: 60,
              child: Text(
                'ความชื้นในดิน',
                style: TextStyle(fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 20,
              width: 60,
              child: Text(
                'น้ำคงเหลือ',
                style: TextStyle(fontSize: 12),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: 20,
              width: 60,
              child: Text(
                "${weatherDataCurrent.current.humidity}%",
                style: TextStyle(fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 20,
              width: 60,
              child: Text(
                "${weatherDataCurrent.current.windSpeed}%",
                style: TextStyle(fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 20,
              width: 60,
              child: Text(
                "${water_level}%",
                style: TextStyle(fontSize: 12),
                textAlign: TextAlign.center,
              ),
            )
          ],
        )
      ],
    );
  }
}
