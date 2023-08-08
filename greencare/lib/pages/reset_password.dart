import 'package:flutter/material.dart';
import 'package:greencare/pages/otp_verification.dart';
import 'package:http/http.dart' as http;
import 'package:greencare/utils/api_url.dart';
import 'dart:async';
import 'dart:convert';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  var email = TextEditingController();
  String result = "------Result------";
  String? status;
  @override
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
            Image.asset(
              'assets/img_reset_password.png',
              width: 120,
              height: 120,
            ),
            // Image.asset('assets/login.png', width: 200, height: 200),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                height: 230,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255),
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(255, 255, 255, 255).withAlpha(0),
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
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: Text(
                          'กรอกอีเมล เพื่อรับรหัสยืนยัน',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            width: 285,
                            child: TextField(
                              controller: email,
                              cursorColor: Colors.grey,
                              style: TextStyle(
                                color: Colors.black54,
                              ),
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.email,
                                  color: Color.fromARGB(255, 133, 133, 133),
                                ),
                                hintText: 'อีเมล์',
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
                            email_reset();
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xff3AAA94),
                              fixedSize: const Size(130, 20),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50))),
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

  Future email_reset() async {
    // var url = Uri.https('abcd.ngrok.io', '/api/post-todolist');
    print(email.text);
    var url = Uri.http(urlH(), 'api/reset-password');
    Map<String, String> header = {"Content-type": "application/json"};
    String v1 = '"user":"${email.text}"';
    String jsondata = '{$v1}';
    var response = await http.post(url, headers: header, body: jsondata);
    print('--------result--------');
    print(response.body);
    var resulttext = utf8.decode(response.bodyBytes);
    var result_json = json.decode(resulttext);

    String status = result_json['status'];
    if (status == 'email-ok') {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => OTP(email: email.text)));
    } else if (status == 'email-doesnot') {
      final snackBar = SnackBar(
        backgroundColor: Colors.grey[400],
        content: Text('ไม่มีอีเมล์นี้ในระบบ'),
        action: SnackBarAction(
          label: 'รับทราบ',
          onPressed: () {},
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if (email.text.isEmpty) {
      final snackBar = SnackBar(
        backgroundColor: Colors.grey[400],
        content: Text('กรุณากรอกอีเมล์'),
        action: SnackBarAction(
          label: 'รับทราบ',
          onPressed: () {},
        ),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future email_auth() async {}
}
