import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  File? _image;

  Future _getImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      // final imageTemporary = File(image.path);
      final imagePermanant = await saveFilePermanently(image.path);
      setState(() {
        this._image = imagePermanant;
      });
    } on PlatformException catch (e) {
      print(e);
    }
  }

  Future<File> saveFilePermanently(String imagePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = basename(imagePath);
    final image = File('${directory.path}/$name');
    print(name);
    return File(imagePath).copy(image.path);
  }

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
          child: Column(children: [
            SizedBox(
              height: 40,
            ),
            _image != null
                ? Image.file(
                    _image!,
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  )
                : Image.network(
                    "https://cdn-icons-png.flaticon.com/512/3607/3607444.png",
                    width: 200,
                    height: 200,
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
