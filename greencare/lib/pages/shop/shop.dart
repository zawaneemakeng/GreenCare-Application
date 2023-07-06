import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
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
  String message = "";
  File? _image;
  Future uploadImage() async {
    final request =
        http.MultipartRequest("POST", Uri.parse("http://${urlH()}/api/image"));
    final headers = {"Content-type": "multipart/form-data"};
    request.files.add(http.MultipartFile('cover_img',
        selectedImage!.readAsBytes().asStream(), selectedImage!.lengthSync(),
        filename: selectedImage!.path.split("/").last));
    request.headers.addAll(headers);
    final response = await request.send();
    http.Response res = await http.Response.fromStream(response);
  }

  Future _getImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    selectedImage = File(image!.path);
    setState(() {
      print(selectedImage);
    });
  }

  // Future<File> saveFilePermanently(String imagePath) async {
  //   final directory = await getApplicationDocumentsDirectory();
  //   final name = basename(imagePath);
  //   final image = File('${directory.path}/$name');
  //   print(name);

  //   setState(() {
  //     _image = image;
  //     print(_image);
  //     uploadImage();
  //   });
  //   return File(imagePath).copy(image.path);
  // }

  // @override
  // void initState() {
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(children: <Widget>[
            SizedBox(
              height: 40,
            ),
            selectedImage == null
                ? Image.network(
                    "https://cdn-icons-png.flaticon.com/512/3607/3607444.png",
                    width: 200,
                    height: 200,
                  )
                : Image.file(
                    selectedImage!,
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
            SizedBox(
              height: 40,
            ),
            ElevatedButton(
                onPressed: () {
                  _getImage(ImageSource.gallery);
                },
                child: Text('fkjdskf')),
            SizedBox(
              height: 40,
            ),
            ElevatedButton(
                onPressed: () {
                  _getImage(ImageSource.camera);
                },
                child: Text('camara')),
            SizedBox(
              height: 40,
            ),
            ElevatedButton(
                onPressed: () {
                  uploadImage();
                },
                child: Text('Upload')),
          ]),
        ),
      ),
    );
  }

  // Widget imageProfile() {
  //   return Center(
  //     child: Stack(children: <Widget>[
  //       CircleAvatar(
  //           radius: 80,
  //           backgroundImage: NetworkImage(
  //               "https://cdn-icons-png.flaticon.com/512/3607/3607444.png")),
  //       Positioned(
  //           bottom: 20,
  //           right: 25,
  //           child: InkWell(
  //               onTap: () {
  //                 showModalBottomSheet(
  //                   context: context,
  //                   builder: ((builder) => bottomSheet()),
  //                   backgroundColor: Colors.white,
  //                 );
  //               },
  //               child: Icon(Icons.camera_alt, color: Colors.grey, size: 26.0)))
  //     ]),
  //   );
  // }

  // Widget bottomSheet() {
  //   return Container(
  //     height: 80,
  //     margin: EdgeInsets.only(right: 10, top: 20, bottom: 10),
  //     child: Column(
  //       children: [
  //         Text("เลือกรูปภาพ"),
  //         SizedBox(
  //           height: 10.0,
  //         ),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: <Widget>[
  //             TextButton.icon(
  //                 onPressed: () {
  //                   _getImage(ImageSource.camera);
  //                 },
  //                 icon: Icon(
  //                   Icons.camera_alt,
  //                   color: Colors.green,
  //                 ),
  //                 label: Text(
  //                   "Camera",
  //                   style: TextStyle(color: Colors.black),
  //                 )),
  //             TextButton.icon(
  //                 onPressed: () {
  //                   _getImage(ImageSource.gallery);
  //                 },
  //                 icon: Icon(Icons.image, color: Colors.green),
  //                 label: Text(
  //                   "Gallery",
  //                   style: TextStyle(color: Colors.black),
  //                 )),
  //           ],
  //         )
  //       ],
  //     ),
  //   );
  // }
}
