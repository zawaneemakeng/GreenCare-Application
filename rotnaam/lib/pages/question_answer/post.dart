import 'package:flutter/material.dart';
import 'package:rotnaam/pages/question_answer/comment.dart';
import 'package:rotnaam/pages/question_answer/update_post.dart';
import 'package:rotnaam/utils/api_url.dart';
import 'package:rotnaam/utils/custom.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';

class CommunityPage extends StatefulWidget {
  const CommunityPage({super.key});

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  List postItems = [];
  List comentItem = [];
  int? userID;
  var postCtrl = TextEditingController();
  String? profileImg;
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
    DateTime now = DateTime.now();
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
    super.initState();
    check();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: post(),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 10),
            child: Text(
              "โพสต์ล่าสุด",
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ),
          postTailWidget()
        ],
      ),
    );
  }

  Widget post() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
      ),
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.only(left: 12, right: 12),
          child: Row(
            children: [
              profileImg != null
                  ? Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage("http://${host()}$profileImg"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  : Center(
                      child: Lottie.asset(
                          'assets/animations/animation_lkuv6jxa.json',
                          width: 120,
                          height: 120),
                    ),
              const SizedBox(
                width: 10,
                height: 90,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: TextField(
                    controller: postCtrl,
                    decoration: const InputDecoration.collapsed(
                        hintText: 'โพสต์คำถามของคุณ'),
                    maxLines: 2,
                  ),
                ),
              ),
            ],
          ),
        ),
        const Divider(
          thickness: 0.5,
        ),
        Padding(
          padding: const EdgeInsets.only(right: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                width: 125,
                height: 30,
                child: ElevatedButton(
                  onPressed: () {
                    if (postCtrl.text == '') {
                      final snackBar = SnackBar(
                        backgroundColor: SnackBarColor.bgcolor,
                        content: const Text('กรุณากรอกข้อมูลให้ครบถ้วน'),
                        action: SnackBarAction(
                          label: 'รับทราบ',
                          onPressed: () {},
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else {
                      addPost();
                      postCtrl.clear();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      fixedSize: const Size(100, 10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40))),
                  child: const Text(
                    'โพสต์',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const Divider(
                thickness: 0.5,
              ),
            ],
          ),
        )
      ]),
    );
  }

  Widget postTailWidget() {
    return Expanded(
      child: ListView.builder(
        itemCount: postItems.length.clamp(0, 10),
        itemBuilder: (context, index) {
          final reversedIndex = postItems.length - 1 - index;
          return Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: BoxColor.color,
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
                        header(
                          postItems[reversedIndex]['id'],
                          "${postItems[reversedIndex]['question']}",
                          "${postItems[reversedIndex]['name']}",
                          "${postItems[reversedIndex]['date']}",
                          postItems[reversedIndex]['user'],
                          "${postItems[reversedIndex]['profile_img']}",
                        ),
                        const SizedBox(
                          height: 10,
                          width: 20,
                        ),
                        Text("${postItems[reversedIndex]['question']}"),
                        const SizedBox(
                          height: 5,
                        )
                      ],
                    ),
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: commentButton(
                              postItems[reversedIndex]['id'],
                              postItems[reversedIndex]['question'],
                              postItems[reversedIndex]['name'],
                              postItems[reversedIndex]['date'],
                              "${postItems[reversedIndex]['profile_img']}")),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget header(int id, String question, String name, String date, int user,
      String profile) {
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
        userID == user
            ? IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UpdatePost(
                                id: id,
                                question: question,
                              ))).then(
                    (value) {
                      //.then ตือให้ทำอะไรถ้ากลับมา
                      setState(
                        () {
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
                        },
                      );
                    },
                  );
                },
                icon: const Icon(Icons.edit_note))
            : const Text("")
      ],
    );
  }

  Widget commentButton(
      int id, String question, String name, String date, String profile) {
    return SizedBox(
      width: 120,
      height: 30,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Comment(
                        id: id,
                        question: question,
                        name: name,
                        date: date,
                        profilePost: profile,
                      )));
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.teal,
            fixedSize: const Size(30, 10),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30))),
        child: const Text(
          'คอมมเมนท์',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Future addPost() async {
    var url = Uri.http(host(), 'post-question');
    Map<String, String> header = {"Content-type": "application/json"};
    String v1 = '"user":"$userID"';
    String v2 = '"question":"${postCtrl.text}"';
    String v3 = '"date":"${formattedDateTime()}"';
    String jsondata = '{$v1,$v2,$v3}';
    var response = await http.post(url, headers: header, body: jsondata);
    print(response.body);
    setState(() {
      getPost();
    });
  }

  void check() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final checkvalue = pref.get('user') ?? 0;
    if (checkvalue != 0) {
      getUsernameProfile();
    }
  }

  void getUsernameProfile() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      var username = pref.getInt('user');
      userID = username;
      var profile = pref.getString('profile_img');
      profileImg = profile;
      print(profileImg);
      getPost();
    });
  }

  Future getPost() async {
    var url = Uri.http(host(), 'get-question/');
    var response = await http.get(url);
    // var result = json.decode(response.body);
    var result = utf8.decode(response.bodyBytes);
    setState(() {
      postItems = json.decode(result);
      print(postItems);
    });
  }
}
