import 'package:flutter/material.dart';
import 'package:rotnaam/pages/material.dart';
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
  File? selectedImage;
  List imageList = [];
  String fileName = "";
  String getlast_img = "";
  List profilelist = [];
  int? userID;
  int? IDimg;
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
        child: Column(children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15, top: 30),
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
            height: 40,
          ),
        ]),
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
      print(userID);
      getImage();
    });
  }

  // Future getprofileInfo() async {
  //   var url = Uri.http(host(), '${getprofile()}/${userID}/');
  //   var response = await http.get(url);
  //   // var result = json.decode(response.body);
  //   var result = utf8.decode(response.bodyBytes);
  //   setState(() {
  //     profilelist = json.decode(result);
  //     print(profilelist);
  //   });
  // }

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

  Widget imageProfile() {
    return imageList.isNotEmpty
        ? Expanded(
            child: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: imageList.length.clamp(0, 1),
                shrinkWrap: false,
                itemBuilder: (context, int index) {
                  return CachedNetworkImage(
                    imageUrl:
                        "http://${host()}${imageList[index]['profile_img']}",
                    imageBuilder: (context, imageProvider) => Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.fill),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 55, top: 80),
                        child: showDialogPhoto(),
                      ),
                    ),
                    placeholder: (context, url) => _onloading(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  );
                }),
          )
        : _onloading();
  }

  Widget _onloading() {
    return Center(
      child: Stack(children: <Widget>[
        Container(
            width: 130,
            height: 130,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 0),
              shape: BoxShape.circle,
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
          title: const Text('กรุณาเลือกจ้า'),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: 70,
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
                      "camera",
                      style: TextStyle(color: Colors.grey[700], fontSize: 14),
                    ),
                  ],
                ),
              ),
              Container(
                height: 70,
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
                      "gallery",
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
}
