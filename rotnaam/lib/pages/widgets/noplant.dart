import 'package:flutter/material.dart';

Widget noPlant() {
  return Padding(
    padding: const EdgeInsets.all(15.0),
    child: Container(
      height: 100,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: Colors.grey[300], borderRadius: BorderRadius.circular(8.0)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.nature,
                color: Color(0xff3AAA94),
                size: 30,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                '''กรุณาเชื่อมอุปรกณ์
เเละเพิ่มข้อมูลการปลูกผัก''',
                style: TextStyle(color: Colors.grey[600], fontSize: 14),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
