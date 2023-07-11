import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';

class UpdatePlant extends StatefulWidget {
  //constructor
  final v1, v2, v3, v4;
  bool? v5;
  UpdatePlant(this.v1, this.v2, this.v3, this.v4, this.v5, {super.key});

  @override
  State<UpdatePlant> createState() => _UpdatePlantState();
}

class _UpdatePlantState extends State<UpdatePlant> {
  int? userID;
  var _v1, _v2, _v3, _v4, _v5;
  DateTime selectedDate = DateTime.now();
  var plantstype = TextEditingController();
  var detail = TextEditingController();
  bool? status;
  String fulldate = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _v1 = widget.v1; //id
    _v2 = widget.v2; //title
    _v3 = widget.v3; //details
    _v4 = widget.v4;
    _v5 = widget.v5;
    plantstype.text = _v2;
    detail.text = _v3;
    fulldate = _v4;
    status = _v5;
    print(_v1);
  }

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
                    Navigator.pop(context, 'refresh');
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
                    controller: plantstype,
                    cursorColor: Colors.grey,
                    style: TextStyle(
                      color: Colors.black54,
                    ),
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.money,
                        color: Color.fromARGB(255, 133, 133, 133),
                      ),
                      hintText: 'ชื่อพืช',
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
                  width: 285,
                  child: TextField(
                    controller: detail,
                    cursorColor: Colors.grey,
                    style: TextStyle(
                      color: Colors.black54,
                    ),
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.note,
                        color: Color.fromARGB(255, 133, 133, 133),
                      ),
                      hintText: 'โน้ต',
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
                      "${_v4}",
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
            Checkbox(
              value: status,
              onChanged: (bool? value) {
                setState(() {
                  status = value!;
                });
              },
            ),

            Padding(
              padding: const EdgeInsets.only(left: 80.0, right: 80.0),
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    fulldate =
                        "${selectedDate.day} ${months[selectedDate.month - 1]} ${selectedDate.year + 543 - 2500}";
                  });
                  // postTodo();
                  // String t2 = "${plantstype.text}";
                  // String t3 = "${detail.text}";
                  // String t4 = "${fulldate}";
                  // bool t5 = status;
                  // print('${t2} ${t3} ${t4} ${t5}');
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
      // getPlants();
    });
  }
}
