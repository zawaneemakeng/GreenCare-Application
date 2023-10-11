import 'package:flutter/material.dart';
import 'package:rotnaam/pages/material.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'dart:io';
import 'package:rotnaam/utils/api_url.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  DateTime selectedDate = DateTime.now();
  File? selectedImage;
  List imageList = [];
  String fileName = "";
  String getlast_img = "";
  List profilelist = [""];
  int? userID;
  int? IDimg;
  String? fulldate;
  String? first_name;
  String? b_date = "";
  String? p_number = "";

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
  void initState() {
    // TODO: implement initState
    super.initState();
    check();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: ListView(children: [
        Column(children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15, top: 20),
                child: IconButton(
                  icon: Image.asset('assets/back.png', height: 35, width: 35),
                  iconSize: 50,
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => HomePage()));
                  },
                ),
              ),
            ],
          ),
          imageProfile(),
          SizedBox(
            height: 10,
          ),
          profileInfo()
        ]),
      ]),
    ));
  }

  Widget profileInfo() {
    return profilelist.isNotEmpty
        ? Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              height: 400,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255),
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(255, 255, 255, 255).withAlpha(0),
                    spreadRadius: 0,
                    blurRadius: 5,
                    offset: const Offset(0.5, 0),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: Text(
                          'โปรไฟลของคุณ',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            width: 285,
                            child: TextField(
                              // controller: email,
                              cursorColor: Colors.grey,
                              style: TextStyle(
                                color: Colors.black54,
                              ),
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.email,
                                  color: Color.fromARGB(255, 133, 133, 133),
                                ),
                                hintText: first_name,
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Divider(
                          height: 1,
                          color: Colors.grey,
                          thickness: 1,
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            width: 285,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              // controller: password,
                              obscureText: true,
                              cursorColor: Colors.grey,
                              style: TextStyle(
                                color: Colors.black54,
                              ),
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.phone,
                                  color: Color.fromARGB(255, 93, 93, 93),
                                ),
                                hintText: "เบอร์โทร ${p_number}",
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Divider(
                          height: 1,
                          color: Colors.grey,
                          thickness: 1,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          _selectDate(context);
                          FocusScope.of(context).unfocus();
                        },
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                            EdgeInsets.zero,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 12),
                                child: Icon(
                                  Icons.date_range,
                                  size: 24.0,
                                  // color: Colors.grey[700],
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 12.0,
                            ),
                            Text(
                              "วันเกิด ${b_date}",
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.grey[700],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Divider(
                          height: 1,
                          color: Colors.grey,
                          thickness: 1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: ElevatedButton(
                          onPressed: () {
                            //
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xff3AAA94),
                              fixedSize: const Size(130, 20),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50))),
                          child: const Text(
                            'เเก้ไข',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      )
                    ]),
              ),
            ),
          )
        : Center(
            child: Lottie.asset('assets/animations/animation_lkuv6jxa.json',
                width: 35, height: 35),
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
      var f_name = pref.getString('first_name');
      first_name = f_name;
      var username = pref.getInt('user');
      userID = username;
      print(userID);
      Future.delayed(const Duration(seconds: 1), () {
        getImage();
        getProfile();
      });
    });
  }

  Future getImage() async {
    var url = Uri.http(host(), '/media/profile/${userID}/');
    var response = await http.get(url);
    var result = utf8.decode(response.bodyBytes);
    setState(() {
      imageList = json.decode(result);
      print(imageList);
      IDimg = imageList[0]['id'];
    });
  }

  Future getProfile() async {
    var url = Uri.http(host(), '/media/profile/${userID}/');
    var response = await http.get(url);
    var result = utf8.decode(response.bodyBytes);
    setState(() {
      profilelist = json.decode(result);
      print(profilelist);
      p_number = profilelist[0]['phone_number'];
      b_date = profilelist[0]['birthdate'];
    });
  }

  Widget imageProfile() {
    return imageList.isNotEmpty
        ? CachedNetworkImage(
            imageUrl: "http://${host()}${imageList[0]['profile_img']}",
            imageBuilder: (context, imageProvider) => Container(
              width: 130,
              height: 160,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                shape: BoxShape.circle,
                image: DecorationImage(image: imageProvider, fit: BoxFit.fill),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 50, top: 70),
                child: showDialogPhoto(),
              ),
            ),
            placeholder: (context, url) => _onloading(),
            errorWidget: (context, url, error) => Icon(Icons.error),
          )
        : _onloading();
  }

  Widget _onloading() {
    return Center(
      child: Stack(children: <Widget>[
        Container(
            width: 130,
            height: 150,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 0),
              color: Colors.grey[300],
            ),
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: Lottie.asset('assets/animations/animation_lkuv6jxa.json',
                  width: 35, height: 35),
            )),
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
        'PATCH', Uri.parse("http://${host()}/update/profile/${IDimg}/"));
    final headers = {"Content-type": "application/json"};
    request.files.add(http.MultipartFile('profile_img',
        selectedImage!.readAsBytes().asStream(), selectedImage!.lengthSync(),
        filename: selectedImage!.path.split("/").last));
    request.headers.addAll(headers);
    final response = await request.send();
    print(response);
    setState(() {
      Navigator.pop(context);
      getImage();
    });
  }

  Widget showDialogPhoto() {
    return IconButton(
      onPressed: () => showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16.0))),
          surfaceTintColor: Color(0xff3AAA94),
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

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showRoundedDatePicker(
      context: context,
      locale: Locale("th", "TH"),
      era: EraMode.BUDDHIST_YEAR,
      initialDate: selectedDate,
      firstDate: DateTime(2017, 1),
      lastDate: DateTime(2037),
      borderRadius: 15,
      theme: ThemeData(primaryColor: const Color(0xff3AAA94), fontFamily: 'PK'),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }
}
