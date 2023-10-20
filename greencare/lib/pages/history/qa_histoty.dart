import 'package:flutter/material.dart';
import 'package:rotnaam/pages/history/all_histoty.dart';
import 'package:rotnaam/pages/question_answer/comment.dart';
import 'package:rotnaam/pages/question_answer/update_post.dart';
import 'package:rotnaam/utils/api_url.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class QAHistory extends StatefulWidget {
  final userid;
  const QAHistory({super.key, this.userid});

  @override
  State<QAHistory> createState() => _QAHistoryState();
}

class _QAHistoryState extends State<QAHistory> {
  int? userID;
  List postItem = [];
  // mark_chat_unread_rounded
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userID = widget.userid;
    getQa();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15, top: 30),
                child: IconButton(
                  icon: Image.asset('assets/back.png', height: 35, width: 35),
                  iconSize: 50,
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const AllHistory()));
                  },
                ),
              ),
            ],
          ),
          const Text(
            "ประวัติการโพสต์ทั้งหมด",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          posttailwidget()
        ],
      ),
    );
  }

  Widget posttailwidget() {
    return Expanded(
      child: ListView.builder(
        itemCount: postItem.length,
        itemBuilder: (context, index) {
          final reversedIndex = postItem.length - 1 - index;
          return Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.grey[300],
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
                          postItem[reversedIndex]['id'],
                          "${postItem[reversedIndex]['question']}",
                          "${postItem[reversedIndex]['name']}",
                          "${postItem[reversedIndex]['date']}",
                          postItem[reversedIndex]['user'],
                        ),
                        const SizedBox(
                          height: 10,
                          width: 20,
                        ),
                        Text("${postItem[reversedIndex]['question']}"),
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
                            postItem[reversedIndex]['id'],
                            postItem[reversedIndex]['question'],
                            postItem[reversedIndex]['name'],
                            postItem[reversedIndex]['date'],
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

  Widget header(int id, String question, String name, String date, int user) {
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
        IconButton(
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
                      print(value);
                      if (value == 'update') {
                        final snackBar = SnackBar(
                          content: const Text('เเก้ไขเรียบร้อย'),
                          action: SnackBarAction(
                            label: 'ปิด',
                            onPressed: () {},
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } else if (value == 'delete') {
                        final snackBar = SnackBar(
                          content: const Text('ลบเรียบร้อย'),
                          action: SnackBarAction(
                            label: 'ปิด',
                            onPressed: () {},
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    },
                  );
                },
              );
            },
            icon: const Icon(Icons.edit_note))
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
            backgroundColor: Colors.teal,
            fixedSize: const Size(80, 10),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30))),
        child: const Text(
          'Comment',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Future getQa() async {
    var url = Uri.http(host(), 'get-question-by/$userID/');
    var response = await http.get(url);
    var result = utf8.decode(response.bodyBytes);
    setState(() {
      postItem = json.decode(result);
    });
  }
}
