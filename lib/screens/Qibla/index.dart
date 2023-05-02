import 'package:flutter/material.dart';
import 'package:pray_time/config/constants.dart';
import 'package:pray_time/config/sizeConf.dart';
import 'package:pray_time/screens/Qibla/QiblaContainer.dart';

class Qibla extends StatefulWidget {
  static String routeName = "/Qibla";
  const Qibla({super.key});

  @override
  State<Qibla> createState() => _QiblaState();
}

class _QiblaState extends State<Qibla> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConf().init(context);
    return const Scaffold(
        backgroundColor: backGroundLight, body: QiblaContainer());
  }
}
