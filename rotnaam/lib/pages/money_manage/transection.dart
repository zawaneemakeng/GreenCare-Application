import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rotnaam/pages/money_manage/add_transection.dart';
import 'package:rotnaam/pages/money_manage/delete_transection.dart';
import 'package:rotnaam/pages/money_manage/update_transection.dart';
import 'package:rotnaam/utils/api_url.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class AllTransection extends StatefulWidget {
  const AllTransection({super.key});

  @override
  State<AllTransection> createState() => _AllTransectionState();
}

class _AllTransectionState extends State<AllTransection> {
  double totalIncome = 0.0;
  double totalExpense = 0.0;
  double totalBalance = 0.0;

  List transactionItem = [];
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
      floatingActionButton: SizedBox(
        width: 100,
        height: 40,
        child: FittedBox(
          child: FloatingActionButton.extended(
              onPressed: () async {
                String refresh = await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AddTransection()),
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
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50.0))),
              label: const Text(
                'เพิ่มรายการ',
                style: TextStyle(fontSize: 16),
              ),
              icon: const Icon(Icons.add),
              backgroundColor: Colors.teal,
              foregroundColor: Colors.white),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            cardtotal(),
            const Padding(
              padding: EdgeInsets.only(left: 20, right: 20, top: 10),
              child: Text('ค่าใช้จ่ายล่าสุด',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
            ),
            transTile(),
            const SizedBox(
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
      margin: const EdgeInsets.all(20.0),
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.teal,
              Color.fromARGB(255, 147, 206, 190),
            ],
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(24),
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
        child: Column(
          children: [
            const Text('ยอดรวมคงเหลือ',
                textAlign: TextAlign.center, style: TextStyle(fontSize: 16)),
            Text("$totalBalance",
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.all(6),
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
          padding: const EdgeInsets.all(6.0),
          margin: const EdgeInsets.only(right: 8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Icon(
            Icons.arrow_downward,
            size: 20,
            color: Colors.green,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'รายรับ',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            Text(
              "$totalIncome",
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
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
          padding: const EdgeInsets.all(6.0),
          margin: const EdgeInsets.only(right: 8.0),
          child: const Icon(
            Icons.arrow_upward,
            size: 20,
            color: Colors.red,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'รายจ่าย',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            Text(
              "$totalExpense",
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
            ),
          ],
        )
      ],
    );
  }

  Widget transTile() {
    return Expanded(
      child: ListView.builder(
        itemCount: transactionItem.length.clamp(0, 10),
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
                  motion: const ScrollMotion(),
                  children: [
                    SlidableAction(
                        padding: const EdgeInsets.only(left: 4),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(8.0),
                          bottomLeft: Radius.circular(8.0),
                        ),
                        icon: Icons.edit,
                        backgroundColor: const Color.fromARGB(255, 96, 185, 99),
                        foregroundColor: const Color(0xffE0E0E0),
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
                                    totalIncome = 0.0;
                                    totalExpense = 0.0;
                                    totalBalance = 0.0;
                                    getTransection();
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
                        padding: const EdgeInsets.only(left: 4),
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(8.0),
                          bottomRight: Radius.circular(8.0),
                        ),
                        autoClose: true,
                        icon: Icons.delete,
                        backgroundColor: Colors.redAccent,
                        foregroundColor: const Color(0xffE0E0E0),
                        onPressed: (context) => {
                              deleteTransection(
                                      transactionItem[reversedIndex]['id'])
                                  .then((value) => setState(() {
                                        totalIncome = 0.0;
                                        totalExpense = 0.0;
                                        totalBalance = 0.0;
                                        getTransection();

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
                    const SizedBox(
                      width: 20,
                    )
                  ],
                ),
                child: Container(
                  margin: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                  ),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xffE6E6E6),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.arrow_circle_down_outlined,
                            color: Colors.green,
                          ),
                          const SizedBox(
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
                          style: const TextStyle(fontSize: 14)),
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
                  motion: const ScrollMotion(),
                  children: [
                    SlidableAction(
                        padding: const EdgeInsets.only(left: 4),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(8.0),
                          bottomLeft: Radius.circular(8.0),
                        ),
                        icon: Icons.edit,
                        backgroundColor: const Color.fromARGB(255, 96, 185, 99),
                        foregroundColor: const Color(0xffE0E0E0),
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
                                    totalIncome = 0.0;
                                    totalExpense = 0.0;
                                    totalBalance = 0.0;
                                    getTransection();
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
                        padding: const EdgeInsets.only(left: 4),
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(8.0),
                          bottomRight: Radius.circular(8.0),
                        ),
                        autoClose: true,
                        icon: Icons.delete,
                        backgroundColor: Colors.redAccent,
                        foregroundColor: const Color(0xffE0E0E0),
                        onPressed: (context) => {
                              deleteTransection(
                                      transactionItem[reversedIndex]['id'])
                                  .then((value) => setState(() {
                                        totalIncome = 0.0;
                                        totalExpense = 0.0;
                                        totalBalance = 0.0;
                                        getTransection();

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
                    const SizedBox(
                      width: 20,
                    )
                  ],
                ),
                child: Container(
                  margin: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                  ),
                  padding: const EdgeInsets.all(12),
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
                          const Icon(
                            Icons.arrow_circle_up_outlined,
                            color: Colors.red,
                          ),
                          const SizedBox(
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
                          style: const TextStyle(fontSize: 14)),
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
      getTransection();
    });
  }

  Future getTransection() async {
    var url = Uri.http(host(), "${gettransaction()}/$userID");
    var response = await http.get(url);
    var result = utf8.decode(response.bodyBytes);
    setState(() {
      transactionItem = json.decode(result);
      for (int i = 0; i < transactionItem.length; i++) {
        if (transactionItem[i]['transtype'] == 'Income') {
          totalIncome += double.parse(transactionItem[i]['amount']);
        } else if (transactionItem[i]['transtype'] == 'Expense') {
          totalExpense += double.parse(transactionItem[i]['amount']);
        }
      }
      totalBalance = totalIncome - totalExpense;
      // print(transactionItem);
      // print(totalIncome);
      // print(totalExpense);
      // print("Total ${totalBalance}");
    });
  }
}
