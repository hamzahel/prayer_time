import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pray_time/config/appLocal.dart';
import 'package:pray_time/config/constants.dart';
import 'package:pray_time/config/sizeConf.dart';
import 'package:pray_time/provider/states.dart';
import 'package:pray_time/screens/Home/components/RowLine.dart';
import 'package:provider/provider.dart';

class BoxTimesPray extends StatelessWidget {
  const BoxTimesPray({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            getLang(context, "AllTimes").toString().toUpperCase(),
            style: TextStyle(
                color: Colors.white,
                fontSize: mFontSize),
          ),
          SizedBox(
            height: getProportionateScreenHeight(36),
          ),
          Container(
            height: getProportionateScreenHeight(339),
            width: getProportionateScreenWidth(381),
            padding: EdgeInsets.symmetric(
                vertical: getProportionateScreenWidth(0),
                horizontal: getProportionateScreenHeight(20)),
            decoration: BoxDecoration(
                color: secondaryColor,
                boxShadow: [
                  BoxShadow(
                      color: Colors.white.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 0.5,
                      blurStyle: BlurStyle.solid)
                ],
                borderRadius: BorderRadius.all(
                    Radius.circular(getProportionateScreenHeight(23)))),
            child: Consumer<States>(builder: (context, value, child) {
              return ListView.builder(
                  itemCount: value.getCurrentData.times.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        RowLine(
                          title:
                              getLang(context, value.getCurrentData.times[index].prayerTimeName),
                          hours: value.getCurrentData.times[index].time.hour,
                          minutes:
                              value.getCurrentData.times[index].time.minutes,
                          isNextPray: value
                                  .getCurrentData.times[index].prayerTimeName ==
                              value.getNextPrayList[0].prayerTimeName,
                          indexPray: index
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(23),
                        )
                      ],
                    );
                  });
            }),
          ),
        ],
      ),
    );
  }
}
