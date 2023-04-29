import 'package:flutter/material.dart';
import 'package:pray_time/config/constants.dart';
import 'package:pray_time/config/sizeConf.dart';
import 'package:pray_time/config/tools.dart';

enum TypeBox { PRIMARY, SECONDRY }

class BoxTime extends StatelessWidget {
  BoxTime(
      {this.width,
      this.height,
      required this.desc,
      required this.title,
      required this.hour,
      required this.minutes,
      required this.typebox,
      super.key});

  double? width;
  double? height;
  String desc;
  String title;
  int hour;
  int minutes;
  TypeBox typebox;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: (typebox == TypeBox.PRIMARY)
            ? getProportionateScreenHeight(200)
            : getProportionateScreenHeight(245),
        width: (typebox == TypeBox.PRIMARY)
            ? getProportionateScreenWidth(212)
            : getProportionateScreenWidth(152),
        padding: EdgeInsets.symmetric(
            // vertical: getProportionateScreenWidth(0),
            horizontal: (typebox == TypeBox.PRIMARY) ?  getProportionateScreenHeight(25) : 0),
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
        child: Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: (typebox == TypeBox.PRIMARY) ? CrossAxisAlignment.start :  CrossAxisAlignment.center,
            children: [
              Text(desc.toUpperCase(),
                  style: TextStyle(color: Colors.white, fontSize: xsFontSize)),
              SizedBox(height: getProportionateScreenHeight(9),),
              Text(title.toUpperCase(),
                  style: TextStyle(
                      color: primaryColor,
                      fontSize: (typebox == TypeBox.PRIMARY) ? lFontSize : mFontSize)),
              SizedBox(height: getProportionateScreenHeight(9),),
              ( typebox == TypeBox.PRIMARY) ? Text("PRAYER",
                  style: TextStyle(color: Colors.white, fontSize: xsFontSize)) : SizedBox(height: getProportionateScreenHeight(9),),
              SizedBox(height: (typebox == TypeBox.PRIMARY) ?  getProportionateScreenHeight(9) : getProportionateScreenHeight(35),),
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.end,
                children: [
                  Text("${add0ToInt(hour)}:${add0ToInt(minutes)}",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: lFontSize)),
                  // const Text("min",
                  //     style: TextStyle(color: primaryColor, fontSize: 14)),
                ],
              )
            ],
          ),
        ));
  }
}
