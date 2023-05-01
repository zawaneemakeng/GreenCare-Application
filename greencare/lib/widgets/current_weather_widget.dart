import 'package:flutter/material.dart';
import 'package:greencare/model/weather_data_current.dart';

class CurrentWeatherWidget extends StatelessWidget {
  final WeatherDataCurrent weatherDataCurrent;
  const CurrentWeatherWidget({Key? key, required this.weatherDataCurrent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('${weatherDataCurrent.current.humidity}'),
    );
  }
}
