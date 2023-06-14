import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ShowOTP extends StatefulWidget {
  const ShowOTP({super.key});

  @override
  State<ShowOTP> createState() => _ShowOTPState();
}

class _ShowOTPState extends State<ShowOTP> {
  List todolistitems = [];
  int? userID;

  @override
  void initState() {
    super.initState();
    check();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text(
              'no data',
            ),
            todolistCreate()
          ],
        ),
      ),
    );
  }

  Widget todolistCreate() {
    return Expanded(
      child: ListView.builder(
          itemCount: todolistitems.length,
          itemBuilder: (context, int index) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Card(
                child: ListTile(
                  title: Text(
                    "${todolistitems[index]['date']}",
                    style: TextStyle(fontSize: 18),
                  ),
                  leading: const Icon(Icons.event_note),
                  tileColor: Color.fromARGB(255, 251, 244, 255),
                  onTap: () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: ((context) => UpdateTodo(
                    //               todolistitems[index]['id'],
                    //               todolistitems[index]['title'],
                    //               todolistitems[index]['details'],
                    //             )))).then((value) {
                    //   //.then ตือให้ทำอะไรถ้ากลับมา
                    //   setState(() {
                    //     getTodolist();
                    //     print(value);
                    //     if (value == 'delate') {
                    //       final snackBar = SnackBar(
                    //         content: const Text('เเก้ไขเรียบร้อย'),
                    //         action: SnackBarAction(
                    //           label: 'Undo',
                    //           onPressed: () {},
                    //         ),
                    //       );
                    //       ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    //     }
                    //   });
                    // });
                  },
                ),
              ),
            );
          }),
    );
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
      getTodolist();
    });
  }

  Future getTodolist() async {
    var url = Uri.http('8000:8000', '/api/transection/$userID');
    var response = await http.get(url);
    // var result = json.decode(response.body);
    var result = utf8.decode(response.bodyBytes);
    print(result);
    setState(() {
      todolistitems = json.decode(result);
    });
  }
}
