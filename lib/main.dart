import "dart:ui";

import "package:android_alarm_manager_plus/android_alarm_manager_plus.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_localizations/flutter_localizations.dart";
import "package:just_audio_background/just_audio_background.dart";
import "package:pray_time/config/appLocal.dart";
import "package:pray_time/config/constants.dart";
import "package:pray_time/config/localStorage.dart";
import "package:pray_time/functions/localNotificationManager.dart";
import 'package:pray_time/provider/states.dart';
import "package:pray_time/screens/Intro/index.dart";
import "package:pray_time/screens/Notification/index.dart";
import "package:provider/provider.dart";
import "package:pray_time/routes.dart";
import "package:pray_time/screens/Home/index.dart";
import "package:pray_time/functions/backgroundService.dart";
import 'package:onesignal_flutter/onesignal_flutter.dart';
import "dart:isolate";
import 'package:workmanager/workmanager.dart';


// void OneSignalExec() async {
//   await OneSignal.shared.setAppId(oneSignalId);
//   OneSignal.shared.setNotificationWillShowInForegroundHandler((event) {
//     OSNotificationDisplayType.notification;
//   });
// }


ReceivePort port = ReceivePort();

void main() async {
  await WidgetsFlutterBinding.ensureInitialized();
  // ReceivePort port = ReceivePort();
  // await JustAudioBackground.init(
  //   androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
  //   androidNotificationChannelName: 'Audio playback',
  //   androidNotificationOngoing: true,
  // );
  await IsolateNameServer.registerPortWithName(port.sendPort, isolateName);
  await AndroidAlarmManager.initialize();
  // Workmanager().initialize (
  //     workManagerCallbackDispatcher, // The top level function, aka callbackDispatcher
  //     isInDebugMode: true // If enabled it will post a notification whenever the task is running. Handy for debugging tasks
  // );
  await LocalNotification.initialize(LocalNotification.flutterLocalNotificationsPlugin);

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => States(),
      child: const MaterialAppChanger(),
    );
  }
}

class MaterialAppChanger extends StatefulWidget {
  const MaterialAppChanger({super.key});
  static void setLocale(BuildContext context, Locale newLocale) {
    MaterialAppChangerState? state =
    context.findAncestorStateOfType();
    if (state != null) {
      state.setLocale(newLocale);
    }
  }
  @override
  MaterialAppChangerState createState() => MaterialAppChangerState();
}

class MaterialAppChangerState extends State<MaterialAppChanger> {
  Locale _locale = const Locale("en");
  String? _pageNavigation;
  String? data;

  @override
  void initState() {
    // Isolate.spawn(WorkManager.callbackDispatcher, "hello world");
    // callMethodback();
    // OneSignalExec();
    // print("the route is : "+ data.toString());
    // WidgetsBinding.instance.addPostFrameCallback((_) async {
    //   // getStringValue("page").then((value) {
    //   //   setState(() {
    //   //     if (value == null)
    //   //       _pageNavigation = "/Intro";
    //   //     _pageNavigation = value;
    //   //     print("the page us :" + _pageNavigation.toString());
    //   //   });
    //   // });
    // });
    super.initState();
  }

  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() async {
    await getStringValue('lang').then((locale) {
      setState(() {
        this._locale = (locale == null) ? Locale('en', '') : Locale(locale, '');
      });
    });
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    getStringValue('lang').then((locale) {
      setState(() {
        this._locale = (locale == null) ? Locale('en', '') : Locale(locale, '');
      });
    });
    removeValue("trigger");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Pray Time',
        home: Intro(),
        routes: routes,
        initialRoute: Intro.routeName,
        localizationsDelegates: const [
          AppLocale.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        supportedLocales: const [
          Locale("en", ""),
          Locale("ar", ""),
        ],
        locale: _locale,
        localeResolutionCallback: (currentLang, supportLang) {
          if (currentLang != null) {
            for (Locale locale in supportLang) {
              if (locale.languageCode == currentLang.languageCode) {
                return currentLang;
              }
            }
          }
          return supportLang.first;
        });
  }
}
