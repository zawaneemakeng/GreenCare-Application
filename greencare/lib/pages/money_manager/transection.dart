import 'package:flutter/material.dart';
import 'package:greencare/pages/money_manager/add_transection.dart';

class AllTransection extends StatefulWidget {
  const AllTransection({super.key});

  @override
  State<AllTransection> createState() => _AllTransectionState();
}

class _AllTransectionState extends State<AllTransection> {
  int totalBalance = 0;
  int totalIncome = 0;
  int totalExpense = 0;

  getTotalBalance(Map entieData) {
    entieData.forEach((key, value) {
      print(key);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: SizedBox(
              height: 45,
              width: 45,
              child: FittedBox(
                child: FloatingActionButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddTransection()),
                    );
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
        body: ListView(
          children: [
            Container(
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
                padding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 8.0),
                child: Column(
                  children: [
                    Text('ยอดรวมทั้งหมด',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16)),
                    Text('15,909 บาท',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16)),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          cardIncome("1200"),
                          cardExpense("700"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
              child: Text('ค่าใช้จ่ายล่าสุด',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
            ),
            expenseTile(100, "ค่ากินไก่"),
            incomeTile(200, "ขายผักบุ้ง")

            // ListView.builder(
            //     shrinkWrap: true,
            //     physics: NeverScrollableScrollPhysics(),
            //     itemCount: snapshot.data!.length,
            //     itemBuilder: (context, index) {
            //       Map dataIndex - snapshot.data![index];
            //       return Text('data');
            //     })
          ],
        ));
  }

  Widget cardIncome(String income) {
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
              income,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
            ),
          ],
        )
      ],
    );
  }

  Widget cardExpense(String expense) {
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
              expense,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
            ),
          ],
        )
      ],
    );
  }

  Widget expenseTile(int value, String note) {
    return Container(
      margin: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 10,
      ),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: Colors.grey[300], borderRadius: BorderRadius.circular(8.0)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              Text(note),
            ],
          ),
          Text("-${value} "),
        ],
      ),
    );
  }

  Widget incomeTile(int value, String note) {
    return Container(
      margin: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 15,
      ),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: Colors.grey[300], borderRadius: BorderRadius.circular(8.0)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              Text(note),
            ],
          ),
          Text("+${value} "),
        ],
      ),
    );
  }
}
