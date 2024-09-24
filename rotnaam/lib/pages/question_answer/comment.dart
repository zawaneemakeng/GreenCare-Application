import 'package:flutter/material.dart';
import 'package:rotnaam/pages/question_answer/update_comment.dart';
import 'package:rotnaam/utils/api_url.dart';
import 'package:rotnaam/utils/custom.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Comment extends StatefulWidget {
  final id, question, name, date, profilePost;
  Comment(
      {super.key,
      required this.id,
      required this.question,
      required this.name,
      required this.date,
      this.profilePost});

  @override
  State<Comment> createState() => _CommentState();
}

class _CommentState extends State<Comment> {
  List commuList = [];
  List comentItem = [];
  int? userID;
  var commentCtrl = TextEditingController();
  var _id, _question, _name, _date, _profilePost;
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
    _profilePost = widget.profilePost;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.only(top: 30, left: 10),
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
        const SizedBox(
          height: 15.0,
        ),
        showPostWidget(),
        const Padding(
          padding: EdgeInsets.only(top: 10),
          child: Text(
            "คอมเมนท์ทั้งหมด",
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
        ),
        showCommentWidget(),
      ]),
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
                padding: const EdgeInsets.only(left: 12, right: 12, top: 10),
                decoration: const BoxDecoration(
                  color: Color(0xffE6E6E6),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: NetworkImage(
                                  "http://${host()}${comentItem[reversedIndex]['profile_img']}"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 8,
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
                      ],
                    ),
                    userID == comentItem[reversedIndex]['user']
                        ? IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => UpdateCommment(
                                            id: comentItem[reversedIndex]['id'],
                                            post: comentItem[reversedIndex]
                                                ['answer'],
                                          ))).then(
                                (value) {
                                  //.then ตือให้ทำอะไรถ้ากลับมา
                                  setState(() {
                                    check();
                                    print(value);
                                    if (value == 'update') {
                                      final snackBar = SnackBar(
                                        content: const Text('เเก้ไขเรียบร้อย'),
                                        action: SnackBarAction(
                                          label: 'ปิด',
                                          onPressed: () {},
                                        ),
                                      );
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                    } else if (value == 'delete') {
                                      final snackBar = SnackBar(
                                        content: const Text('ลบเรียบร้อย'),
                                        action: SnackBarAction(
                                          label: 'ปิด',
                                          onPressed: () {},
                                        ),
                                      );
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                    }
                                  });
                                },
                              );
                            },
                            icon: Icon(Icons.edit_note))
                        : const Text("")
                  ],
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Container(
                width: 500,
                margin: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                padding: const EdgeInsets.only(left: 12, right: 12),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                  color: Color(0xffE6E6E6),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      comentItem[reversedIndex]['answer'],
                    ),
                    const SizedBox(
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

  Widget showCommentWidget() {
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
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.comment_rounded,
                            size: 70,
                            color: Colors.teal,
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
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: commentCtrl,
                      cursorColor: Colors.grey,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 14),
                          hintText: "เเสดงความคิดเห็น..."),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: IconButton(
                          onPressed: () {
                            if (commentCtrl.text == '') {
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
                              addComment();
                              commentCtrl.clear();
                            }
                          },
                          icon: const Icon(
                            Icons.send,
                            color: Colors.teal,
                          ))),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget showPostWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  header(_id, _question, _name, _date, _profilePost),
                  const SizedBox(
                    height: 10,
                    width: 20,
                  ),
                  Text(_question),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }

  Widget header(
      int id, String question, String name, String date, String profile) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: NetworkImage("http://${host()}$profile"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(fontSize: 16),
              ),
              Row(
                children: [
                  Text(date, style: TextStyle(color: Colors.grey[700])),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

  Future addComment() async {
    var url = Uri.http(host(), 'post-answer');
    Map<String, String> header = {"Content-type": "application/json"};
    String v1 = '"user":"$userID"';
    String v2 = '"q_id":"$_id"';
    String v3 = '"answer":"${commentCtrl.text}"';
    String v4 = '"date":"${formattedDateTime()}"';
    String jsondata = '{$v1,$v2,$v3,$v4}';
    var response = await http.post(url, headers: header, body: jsondata);
    print('--------result--------');
    print(response.body);
    setState(() {
      getAnswer();
    });
  }

  Future getAnswer() async {
    var url = Uri.http(host(), 'get-answer/$_id/');
    var response = await http.get(url);
    var result = utf8.decode(response.bodyBytes);
    setState(() {
      comentItem = json.decode(result);
      print(comentItem);
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
      getAnswer();
    });
  }
}
