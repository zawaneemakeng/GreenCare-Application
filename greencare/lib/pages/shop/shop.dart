import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(children: [imageProfile()]),
      ),
    );
  }

  Widget imageProfile() {
    return Center(
      child: Stack(children: <Widget>[
        CircleAvatar(
          radius: 80,
          backgroundImage: AssetImage("assets/icons/windspeed.png"),
        ),
        Positioned(
            bottom: 20,
            right: 25,
            child: InkWell(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: ((builder) => bottomSheet()),
                    backgroundColor: Colors.white,
                  );
                },
                child: Icon(Icons.camera_alt, color: Colors.grey, size: 26.0)))
      ]),
    );
  }

  Widget bottomSheet() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 80,
      margin: EdgeInsets.only(right: 10, top: 20, bottom: 10),
      child: Column(
        children: [
          Text("เลือกรูปภาพ"),
          SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextButton.icon(
                  onPressed: () {},
                  icon: Icon(
                    Icons.camera_alt,
                    color: Colors.green,
                  ),
                  label: Text(
                    "Camera",
                    style: TextStyle(color: Colors.black),
                  )),
              TextButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.image, color: Colors.green),
                  label: Text(
                    "Gallery",
                    style: TextStyle(color: Colors.black),
                  )),
            ],
          )
        ],
      ),
    );
  }
}
