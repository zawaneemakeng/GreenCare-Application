import 'package:flutter/material.dart';
import 'package:greencare/pages/home.dart';
import 'package:greencare/pages/onboarding_screen.dart';
import 'package:greencare/pages/register.dart';
import 'package:greencare/pages/reset_password.dart';
import 'package:greencare/utils/api_url.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var email = TextEditingController();
  var password = TextEditingController();
  String result = "----------";
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OnBoardScreen()),
                      );
                    },
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Text.rich(
                      TextSpan(
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                          text: "ยินดีต้อนรับ",
                          children: [
                            TextSpan(text: '''
                  
 การกลับมา''', style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic))
                          ]),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Image.asset('assets/plant.png', width: 80, height: 80),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                height: 320,
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
                          'Login here ',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
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
                                hintText: 'example@gmail.com',
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Divider(
                          height: 1,
                          color: Colors.grey,
                          thickness: 1,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Container(
                            width: 285,
                            child: TextField(
                              controller: password,
                              obscureText: true,
                              cursorColor: Colors.grey,
                              style: TextStyle(
                                color: Colors.black54,
                              ),
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.password,
                                  color: Color.fromARGB(255, 93, 93, 93),
                                ),
                                hintText: 'password',
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
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RegisterPage()),
                                );
                              },
                              child: Text(
                                'ยังไม่มีบัญชี',
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                            GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ResetPasswordPage()),
                                  );
                                },
                                child: Text('ลืมรหัสผ่าน',
                                    style: TextStyle(fontSize: 12))),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: ElevatedButton(
                          onPressed: () {
                            login();
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xff3AAA94),
                              fixedSize: const Size(130, 20),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50))),
                          child: const Text(
                            'Login',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      Text(
                        result,
                        style: TextStyle(fontSize: 20, color: Colors.pink),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future login() async {
    // var url = Uri.https('abcd.ngrok.io', '/api/post-todolist');
    var url = Uri.http(urlH(), apiAuth());
    Map<String, String> header = {"Content-type": "application/json"};

    String v1 = '"username":"${email.text}"';
    String v2 = '"password":"${password.text}"';

    String jsondata = '{$v1,$v2}';
    var response = await http.post(url, headers: header, body: jsondata);
    print('--------result--------');
    print(response.body);

    var resulttext = utf8.decode(response.bodyBytes);
    var result_json = json.decode(resulttext);

    String status = result_json['status'];

    if (status == 'login-success') {
      // String user = result_json['username'];
      String email_auth = result_json['username'];
      String token = result_json['token']; //ดึง
      setToken(token); //เมื่อได้รับ tokenเเล้วให้บันทึกในระบบ
      setUserInfo(email_auth);
      //ไปยังหน้าใหม่เเเบบไม่ย้อน ไม่มีลูกศร
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => HomePage()));
    } else if (status == 'login-failed') {
      String setresult = 'เข้าสุ่ระบบไม่สำเร็จ';
      setState(() {
        result = setresult;
      });
    } else {
      String setresult = 'กรุณาลองอีกครั้ง';
      setState(() {
        result = setresult;
      });
    }
  }

  //auth
  void setToken(token) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('token', token);
  }

  void setUserInfo(usr) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();

    pref.setString('username', usr);
  }
}
