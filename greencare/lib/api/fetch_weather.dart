import 'dart:convert';

import 'package:greencare/api/api_key.dart';
import 'package:greencare/model/weather_data.dart';
import 'package:greencare/utils/api_url.dart';
import 'package:http/http.dart' as http;
import 'package:greencare/model/weather_data_current.dart';

class FetchWeatherAPI {
  WeatherData? weatherData;
  //processing the data from response to json
  Future<WeatherData> processData(lat, lon) async {
    var response = await http.get(Uri.parse(apiURL(lat, lon)));
    var jsonString = jsonDecode(response.body);
    weatherData = WeatherData(WeatherDataCurrent.fromJson(jsonString));

    return weatherData!;
  }
}
