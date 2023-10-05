import 'package:flutter/material.dart';

class UpdatePost extends StatefulWidget {
  final question;
  const UpdatePost({super.key, this.question});

  @override
  State<UpdatePost> createState() => _UpdatePostState();
}

class _UpdatePostState extends State<UpdatePost> {
  var q = TextEditingController();
  var _qustion;
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
        (now.year + 543).toString() +
        " " +
        now.hour.toString() +
        ":" +
        now.minute.toString();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _qustion = widget.question;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Image.asset('assets/back.png', height: 35, width: 35),
                  iconSize: 50,
                  onPressed: () {
                    Navigator.pop(context, 'refresh');
                  },
                ),
                Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(50)),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        children: [
                          Icon(Icons.delete_rounded, color: Colors.red[400]),
                          Text("ลบโพสต์"),
                        ],
                      ),
                    )),
              ],
            ),
            Text(
              "เเก้ไขโพสต์",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 20, left: 10, right: 10, bottom: 20),
                child: Column(children: [
                  Row(
                    children: [
                      Container(
                        width: 285,
                        child: TextField(
                          controller: q,
                          keyboardType: TextInputType.number,
                          cursorColor: Colors.grey,
                          style: TextStyle(
                            color: Colors.black54,
                          ),
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.edit_note_outlined,
                              color: Color.fromARGB(255, 133, 133, 133),
                            ),
                            hintText: _qustion,
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
                  Padding(
                      padding: const EdgeInsets.only(left: 80.0, right: 80.0),
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff3AAA94),
                            fixedSize: const Size(130, 20),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50))),
                        child: const Text(
                          'เเก้ไข',
                          style: TextStyle(color: Colors.white),
                        ),
                      ))
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
