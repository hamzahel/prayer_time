import 'package:flutter/material.dart';
import 'package:pray_time/config/constants.dart';
import 'package:pray_time/config/sizeConf.dart';

class Button extends StatelessWidget {
  Button(
      {required this.title,
      this.width,
      this.height,
      required this.press,
      this.backGroundColor,
      this.color,
      super.key});

  String title;
  double? width;
  double? height;
  Color? backGroundColor;
  Color? color;
  Function() press;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Container(
        decoration: BoxDecoration(
          color: (backGroundColor == null) ? secondaryColor : backGroundColor,
          borderRadius: BorderRadius.circular(getProportionateScreenWidth(5)),
          // border: Border.all(color: Colors.red)
        ),
        padding: EdgeInsets.all(4),
        // color: primaryColor,
        height: height,
        width: width,
        child: Align(
          alignment: Alignment.center,
          child: Text(
            title,
            style: TextStyle(
                height: getProportionateScreenHeight(0.8),
                color: (color == null) ? Colors.white : color,
                fontSize: getProportionateScreenWidth(32)),
          ),
        ),
      ),
    );
  }
}
