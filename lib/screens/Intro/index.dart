import 'package:flutter/material.dart';
import 'package:pray_time/config/constants.dart';
import 'package:pray_time/config/sizeConf.dart';
import 'package:pray_time/screens/Intro/IntroContainer.dart';
import 'package:pray_time/screens/Notification/NotificationContainer.dart';

class Intro extends StatefulWidget {
  static String routeName = "/Notification";
  const Intro({super.key});

  @override
  State<Intro> createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConf().init(context);
    return const IntroContainer();
  }
}
