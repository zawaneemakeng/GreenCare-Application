import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:rotnaam/utils/api_url.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lottie/lottie.dart';

class UpdateCommment extends StatefulWidget {
  final post;
  final id;
  const UpdateCommment({super.key, this.post, this.id});

  @override
  State<UpdateCommment> createState() => _UpdateCommmentState();
}

class _UpdateCommmentState extends State<UpdateCommment> {
  var c = TextEditingController();
  String? _post;
  int? _id;
  int? userID;
  String? profileImg;

  @override
  void initState() {
    // TODO: implemnt initState
    super.initState();
    check();
    _post = widget.post;
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
                      deleteComment(_id!);
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
                            const Text("ลบคอมเม้นท์"),
                          ],
                        ),
                      )),
                ),
              ],
            ),
            const Text(
              "เเก้ไขคอมเม้นท์",
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
                          padding: const EdgeInsets.only(
                            top: 10,
                          ),
                          child: TextField(
                            controller: c,
                            decoration:
                                InputDecoration.collapsed(hintText: _post!),
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
                      const Divider(
                        thickness: 0.5,
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
    final String apiUrl = 'http://${host()}/patch-answer/$_id';
    final Map<String, dynamic> dataToUpdate = {
      'answer': c.text,
    };

    final response = await http.patch(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(dataToUpdate),
    );
    setState(() {
      print(response.body);
      Navigator.pop(context, 'update');
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

  Future deleteComment(int id) async {
    var url = Uri.http(host(), '/delete-answer/$id');
    Map<String, String> header = {"Content-type": "application/json"};
    var response = await http.delete(url, headers: header);
    print(response);
    setState(() {
      Navigator.pop(context, 'delete');
    });
  }
}
