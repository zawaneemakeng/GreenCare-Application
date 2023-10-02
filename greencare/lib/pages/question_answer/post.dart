import 'package:flutter/material.dart';
import 'package:rotnaam/pages/question_answer/comment.dart';
import 'package:rotnaam/pages/question_answer/update_post.dart';
import 'package:rotnaam/utils/api_url.dart';
import 'package:rotnaam/utils/custom.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CommunityPage extends StatefulWidget {
  const CommunityPage({super.key});

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  List postList = [];
  List comentItem = [];
  int? userID;
  var q = TextEditingController();
  var a = TextEditingController();

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
          // CommuTile(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: post(),
          ),
          posttailwidget()
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
      padding: EdgeInsets.only(top: 10, bottom: 10),
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.only(left: 12, right: 12),
          child: Row(
            children: [
              Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                      color: Color(0xff3AAA94), shape: BoxShape.circle),
                  child: const Icon(Icons.person)),
              const SizedBox(
                width: 10,
                height: 50,
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: TextField(
                    controller: q,
                    decoration: InputDecoration.collapsed(
                        hintText: 'คุณต้องการถามอะไร'),
                    maxLines: 2,
                  ),
                ),
              ),
            ],
          ),
        ),
        Divider(
          thickness: 0.5,
        ),
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                width: 80,
                height: 30,
                child: ElevatedButton(
                  onPressed: () {
                    addQuestion();
                    q.clear();
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: ButtonColor.bgcolor,
                      fixedSize: const Size(80, 10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40))),
                  child: const Text(
                    'โพสต์',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Divider(
                thickness: 0.5,
              ),
            ],
          ),
        )
      ]),
    );
  }

  Widget posttailwidget() {
    return Expanded(
      child: ListView.builder(
        itemCount: postList.length,
        itemBuilder: (context, index) {
          final reversedIndex = postList.length - 1 - index;
          return Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color(0xffE0E0E0),
              ),
              margin: const EdgeInsets.symmetric(vertical: 5),
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        header(
                          "${postList[reversedIndex]['question']}",
                          "${postList[reversedIndex]['name']}",
                          "${postList[reversedIndex]['date']}",
                          postList[reversedIndex]['user'],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text("${postList[reversedIndex]['question']}"),
                        // Image(image: image). =! null?
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
                            postList[reversedIndex]['id'],
                            postList[reversedIndex]['question'],
                            postList[reversedIndex]['name'],
                            postList[reversedIndex]['date'],
                          )),
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

  Widget header(String question, String name, String date, int user) {
    return Row(
      children: [
        Container(
            padding: const EdgeInsets.all(4),
            decoration: const BoxDecoration(
                color: Color(0xff3AAA94), shape: BoxShape.circle),
            child: const Icon(Icons.person)),
        const SizedBox(
          width: 8,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(fontSize: 16),
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
                                question: question,
                              )));
                },
                icon: const Icon(Icons.edit_note))
            : Text("")
      ],
    );
  }

  Widget commentButton(int id, String question, String name, String date) {
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
                      )));
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: ButtonColor.bgcolor,
            fixedSize: const Size(80, 10),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40))),
        child: const Text(
          'ความคิดเห็น',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Future addQuestion() async {
    var url = Uri.http(host(), 'post-question');
    Map<String, String> header = {"Content-type": "application/json"};
    String v1 = '"user":"${userID}"';
    String v2 = '"question":"${q.text}"';
    String v3 = '"date":"${formattedDateTime()}"';
    String jsondata = '{$v1,$v2,$v3}';
    var response = await http.post(url, headers: header, body: jsondata);
    print('--------result--------');
    print(response.body);
    setState(() {
      get_qa();
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
      get_qa();
    });
  }

  Future get_qa() async {
    var url = Uri.http(host(), 'get-question/');
    var response = await http.get(url);
    // var result = json.decode(response.body);
    var result = utf8.decode(response.bodyBytes);
    setState(() {
      postList = json.decode(result);
      print(postList);
    });
  }
}
