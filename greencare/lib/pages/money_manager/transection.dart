import 'package:flutter/material.dart';
import 'package:greencare/pages/money_manager/add_transection.dart';

class AllTransection extends StatefulWidget {
  const AllTransection({super.key});

  @override
  State<AllTransection> createState() => _AllTransectionState();
}

class _AllTransectionState extends State<AllTransection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddTransection()),
            );
          },
          backgroundColor: Color(0xff3AAA94),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
          child: Icon(
            Icons.add,
            size: 35.0,
            color: Colors.white,
          ),
        ),
      ),
      body: Center(
        child: Text('NO data'),
      ),
    );
  }
}
