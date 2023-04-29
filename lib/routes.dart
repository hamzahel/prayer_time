import "package:flutter/material.dart";
import 'package:pray_time/screens/Home/index.dart';
import 'package:pray_time/screens/Intro/index.dart';
import 'package:pray_time/screens/Qibla/index.dart';
import 'package:pray_time/screens/Settings/index.dart';
import 'package:pray_time/screens/Notification/index.dart';

final Map<String, WidgetBuilder> routes = {
  Home.routeName: (context) => const Home(),
  Settings.routeName: (context) => const Settings(),
  Notifier.routeName: (context) => const Notifier(),
  Intro.routeName: (context) => const Intro(),
  Qibla.routeName: (context) => const Qibla()
};
