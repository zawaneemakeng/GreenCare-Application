import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';

class GlobalController extends GetxController {
  final RxBool _isLoading = true.obs;
  final RxDouble _latitude = 0.0.obs;
  final RxDouble _longitude = 0.0.obs;

  RxBool checkLoading() => _isLoading;
  RxDouble getLattitude() => _latitude;
  RxDouble getLongitude() => _longitude;

  @override
  void onInit() {
    if (_isLoading.isTrue) {
      getLocation();
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
      _isLoading.value = false;
    });
  }
}
