import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:greencare/controller/global_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HeaderWidget extends StatefulWidget {
  const HeaderWidget({super.key});

  @override
  State<HeaderWidget> createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  String city = "";
  String date = DateFormat('EEEdMMM').format(DateTime.now());

  final GlobalController globalController =
      Get.put(GlobalController(), permanent: true);

  @override
  void initState() {
    getAddress(globalController.getLatitude().value,
        globalController.getLongitude().value);
    super.initState();
  }

  getAddress(lat, lon) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, lon);
    //print(placemarks);
    Placemark place = placemarks[0];
    setState(() {
      city = place.locality!;
      //city = place.subLocality!;
    });
  }

  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(left: 20, right: 20),
          alignment: Alignment.topLeft,
          child: Text(
            city,
            style: const TextStyle(
              fontSize: 25,
              height: 2,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
          alignment: Alignment.topLeft,
          child: Text(
            date,
            style:
                TextStyle(fontSize: 14, color: Colors.grey[600], height: 1.5),
          ),
        ),
      ],
    );
  }
}
