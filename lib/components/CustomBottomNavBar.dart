import 'package:flutter/material.dart';
import 'package:pray_time/config/constants.dart';
import 'package:pray_time/config/sizeConf.dart';
import 'package:pray_time/components/GenerateIcon.dart';
import 'package:pray_time/screens/Home/index.dart';
import 'package:pray_time/screens/Qibla/index.dart';
import 'package:pray_time/screens/Settings/index.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({
    this.backgroundcolor,
    this.color,
    this.index,
    super.key,
  });

  final Color? backgroundcolor;
  final Color? color;
  final int? index;
  @override
  Widget build(BuildContext context) {
    final Color inActiveIconColor = Color(0xFFB6B6B6);
    return Container(
      clipBehavior: Clip.hardEdge,
      width: double.infinity,
      height: getProportionateScreenHeight(70),
      padding: const EdgeInsets.symmetric(vertical: 0),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Colors.grey.shade50,
              spreadRadius: 0.5,
              blurRadius: 1,
              blurStyle: BlurStyle.solid)
        ],
        color: backgroundcolor ?? backGround,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: getProportionateScreenWidth(68),
        children: [
          InkWell(
              onTap: () => Navigator.pushNamed(context, Home.routeName),
              child: Column(
                children: [
                  (index == 0) ?  Column(
                    children: [
                      Container(color: color ?? Colors.white,
                        width: getProportionateScreenWidth(75),
                        height: getProportionateScreenWidth(3),
                      ),
                      SizedBox(height: getProportionateScreenHeight(10),),
                    ],
                        )
                      : SizedBox(
                          height: getProportionateScreenHeight(13),
                        ),
                  Container(
                      width: getProportionateScreenWidth(75),
                      child: IconGenerate(
                        type: IconsType.Home,
                        size: getProportionateScreenWidth(38),
                        color: color ?? Colors.white,
                      )),
                ],
              )),
          InkWell(
              onTap: () => Navigator.pushNamed(context, Qibla.routeName),
              child: Column(
                children: [
                  (index == 1)
                      ? Column(
                          children: [
                            Container(
                              color: color ?? Colors.white,
                              width: getProportionateScreenWidth(75),
                              height: getProportionateScreenWidth(3),
                            ),
                            SizedBox(
                              height: getProportionateScreenHeight(10),
                            ),
                          ],
                        )
                      : SizedBox(
                          height: getProportionateScreenHeight(13),
                        ),
                  Container(
                      width: getProportionateScreenWidth(75),
                      child: IconGenerate(
                    type: IconsType.Compass,
                    size: getProportionateScreenWidth(38),
                    color: color ?? Colors.white,
                  )),
                ],
              )),
          InkWell(
              onTap: () => Navigator.pushNamed(context, Settings.routeName),
              child: Column(
                children: [
                  (index == 2)
                      ? Column(
                          children: [
                            Container(
                              color: color ?? Colors.white,
                              width: getProportionateScreenWidth(75),
                              height: getProportionateScreenWidth(3),
                            ),
                            SizedBox(
                              height: getProportionateScreenHeight(10),
                            ),
                          ],
                        )
                      : SizedBox(
                          height: getProportionateScreenHeight(13),
                        ),
                  Container(
                      width: getProportionateScreenWidth(75),
                      child: IconGenerate(
                    type: IconsType.Settings,
                    size: getProportionateScreenWidth(38),
                    color: color ?? Colors.white,
                  )),
                ],
              )),
        ],
      ),
    );
  }
}
