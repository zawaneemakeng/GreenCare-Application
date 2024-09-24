import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotification {
  static Future initilaze(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var androidInitilize =
        const AndroidInitializationSettings('mipmap/launcher_icon');

    DarwinInitializationSettings initializationSettingDarwin =
        const DarwinInitializationSettings();
    var initializationSettings = InitializationSettings(
        android: androidInitilize, iOS: initializationSettingDarwin);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  static Future showBigTextNotification({
    var id = 0,
    required String title,
    required String body,
    var payload,
    required FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
  }) async {
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails("2", "chanal_name",
            playSound: true,
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    const DarwinNotificationDetails darwinNotificationDetails =
        DarwinNotificationDetails(
      presentSound: false,
    );
    var noti = NotificationDetails(
        android: androidNotificationDetails, iOS: darwinNotificationDetails);
    await flutterLocalNotificationsPlugin.show(0, title, body, noti);
  }
}
