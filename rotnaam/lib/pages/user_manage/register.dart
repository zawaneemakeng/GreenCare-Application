import 'package:flutter/material.dart';
import 'package:rotnaam/pages/user_manage/login.dart';
import 'package:rotnaam/utils/api_url.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:rotnaam/utils/custom.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  var fname = TextEditingController();
  var email = TextEditingController();
  var phonenumber = TextEditingController();
  var password = TextEditingController();
  var password2 = TextEditingController();
  String? result;
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
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
            Row(
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
            const SizedBox(
              height: 20,
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
                        padding: EdgeInsets.only(bottom: 20, top: 10),
                        child: Text(
                          'ลงทะเบียน',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 270,
                            child: TextField(
                              controller: fname,
                              cursorColor: Colors.grey,
                              style: const TextStyle(
                                color: Colors.black54,
                              ),
                              decoration: const InputDecoration(
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: Colors.teal,
                                ),
                                hintText: 'ชื่อ',
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
                        height: 5,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 270,
                            child: TextField(
                              controller: email,
                              cursorColor: Colors.grey,
                              style: const TextStyle(
                                color: Colors.black54,
                              ),
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
                        height: 10,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 240,
                            child: TextField(
                              controller: password2,
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
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: ElevatedButton(
                          onPressed: () {
                            if (fname.text == '' &&
                                phonenumber.text == '' &&
                                email.text == '' &&
                                password.text == '' &&
                                password2.text == '') {
                              final snackBar = SnackBar(
                                backgroundColor: Colors.grey[600],
                                content:
                                    const Text('กรุณากรอกข้อมูลให้ครบถ้วน'),
                                action: SnackBarAction(
                                  label: 'รับทราบ',
                                  onPressed: () {},
                                ),
                              );

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            } else if (password.text != password2.text) {
                              final snackBar = SnackBar(
                                backgroundColor: Colors.grey[600],
                                content: const Text('รหัสผ่านทั้งสองไม่ตรงกัน'),
                                action: SnackBarAction(
                                  label: 'รับทราบ',
                                  onPressed: () {},
                                ),
                              );

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            } else {
                              registernewuser();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.teal,
                              fixedSize: const Size(200, 20),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50))),
                          child: const Text(
                            'ลงทะเบียน',
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
                                  builder: (context) => const LoginPage()),
                            );
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("ต้องการ", style: TextStyle(fontSize: 12)),
                              Text(
                                'ล็อกอิน',
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                              Text("กดที่นี่", style: TextStyle(fontSize: 12)),
                            ],
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

  Future registernewuser() async {
    var url = Uri.http(host(), register());
    Map<String, String> header = {"Content-type": "application/json"};
    String v1 = '"username":"${email.text}"';
    String v2 = '"email":"${email.text}"';
    String v3 = '"first_name":"${fname.text}"';
    String v4 = '"password":"${password.text}"';
    String jsondata = '{$v1,$v2,$v3,$v4}';
    var response = await http.post(url, headers: header, body: jsondata);
    print('--------result--------');
    print(response.body);

    var resulttext = utf8.decode(response.bodyBytes);
    var resultjson = json.decode(resulttext);

    String status = resultjson['status'];

    if (status == 'user_created') {
      setState(() {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => const LoginPage()));
      });
    } else if (status == 'user-exist') {
      String setresult = 'อีเมล์นี้เป็นสมาชิกเรียบร้อยเเล้ว';
      setState(() {
        result = setresult;
        final snackBar = SnackBar(
          backgroundColor: Colors.grey[600],
          content: const Text('คุณเป็นสมาชิกเรียบร้อยเเล้ว'),
          action: SnackBarAction(
            label: 'รับทราบ',
            onPressed: () {},
          ),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      });
    } else {
      String setresult = 'ข้อมูลไม่ถูกต้อง';
      setState(() {
        result = setresult;
        final snackBar = SnackBar(
          backgroundColor: Colors.grey[600],
          content: const Text('ข้อมูลไม่ถูกต้อง'),
          action: SnackBarAction(
            label: 'รับทราบ',
            onPressed: () {},
          ),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      });
    }
  }
}
