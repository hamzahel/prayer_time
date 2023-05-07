import "dart:ui";

import "package:android_alarm_manager_plus/android_alarm_manager_plus.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_localizations/flutter_localizations.dart";
import "package:just_audio_background/just_audio_background.dart";
import "package:pray_time/config/appLocal.dart";
import "package:pray_time/config/localStorage.dart";
import 'package:pray_time/provider/states.dart';
import "package:pray_time/screens/Intro/index.dart";
import "package:provider/provider.dart";
import "package:pray_time/routes.dart";
import "package:pray_time/screens/Home/index.dart";
import "package:pray_time/functions/workmanager.dart";
import 'package:onesignal_flutter/onesignal_flutter.dart';
import "dart:isolate";



ReceivePort port = ReceivePort();

void OneSignalExec() async {
  await OneSignal.shared.setAppId("157e7ac8-711d-4822-9b57-dbb129aabed3");
  OneSignal.shared.setNotificationWillShowInForegroundHandler((event) {
    OSNotificationDisplayType.notification;
  });
}


void main() async {
  await WidgetsFlutterBinding.ensureInitialized();

  await IsolateNameServer.registerPortWithName(port.sendPort, isolateName);
  // await JustAudioBackground.init(
  //   androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
  //   androidNotificationChannelName: 'Audio playback',
  //   androidNotificationOngoing: true,
  // );
  await AndroidAlarmManager.initialize();
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

  @override
  void initState() {
    OneSignalExec();
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
        home: const Home(),
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
