import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:greencare/utils/api_url.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';

class ShowPlant extends StatefulWidget {
  const ShowPlant({super.key});

  @override
  State<ShowPlant> createState() => _ShowPlantState();
}

class _ShowPlantState extends State<ShowPlant> {
  double water_level = 0.0;
  List waterlevelList = [];
  File? selectedImage;
  List imageList = [];
  List soilList = [];
  String fileName = "";
  String getlast_img = "";
  bool light = false;
  bool watering = false;
  String? status;

  @override
  void initState() {
    super.initState();
    getWaterlevel();
    getImage();
    getSoil();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [imageProfile()]),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 20,
          ),
          Led_OnOff(),
          SizedBox(
            height: 20,
          ),
          Watering_OnOff()
        ],
      ),
    );
  }

  Widget CurrentSoilMoisture() {
    return Container(
      height: 65,
      width: 65,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Color(0xffE6E6E6),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Image.asset('assets/icons/humid.png'),
    );
  }

  Widget CurrentWeatherDetailWidget() {
    return Column(
      children: [
        SizedBox(height: 20),
        Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Container(
            height: 65,
            width: 65,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Color(0xffE6E6E6),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Image.asset('assets/icons/humid.png'),
          ),
          Container(
            height: 65,
            width: 65,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
                color: Color(0xffE6E6E6),
                borderRadius: BorderRadius.circular(15)),
            child: Image.asset('assets/leaf.png'),
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
              width: 70,
              child: Text(
                'ความชื้นในดิน',
                style: TextStyle(fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 20,
              width: 70,
              child: Text(
                'ความชื้นในดิน',
                style: TextStyle(fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 20,
              width: 70,
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
              child: ListView.builder(
                itemCount: soilList.length.clamp(0, 1),
                itemBuilder: (context, int index) {
                  final reversedIndex = soilList.length - 1 - index;
                  return Text(
                    "${soilList[reversedIndex]['soilmoisture']}%",
                    style: TextStyle(fontSize: 12),
                    textAlign: TextAlign.center,
                  );
                },
              ),
            ),
            SizedBox(
              height: 20,
              width: 60,
              child: Text(
                "weatherDataCurrent.current.windSpeed",
                style: TextStyle(fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 20,
              width: 60,
              child: ListView.builder(
                itemCount: waterlevelList.length.clamp(0, 1),
                itemBuilder: (context, int index) {
                  final reversedIndex = waterlevelList.length - 1 - index;
                  return Text(
                    "${waterlevelList[reversedIndex]['waterl_remaining']}%",
                    style: TextStyle(fontSize: 12),
                    textAlign: TextAlign.center,
                  );
                },
              ),
            )
          ],
        )
      ],
    );
  }

  Future getImage() async {
    var url = Uri.http('${urlH()}', '/media/profile/');
    var response = await http.get(url);
    var result = utf8.decode(response.bodyBytes);
    setState(() {
      imageList = json.decode(result);
      print(imageList);
      final reversedIndex = imageList.length - 1;
      getlast_img = imageList[reversedIndex]['cover_img'];
      print(getlast_img);
    });
  }

  Widget Led_OnOff() {
    return Container(
      margin: EdgeInsets.only(
        left: 10,
        right: 10,
      ),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Color(0xffE6E6E6),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              light == true
                  ? Image.asset(
                      "assets/power.png",
                      width: 35,
                      height: 35,
                    )
                  : Image.asset(
                      "assets/power_off.png",
                      width: 34,
                      height: 34,
                    ),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  light == true ? Text("ไฟเปิด") : Text("ไฟปิด"),
                  Text(
                    "ไฟจะเปิดอัตโนมัติเวลา 18.30 น.",
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
                ],
              )
            ],
          ),
          Switch(
            // This bool value toggles the switch.
            value: light,
            activeColor: Color.fromARGB(255, 91, 197, 95),
            inactiveTrackColor: Colors.grey[400],

            onChanged: (bool value) {
              // This is called when the user toggles the switch.
              setState(() {
                light = value;
                light == true ? OpenLED("LED=ON") : OpenLED("LED=OFF");
              });
            },
          ),
        ],
      ),
    );
  }

  Widget Watering_OnOff() {
    return Container(
      margin: EdgeInsets.only(
        left: 10,
        right: 10,
      ),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Color(0xffE6E6E6),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              watering == true
                  ? Image.asset(
                      "assets/pump.png",
                      width: 30,
                      height: 30,
                    )
                  : Image.asset(
                      "assets/pump_off.png",
                      width: 30,
                      height: 30,
                    ),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  watering == true ? Text("เปิดปั้มน้ำ") : Text("ปิดปั้มน้ำ"),
                  Text(
                    "ไฟจะเปิดอัตโนมัติเวลา 18.30 น.",
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
                ],
              )
            ],
          ),
          Switch(
            // This bool value toggles the switch.
            value: watering,
            activeColor: Color.fromARGB(255, 91, 197, 95),
            inactiveTrackColor: Colors.grey[400],

            onChanged: (bool value) {
              // This is called when the user toggles the switch.

              setState(() {
                watering = value;
              });
            },
          ),
        ],
      ),
    );
  }

  Future getSoil() async {
    var url = Uri.http(urlH(), '/api/get-soilmoisture/');
    var response = await http.get(url);
    // var result = json.decode(response.body);
    var result = utf8.decode(response.bodyBytes);
    setState(() {
      soilList = json.decode(result);
      print(soilList);
    });
  }

  Future getWaterlevel() async {
    var url = Uri.http(urlH(), '/api/get-waterlevel/');
    var response = await http.get(url);
    // var result = json.decode(response.body);
    var result = utf8.decode(response.bodyBytes);
    setState(() {
      waterlevelList = json.decode(result);
      final reversedIndex = waterlevelList.length - 1;
      double a =
          double.parse(waterlevelList[reversedIndex]['waterl_remaining']);
      water_level = a;
      print(" WATERLEVEL : ${water_level}");
    });
  }

  Future OpenLED(String status) async {
    var url = Uri.http('ass', '/?$status');
    var response = await http.post(url);
    print(response.body);
  }

  Widget imageProfile() {
    return Center(
      child: Stack(children: <Widget>[
        SizedBox(
          height: 40,
        ),
        CachedNetworkImage(
          imageUrl: 'http://${urlH()}/${getlast_img}',
          placeholder: (context, url) => const CircularProgressIndicator(),
          errorWidget: (context, url, error) => const Icon(
            Icons.error,
            size: 100,
            color: Colors.red,
          ),
          imageBuilder: (context, imageProvider) => Column(
            children: [
              Container(
                width: 270,
                height: 150,
                decoration: BoxDecoration(
                  // border: Border.all(color: Color(0xffE6E6E6), width: 10),
                  borderRadius: BorderRadius.circular(15),
                  image:
                      DecorationImage(image: imageProvider, fit: BoxFit.fill),
                ),
              ),
            ],
          ),
        ),
        Positioned(
            bottom: 15.0,
            right: 20.0,
            child: InkWell(
              onTap: () {
                showBottomSheet(
                    context: this.context, builder: (builder) => bottomSheet());
                // enableDrag: false);
              },
              child: Icon(
                Icons.camera_alt_rounded,
                color: Colors.grey[500],
                size: 26,
              ),
            )),
        SizedBox(
          height: 100,
        )
      ]),
    );
  }

  Future _getImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    selectedImage = File(image!.path);
    setState(() {
      print(selectedImage);
      uploadImage();
      Navigator.pop(this.context);
    });
  }

  Future uploadImage() async {
    final request =
        http.MultipartRequest("POST", Uri.parse("http://${urlH()}/api/image"));
    final headers = {"Content-type": "multipart/form-data"};
    request.files.add(http.MultipartFile('cover_img',
        selectedImage!.readAsBytes().asStream(), selectedImage!.lengthSync(),
        filename: selectedImage!.path.split("/").last));
    request.headers.addAll(headers);
    final response = await request.send();
    setState(() {
      fileName = selectedImage!.path.split("/").last;
      print("Name: ${fileName}");
      getlast_img = "/media/profile/${fileName}";
    });
  }

  Widget bottomSheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(this.context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: <Widget>[
          Text("fdkfldfk"),
          SizedBox(
            height: 20,
          ),
          Row(
            children: <Widget>[
              TextButton.icon(
                  onPressed: () {
                    _getImage(ImageSource.camera);
                  },
                  icon: Icon(Icons.camera_alt),
                  label: Text("camera")),
              TextButton.icon(
                  onPressed: () {
                    _getImage(ImageSource.gallery);
                  },
                  icon: Icon(Icons.browse_gallery),
                  label: Text("gallery")),
            ],
          )
        ],
      ),
    );
  }
}
