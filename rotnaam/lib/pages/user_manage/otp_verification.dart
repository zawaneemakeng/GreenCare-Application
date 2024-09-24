// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:rotnaam/pages/user_manage/reset_new_password.dart';
import 'package:rotnaam/utils/api_url.dart';
import 'package:rotnaam/utils/custom.dart';

class OTP extends StatefulWidget {
  final String email;
  final int id;

  OTP({Key? key, required this.email, required this.id}) : super(key: key);

  @override
  State<OTP> createState() => _OTPState();
}

class _OTPState extends State<OTP> {
  List optuserItem = [];
  var otp1 = TextEditingController();
  var otp2 = TextEditingController();
  var otp3 = TextEditingController();
  var otp4 = TextEditingController();
  var last_userotp;
  var _email;
  var _id;
  int? userID;
  String result = '';
  @override
  void initState() {
    super.initState();
    _email = widget.email;
    _id = widget.id;
    print('${_id}');
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
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
            'assets/img_otp.png',
            width: 150,
            height: 150,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              height: 250,
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
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'กรุณาตรวจสอบเลข OTP ที่อีเมล์',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          _email,
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w800),
                        ),
                        const SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                    Form(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _textFormFieldOTP(otp1),
                          _textFormFieldOTP(otp2),
                          _textFormFieldOTP(otp3),
                          _textFormFieldOTP(otp4)
                        ],
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: ElevatedButton(
                          onPressed: () {
                            if (otp1.text == '' ||
                                otp2.text == '' ||
                                otp3.text == '' ||
                                otp4.text == '') {
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
                              otp();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.teal,
                              fixedSize: const Size(200, 20),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50))),
                          child: const Text(
                            'ส่ง',
                            style: TextStyle(color: Colors.white),
                          ),
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
    );
  }

  Widget _textFormFieldOTP(otpnum) {
    return SizedBox(
      width: 65,
      height: 65,
      child: TextFormField(
        controller: otpnum,
        showCursor: false,
        readOnly: false,
        textAlign: TextAlign.center,
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
        },
        keyboardType: TextInputType.number,
        inputFormatters: [LengthLimitingTextInputFormatter(1)],
        style: TextStyle(color: Color(0xff3AAA94), fontSize: 26),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(top: 10),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: Colors.black12),
              borderRadius: BorderRadius.circular(12)),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: Colors.teal),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  Future otp() async {
    var url = Uri.http(host(), "${otppassword()}/${_id}");
    Map<String, String> header = {"Content-type": "application/json"};
    String value = '"otp":"${otp1.text}${otp2.text}${otp3.text}${otp4.text}"';
    String jsondata = '{$value}';
    var response = await http.post(url, headers: header, body: jsondata);
    print('--------result--------');
    print(response.body);
    var resulttext = utf8.decode(response.bodyBytes);
    var result_json = json.decode(resulttext);

    String status = result_json['status'];

    if (status == 'otp-success') {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => ResetNewPassword(
                    email: _email,
                    id: _id,
                  )));
    } else if (status == 'otp-doesnot') {
      final snackBar = SnackBar(
        backgroundColor: SnackBarColor.bgcolor,
        content: Text('OTP ไม่ถูกต้อง หรือ\nไม่ใช่ OTP ครั้งล่าสุด'),
        action: SnackBarAction(
          label: 'รับทราบ',
          onPressed: () {},
        ),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
