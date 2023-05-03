import 'package:flutter/material.dart';
import 'package:pray_time/config/appLocal.dart';
import 'package:pray_time/config/constants.dart';
import 'package:pray_time/config/sizeConf.dart';
import 'package:pray_time/provider/states.dart';
import 'package:pray_time/screens/Home/index.dart';
import 'package:provider/provider.dart';

class NotificationContainer extends StatefulWidget {
  const NotificationContainer({super.key});

  @override
  State<NotificationContainer> createState() => _NotificationContainerState();
}

class _NotificationContainerState extends State<NotificationContainer> {
  @override
  Widget build(BuildContext context) {
    return Consumer<States>(builder: (context, value, child) {
      // print("\n\n\nthe value is : " + value.getPackageInfo.version);
      return InkWell(
        onDoubleTap: () => Navigator.pushNamed(context, Home.routeName),
        child: SizedBox(
            height: SizeConf.screenHeight,
            child: Column(
              children: [
                SizedBox(
                  height: getProportionateScreenHeight(120),
                ),
                notifierIcon,
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
                Text(getLang(context, "Asr") ?? "",
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
