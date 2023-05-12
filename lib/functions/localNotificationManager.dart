import 'dart:math';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotification {
  LocalNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
  });

  int id;
  String? title;
  String? body;
  String? payload;
  //local notification

  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  static Future initialize(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var androidInitialize =
    new AndroidInitializationSettings('mipmap/launcher_icon');
    var iosInitialize = new DarwinInitializationSettings();
    var initializationsSettings = new InitializationSettings(
        android: androidInitialize, iOS: iosInitialize);
    await flutterLocalNotificationsPlugin.initialize(initializationsSettings);
  }

  static Future showBigTextNotification(
      {var id = 0, required String title, required String body,
        var payload,String? soundsrc , required FlutterLocalNotificationsPlugin fln
      }) async {
    AndroidNotificationDetails androidPlatformChannelSpecifics =
    new AndroidNotificationDetails (
      'you_can_name_it_whatever'+Random().nextInt(pow(2,32) as int).toString(),
      'channel_name',
      playSound: true,
      sound: RawResourceAndroidNotificationSound(soundsrc ?? 'notification2'),
      importance: Importance.max,
      priority: Priority.high,
      enableVibration: true,
    ); // AndroidNotificationDetails
    var not = NotificationDetails(android: androidPlatformChannelSpecifics,
        iOS: DarwinNotificationDetails()
    ); // NotificationDetails
    await fln.show(0, title, body, not);
  }


}

