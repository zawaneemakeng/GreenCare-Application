import 'package:flutter/material.dart';
import 'package:greencare/pages/add_transection.dart';

class MoneyManager extends StatefulWidget {
  const MoneyManager({super.key});

  @override
  State<MoneyManager> createState() => _MoneyManagerState();
}

class _MoneyManagerState extends State<MoneyManager> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(" No Data "),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddTransition()));
        },
        backgroundColor: Colors.green,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        child: Icon(
          Icons.add,
          size: 32.0,
        ),
      ),
    );
  }
}
