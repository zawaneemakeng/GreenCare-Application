import 'package:greencare/model/weather_data_current.dart';

class WeatherData {
  final WeatherDataCurrent? current;
  WeatherData([this.current]);
  // funtion to

  WeatherDataCurrent getCurrentWeather() => current!;
}
