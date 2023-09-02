import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:rotnaam/utils/api_url.dart';
import 'package:rotnaam/utils/custom.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:readmore/readmore.dart';

class Comment extends StatefulWidget {
  final id, question, name, date;
  Comment(
      {super.key,
      required this.id,
      required this.question,
      required this.name,
      required this.date});

  @override
  State<Comment> createState() => _CommentState();
}

class _CommentState extends State<Comment> {
  List commuList = [];
  List comentItem = [];
  int? userID;
  var sendcomment = TextEditingController();
  var _id, _question, _name, _date;
  List<String> months = [
    "ม.ค.",
    "ก.พ.",
    "มี.ค.",
    "เม.ย.",
    "พ.ค.",
    "มิ.ย.",
    "ก.ค.",
    "ส.ค.",
    "ก.ย.",
    "ต.ค.",
    "พ.ย.",
    "ธ.ค."
  ];
  String formattedDateTime() {
    DateTime now = new DateTime.now();
    return now.day.toString() +
        " " +
        months[now.month - 1] +
        " " +
        (now.year + 543).toString() +
        " " +
        now.hour.toString() +
        ":" +
        now.minute.toString();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    check();
    _id = widget.id;
    _question = widget.question;
    _name = widget.name;
    _date = widget.date;
    print(_id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 10),
            child: Row(
              children: [
                IconButton(
                  icon: Image.asset('assets/back.png', height: 35, width: 35),
                  iconSize: 50,
                  onPressed: () {
                    Navigator.pop(context, 'refresh');
                  },
                ),
              ],
            ),
          ),

          //
          SizedBox(
            height: 20.0,
          ),
          showq(),
          SizedBox(
            height: 20.0,
          ),
          comment(),
        ]),
      ),
    );
  }

  Widget showcomment() {
    return ListView.builder(
      itemCount: comentItem.length,
      itemBuilder: (context, int index) {
        final reversedIndex = comentItem.length - 1 - index;
        return Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                padding: EdgeInsets.only(left: 12, right: 12, top: 10),
                decoration: BoxDecoration(
                  color: Color(0xffE6E6E6),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            'assets/user.png',
                            width: 30,
                            height: 30,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                comentItem[reversedIndex]['name'],
                                style: TextStyle(fontSize: 12),
                              ),
                              Text(
                                comentItem[reversedIndex]['date'],
                                style: TextStyle(
                                    color: Colors.grey[600], fontSize: 10),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 99,
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.edit_note,
                                size: 25,
                              ))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                width: 500,
                margin: EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                padding: EdgeInsets.only(left: 12, right: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                  color: Color(0xffE6E6E6),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ReadMoreText(comentItem[reversedIndex]['answer'],
                        trimLines: 3,
                        colorClickableText: Colors.pink,
                        trimMode: TrimMode.Line,
                        trimCollapsedText: 'เพิ่มเติม',
                        trimExpandedText: '  ปิด',
                        moreStyle: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                        lessStyle: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 15,
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget comment() {
    return Expanded(
      child: Stack(
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.only(bottom: 80),
              child: comentItem.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: showcomment(),
                    )
                  : Container(
                      width: 500,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.comment_rounded,
                            size: 70,
                            color: IconColor.color,
                          ),
                          Text(
                            "ยังไม่มีความคิดเห็น",
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ))),
          Positioned(
            bottom: 30,
            right: 15,
            left: 15,
            child: Container(
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: sendcomment,
                      cursorColor: Colors.grey,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 15),
                          hintText: "เเสดงความคิดเห็น..."),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: IconButton(
                          onPressed: () {
                            if (sendcomment.text == '') {
                              print('object');
                            } else {
                              addComment();
                              sendcomment.clear();
                            }
                          },
                          icon: Icon(Icons.send))),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget showq() {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8)),
      child: Column(
        children: [
          Container(
            width: 500,
            height: 70,
            padding: EdgeInsets.only(left: 12, right: 12, top: 12),
            decoration: BoxDecoration(
              color: Color(0xffE6E6E6),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Row(
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/user.png',
                        width: 40,
                        height: 40,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Text(_name),
                          Text(
                            _date,
                            style: TextStyle(
                                color: Colors.grey[600], fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 500,
            height: 100,
            padding: EdgeInsets.only(left: 12, right: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
              color: Color(0xffE6E6E6),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _question,
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future addComment() async {
    var url = Uri.http(host(), 'post-answer');
    Map<String, String> header = {"Content-type": "application/json"};
    String v1 = '"user":"${userID}"';
    String v2 = '"q_id":"${_id}"';
    String v3 = '"answer":"${sendcomment.text}"';
    String v4 = '"date":"${formattedDateTime()}"';
    String jsondata = '{$v1,$v2,$v3,$v4}';
    print(jsondata);
    var response = await http.post(url, headers: header, body: jsondata);
    print('--------result--------');
    print(response.body);
    setState(() {
      get_answer();
    });
  }

  Future get_answer() async {
    var url = Uri.http(host(), 'get-answer/${_id}/');
    var response = await http.get(url);
    // var result = json.decode(response.body);
    var result = utf8.decode(response.bodyBytes);
    setState(() {
      comentItem = json.decode(result);
      print(comentItem);
      // final reversedIndex = comentItem.length - 1;
      // print("${comentItem[reversedIndex]['answer']}");
    });
  }

  void check() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final checkvalue = pref.get('user') ?? 0;
    if (checkvalue != 0) {
      getUsername();
    }
  }

  void getUsername() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      var username = pref.getInt('user');
      userID = username;
      print(userID);
      get_answer();
    });
  }
}
