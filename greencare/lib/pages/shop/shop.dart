import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:greencare/utils/api_url.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';

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
                width: 130,
                height: 130,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 1),
                  shape: BoxShape.circle,
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
