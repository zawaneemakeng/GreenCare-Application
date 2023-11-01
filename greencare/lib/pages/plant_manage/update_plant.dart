// ignore_for_file: must_be_immutable
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:rotnaam/utils/api_url.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';

class UpdatePlant extends StatefulWidget {
  final user, id, plantname, detail, startdate;
  bool? status;
  UpdatePlant(
      {super.key,
      this.user,
      this.id,
      this.plantname,
      this.detail,
      this.startdate,
      this.status});

  @override
  State<UpdatePlant> createState() => _UpdatePlantState();
}

class _UpdatePlantState extends State<UpdatePlant> {
  TimeOfDay starttime = const TimeOfDay(
    hour: 19,
    minute: 30,
  );
  TimeOfDay endtime = const TimeOfDay(hour: 1, minute: 30);
  final TimeOfDay currentTime = TimeOfDay.now();
  var moiture = TextEditingController();
  int? userID;
  var _id, _plantname, _detail;
  DateTime selectedDate = DateTime.now();
  var plantnameCtrl = TextEditingController();
  var detailCtrl = TextEditingController();
  bool? _status;
  String? _startdate;
  String? _enddate;

  @override
  void initState() {
    super.initState();
    userID = widget.user;
    _id = widget.id;
    _plantname = widget.plantname;
    _detail = widget.detail;
    _startdate = widget.startdate;
    _status = widget.status;
    plantnameCtrl.text = _plantname;
    detailCtrl.text = _detail;
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
  String formattedDateTime() {
    DateTime now = DateTime.now();
    return now.day.toString() +
        " " +
        months[now.month - 1] +
        " " +
        (now.year + 543).toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15, top: 10),
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
          const Text(
            "เเก้ไขข้อมูลการปลูก",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w700,
            ),
          ),
          //
          const SizedBox(
            height: 20.0,
          ),
          updatePlantWidget()
        ],
      ),
    );
  }

  Widget updatePlantWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(15)),
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Container(
                    width: 285,
                    child: TextField(
                      controller: plantnameCtrl,
                      cursorColor: Colors.grey,
                      style: const TextStyle(
                        color: Colors.black54,
                      ),
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.grass_outlined,
                          color: Colors.teal,
                        ),
                        hintText: plantnameCtrl.text,
                        border: InputBorder.none,
                      ),
                    ))
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
            const SizedBox(
              height: 10.0,
            ),
            Row(
              children: [
                Container(
                  width: 285,
                  child: TextField(
                    controller: detailCtrl,
                    cursorColor: Colors.grey,
                    style: const TextStyle(
                      color: Colors.black54,
                    ),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.description,
                        color: Colors.teal,
                      ),
                      hintText: detailCtrl.text,
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
            const SizedBox(
              height: 10.0,
            ),
            SizedBox(
              height: 45.0,
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
                        child: Icon(
                          Icons.date_range,
                          size: 24.0,
                          color: Colors.teal,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 12.0,
                    ),
                    Text(
                      "${selectedDate.day} ${months[selectedDate.month - 1]} ${selectedDate.year + 543 - 2500}",
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
            const SizedBox(
              height: 10.0,
            ),
            Column(
              children: [
                Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 12),
                      child: Icon(
                        Icons.check_circle_outline_outlined,
                        size: 24.0,
                        color: Colors.teal,
                      ),
                    ),
                    const SizedBox(
                      width: 12.0,
                    ),
                    Text(
                      "สถานะ",
                      style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const SizedBox(
                      height: 60,
                      width: 45.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: ChoiceChip(
                        avatar: CircleAvatar(
                          backgroundColor: Colors.grey[400],
                          backgroundImage: null,
                        ),
                        label: Text(
                          "เก็บเกี่ยว",
                          style: TextStyle(
                            fontSize: 14.0,
                            color:
                                _status == true ? Colors.white : Colors.black,
                          ),
                        ),
                        selectedColor: Colors.teal,
                        backgroundColor: Colors.grey[300],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                        onSelected: (val) {
                          if (val) {
                            setState(() {
                              _status = true;
                            });
                          }
                        },
                        selected: _status == true ? true : false,
                      ),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: ChoiceChip(
                        avatar: CircleAvatar(
                          backgroundColor: Colors.grey[400],
                          backgroundImage: null,
                        ),
                        label: Text(
                          "ยังไม่เก็บเกี่ยว",
                          style: TextStyle(
                            fontSize: 14.0,
                            color:
                                _status == false ? Colors.white : Colors.black,
                          ),
                        ),
                        selectedColor: Colors.teal,
                        backgroundColor: Colors.grey[300],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                        onSelected: (val) {
                          if (val) {
                            setState(() {
                              _status = false;
                            });
                          }
                        },
                        selected: _status == false ? true : false,
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                  ],
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(right: 10, left: 10, bottom: 10),
              child: Divider(
                height: 1,
                color: Colors.grey,
                thickness: 1,
              ),
            ),
            Row(
              children: [
                Container(
                  width: 270,
                  child: TextField(
                    controller: moiture,
                    cursorColor: Colors.grey,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(
                      color: Colors.black54,
                    ),
                    decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.water_drop_rounded,
                        color: Colors.teal,
                      ),
                      hintText: 'ความในดินชื้นที่ต้องการ',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                showDialogPhoto()
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
            const SizedBox(
              height: 10.0,
            ),
            SizedBox(
              height: 50.0,
              child: TextButton(
                onPressed: () async {
                  TimeOfDay? newTime = await showTimePicker(
                      context: context, initialTime: starttime);
                  if (newTime == null) return;
                  setState(() {
                    starttime = newTime;
                  });
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
                        child: Icon(
                          Icons.timelapse_rounded,
                          size: 24.0,
                          color: Colors.teal,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 12.0,
                    ),
                    Text(
                      "เวลาเปิดไฟ ${starttime.hour}:${starttime.minute}",
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
            const SizedBox(
              height: 10.0,
            ),
            SizedBox(
              height: 50.0,
              child: TextButton(
                onPressed: () async {
                  TimeOfDay? newTime = await showTimePicker(
                      context: context, initialTime: endtime);
                  if (newTime == null) return;
                  setState(() {
                    endtime = newTime;
                  });
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
                        child: Icon(
                          Icons.timelapse_rounded,
                          size: 24.0,
                          color: Colors.teal,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 12.0,
                    ),
                    Text(
                      "เวลาปิดไฟ ${endtime.hour}:${endtime.minute}",
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
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.only(left: 80.0, right: 80.0),
              child: ElevatedButton(
                onPressed: () {
                  print(_status);
                  setState(() {
                    if (plantnameCtrl.text == '') {
                      plantnameCtrl.text = _plantname;
                    }
                    if (detailCtrl.text == '') {
                      detailCtrl.text = _detail;
                    }
                    if (_status == true) {
                      _enddate = formattedDateTime();
                      updatePlant(context);
                    } else {
                      _enddate = '-';
                      print(_enddate);
                      updatePlant(context);
                    }
                  });
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

  Future updatePlant(BuildContext context) async {
    final String apiUrl = 'http://${host()}/update-plant/$_id';
    final Map<String, dynamic> dataToUpdate = {
      "plantname": plantnameCtrl.text,
      "detail": detailCtrl.text,
      "startdate": "$_startdate",
      "enddate": "$_enddate",
      "status": "$_status",
    };
    print(plantnameCtrl.text);
    final response = await http.patch(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(dataToUpdate),
    );
    setState(() {
      print(response.body);
      Navigator.pop(context, 'update');
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showRoundedDatePicker(
      context: context,
      locale: const Locale("th", "TH"),
      era: EraMode.BUDDHIST_YEAR,
      initialDate: selectedDate,
      firstDate: DateTime(2017, 1),
      lastDate: DateTime(2037),
      theme: ThemeData(
        primarySwatch: Colors.teal,
        fontFamily: 'PK',
      ),
      styleDatePicker: MaterialRoundedDatePickerStyle(
        textStyleDayOnCalendarSelected:
            const TextStyle(fontSize: 16, color: Colors.white),
      ),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Widget showDialogPhoto() {
    return IconButton(
      onPressed: () => showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16.0))),
          surfaceTintColor: const Color(0xff3AAA94),
          backgroundColor: Colors.white,
          content: Container(
            height: 100,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 15),
                  Text(
                    "ดินแห้ง   : 520-430 %RH ",
                    style: TextStyle(color: Colors.grey[800], fontSize: 15),
                  ),
                  Text(
                    "ดินเปียก : 430 350 %RH ",
                    style: TextStyle(color: Colors.grey[800], fontSize: 15),
                  ),
                  Text(
                    "ดินเเฉะ   : 350 260 %RH ",
                    style: TextStyle(color: Colors.grey[800], fontSize: 15),
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('ปิด', style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
      icon: const Icon(
        Icons.info_outline,
        size: 26,
        color: Colors.grey,
      ),
    );
  }
}
