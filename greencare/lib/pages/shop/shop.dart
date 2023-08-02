import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:greencare/utils/api_url.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  File? selectedImage;
  List imageList = [];
  String fileName = "";
  String getlast_img = "";

  @override
  void initState() {
    super.initState();
    getImage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(children: [
            imageProfile(),
            SizedBox(
              height: 40,
            ),
          ]),
        ),
      ),
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

  Widget imageProfile() {
    return Container(
      width: 130,
      height: 130,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 0),
        shape: BoxShape.circle,
        image: DecorationImage(
            image: NetworkImage("http://192.168.17.152:8000/${getlast_img}"),
            fit: BoxFit.fill),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 70, top: 60),
        child: showDialogPhoto(),
      ),
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
