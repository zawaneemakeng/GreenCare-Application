import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:rotnaam/api/fetch_weather.dart';
import 'package:rotnaam/model/weather_data.dart';

class GlobalController extends GetxController {
  final RxBool _isLoading = true.obs;
  final RxDouble _latitude = 0.0.obs;
  final RxDouble _longitude = 0.0.obs;
  final RxInt _currentIndex = 0.obs;

  RxBool checkLoading() => _isLoading;
  RxDouble getLatitude() => _latitude;
  RxDouble getLongitude() => _longitude;

  final weatherData = WeatherData().obs;

  WeatherData getData() {
    return weatherData.value;
  }

  @override
  void onInit() {
    if (_isLoading.isTrue) {
      getLocation();
    } else {
      getIndex();
    }
    super.onInit();
  }

  getLocation() async {
    bool isServiceEnabled;
    LocationPermission locationPermisstion;
    isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    //return if service is not enable
    if (!isServiceEnabled) {
      return Future.error("locations  not Enable");
    }
    locationPermisstion = await Geolocator.checkPermission();
    if (locationPermisstion == LocationPermission.deniedForever) {
      return Future.error('Location permission are denied Forever');
    } else if (locationPermisstion == LocationPermission.denied) {
      locationPermisstion = await Geolocator.requestPermission();
      if (locationPermisstion == LocationPermission.denied) {
        return Future.error("Location Permission is denied");
      }
    }
    return await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high)
        .then((value) {
      _latitude.value = value.latitude;
      _longitude.value = value.longitude;
      // print(_latitude.value);
      // print(_longitude.value);
      return FetchWeatherAPI()
          .processData(value.latitude, value.longitude)
          .then((value) {
        weatherData.value = value;
        _isLoading.value = false;
      });
    });
  }

  RxInt getIndex() {
    return _currentIndex;
  }
}
