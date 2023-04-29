import 'package:flutter/material.dart';
import 'package:pray_time/components/CustomBottomNavBar.dart';
import 'package:pray_time/config/appLocal.dart';
import 'package:pray_time/config/constants.dart';
import 'package:pray_time/config/sizeConf.dart';
import 'package:pray_time/config/tools.dart';
import 'package:pray_time/provider/states.dart';
import 'package:pray_time/screens/Home/components/BoxTime.dart';
import 'package:pray_time/screens/Home/components/BoxTimesPray.dart';
import 'package:pray_time/screens/Home/index.dart';
import 'package:provider/provider.dart';
import 'package:pray_time/components/Date.dart';

class HomeContainer extends StatefulWidget {
  const HomeContainer({super.key});

  @override
  State<HomeContainer> createState() => _HomeContainerState();
}

class _HomeContainerState extends State<HomeContainer> {
  @override
  Widget build(BuildContext context) {
    return Consumer<States>(builder: (context, value, child) {
      return Container(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          color: backGround,
          // height: SizeConf.screenHeight * 0.9,
          child: Container(
            width: SizeConf.screenWidth,
            height: SizeConf.screenHeight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: getProportionateScreenHeight(12),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(120),
                  child: Center(
                    child: Text(
                          getLang(context, "Today"),
                          style: TextStyle(
                              fontSize: mFontSize,
                              color: primaryColor),
                        ),
                  ),

                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Date(
                        day: value.getCurrentData.hijriDate.day,
                        month: getLang(context, getMonthArabicString(
                            value.getCurrentData.hijriDate.month)) ,
                        year: 1444),
                    Date(
                        day: value.getCurrentData.gregorianDate.day,
                        month: getLang(context, getMonthString(
                            value.getCurrentData.gregorianDate.month)),
                        year: 2023),
                  ],
                ),
                SizedBox(
                  height: getProportionateScreenHeight(20),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BoxTime(
                      desc: getLang(context, "ItsTimeFor"),
                      title: value.getNextPrayList[0].prayerTimeName,
                      hour: value.getNextPrayList[0].time.hour,
                      minutes: value.getNextPrayList[0].time.minutes,
                      typebox: TypeBox.PRIMARY,
                    ),
                    BoxTime(
                      desc: getLang(context, "NextPrayer"),
                      title: value.getNextPrayList[1].prayerTimeName,
                      hour: value.getNextPrayList[1].time.hour,
                      minutes: value.getNextPrayList[1].time.minutes,
                      typebox: TypeBox.SECONDRY,
                    )
                  ],
                ),
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


































  // SizedBox(
  //                   height: SizeConf.screenHeight * 0.8,
  //                   child: ListView.builder(
  //                       // primary: true,
  //                       shrinkWrap: true,
  //                       itemCount: value.getListOfDataModel.length,
  //                       itemBuilder: (context, index) {
  //                         return Text("this is a line " +
  //                             value.getListOfDataModel[index].gregorianDate.day
  //                                 .toString());
  //                       }),
  //                 ),