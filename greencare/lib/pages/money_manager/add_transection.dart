import 'package:flutter/material.dart';

import 'package:flutter/foundation.dart';

import 'package:flutter/services.dart';

class AddTransection extends StatefulWidget {
  const AddTransection({super.key});

  @override
  State<AddTransection> createState() => _AddTransectionState();
}

class _AddTransectionState extends State<AddTransection> {
  DateTime selectedDate = DateTime.now();
  int? amount;
  String note = "Expence";
  String type = "Income";

  List<String> months = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
        child: ListView(
          children: [
            Row(
              children: [
                IconButton(
                  icon: Image.asset('assets/back.png', height: 35, width: 35),
                  iconSize: 50,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            Text(
              "Add Transaction",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 32.0,
                fontWeight: FontWeight.w700,
              ),
            ),
            //
            SizedBox(
              height: 20.0,
            ),
            Row(
              children: [
                Container(
                  width: 285,
                  child: TextField(
                    cursorColor: Colors.grey,
                    style: TextStyle(
                      color: Colors.black54,
                    ),
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.email,
                        color: Color.fromARGB(255, 133, 133, 133),
                      ),
                      hintText: 'example@gmail.com',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Divider(
                height: 1,
                color: Colors.grey,
                thickness: 1,
              ),
            ),
            Row(
              children: [
                Container(
                  width: 285,
                  child: TextField(
                    cursorColor: Colors.grey,
                    style: TextStyle(
                      color: Colors.black54,
                    ),
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.email,
                        color: Color.fromARGB(255, 133, 133, 133),
                      ),
                      hintText: 'example@gmail.com',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Divider(
                height: 1,
                color: Colors.grey,
                thickness: 1,
              ),
            ),
            Row(
              children: [
                Container(
                  width: 285,
                  child: TextField(
                    cursorColor: Colors.grey,
                    style: TextStyle(
                      color: Colors.black54,
                    ),
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.email,
                        color: Color.fromARGB(255, 133, 133, 133),
                      ),
                      hintText: 'Note on Transaction',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Divider(
                height: 1,
                color: Colors.grey,
                thickness: 1,
              ),
            ),

            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 69, 119, 199),
                    borderRadius: BorderRadius.circular(
                      16.0,
                    ),
                  ),
                  padding: EdgeInsets.all(
                    12.0,
                  ),
                  child: Icon(
                    Icons.attach_money,
                    size: 24.0,
                    // color: Colors.grey[700],
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 12.0,
                ),
                ChoiceChip(
                  label: Text(
                    "รายรับ",
                    style: TextStyle(
                      fontSize: 18.0,
                      color: type == "Income" ? Colors.white : Colors.black,
                    ),
                  ),
                  selectedColor: Color.fromARGB(255, 69, 119, 199),
                  onSelected: (val) {
                    if (val) {
                      setState(() {
                        type = "Income";
                        if (note.isEmpty || note == "Expense") {
                          note = 'Income';
                        }
                      });
                    }
                  },
                  selected: type == "Income" ? true : false,
                ),
                SizedBox(
                  width: 8.0,
                ),
                ChoiceChip(
                  label: Text(
                    "รายจ่าย",
                    style: TextStyle(
                      fontSize: 18.0,
                      color: type == "Expense" ? Colors.white : Colors.black,
                    ),
                  ),
                  selectedColor: Color.fromARGB(255, 69, 119, 199),
                  onSelected: (val) {
                    if (val) {
                      setState(() {
                        type = "Expense";

                        if (note.isEmpty || note == "Income") {
                          note = 'Expense';
                        }
                      });
                    }
                  },
                  selected: type == "Expense" ? true : false,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Divider(
                    height: 1,
                    color: Colors.grey,
                    thickness: 1,
                  ),
                ),
              ],
            ),
            //
            SizedBox(
              height: 20.0,
            ),
            //
            SizedBox(
              height: 50.0,
              child: TextButton(
                onPressed: () {
                  _selectDate(context);
                  //
                  // to make sure that no keyboard is shown after selecting Date
                  FocusScope.of(context).unfocus();
                },
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                    EdgeInsets.zero,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 69, 119, 199),
                        borderRadius: BorderRadius.circular(
                          16.0,
                        ),
                      ),
                      padding: EdgeInsets.all(
                        12.0,
                      ),
                      child: Icon(
                        Icons.date_range,
                        size: 24.0,
                        // color: Colors.grey[700],
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      width: 12.0,
                    ),
                    Text(
                      "${selectedDate.day} ${months[selectedDate.month - 1]}",
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Divider(
                height: 1,
                color: Colors.grey,
                thickness: 1,
              ),
            ),
            //
            SizedBox(
              height: 20.0,
            ),
            //
            Padding(
              padding: const EdgeInsets.only(left: 70.0, right: 70.0),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff3AAA94),
                    fixedSize: const Size(130, 20),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50))),
                child: const Text(
                  'Submit',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }
}