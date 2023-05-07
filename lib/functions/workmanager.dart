import 'dart:isolate';
import 'dart:ui';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:just_audio/just_audio.dart';
import 'package:pray_time/config/localStorage.dart';
import 'package:pray_time/functions/audioManager.dart';
import 'package:pray_time/functions/localNotificationManager.dart';
import 'package:pray_time/main.dart';
import 'package:pray_time/models/audioModel.dart';
import 'package:pray_time/provider/states.dart';


final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

String isolateName = "isolate";
SendPort? portReceiver;

@pragma('vm:entry-point')
void callbackDispatcher() async {
    print("you enter to workmanager");

    // switch (taskType) {
    //   case "azanTime":
    //     {
    //       await LocalNotification.initialize(flutterLocalNotificationsPlugin);
    //       await LocalNotification.showBigTextNotification(
    //           title: "pray time",
    //           body: "the azane ",
    //           fln: flutterLocalNotificationsPlugin);
    //
    //       AudioPlayer _player = AudioPlayer();
    //       int? index = await getIntValue("audioIndex");
    //         if (index == null)
    //           await initAudio(_player, audios[0]);
    //         else
    //           await initAudio(_player, audios[index]);
    //       await _player.play();
    //     }
    //     break;
    //   case "remainingTime":
    //     {
    //       LocalNotification.initialize(flutterLocalNotificationsPlugin);
    //       LocalNotification.showBigTextNotification(
    //           title: "pray time remaining",
    //           body: "the azane is up comming Notification",
    //           fln: flutterLocalNotificationsPlugin);
    //     }
    //     break;
    //   case "initAll":
    //     {
    //       States state = States();
    //       await state.init();
    //       await state.triggerNotificationAndAzan();
    //     }
    //     break;
    //   // default:
    //   //   print("you print to one signal ");
    //   //   break;
    // }

    portReceiver ??= IsolateNameServer.lookupPortByName(isolateName);
    portReceiver?.send(null);
}
