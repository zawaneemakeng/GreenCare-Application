import 'package:flutter/material.dart';
import 'package:rotnaam/pages/material.dart';
import 'package:rotnaam/utils/api_url.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ShowHistory extends StatefulWidget {
  final userID;
  const ShowHistory({super.key, this.userID});

  @override
  State<ShowHistory> createState() => _ShowHistoryState();
}

class _ShowHistoryState extends State<ShowHistory> {
  int? _userID;
  List plantListItems = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _userID = widget.userID;
    print(_userID);
    getAllPlants();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15, top: 20),
                child: IconButton(
                  icon: Image.asset('assets/back.png', height: 35, width: 35),
                  iconSize: 50,
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => HomePage()));
                  },
                ),
              ),
            ],
          ),
          historyTail(),
        ],
      ),
    );
  }

  Widget historyTail() {
    return Expanded(
      child: ListView.builder(
        itemCount: plantListItems.length,
        itemBuilder: (context, int index) {
          final reversedIndex = plantListItems.length - 1 - index;
          if (plantListItems[reversedIndex]['status'] == false) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)),
                child: Column(
                  children: [
                    SizedBox(
                      height: 50.0,
                      child: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 12),
                            child: Icon(
                              Icons.track_changes,
                              size: 24.0,
                              // color: Colors.grey[700],
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(
                            width: 12.0,
                          ),
                          Text(
                            "${plantListItems[reversedIndex]['plantname']}",
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.grey[700],
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 50.0,
                      child: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 12),
                            child: Icon(
                              Icons.track_changes,
                              size: 24.0,
                              // color: Colors.grey[700],
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(
                            width: 12.0,
                          ),
                          Text(
                            "${plantListItems[reversedIndex]['detail']}",
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.grey[700],
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 50.0,
                      child: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 12),
                            child: Icon(
                              Icons.track_changes,
                              size: 24.0,
                              // color: Colors.grey[700],
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(
                            width: 12.0,
                          ),
                          Text(
                            "วันที่ปลูก : ${plantListItems[reversedIndex]['startdate']}",
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.grey[700],
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 50.0,
                      child: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 12),
                            child: Icon(
                              Icons.track_changes,
                              size: 24.0,
                              // color: Colors.grey[700],
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(
                            width: 12.0,
                          ),
                          Text(
                            "วันที่เก็บเกี่ยว :  ${plantListItems[reversedIndex]['enddate']}",
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.grey[700],
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 50.0,
                      child: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 12),
                            child: Icon(
                              Icons.track_changes,
                              size: 24.0,
                              // color: Colors.grey[700],
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(
                            width: 12.0,
                          ),
                          plantListItems[reversedIndex]['status'] == true
                              ? Text(
                                  "สถานะ : เก็บเกี่ยว",
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.grey[700],
                                  ),
                                )
                              : Text(
                                  "สถานะ : ยังไม่เก็บเกี่ยว",
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.grey[700],
                                  ),
                                )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(15)),
                child: Column(
                  children: [
                    SizedBox(
                      height: 50.0,
                      child: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 12),
                            child: Icon(
                              Icons.track_changes,
                              size: 24.0,
                              // color: Colors.grey[700],
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(
                            width: 12.0,
                          ),
                          Text(
                            "${plantListItems[reversedIndex]['plantname']}",
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.grey[700],
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 50.0,
                      child: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 12),
                            child: Icon(
                              Icons.track_changes,
                              size: 24.0,
                              // color: Colors.grey[700],
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(
                            width: 12.0,
                          ),
                          Text(
                            "${plantListItems[reversedIndex]['detail']}",
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.grey[700],
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 50.0,
                      child: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 12),
                            child: Icon(
                              Icons.track_changes,
                              size: 24.0,
                              // color: Colors.grey[700],
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(
                            width: 12.0,
                          ),
                          Text(
                            "วันที่ปลูก : ${plantListItems[reversedIndex]['startdate']}",
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.grey[700],
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 50.0,
                      child: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 12),
                            child: Icon(
                              Icons.track_changes,
                              size: 24.0,
                              // color: Colors.grey[700],
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(
                            width: 12.0,
                          ),
                          Text(
                            "วันที่เก็บเกี่ยว :  ${plantListItems[reversedIndex]['enddate']}",
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.grey[700],
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 50.0,
                      child: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 12),
                            child: Icon(
                              Icons.track_changes,
                              size: 24.0,
                              // color: Colors.grey[700],
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(
                            width: 12.0,
                          ),
                          plantListItems[reversedIndex]['status'] == true
                              ? Text(
                                  "สถานะ : เก็บเกี่ยว",
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.grey[700],
                                  ),
                                )
                              : Text(
                                  "สถานะ : ยังไม่เก็บเกี่ยว",
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.grey[700],
                                  ),
                                )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Future getAllPlants() async {
    var url = Uri.http(host(), 'get-plants/$_userID');
    var response = await http.get(url);
    var result = utf8.decode(response.bodyBytes);
    setState(() {
      plantListItems = json.decode(result);
      print(plantListItems);
    });
  }
}
