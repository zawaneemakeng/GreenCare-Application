import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rotnaam/pages/intro_screens/onboarding_screen.dart';
import 'package:rotnaam/pages/material.dart';
import 'package:rotnaam/pages/user_manage/register.dart';
import 'package:rotnaam/pages/user_manage/forgot_password.dart';
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
                            builder: (context) => OnboardingScreen()),
                      );
                    },
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade400.withAlpha(80),
                          spreadRadius: 0,
                          blurRadius: 20,
                          offset: const Offset(10, 0),
                        ),
                      ],
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset(
                      'assets/logo.png',
                      height: 120.0,
                      width: 120.0,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
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
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(bottom: 15, top: 10),
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
                            child: TextField(
                              controller: email,
                              decoration: const InputDecoration(
                                prefixIcon: Icon(
                                  Icons.email,
                                  color: Colors.teal,
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
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 270,
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
                                    color: Colors.grey,
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
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
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
                                child: const Text('ลืมรหัสผ่าน',
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
                                content:
                                    const Text('กรุณากรอกข้อมูลให้ครบถ้วน'),
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
                            backgroundColor: Colors.teal,
                            fixedSize: const Size(200, 20),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50)),
                          ),
                          child: const Text(
                            'Login',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5, bottom: 10),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegisterPage()),
                            );
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("หากยังไม่มีบัญชี",
                                  style: TextStyle(fontSize: 12)),
                              Text(
                                'กดลงทะเบียน',
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                              Text("ที่นี่", style: TextStyle(fontSize: 12)),
                            ],
                          ),
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
      int userID = result_json['user'];
      String fname = result_json['first_name'];
      String token = result_json['token']; //ดึง
      String profileImg = result_json['profile_img']; //ดึง

      setToken(token); //เมื่อได้รับ tokenเเล้วให้บันทึกในระบบ
      setUserInfo(fname);
      setuserID(userID);
      setProfile(profileImg);
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

  void setProfile(profileImg) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('profile_img', profileImg);
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

  void setnewImg() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final checkvalue = pref.get('profile_img') ?? 0;
    if (checkvalue == 0) {
      await pref.setString('profile_img', "/media/profile/default/user.png");
    }
  }
}
