import 'package:flutter/material.dart';
import 'package:pray_time/config/appLocal.dart';
import 'package:pray_time/config/sizeConf.dart';
import 'package:pray_time/provider/states.dart';
import 'package:pray_time/screens/Home/components/BoxTime.dart';
import 'package:provider/provider.dart';

class TwoBoxTime extends StatelessWidget {
  const TwoBoxTime({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<States>(
      builder: (context, value, child) {
        return  Wrap(
          spacing: getProportionateScreenWidth(21),
          children: [
            BoxTime(
              desc: getLang(context, "ItsTimeFor") ?? "",
              title: getLang(context, value.getNextPrayList[0].prayerTimeName) ?? "",
              hour: (value.getNextPrayList.isEmpty) ? 1 : value.getNextPrayList[0].time.hour,
              minutes: (value.getNextPrayList.isEmpty) ? 1 : value.getNextPrayList[0].time.minutes ?? 1,
              typebox: TypeBox.PRIMARY,
            ),
            BoxTime(
              desc: getLang(context, "NextPrayer") ?? "",
              title: getLang(context, value.getNextPrayList[1].prayerTimeName) ?? "",
              hour: (value.getNextPrayList.isEmpty) ? 1 : value.getNextPrayList[1].time.hour,
              minutes: (value.getNextPrayList.isEmpty) ? 1: value.getNextPrayList[1].time.minutes ?? 1,
              typebox: TypeBox.SECONDRY,
            )
          ],
        );
      }
    );
  }
}
