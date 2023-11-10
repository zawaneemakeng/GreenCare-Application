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
  final int userID;
  const ProfilePage({super.key, required this.userID});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? selectedImage;
  Map<String, dynamic> profile = {};
  int? _userID;
  int? profile_id;
  String? first_name;
  String? job = "";
  String? p_number = "";
  String? current_img = "";

  @override
  void initState() {
    super.initState();
    _userID = widget.userID;
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
                padding: const EdgeInsets.only(left: 15, top: 15),
                child: IconButton(
                  icon: Image.asset('assets/back.png', height: 35, width: 35),
                  iconSize: 50,
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const HomePage()));
                  },
                ),
              ),
            ],
          ),
          imageProfile(),
          const SizedBox(
            height: 10,
          ),
          profileInfo()
        ]),
      ]),
    ));
  }

  Widget profileInfo() {
    return profile.isNotEmpty
        ? Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              height: 400,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withAlpha(0),
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
                      const Padding(
                        padding: EdgeInsets.only(bottom: 15),
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
                              style: const TextStyle(
                                color: Colors.black54,
                              ),
                              decoration: InputDecoration(
                                prefixIcon: const Icon(
                                  Icons.email,
                                  color: Colors.teal,
                                ),
                                hintText: first_name,
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
                      Row(
                        children: [
                          Container(
                            width: 285,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              cursorColor: Colors.grey,
                              style: const TextStyle(
                                color: Colors.black54,
                              ),
                              decoration: InputDecoration(
                                prefixIcon: const Icon(
                                  Icons.phone,
                                  color: Colors.teal,
                                ),
                                hintText: "เบอร์โทร $p_number",
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
                      Row(
                        children: [
                          Container(
                            child: const Padding(
                              padding: EdgeInsets.only(left: 12),
                              child: Icon(
                                Icons.date_range,
                                size: 24.0,
                                color: Colors.teal,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 12.0,
                          ),
                          Text(
                            "อาชีพ $job",
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.grey[700],
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
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: ElevatedButton(
                          onPressed: () {
                            //
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.teal,
                              fixedSize: const Size(200, 20),
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

  Widget imageProfile() {
    return profile.isNotEmpty
        ? CachedNetworkImage(
            imageUrl: "http://${host()}${profile['profile_img']}",
            imageBuilder: (context, imageProvider) => Container(
              width: 160,
              height: 160,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade400.withAlpha(90),
                    spreadRadius: 0,
                    blurRadius: 20,
                    offset: const Offset(20, 10),
                  ),
                ],
                color: Colors.grey[300],
                shape: BoxShape.circle,
                image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 80, top: 90),
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

  Future getProfile() async {
    var url = Uri.http(host(), '/media/profile/$_userID/');
    var response = await http.get(url);
    var result = utf8.decode(response.bodyBytes);
    setState(() {
      profile = json.decode(result);
      profile_id = profile['id'];
      p_number = profile['phone_number'];
      job = profile['job'];
      current_img = profile['profile_img'];
      setnewImg();
    });
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
        'PATCH', Uri.parse("http://${host()}/update/profile/$profile_id/"));
    final headers = {"Content-type": "application/json"};
    request.files.add(http.MultipartFile('profile_img',
        selectedImage!.readAsBytes().asStream(), selectedImage!.lengthSync(),
        filename: selectedImage!.path.split("/").last));
    request.headers.addAll(headers);
    final response = await request.send();
    print(response);
    setState(() {
      getProfile();
      Navigator.pop(context);
    });
  }

  Widget showDialogPhoto() {
    return IconButton(
      onPressed: () => showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16.0))),
          surfaceTintColor: Colors.teal,
          backgroundColor: Colors.white,
          content: Row(
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

  void check() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final checkvalue = pref.get('user') ?? 0;
    if (checkvalue != 0) {
      getUsername();
    }
  }

  void getUsername() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    setState(
      () {
        var f_name = pref.getString('first_name');
        first_name = f_name;
        var username = pref.getInt('user');
        _userID = username;
        getProfile();
      },
    );
  }

  void setnewImg() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('profile_img', current_img!);
  }
}
