import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';
import 'package:pray_time/config/appLocal.dart';
import 'package:pray_time/config/constants.dart';
import 'package:pray_time/config/localStorage.dart';
import 'package:pray_time/config/sizeConf.dart';
import 'package:pray_time/functions/audioManager.dart';
import 'package:pray_time/models/audioModel.dart';
import 'package:pray_time/provider/states.dart';
import 'package:pray_time/screens/Home/index.dart';
import 'package:pray_time/screens/Intro/index.dart';
import 'package:pray_time/screens/Notification/index.dart';
import 'package:provider/provider.dart';

class NotificationContainer extends StatefulWidget {
  const NotificationContainer({super.key});

  @override
  State<NotificationContainer> createState() => _NotificationContainerState();
}

class _NotificationContainerState extends State<NotificationContainer> {

  States provider = States();
  AudioPlayer _player = AudioPlayer();
  String? prayName;


  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      int? index = await getIntValue("audioIndex");
      if (index == null)
        await initAudio(_player, audios[0]);
      else
        await initAudio(_player, audios[index]);
      getStringValue("prayName").then((value){
        setState(() {
          if (value == null)
            prayName = "Fajr001";
          prayName = value;
        });
      });
      // if (prayName == null)
      //   prayName = "Fajr001";
      await _player.play();
      await Future.delayed(
        const Duration(seconds: 30),
      );
      // await provider.init();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<States>(builder: (context, value, child) {
      return SafeArea(
        child: SizedBox(
            height: SizeConf.screenHeight,
            child: Column(
              children: [
                SizedBox(
                  height: getProportionateScreenHeight(120),
                ),
                InkWell(onDoubleTap: () async {
                  _player.stop();
                  // Navigator.of(context)
                  //     .pushReplacementNamed(Intro.routeName);
                  Navigator.pushNamedAndRemoveUntil(context, Intro.routeName , (route) => true);
                  SystemNavigator.pop(animated: true);
                  // Navigator.pop(context);
                },
                  child: notifierIcon,
                ),
                SizedBox(
                  height: getProportionateScreenHeight(50),
                ),
                Text(getLang(context, "ItsTimeFor") ?? "",
                    style: TextStyle(
                        color: backGround,
                        fontWeight: FontWeight.w500,
                        fontSize: getProportionateScreenWidth(24))),
                SizedBox(
                  height: getProportionateScreenHeight(20),
                ),
                Text( getLang(context, prayName) ?? "",
                    style: TextStyle(
                        color: backGround,
                        fontWeight: FontWeight.w700,
                        fontSize: getProportionateScreenWidth(46))),
                SizedBox(
                  height: getProportionateScreenHeight(20),
                ),
                Text(getLang(context, "Prayer") ?? "",
                    style: TextStyle(
                        color: backGround,
                        fontWeight: FontWeight.w500,
                        fontSize: getProportionateScreenWidth(14))),
              ],
            )),
      );
    });
  }
}
