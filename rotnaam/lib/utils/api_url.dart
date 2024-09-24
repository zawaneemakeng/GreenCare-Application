import 'package:rotnaam/api/api_key.dart';

String apiURL(var lat, var lon) {
  String url;
  url =
      "https://api.openweathermap.org/data/3.0/onecall?lat=$lat&lon=$lon&appid=$apiKey&units=metric&exclude=minutely";
  return url;
}

String host() {
  return "192.168.2.33:8000";
}

String register() {
  return "register";
}

String authen() {
  return "authenticate";
}

String article() {
  return "article/";
}
// _______________________RESET PASSWORD_____________________

String resetpassword() {
  return "reset-password";
}

String otppassword() {
  return "otp-reset-password";
}

String getprofile() {
  return "api/profile";
}

String resetnewpassword() {
  return "reset-new-password";
}

//_______________Control__________
String urlDevice() {
  return "192.168.233.205";
}

String waterplant() {
  return "api/post-waterplant";
}

String ledplant() {
  return "api/post-ledplant";
}

String controlLED() {
  return "?LED=";
}

String controlPUMP() {
  return "?PUMP=";
}

// __________________PLANT_____________________
String addplant() {
  return "add-newplant";
}

String getplant() {
  return "get-plants/";
}

String petchimgplant() {
  return "petch/img-plant";
}

// __________________TRANSACTIONS_____________________
String addtransaction() {
  return "add-transaction";
}

String gettransaction() {
  return "transection";
}

//__________________DEVICES_________________

String getsoilmoisture() {
  return "api/get-soilmoisture";
}

int userID(usrid) {
  return usrid;
}

String getwaterlevel() {
  return "api/get-waterlevel";
}
