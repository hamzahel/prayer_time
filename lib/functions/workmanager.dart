import 'dart:io';
import 'dart:developer' as developer;
import 'dart:isolate';

import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:just_audio/just_audio.dart';
import 'package:pray_time/config/localStorage.dart';
import 'package:pray_time/functions/audioManager.dart';
import 'package:pray_time/functions/localNotificationManager.dart';
import 'package:pray_time/models/audioModel.dart';
import 'package:pray_time/provider/states.dart';
import 'package:workmanager/workmanager.dart';


final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

@pragma('vm:entry-point')
void callbackDispatcher() async {
  // WidgetsFlutterBinding.ensureInitialized();
  print("\n\n\nokok");
  Workmanager().executeTask((taskType, inputData) async {
    print("you enter to workmanager");

    switch (taskType) {
      case "azanTime":
        {
          AudioPlayer _player = AudioPlayer();
          int? index = await getIntValue("audioIndex");
            if (index == null)
          await initAudio(_player, audios[0]);
            else
              initAudio(_player, audios[index]);
          await _player.play();


          await LocalNotification.initialize(flutterLocalNotificationsPlugin);
          await LocalNotification.showBigTextNotification(
              title: "pray time",
              body: "the azane is up comming from azantime",
              fln: flutterLocalNotificationsPlugin);
        }
        break;
      case "remainingTime":
        {
          LocalNotification.initialize(flutterLocalNotificationsPlugin);
          LocalNotification.showBigTextNotification(
              title: "pray time remaining",
              body: "the azane is up comming remaining.",

              fln: flutterLocalNotificationsPlugin);
        }
        break;
      default:
        print("you print to one signal ");
        break;
    }
    States state = States();
    state.init();
    return Future.value(true);
  });
}
