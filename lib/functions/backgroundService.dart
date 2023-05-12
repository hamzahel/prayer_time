import 'dart:isolate';
import 'dart:ui';


import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:pray_time/config/localStorage.dart';
import 'package:pray_time/functions/localNotificationManager.dart';
import 'package:pray_time/main.dart';
import 'package:pray_time/models/audioModel.dart';
import 'package:pray_time/provider/states.dart';
import 'package:workmanager/workmanager.dart';




// @pragma('vm:entry-point')
// void startCallBack() async
// {
//   await Isolate.spawn(WorkManager.callbackDispatcher, "hello world11");
// }

String isolateName = "isolate";
SendPort? portReceiver;

// @pragma('vm:entry-point')
// void workManagerCallbackDispatcher() {
//   Workmanager().executeTask((task, inputData) async {
//     // const MethodChannel channelScreen = MethodChannel('example.com/channel_alarm');
//     // await channelScreen.invokeMethod("launchScreen");
//     // await callMethodback();
//     if (task == "initAlarm")
//       {
//         States provider = States();
//         await provider.init();
//         FlutterLocalNotificationsPlugin flutterLocalNotificationsPluginx =
//         FlutterLocalNotificationsPlugin();
//         await LocalNotification.showBigTextNotification(
//             title: "looping is start ",
//             body: "init all function",
//             fln: flutterLocalNotificationsPluginx);
//       }
//     // portReceiver ??= IsolateNameServer.lookupPortByName(isolateName);
//     // portReceiver?.send(null);
//     return Future.value(true);
//   });
// }


// @pragma('vm:entry-point')
// void callbackDispatcherLoop(int i) async {
//
//   FlutterLocalNotificationsPlugin flutterLocalNotificationsPluginx =
//   FlutterLocalNotificationsPlugin();
//   await LocalNotification.showBigTextNotification(
//       title: "looping is start ",
//       body: "init all function",
//       fln: flutterLocalNotificationsPluginx);
//   print("the value from looop : ");
// }



@pragma('vm:entry-point')
void callbackDispatcher(int i ,Map<String, dynamic> params) async {

    // const MethodChannel channelScreen = MethodChannel('example.com/channel_alarm');
    // await channelScreen.invokeMethod("launchScreen");
    // await callMethodback();
  if (i == 99)
    {
      States provider = States();
      await provider.exInit();
      // FlutterLocalNotificationsPlugin flutterLocalNotificationsPluginx =
      // FlutterLocalNotificationsPlugin();
      // await LocalNotification.showBigTextNotification(
      //     title: "looping is start ",
      //     body: "init all function",
      //     fln: flutterLocalNotificationsPluginx);
    }
  if ( i >= 7 && i < 99 ) {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPluginx =
    FlutterLocalNotificationsPlugin();
    await LocalNotification.showBigTextNotification(
        title: "Time to pray ",
        body: "Time to pray " + params["name"] +
            " is soon! (${params["delay"]} min)",
        soundsrc: notificationSounds[await getIntValue("notificationIndex") ?? 0].tag.title.toString(),
        fln: flutterLocalNotificationsPluginx);
  }
  if (i < 7)
    {
      print("you enter here: "+ params["name"]);
      await addStringValue("prayName", params["name"]);
    }
    portReceiver ??= IsolateNameServer.lookupPortByName(isolateName);
    portReceiver?.send(null);
}



// class WorkManager {

//
//   // @pragma('vm:entry-point')
//
// }
