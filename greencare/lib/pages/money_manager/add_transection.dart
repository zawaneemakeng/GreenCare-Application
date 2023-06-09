import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';

class AddTransection extends StatefulWidget {
  const AddTransection({super.key});

  @override
  State<AddTransection> createState() => _AddTransectionState();
}

class _AddTransectionState extends State<AddTransection> {
  DateTime selectedDate = DateTime.now();
  var amount = TextEditingController();
  String note = "Expense";
  String type = "Income";

  List<String> months = [
    "มกราคม",
    "กุมภาพันธ์",
    "มีนาคม",
    "เมษายน",
    "พฤษภาคม",
    "มิถุนายน",
    "กรกฎาคม",
    "สิงหาคม",
    "กันยายน",
    "ตุลาคม",
    "พฤศจิกายน",
    "ธันวาคม"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
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
                    controller: amount,
                    keyboardType: TextInputType.number,
                    cursorColor: Colors.grey,
                    style: TextStyle(
                      color: Colors.black54,
                    ),
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.money,
                        color: Color.fromARGB(255, 133, 133, 133),
                      ),
                      hintText: 'จำนวนเงิน',
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
            SizedBox(
              height: 10.0,
            ),
            Row(
              children: [
                Container(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Icon(
                      Icons.moving_sharp,
                      size: 24.0,
                      // color: Colors.grey[700],
                      color: Colors.grey,
                    ),
                  ),
                ),
                SizedBox(
                  width: 12.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: ChoiceChip(
                    avatar: CircleAvatar(
                      backgroundColor: Colors.grey[500],
                      backgroundImage: null,
                    ),
                    label: Text(
                      "รายรับ",
                      style: TextStyle(
                        fontSize: 14.0,
                        color: type == "Income" ? Colors.black : Colors.white,
                      ),
                    ),
                    selectedColor: Color.fromARGB(255, 147, 206, 190),
                    backgroundColor: Colors.grey[400],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
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
                ),
                SizedBox(
                  width: 10.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: ChoiceChip(
                    avatar: CircleAvatar(
                      backgroundColor: Colors.grey[500],
                      backgroundImage: null,
                    ),
                    label: Text(
                      "รายจ่าย",
                      style: TextStyle(
                        fontSize: 14.0,
                        color: type == "Income" ? Colors.white : Colors.black,
                      ),
                    ),
                    selectedColor: Color.fromARGB(255, 147, 206, 190),
                    backgroundColor: Colors.grey[400],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
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
                ),
                SizedBox(
                  height: 20.0,
                ),
              ],
            ),
            //
            const Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Divider(
                height: 1,
                color: Colors.grey,
                thickness: 1,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Row(
              children: [
                Container(
                  width: 285,
                  child: TextField(
                    // controller: note,
                    cursorColor: Colors.grey,
                    style: TextStyle(
                      color: Colors.black54,
                    ),
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.note,
                        color: Color.fromARGB(255, 133, 133, 133),
                      ),
                      hintText: 'โน้ตค่าใช้จ่าย',
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
            SizedBox(
              height: 10.0,
            ),
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
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12),
                        child: Icon(
                          Icons.date_range,
                          size: 24.0,
                          // color: Colors.grey[700],
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12.0,
                    ),
                    Text(
                      "${selectedDate.day} ${months[selectedDate.month - 1]}",
                      style: TextStyle(
                        fontSize: 16.0,
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
            SizedBox(
              height: 30.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 80.0, right: 80.0),
              child: ElevatedButton(
                onPressed: () {
                  print("Amout: ${amount.text}");
                  print(note);
                  // precacheImage(type);
                  print("Selected date: ${selectedDate}");
                },
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
    final DateTime? picked = await showRoundedDatePicker(
      context: context,
      locale: Locale("th", "TH"),
      era: EraMode.BUDDHIST_YEAR,
      initialDate: selectedDate,
      firstDate: DateTime(2017, 1),
      lastDate: DateTime(2037),
      borderRadius: 15,
      theme: ThemeData(primaryColor: const Color(0xff3AAA94), fontFamily: 'PK'),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }
}
