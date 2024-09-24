import 'dart:convert';
import 'package:rotnaam/model/weather_data.dart';
import 'package:rotnaam/model/weather_data_hourly.dart';
import 'package:rotnaam/utils/api_url.dart';
import 'package:http/http.dart' as http;
import 'package:rotnaam/model/weather_data_current.dart';

class FetchWeatherAPI {
  WeatherData? weatherData;
  //processing the data from response to json
  Future<WeatherData> processData(lat, lon) async {
    var response = await http.get(Uri.parse(apiURL(lat, lon)));
    var jsonString = jsonDecode(response.body);
    print(jsonString);
    weatherData = WeatherData(WeatherDataCurrent.fromJson(jsonString),
        WeatherDataHourly.fromJson(jsonString));

    return weatherData!;
  }
}
