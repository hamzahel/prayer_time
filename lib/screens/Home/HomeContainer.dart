import 'package:flutter/material.dart';
import 'package:pray_time/config/appLocal.dart';
import 'package:pray_time/config/constants.dart';
import 'package:pray_time/config/sizeConf.dart';
import 'package:pray_time/config/tools.dart';
import 'package:pray_time/functions/localNotificationManager.dart';
import 'package:pray_time/provider/states.dart';
import 'package:pray_time/screens/Home/components/BoxTime.dart';
import 'package:pray_time/screens/Home/components/BoxTimesPray.dart';
import 'package:pray_time/screens/Home/components/TwoBoxTime.dart';
import 'package:provider/provider.dart';
import 'package:pray_time/components/Date.dart';
import 'package:hijri/hijri_calendar.dart';

class HomeContainer extends StatefulWidget {
  const HomeContainer({super.key});

  @override
  State<HomeContainer> createState() => _HomeContainerState();
}

class _HomeContainerState extends State<HomeContainer> {

  @override
  void initState() {
    // TODO: implement initState
    // WidgetsBinding.instance.addPostFrameCallback((_) async {
    //   await LocalNotification.showBigTextNotification(
    //       title: "pray time",
    //       body: "the azane ",
    //       fln: LocalNotification.flutterLocalNotificationsPlugin);
    // });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<States>(builder: (context, value, child) {
      return Container(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          color: backGround,
          child: Container(
            width: SizeConf.screenWidth,
            height: SizeConf.screenHeight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: getProportionateScreenHeight(12),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(60),
                  child: Center(
                    child: Text(
                      getLang(context, "Today") ?? "TODAY",
                      textScaleFactor: 1.0,
                      style:
                          TextStyle(fontSize: mFontSize, color: primaryColor),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Date(
                        day: HijriCalendar.now().hDay ?? 1,
                        month: getLang(
                            context,
                            getMonthArabicString(
                                HijriCalendar.now().hMonth)) ?? "",
                        year: HijriCalendar.now().hYear ?? 1444),
                    Date(
                        day: value.getCurrentData.gregorianDate.day ?? 1,
                        month: getLang(
                            context,
                            getMonthString(
                                value.getCurrentData.gregorianDate.month)) ?? "",
                        year: value.getCurrentTime.year ?? 2023),
                  ],
                ),
                SizedBox(
                  height: getProportionateScreenHeight(20),
                ),
                TwoBoxTime(),
                SizedBox(
                  height: getProportionateScreenHeight(0),
                ),
                BoxTimesPray(),
              ],
            ),
          ));
    });
  }
}
