import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rotnaam/pages/plant_manage/add_plants.dart';
import 'package:rotnaam/pages/plant_manage/current_devices.dart';
import 'package:rotnaam/pages/plant_manage/control_plant.dart';
import 'package:rotnaam/pages/plant_manage/update_plant.dart';
import 'package:rotnaam/pages/widgets/noplant.dart';
import 'package:rotnaam/utils/api_url.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';

class PlantPage extends StatefulWidget {
  const PlantPage({super.key});

  @override
  State<PlantPage> createState() => _PlantPageState();
}

class _PlantPageState extends State<PlantPage> {
  DateTime selectedDate = DateTime.now();
  File? selectedImage;
  List imageList = [];
  String fileName = "";
  int? userID;
  List plantsItems = [];
  int? plantID;
  String? plantname;
  String? imgplant;
  String? startdate;
  String? detail;
  String? setmoisture;
  String? setstarttime;
  String? setendtime;

  bool status = false;
  var newplantname = TextEditingController();
  var newplandetail = TextEditingController();
  @override
  void initState() {
    super.initState();
    check();
    print(plantID);
  }

  List<String> months = [
    "ม.ค.",
    "ก.พ.",
    "มี.ค.",
    "เม.ย.",
    "พ.ค.",
    "มิ.ย.",
    "ก.ค.",
    "ส.ค.",
    "ก.ย.",
    "ต.ค.",
    "พ.ย.",
    "ธ.ค."
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SizedBox(
        width: 100,
        height: 40,
        child: FittedBox(
          child: FloatingActionButton.extended(
              onPressed: () async {
                final reversedIndex = plantsItems.length - 1;
                if (plantsItems.isEmpty ||
                    plantsItems[reversedIndex]['status'] == true) {
                  String refresh = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AddPlants()),
                  );
                  if (refresh == 'refresh') {
                    check();
                  }
                } else {
                  final snackBar = SnackBar(
                    backgroundColor: Colors.grey[600],
                    content: const Text(
                        'ไม่สามารถเพิ่มได้ \nกรุณาเปลี่ยนสถานะเก็บเกี่ยว!'),
                    action: SnackBarAction(
                      label: 'รับทราบ',
                      onPressed: () {
                        // Some code to undo the change.
                      },
                    ),
                  );

                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50.0))),
              label: const Text(
                'เพิ่มรายการ',
                style: TextStyle(fontSize: 16),
              ),
              icon: const Icon(Icons.add),
              backgroundColor: Colors.teal,
              foregroundColor: Colors.white),
        ),
      ),
      body: plantsItems.isNotEmpty
          ? Center(
              child: ListView(
                children: [
                  Column(
                    children: [
                      CurrentDevices(pid: plantID),
                      DevicesPlant(pid: plantID),
                      const Padding(
                        padding: EdgeInsets.only(
                            left: 20, right: 20, top: 40, bottom: 20),
                        child: Text('รายละเอียด',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w700)),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      imagePlant(),
                      const SizedBox(
                        height: 20,
                      ),
                      showDetail()
                    ],
                  ),
                ],
              ),
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  noPlant(),
                ],
              ),
            ),
    );
  }

  Widget showDetail() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Slidable(
        endActionPane: ActionPane(
          extentRatio: 0.3,
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
                padding: const EdgeInsets.only(left: 5),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  bottomLeft: Radius.circular(8.0),
                ),
                icon: Icons.edit,
                backgroundColor: const Color.fromARGB(255, 96, 185, 99),
                foregroundColor: const Color(0xffE0E0E0),
                onPressed: (context) => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UpdatePlant(
                                  user: userID,
                                  id: plantID,
                                  plantname: plantname,
                                  detail: detail,
                                  startdate: startdate,
                                  status: status,
                                  setstarttime: setstarttime,
                                  setendtime: setendtime,
                                  setmoisture: setmoisture.toString()))).then(
                        (value) {
                          //.then ตือให้ทำอะไรถ้ากลับมา
                          setState(() {
                            check();

                            if (value == 'update') {
                              final snackBar = SnackBar(
                                content: const Text('เเก้ไขเรียบร้อย'),
                                action: SnackBarAction(
                                  label: 'ปิด',
                                  onPressed: () {},
                                ),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            } else if (value == 'delete') {
                              final snackBar = SnackBar(
                                content: const Text('ลบเรียบร้อย'),
                                action: SnackBarAction(
                                  label: 'ปิด',
                                  onPressed: () {},
                                ),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                          });
                        },
                      )
                    }),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 10,
            right: 10,
          ),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(8)),
            child: Column(
              children: [
                SizedBox(
                  height: 50.0,
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 12),
                        child: Icon(
                          Icons.grass_outlined,
                          size: 24.0,
                          color: Colors.teal,
                        ),
                      ),
                      const SizedBox(
                        width: 12.0,
                      ),
                      Text(
                        "$plantname",
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.grey[700],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 50.0,
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 12),
                        child: Icon(
                          Icons.description,
                          size: 24.0,
                          color: Colors.teal,
                        ),
                      ),
                      const SizedBox(
                        width: 12.0,
                      ),
                      Text(
                        "$detail",
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.grey[700],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 50.0,
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 12),
                        child: Icon(
                          Icons.date_range,
                          size: 24.0,
                          color: Colors.teal,
                        ),
                      ),
                      const SizedBox(
                        width: 12.0,
                      ),
                      Text(
                        "วันที่ปลูก : $startdate",
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.grey[700],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 50.0,
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 12),
                        child: Icon(Icons.track_changes,
                            size: 24.0, color: Colors.teal),
                      ),
                      const SizedBox(
                        width: 12.0,
                      ),
                      status == true
                          ? Text(
                              "สถานะ : เก็บเกี่ยว",
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.grey[700],
                              ),
                            )
                          : Text(
                              "สถานะ : ยังไม่เก็บเกี่ยว",
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.grey[700],
                              ),
                            )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void check() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final checkvalue = pref.get('user') ?? 0;
    if (checkvalue != 0) {
      getUsername();
    }
  }

  void getUsername() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      var username = pref.getInt('user');
      userID = username;
      getPlants();
    });
  }

  Future getPlants() async {
    var url = Uri.http(host(), 'get-plants/$userID');
    var response = await http.get(url);
    var result = utf8.decode(response.bodyBytes);
    setState(() {
      plantsItems = json.decode(result);
      final reversedIndex = plantsItems.length - 1;
      plantID = plantsItems[reversedIndex]['id'];
      plantname = plantsItems[reversedIndex]['plantname'];
      detail = plantsItems[reversedIndex]['detail'];
      startdate = plantsItems[reversedIndex]['startdate'];
      status = plantsItems[reversedIndex]['status'];
      imgplant = plantsItems[reversedIndex]['plant_img'];
      setmoisture = plantsItems[reversedIndex]['setmoisture'];
      setstarttime = plantsItems[reversedIndex]['setstarttime'];
      setendtime = plantsItems[reversedIndex]['setendtime'];
      print("${host()}$imgplant");
    });
  }

  Widget imagePlant() {
    return CachedNetworkImage(
      imageUrl: "http://${host()}$imgplant",
      imageBuilder: (context, imageProvider) => Container(
        width: 300,
        height: 150,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(image: imageProvider, fit: BoxFit.fill),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 220, top: 80),
          child: showDialogPhoto(),
        ),
      ),
      placeholder: (context, url) => _onloading(),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }

  Widget showDialogPhoto() {
    return IconButton(
      onPressed: () => showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16.0))),
          surfaceTintColor: const Color(0xff3AAA94),
          backgroundColor: Colors.white,
          content: Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 80,
                  width: 60,
                  child: Column(
                    children: [
                      IconButton(
                        onPressed: () {
                          _getImage(ImageSource.camera);
                        },
                        icon: Icon(Icons.camera_alt,
                            size: 28, color: Colors.grey[700]),
                      ),
                      Text(
                        "กล้อง",
                        style: TextStyle(color: Colors.grey[700], fontSize: 14),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 80,
                  width: 60,
                  child: Column(
                    children: [
                      IconButton(
                        onPressed: () {
                          _getImage(ImageSource.gallery);
                        },
                        icon: Icon(Icons.photo_sharp,
                            size: 28, color: Colors.grey[700]),
                      ),
                      Text(
                        "แกลลอรี่",
                        style: TextStyle(color: Colors.grey[700], fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('ยกเลิก', style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
      icon: Icon(
        Icons.camera_alt,
        size: 26,
        color: Colors.grey[400],
      ),
    );
  }

  Widget _onloading() {
    return Center(
      child: Stack(children: <Widget>[
        Container(
            width: 130,
            height: 130,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: Lottie.asset('assets/animations/animation_lkuv6jxa.json',
                  width: 35, height: 35),
            )),
        Positioned(
          height: 180,
          width: 200,
          child: showDialogPhoto(),
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
    });
  }

  Future uploadImage() async {
    final request = http.MultipartRequest(
        'PATCH', Uri.parse("http://${host()}/api/update-plant-img/${plantID}"));
    final headers = {"Content-type": "application/json"};
    request.files.add(http.MultipartFile('plant_img',
        selectedImage!.readAsBytes().asStream(), selectedImage!.lengthSync(),
        filename: selectedImage!.path.split("/").last));
    request.headers.addAll(headers);
    final response = await request.send();
    print(response);
    setState(() {
      Navigator.pop(context);
      getPlants();
    });
  }
}
