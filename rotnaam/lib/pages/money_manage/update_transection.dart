import 'package:flutter/material.dart';
import 'package:rotnaam/utils/api_url.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:http/http.dart' as http;

class UpdateTransition extends StatefulWidget {
  final user, id, amount, note, transtype, date;
  const UpdateTransition(
      this.user, this.id, this.amount, this.note, this.transtype, this.date,
      {super.key});

  @override
  State<UpdateTransition> createState() => _UpdateTransitionState();
}

class _UpdateTransitionState extends State<UpdateTransition> {
  var userID, _id, _amount, _note, _transtype, _date;
  DateTime selectedDate = DateTime.now();
  final _amountCtrl = TextEditingController();
  var _noteCtrl = TextEditingController();
  String type = "Income";
  String fulldate = "";

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

  @override
  void initState() {
    super.initState();
    userID = widget.user;
    _id = widget.id; //id
    _amount = widget.amount; //amount
    _note = widget.note; //detail
    _transtype = widget.transtype;
    _date = widget.date; //date
    _amountCtrl.text = _amount;
    _noteCtrl.text = _note;
    type = _transtype;
    fulldate = _date;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  icon: Image.asset('assets/back.png', height: 35, width: 35),
                  iconSize: 50,
                  onPressed: () {
                    Navigator.pop(context, 'refresh');
                  },
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
          updateForm()
        ],
      ),
    );
  }

  Widget updateForm() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(15)),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 20, bottom: 25),
              child: Text(
                "เเก้ไขข้อมูลการเงิน",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            //
            Row(
              children: [
                Container(
                  width: 285,
                  child: TextField(
                    controller: _amountCtrl,
                    keyboardType: TextInputType.number,
                    cursorColor: Colors.grey,
                    style: const TextStyle(
                      color: Colors.black54,
                    ),
                    decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.money,
                        color: Colors.teal,
                      ),
                      hintText: 'จำนวนเงิน',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(
                right: 10,
                left: 10,
              ),
              child: Divider(
                height: 1,
                color: Colors.grey,
                thickness: 1,
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),

            Row(
              children: [
                Container(
                  child: const Padding(
                    padding: EdgeInsets.only(left: 12),
                    child: Icon(Icons.moving_sharp,
                        size: 24.0, color: Colors.teal),
                  ),
                ),
                const SizedBox(
                  width: 12.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: ChoiceChip(
                    avatar: CircleAvatar(
                      backgroundColor: Colors.grey[300],
                      backgroundImage: null,
                    ),
                    label: Text(
                      "รายรับ",
                      style: TextStyle(
                        fontSize: 14.0,
                        color: type == "Income" ? Colors.black : Colors.white,
                      ),
                    ),
                    selectedColor: Colors.teal,
                    backgroundColor: Colors.grey[400],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    onSelected: (val) {
                      if (val) {
                        setState(() {
                          type = "Income";
                        });
                      }
                    },
                    selected: type == "Income" ? true : false,
                  ),
                ),
                const SizedBox(
                  width: 10.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: ChoiceChip(
                    avatar: CircleAvatar(
                      backgroundColor: Colors.grey[300],
                      backgroundImage: null,
                    ),
                    label: Text(
                      "รายจ่าย",
                      style: TextStyle(
                        fontSize: 14.0,
                        color: type == "Income" ? Colors.black : Colors.white,
                      ),
                    ),
                    selectedColor: Colors.teal,
                    backgroundColor: Colors.grey[400],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    onSelected: (val) {
                      if (val) {
                        setState(() {
                          type = "Expense";
                        });
                      }
                    },
                    selected: type == "Expense" ? true : false,
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
              ],
            ),
            //
            const Padding(
              padding: EdgeInsets.only(
                right: 10,
                left: 10,
              ),
              child: Divider(
                height: 1,
                color: Colors.grey,
                thickness: 1,
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Row(
              children: [
                Container(
                  width: 285,
                  child: TextField(
                    controller: _noteCtrl,
                    cursorColor: Colors.grey,
                    style: const TextStyle(
                      color: Colors.black54,
                    ),
                    decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.note,
                        color: Colors.teal,
                      ),
                      hintText: 'โน้ตค่าใช้จ่าย',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(
                right: 10,
                left: 10,
              ),
              child: Divider(
                height: 1,
                color: Colors.grey,
                thickness: 1,
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            SizedBox(
              height: 50.0,
              child: TextButton(
                onPressed: () {
                  _selectDate(context);
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
                      child: const Padding(
                        padding: EdgeInsets.only(left: 12),
                        child: Icon(Icons.date_range,
                            size: 24.0, color: Colors.teal),
                      ),
                    ),
                    const SizedBox(
                      width: 12.0,
                    ),
                    Text(
                      "{$fulldate}",
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
              padding: EdgeInsets.only(
                right: 10,
                left: 10,
              ),
              child: Divider(
                height: 1,
                color: Colors.grey,
                thickness: 1,
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 80.0, right: 80.0),
              child: ElevatedButton(
                onPressed: () {
                  print("Amout: ${_amountCtrl.text}");
                  print('Type:${type}');
                  if (_noteCtrl.text == "") {
                    _noteCtrl.text = type;
                  }
                  print("_noteCtrl: ${_noteCtrl.text}");
                  print(
                      "Selected date: ${selectedDate.day}-${months[selectedDate.month - 1]}-${selectedDate.year + 543}");
                  setState(() {
                    fulldate =
                        "${selectedDate.day} ${months[selectedDate.month - 1]} ${selectedDate.year + 543 - 2500}";
                  });
                  setState(() {
                    updatetransaction(context);
                  });
                  _noteCtrl.clear();
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    fixedSize: const Size(200, 20),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50))),
                child: const Text(
                  'เเก้ไข',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Future updatetransaction(BuildContext context) async {
    var url = Uri.http(host(), 'api/update-transection/$_id');
    Map<String, String> header = {"Content-type": "application/json"};

    String t1 = '"user":"$userID"';
    String t2 = '"amount":"${_amountCtrl.text}"';
    String t3 = '"detail":"${_noteCtrl.text}"';
    String t4 = '"transtype":"$type"';
    String t5 = '"date":"$fulldate"';

    String jsondata = '{$t1,$t2,$t3,$t4,$t5}';
    var response = await http.put(url, headers: header, body: jsondata);
    print('--------result--------');
    print(response.body);
    Navigator.pop(context, 'update');
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showRoundedDatePicker(
      context: context,
      locale: const Locale("th", "TH"),
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
