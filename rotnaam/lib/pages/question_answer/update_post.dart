import 'package:flutter/material.dart';
import 'package:rotnaam/utils/api_url.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';

class UpdatePost extends StatefulWidget {
  final question;
  final id;
  const UpdatePost({super.key, this.question, this.id});

  @override
  State<UpdatePost> createState() => _UpdatePostState();
}

class _UpdatePostState extends State<UpdatePost> {
  var postCtrl = TextEditingController();
  var _qustion;
  var _id;
  int? userID;
  String? profileImg;

  @override
  void initState() {
    super.initState();
    check();
    _qustion = widget.question;
    _id = widget.id;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Image.asset('assets/back.png', height: 35, width: 35),
                  iconSize: 50,
                  onPressed: () {
                    Navigator.pop(context, 'refresh');
                  },
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      deleteQuestion(_id);
                    });
                  },
                  child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(50)),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          children: [
                            Icon(Icons.delete_rounded, color: Colors.red[400]),
                            const Text("ลบโพสต์"),
                          ],
                        ),
                      )),
                ),
              ],
            ),
            const Text(
              "เเก้ไขโพสต์ของคุณ",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
              ),
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.only(left: 12, right: 12),
                  child: Row(
                    children: [
                      profileImg != null
                          ? Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: NetworkImage(
                                      "http://${host()}$profileImg"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                          : Center(
                              child: Lottie.asset(
                                  'assets/animations/animation_lkuv6jxa.json',
                                  width: 40,
                                  height: 40),
                            ),
                      const SizedBox(
                        width: 10,
                        height: 50,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: TextField(
                            controller: postCtrl,
                            decoration:
                                InputDecoration.collapsed(hintText: _qustion),
                            maxLines: 2,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Divider(
                    thickness: 0.5,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 5, top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          patchData();
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
                    ],
                  ),
                )
              ]),
            )
          ],
        ),
      ),
    );
  }

  void patchData() async {
    final String apiUrl = 'http://${host()}/patch-question/$_id';
    final Map<String, dynamic> dataToUpdate = {
      'question': postCtrl.text,
    };
    final response = await http.patch(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(dataToUpdate),
    );
    setState(() {
      Navigator.pop(context, 'update');
    });
  }

  Future deleteQuestion(int _id) async {
    var url = Uri.http(host(), '/delete-question/$_id');
    Map<String, String> header = {"Content-type": "application/json"};
    var response = await http.delete(url, headers: header);
    print('--------result--------');

    var resulttext = utf8.decode(response.bodyBytes);

    setState(() {
      Navigator.pop(context, 'delete');
    });
  }

  void check() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final checkvalue = pref.get('user') ?? 0;
    if (checkvalue != 0) {
      getUserProfile();
    }
  }

  void getUserProfile() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      var user = pref.getInt('user');
      userID = user;
      var profile = pref.getString('profile_img');
      profileImg = profile;
    });
  }
}
