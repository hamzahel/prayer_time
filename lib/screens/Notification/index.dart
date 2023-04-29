import 'package:flutter/material.dart';
import 'package:pray_time/config/constants.dart';
import 'package:pray_time/config/sizeConf.dart';
import 'package:pray_time/screens/Notification/NotificationContainer.dart';
class Notifier extends StatefulWidget {
  static String routeName = "/Notification";
  const Notifier({super.key});

  @override
  State<Notifier> createState() => _NotifierState();
}

class _NotifierState extends State<Notifier> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConf().init(context);
    return const Scaffold(
        backgroundColor: backGroundLight, body: NotificationContainer());
  }
}
