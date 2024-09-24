import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rotnaam/pages/user_manage/login.dart';
import 'dart:async';

import 'package:rotnaam/utils/api_url.dart';
import 'package:rotnaam/utils/custom.dart';

class ResetNewPassword extends StatefulWidget {
  final String email;
  final int id;
  ResetNewPassword({Key? key, required this.email, required this.id})
      : super(key: key);

  @override
  State<ResetNewPassword> createState() => _ResetNewPasswordState();
}

class _ResetNewPasswordState extends State<ResetNewPassword> {
  var newPassword1 = TextEditingController();
  var newPassword2 = TextEditingController();
  var _id;

  String result = '';
  var _isObscured;

  @override
  void initState() {
    super.initState();
    _id = widget.id;
    _isObscured = true;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                    icon: Image.asset('assets/back.png', height: 35, width: 35),
                    iconSize: 50,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                height: 300,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255),
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade400.withAlpha(80),
                      spreadRadius: 0,
                      blurRadius: 10,
                      offset: const Offset(10, 0),
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
                          'ตั้งรหัสผ่านใหม่',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 270,
                            child: TextField(
                              obscureText: _isObscured,
                              controller: newPassword1,
                              cursorColor: Colors.grey,
                              style: const TextStyle(
                                color: Colors.black54,
                              ),
                              decoration: const InputDecoration(
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: Colors.teal,
                                ),
                                hintText: 'รหัสผ่าน',
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: _isObscured
                                ? const Icon(
                                    Icons.visibility,
                                    color: IconColor.color,
                                  )
                                : const Icon(
                                    Icons.visibility_off,
                                    color: IconColor.color,
                                  ),
                            onPressed: () {
                              setState(() {
                                _isObscured = !_isObscured;
                              });
                            },
                          )
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
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 240,
                            child: TextField(
                              controller: newPassword2,
                              obscureText: _isObscured,
                              cursorColor: Colors.grey,
                              style: const TextStyle(
                                color: Colors.black54,
                              ),
                              decoration: const InputDecoration(
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: Colors.teal,
                                ),
                                hintText: 'รหัสผ่านอีกครั้ง',
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
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: ElevatedButton(
                          onPressed: () {
                            if (newPassword1.text == "" &&
                                newPassword2.text == "") {
                              final snackBar = SnackBar(
                                backgroundColor: Colors.grey[600],
                                content: Text('กรุณากรอกข้อมูลให้ครบทุกช่อง'),
                                action: SnackBarAction(
                                  label: 'รับทราบ',
                                  onPressed: () {},
                                ),
                              );

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            } else if (newPassword1.text != newPassword2.text) {
                              final snackBar = SnackBar(
                                backgroundColor: Colors.grey[600],
                                content: Text('รหัสผ่านทั้งสองไม่ตรงกัน'),
                                action: SnackBarAction(
                                  label: 'รับทราบ',
                                  onPressed: () {},
                                ),
                              );

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            } else {
                              resetnewpassword();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal,
                            fixedSize: const Size(200, 20),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50)),
                          ),
                          child: const Text(
                            'ส่ง',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future resetnewpassword() async {
    var url = Uri.http(host(), 'reset-new-password/${_id}');
    print(url);
    Map<String, String> header = {"Content-type": "application/json"};
    String p1 = '"resetpassword":"${newPassword1.text}"';
    String jsondata = '{$p1}';
    var response = await http.post(url, headers: header, body: jsondata);

    print('--------result--------');
    print(response.body);

    var resulttext = utf8.decode(response.bodyBytes);
    var result_json = json.decode(resulttext);

    String status = result_json['status'];

    if (status == 'password-changed') {
      final snackBar = SnackBar(
        backgroundColor: Colors.grey[600],
        content:
            Text('เปลี่ยนรหัสผ่านสำเร็จ\nคลิกรับทราบเพื่อเข้าสู้ระบบอีกครั้ง'),
        action: SnackBarAction(
          label: 'รับทราบ',
          onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => LoginPage()));
          },
        ),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if (status == 'password-error') {
      final snackBar = SnackBar(
        backgroundColor: Colors.grey[600],
        content: Text('กรุณาลองใหม่อีกครั้งในภายหลัง'),
        action: SnackBarAction(
          label: 'รับทราบ',
          onPressed: () {},
        ),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
