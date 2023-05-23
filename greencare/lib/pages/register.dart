import 'package:flutter/material.dart';
import 'package:greencare/pages/home..dart';
import 'package:greencare/pages/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';

class RegisterPage extends StatefulWidget {
  RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  var email = TextEditingController();
  var password = TextEditingController();
  var first_name = TextEditingController();
  var last_name = TextEditingController();
  var phone_number = TextEditingController();

  String result = "------Result------";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFEFEFEF),
      ),
      body: Center(
        child: ListView(
          children: [
            Image.asset('assets/smartfarm2.png', width: 200, height: 200),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                height: 470,
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
                          'Register Here ',
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
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Container(
                            width: 285,
                            child: TextField(
                              controller: first_name,
                              obscureText: true,
                              cursorColor: Colors.grey,
                              style: TextStyle(
                                color: Colors.black54,
                              ),
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: Color.fromARGB(255, 93, 93, 93),
                                ),
                                hintText: 'Name',
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
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Container(
                            width: 285,
                            child: TextField(
                              controller: last_name,
                              obscureText: true,
                              cursorColor: Colors.grey,
                              style: TextStyle(
                                color: Colors.black54,
                              ),
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: Color.fromARGB(255, 93, 93, 93),
                                ),
                                hintText: 'Last Name',
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
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Container(
                            width: 285,
                            child: TextField(
                              controller: phone_number,
                              obscureText: true,
                              cursorColor: Colors.grey,
                              style: TextStyle(
                                color: Colors.black54,
                              ),
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.phone,
                                  color: Color.fromARGB(255, 93, 93, 93),
                                ),
                                hintText: 'Phone Number',
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
                                      builder: (context) => const LoginPage()),
                                );
                              },
                              child: Text(
                                'มีบัญชีเเล้ว',
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: ElevatedButton(
                          onPressed: () {
                            register_newuser();
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) => const HomePage()),
                            // );
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xff3AAA94),
                              fixedSize: const Size(130, 20),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50))),
                          child: const Text(
                            'Register',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
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
    );
  }

  Future register_newuser() async {
    var url = Uri.http('000000:8000', 'api/newuser');
    Map<String, String> header = {"Content-type": "application/json"};
    String v1 = '"username":"${email.text}"';
    String v2 = '"password":"${password.text}"';
    String v3 = '"first_name":"${first_name.text}"';
    String v4 = '"last_name":"${last_name.text}"';
    String v5 = '"mobile":"${phone_number.text}"';
    String jsondata = '{$v1,$v2,$v3,$v4,$v5}';
    var response = await http.post(url, headers: header, body: jsondata);
    print('--------result--------');
    print(response.body);

    var resulttext = utf8.decode(response.bodyBytes);
    var result_json = json.decode(resulttext);

    String status = result_json['status'];

    if (status == 'user_created') {
      String t1 = result_json['first_name'];
      String t2 = result_json['last_name'];
      String token = result_json['token']; //ดึง
      setToken(token); //เมื่อได้รับ tokenเเล้วให้บันทึกในระบบ
      String setresult = 'ยินดีด้วย คุณ $t1 $t2\n คุณได้สมัคสมาชิกเรียบร้อย';
      setState(() {
        result = setresult;
      });
    } else if (status == 'user-exist') {
      String setresult = 'คุณเป็นสมาชิกเรียบร้อยเเล้ว';
      setState(() {
        result = setresult;
      });
    } else {
      String setresult = 'ข้อมูลไม่ถูกต้อง';
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
}
