import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rotnaam/controller/flutter_local_notification.dart';

class TestNoti extends StatefulWidget {
  const TestNoti({super.key});

  @override
  State<TestNoti> createState() => _TestNotiState();
}

class _TestNotiState extends State<TestNoti> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    LocalNotification.initilaze(flutterLocalNotificationsPlugin);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Local"),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                  onPressed: () {
                    LocalNotification.showBigTextNotification(
                        title: "hi",
                        body: "It's me again",
                        flutterLocalNotificationsPlugin:
                            flutterLocalNotificationsPlugin);
                  },
                  child: Text("Click")),
            )
          ],
        ),
      ),
    );
  }
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
