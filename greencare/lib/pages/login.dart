import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rotnaam/pages/intro_screens/onboarding_screen.dart';
import 'package:rotnaam/pages/material.dart';
import 'package:rotnaam/pages/user_manage/register.dart';
import 'package:rotnaam/pages/user_manage/reset_password.dart';
import 'package:rotnaam/utils/api_url.dart';
import 'package:rotnaam/utils/custom.dart';
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

  var _isObscured;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isObscured = true;
  }

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
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff3AAA94)),
                          text: "ยินดีต้อนรับ",
                          children: [
                            TextSpan(
                                text: '''
                  
 การกลับมา''',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.grey[700]))
                          ]),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
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
                          'เข้าสู่ระบบ',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 285,
                            height: 50,
                            child: TextField(
                              controller: email,
                              cursorColor: Colors.grey,
                              style: TextStyle(
                                color: Colors.grey[200],
                              ),
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.email,
                                  color: Colors.grey,
                                ),
                                hintText: 'อีเมล์',
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
                        height: 5,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 239,
                            child: TextField(
                              obscureText: _isObscured,
                              controller: password,
                              cursorColor: Colors.grey,
                              style: const TextStyle(
                                color: Colors.black54,
                              ),
                              decoration: const InputDecoration(
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: IconColor.color,
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
                            if (email.text == '' || password.text == '') {
                              final snackBar = SnackBar(
                                backgroundColor: SnackBarColor.bgcolor,
                                content: Text('กรุณากรอกข้อมูลให้ครบถ้วน'),
                                action: SnackBarAction(
                                  label: 'รับทราบ',
                                  onPressed: () {},
                                ),
                              );

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            } else {
                              login();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: ButtonColor.bgcolor,
                              fixedSize: const Size(200, 20),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50))),
                          child: const Text(
                            'Login',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("หากยังไม่มีบัญชี",
                                style: TextStyle(fontSize: 12)),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RegisterPage()),
                                );
                              },
                              child: Text(
                                'ลงทะเบียน',
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Text("ที่นี่", style: TextStyle(fontSize: 12)),
                          ],
                        ),
                      ),
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
    var url = Uri.http(host(), authen());
    Map<String, String> header = {"Content-type": "application/json"};
    String v1 = '"email":"${email.text}"';
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
      int userID = result_json['user'];
      String fname = result_json['first_name'];
      String token = result_json['token']; //ดึง
      setToken(token); //เมื่อได้รับ tokenเเล้วให้บันทึกในระบบ
      setUserInfo(fname);
      setuserID(userID);
      //ไปยังหน้าใหม่เเเบบไม่ย้อน ไม่มีลูกศร
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => const HomePage()));
    } else if (status == 'email-doesnot-exist') {
      setState(() {
        final snackBar = SnackBar(
          backgroundColor: SnackBarColor.bgcolor,
          content: Text('อีเมลนี้ไม่มีในระบบกรุณาลงทะเบียน'),
          action: SnackBarAction(
            label: 'รับทราบ',
            onPressed: () {},
          ),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      });
    } else if (status == 'password-wrong') {
      setState(() {
        final snackBar = SnackBar(
          backgroundColor: SnackBarColor.bgcolor,
          content: Text('รหัสผ่านไม่ถูกต้อง'),
          action: SnackBarAction(
            label: 'รับทราบ',
            onPressed: () {},
          ),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      });
    }
  }

  void setToken(token) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('token', token);
  }

  void setUserInfo(f_name) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('first_name', f_name);
  }

  void setuserID(usrid) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt('user', usrid);
    print(pref.setInt('user', usrid));
  }
}
