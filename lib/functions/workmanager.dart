import 'dart:io';
import 'dart:developer' as developer;

import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:just_audio/just_audio.dart';
import 'package:pray_time/functions/audioManager.dart';
import 'package:pray_time/functions/localNotificationManager.dart';
import 'package:pray_time/models/audioModel.dart';
import 'package:pray_time/provider/states.dart';
import 'package:pray_time/screens/Notification/index.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

void AzanTimeHandler ()
{
    print ("azanTime is up");
}

void RemainingTimeHandler ()
{
    print ("remaining time handler");
}

void OneSignalHandler ()
{
    print ("one signal handler");
}

void runScreen() async {
  Process process = await Process.start('screen', ['-S', 'myScreenSession']);
  process.stdin.writeln('ls'); // You can add any command to the Screen session
  process.stdin.writeln('exit');
}

@pragma('vm:entry-point')
void callbackDispatcher () async
{
    // WidgetsFlutterBinding.ensureInitialized();
    print("\n\n\nokok");
    Workmanager().executeTask((taskType, inputData) async {
      final AudioPlayer _player = AudioPlayer();
      print ("you enter to workmanager");
      //initialize local notification

    switch (taskType) {
      case "azanTime":
        {
          print("\n\nyou enter to azan time\n\n");
          // int index = inputData?["index"];
          // int diff = inputData?["diff"];
          // developer.log("the azan is done !" + index.toString());
          runApp(Notifier());
          await LocalNotification.initialize(flutterLocalNotificationsPlugin);
          await LocalNotification.showBigTextNotification(
              title: "pray time",
              body: "the azane is up comming from azantime",
              fln: flutterLocalNotificationsPlugin);
          await initAudio(_player, audios[1].src);
          await _player.play();
        }
        break;
      case "remainingTime":
        {
          print("the notification is trigger");
          LocalNotification.initialize(flutterLocalNotificationsPlugin);
          LocalNotification.showBigTextNotification(
                  title: "pray time",
                  body: "the azane is up comming",
                  fln: flutterLocalNotificationsPlugin);
        }
        break;
      default:
        print("you print to one signal ");
        break;
    }
    return Future.value(true);
    });
}