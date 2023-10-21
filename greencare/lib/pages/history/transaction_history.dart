import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:http/http.dart' as http;
import 'package:rotnaam/pages/history/all_histoty.dart';
import 'package:rotnaam/pages/money_manage/delete_transection.dart';
import 'package:rotnaam/pages/money_manage/update_transection.dart';
import 'package:rotnaam/utils/api_url.dart';
import 'dart:async';
import 'dart:convert';

class TransactionHistory extends StatefulWidget {
  final userid;
  const TransactionHistory({super.key, this.userid});

  @override
  State<TransactionHistory> createState() => _TransactionHistoryState();
}

class _TransactionHistoryState extends State<TransactionHistory> {
  List transactionItem = [];
  List expenseItem = [];
  int? userID;
  double? total;
  int? count;

  @override
  void initState() {
    super.initState();
    userID = widget.userid;
    getTransection();
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
                            builder: (BuildContext context) => AllHistory()));
                  },
                ),
              ),
            ],
          ),
          const Text(
            "ประวัติการปลูกทั้งหมด",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          transTile()
        ],
      ),
    );
  }

  Widget transTile() {
    return Expanded(
      child: ListView.builder(
        itemCount: transactionItem.length.clamp(0, 6),
        itemBuilder: (context, int index) {
          final reversedIndex = transactionItem.length - 1 - index;
          if (transactionItem[reversedIndex]['transtype'] == 'Income') {
            return Padding(
              padding: const EdgeInsets.only(
                top: 15,
              ),
              child: Slidable(
                endActionPane: ActionPane(
                  extentRatio: 0.4,
                  motion: ScrollMotion(),
                  children: [
                    SlidableAction(
                        padding: EdgeInsets.only(left: 4),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8.0),
                          bottomLeft: Radius.circular(8.0),
                        ),
                        icon: Icons.edit,
                        backgroundColor: const Color.fromARGB(255, 96, 185, 99),
                        foregroundColor: Color(0xffE0E0E0),
                        onPressed: (context) => {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) => UpdateTransition(
                                            transactionItem[reversedIndex]
                                                ['user'],
                                            transactionItem[reversedIndex]
                                                ['id'],
                                            transactionItem[reversedIndex]
                                                ['amount'],
                                            transactionItem[reversedIndex]
                                                ['detail'],
                                            transactionItem[reversedIndex]
                                                ['transtype'],
                                            transactionItem[reversedIndex]
                                                ['date'],
                                          )))).then(
                                (value) {
                                  //.then ตือให้ทำอะไรถ้ากลับมา
                                  setState(() {
                                    getTransection();
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
                                    }
                                  });
                                },
                              )
                            }),
                    SlidableAction(
                        padding: EdgeInsets.only(left: 4),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(8.0),
                          bottomRight: Radius.circular(8.0),
                        ),
                        autoClose: true,
                        icon: Icons.delete,
                        backgroundColor: Colors.redAccent,
                        foregroundColor: Color(0xffE0E0E0),
                        onPressed: (context) => {
                              deleteTransection(
                                      transactionItem[reversedIndex]['id'])
                                  .then((value) => setState(() {
                                        getTransection();
                                        print(value);
                                        if (value == 'deleted') {
                                          final snackBar = SnackBar(
                                            content: const Text('ลบสำเร็จ'),
                                            action: SnackBarAction(
                                              label: 'ปิด',
                                              onPressed: () {},
                                            ),
                                          );

                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar);
                                        }
                                      }))
                            }),
                    SizedBox(
                      width: 20,
                    )
                  ],
                ),
                child: Container(
                  margin: EdgeInsets.only(
                    left: 20,
                    right: 20,
                  ),
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Color(0xffE6E6E6),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.arrow_circle_down_outlined,
                            color: Colors.green,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  "${transactionItem[reversedIndex]['detail']}"),
                              Text(
                                "${transactionItem[reversedIndex]['date']}",
                                style: TextStyle(
                                    color: Colors.grey[600], fontSize: 12),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Text("+ ${transactionItem[reversedIndex]['amount']}",
                          style: TextStyle(fontSize: 14)),
                    ],
                  ),
                ),
              ),
            );
          } else if (transactionItem[reversedIndex]['transtype'] == 'Expense') {
            return Padding(
              padding: const EdgeInsets.only(
                top: 15,
              ),
              child: Slidable(
                endActionPane: ActionPane(
                  extentRatio: 0.4,
                  motion: ScrollMotion(),
                  children: [
                    SlidableAction(
                        padding: EdgeInsets.only(left: 4),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8.0),
                          bottomLeft: Radius.circular(8.0),
                        ),
                        icon: Icons.edit,
                        backgroundColor: const Color.fromARGB(255, 96, 185, 99),
                        foregroundColor: Color(0xffE0E0E0),
                        onPressed: (context) => {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) => UpdateTransition(
                                            transactionItem[reversedIndex]
                                                ['user'],
                                            transactionItem[reversedIndex]
                                                ['id'],
                                            transactionItem[reversedIndex]
                                                ['amount'],
                                            transactionItem[reversedIndex]
                                                ['detail'],
                                            transactionItem[reversedIndex]
                                                ['transtype'],
                                            transactionItem[reversedIndex]
                                                ['date'],
                                          )))).then(
                                (value) {
                                  //.then ตือให้ทำอะไรถ้ากลับมา
                                  setState(() {
                                    getTransection();
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
                                    }
                                  });
                                },
                              )
                            }),
                    SlidableAction(
                        padding: EdgeInsets.only(left: 4),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(8.0),
                          bottomRight: Radius.circular(8.0),
                        ),
                        autoClose: true,
                        icon: Icons.delete,
                        backgroundColor: Colors.redAccent,
                        foregroundColor: Color(0xffE0E0E0),
                        onPressed: (context) => {
                              deleteTransection(
                                      transactionItem[reversedIndex]['id'])
                                  .then((value) => setState(() {
                                        getTransection();
                                        print(value);
                                        if (value == 'deleted') {
                                          final snackBar = SnackBar(
                                            content: const Text('ลบสำเร็จ'),
                                            action: SnackBarAction(
                                              label: 'ปิด',
                                              onPressed: () {},
                                            ),
                                          );

                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar);
                                        }
                                      }))
                            }),
                    SizedBox(
                      width: 20,
                    )
                  ],
                ),
                child: Container(
                  margin: EdgeInsets.only(
                    left: 20,
                    right: 20,
                  ),
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Color(0xffE6E6E6),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.arrow_circle_up_outlined,
                            color: Colors.red,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  "${transactionItem[reversedIndex]['detail']}"),
                              Text(
                                "${transactionItem[reversedIndex]['date']}",
                                style: TextStyle(
                                    color: Colors.grey[600], fontSize: 12),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Text("- ${transactionItem[reversedIndex]['amount']}",
                          style: TextStyle(fontSize: 14)),
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Future getTransection() async {
    var url = Uri.http(host(), "${gettransaction()}/${userID}");
    var response = await http.get(url);
    var result = utf8.decode(response.bodyBytes);
    setState(() {
      transactionItem = json.decode(result);
    });
  }
}
