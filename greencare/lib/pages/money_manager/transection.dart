import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:greencare/pages/money_manager/add_transection.dart';
import 'package:greencare/pages/money_manager/delete_transection.dart';
import 'package:greencare/pages/money_manager/update_transection.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:greencare/utils/api_url.dart';

class AllTransection extends StatefulWidget {
  const AllTransection({super.key});

  @override
  State<AllTransection> createState() => _AllTransectionState();
}

class _AllTransectionState extends State<AllTransection> {
  double totalIncome = 0.0;
  double totalExpense = 0.0;
  double totalBalance = 0.0;

  List incomeItem = [];
  List expenseItem = [];
  int? userID;
  double? total;
  int? count;

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
                  String refresh = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddTransection()),
                  );
                  if (refresh == 'refresh') {
                    setState(() {
                      totalIncome = 0.0;
                      totalExpense = 0.0;
                      totalBalance = 0.0;
                      getTransection();
                    });
                  }
                },
                backgroundColor: Color(0xff3AAA94),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0)),
                child: Icon(
                  Icons.add,
                  size: 30.0,
                  color: Colors.white,
                ),
              ),
            )),
      ),
      body: Center(
        child: Column(
          children: [
            cardtotal(),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
              child: Text('ค่าใช้จ่ายล่าสุด',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
            ),
            transTile(),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }

  Widget cardtotal() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      margin: EdgeInsets.all(20.0),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff3AAA94),
              Color.fromARGB(255, 147, 206, 190),
            ],
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(24),
          ),
        ),
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
        child: Column(
          children: [
            Text('ยอดรวมคงเหลือ',
                textAlign: TextAlign.center, style: TextStyle(fontSize: 16)),
            Text("${totalBalance}",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: EdgeInsets.all(6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  cardIncome(),
                  cardExpense(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget cardIncome() {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          padding: EdgeInsets.all(6.0),
          child: Icon(
            Icons.arrow_downward,
            size: 20,
            color: Colors.green,
          ),
          margin: EdgeInsets.only(right: 8.0),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'รายรับ',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            Text(
              "${totalIncome}",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
            ),
          ],
        )
      ],
    );
  }

  Widget cardExpense() {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          padding: EdgeInsets.all(6.0),
          child: Icon(
            Icons.arrow_upward,
            size: 20,
            color: Colors.red,
          ),
          margin: EdgeInsets.only(right: 8.0),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'รายจ่าย',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            Text(
              "${totalExpense}",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
            ),
          ],
        )
      ],
    );
  }

  Widget transTile() {
    return Expanded(
      child: ListView.builder(
        itemCount: incomeItem.length.clamp(0, 6),
        itemBuilder: (context, int index) {
          final reversedIndex = incomeItem.length - 1 - index;
          if (incomeItem[reversedIndex]['transtype'] == 'Income') {
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
                                            incomeItem[reversedIndex]['id'],
                                            incomeItem[reversedIndex]['amount'],
                                            incomeItem[reversedIndex]['detail'],
                                            incomeItem[reversedIndex]
                                                ['transtype'],
                                            incomeItem[reversedIndex]['date'],
                                          )))).then(
                                (value) {
                                  //.then ตือให้ทำอะไรถ้ากลับมา
                                  setState(() {
                                    totalIncome = 0.0;
                                    totalExpense = 0.0;
                                    totalBalance = 0.0;
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
                              deleteTransection(incomeItem[reversedIndex]['id'])
                                  .then((value) => setState(() {
                                        totalIncome = 0.0;
                                        totalExpense = 0.0;
                                        totalBalance = 0.0;
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
                              Text("${incomeItem[reversedIndex]['detail']}"),
                              Text(
                                "${incomeItem[reversedIndex]['date']}",
                                style: TextStyle(
                                    color: Colors.grey[600], fontSize: 12),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Text("+ ${incomeItem[reversedIndex]['amount']}",
                          style: TextStyle(fontSize: 14)),
                    ],
                  ),
                ),
              ),
            );
          } else if (incomeItem[reversedIndex]['transtype'] == 'Expense') {
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
                                            incomeItem[reversedIndex]['id'],
                                            incomeItem[reversedIndex]['amount'],
                                            incomeItem[reversedIndex]['detail'],
                                            incomeItem[reversedIndex]
                                                ['transtype'],
                                            incomeItem[reversedIndex]['date'],
                                          )))).then(
                                (value) {
                                  //.then ตือให้ทำอะไรถ้ากลับมา
                                  setState(() {
                                    totalIncome = 0.0;
                                    totalExpense = 0.0;
                                    totalBalance = 0.0;
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
                              deleteTransection(incomeItem[reversedIndex]['id'])
                                  .then((value) => setState(() {
                                        totalIncome = 0.0;
                                        totalExpense = 0.0;
                                        totalBalance = 0.0;
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
                              Text("${incomeItem[reversedIndex]['detail']}"),
                              Text(
                                "${incomeItem[reversedIndex]['date']}",
                                style: TextStyle(
                                    color: Colors.grey[600], fontSize: 12),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Text("- ${incomeItem[reversedIndex]['amount']}",
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
      getTransection();
    });
  }

  Future getTransection() async {
    var url = Uri.http(urlH(), '/api/transection/$userID');
    var response = await http.get(url);
    // var result = json.decode(response.body);
    var result = utf8.decode(response.bodyBytes);
    setState(() {
      incomeItem = json.decode(result);
      for (int i = 0; i < incomeItem.length; i++) {
        if (incomeItem[i]['transtype'] == 'Income') {
          totalIncome += double.parse(incomeItem[i]['amount']);
        } else if (incomeItem[i]['transtype'] == 'Expense') {
          totalExpense += double.parse(incomeItem[i]['amount']);
        }
      }
      print(incomeItem);
      print(totalIncome);
      print(totalExpense);
      totalBalance = totalIncome - totalExpense;
      print("Total ${totalBalance}");
    });
  }
}
