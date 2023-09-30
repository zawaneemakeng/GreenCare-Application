import 'package:flutter/material.dart';
import 'package:rotnaam/pages/question_answer/comment.dart';
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
    super.initState();
    check();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: SizedBox(
            height: 45,
            width: 45,
            child: FittedBox(
              child: FloatingActionButton(
                onPressed: () async {
                  _dialogBuilder(context);
                },
                backgroundColor: const Color(0xff3AAA94),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0)),
                child: const Icon(
                  Icons.post_add,
                  size: 30.0,
                  color: Colors.white,
                ),
              ),
            )),
      ),
      body: Column(
        children: [
          // CommuTile(),
          post(),
          posttailwidget()
        ],
      ),
    );
  }

  Widget post() {
    return Container(
      padding: EdgeInsets.fromLTRB(12, 8, 12, 0),
      color: Colors.white,
      child: Column(children: [
        Row(
          children: [
            Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                    color: Colors.green, shape: BoxShape.circle),
                child: const Icon(Icons.person)),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: TextField(
                decoration:
                    InputDecoration.collapsed(hintText: 'คุณต้องการถามอะไร'),
              ),
            ),
          ],
        ),
        Divider(
          thickness: 0.5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton.icon(
                onPressed: () {},
                icon: Icon(Icons.photo_library),
                label: Text('ภาพ')),
            TextButton(onPressed: () {}, child: Text('โพสต์'))
          ],
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
            padding: const EdgeInsets.all(10),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
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
                        header("${postList[reversedIndex]['name']}",
                            "${postList[reversedIndex]['date']}"),
                        const SizedBox(
                          height: 5,
                        ),
                        Text("${postList[reversedIndex]['question']}"),
                        // Image(image: image). =! null?
                      ],
                    ),
                  ),
                  Image.asset("assets/img_otp.png"),
                  const Divider(),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: commentButton(
                          postList[reversedIndex]['id'],
                          postList[reversedIndex]['question'],
                          postList[reversedIndex]['name'],
                          postList[reversedIndex]['date']))
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget header(String name, String date) {
    return Row(
      children: [
        Container(
            padding: const EdgeInsets.all(4),
            decoration: const BoxDecoration(
                color: Colors.green, shape: BoxShape.circle),
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
        IconButton(
            onPressed: () {
              // ignore: avoid_print
              print("object");
            },
            icon: const Icon(Icons.more_horiz))
      ],
    );
  }

  Widget postState() {
    return Column(
      children: [
        Row(
          children: [
            const SizedBox(width: 190),
            const Text(
              "23 comment",
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
        const Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [],
        )
      ],
    );
  }

  Widget likeButton() {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        height: 25,
        child: const Row(
          children: [
            Icon(
              Icons.thumb_up_alt_outlined,
              color: Colors.grey,
              size: 20,
            ),
            SizedBox(
              width: 5,
            ),
            Text("LIKE")
          ],
        ),
      ),
    );
  }

  Widget commentButton(int id, String question, String name, String date) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Comment(
                      id: id,
                      question: question,
                      name: question,
                      date: date,
                    )));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        height: 25,
        child: const Row(
          children: [
            Icon(
              Icons.add_comment,
              color: Colors.grey,
              size: 20,
            ),
            SizedBox(
              width: 5,
            ),
            Text("Comment")
          ],
        ),
      ),
    );
  }

  Widget commuTile() {
    return Expanded(
      child: ListView.builder(
        itemCount: postList.length.clamp(0, 6),
        itemBuilder: (context, int index) {
          final reversedIndex = postList.length - 1 - index;
          return Padding(
            padding: const EdgeInsets.only(left: 5, right: 5, top: 10),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                  ),
                  padding: const EdgeInsets.only(left: 12, right: 12, top: 12),
                  decoration: const BoxDecoration(
                    color: Color(0xffE6E6E6),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                  ),
                  child: Row(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            'assets/user.png',
                            width: 40,
                            height: 40,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(
                                width: 10,
                              ),
                              Text("${postList[reversedIndex]['name']}"),
                              Text(
                                "${postList[reversedIndex]['date']}",
                                style: TextStyle(
                                    color: Colors.grey[600], fontSize: 12),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 60,
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.edit_note,
                                size: 30,
                              ))
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 500,
                  height: 100,
                  margin: EdgeInsets.only(
                    left: 20,
                    right: 20,
                  ),
                  padding: EdgeInsets.only(left: 12, right: 12),
                  decoration: BoxDecoration(
                    color: Color(0xffE6E6E6),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${postList[reversedIndex]['question']},",
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(right: 20, left: 20, bottom: 20),
                  child: Container(
                    width: 500,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: ButtonColor.bgcolor,
                                  fixedSize: const Size(140, 10),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50))),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Comment(
                                              id: postList[reversedIndex]['id'],
                                              question: postList[reversedIndex]
                                                  ['question'],
                                              name: postList[reversedIndex]
                                                  ['name'],
                                              date: postList[reversedIndex]
                                                  ['date'],
                                            )));
                              },
                              child: Text(
                                "ความคิดเห็น",
                                style: TextStyle(color: Colors.white),
                              ))
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.only(left: 20, right: 20, top: 20),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12))),
          title: Center(
            child: const Text(
              'คุณต้องการถามอะไร',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          content: Container(
            width: 320,
            height: 150,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: TextField(
                autofocus: true,
                controller: q,
                cursorColor: Colors.grey,
                style: TextStyle(color: Colors.black54, fontSize: 16),
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
                showCursor: true,
                maxLines: 5,
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('ยกเลิก'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('โพสต์'),
              onPressed: () {
                addQuestion();
                q.clear();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _Comment(
    BuildContext context,
    int id,
    String q,
    String name,
    String date,
  ) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.only(left: 16, right: 16, top: 16),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12))),
          title: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
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
                                    Text(
                                      name,
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    Text(
                                      date,
                                      style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 12),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                  height: 60,
                  width: 300,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Text(q, style: TextStyle(fontSize: 14)),
                  ))
            ],
          ),
          content: Column(
            children: [
              comentItem.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.only(left: 70),
                      child: Text("ยังไม่มีความคิดเห็น"),
                    )
                  : ListView.builder(
                      itemCount: postList.length.clamp(0, 6),
                      itemBuilder: (context, int index) {
                        final reversedIndex = postList.length - 1 - index;
                        return Container(
                          width: 320,
                          height: 50,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Text(
                              postList[reversedIndex]['name'],
                            ),
                          ),
                        );
                      }),
              Container(
                  width: 500,
                  height: 100,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      TextField(),
                    ],
                  ))
            ],
          ),
        );
      },
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
