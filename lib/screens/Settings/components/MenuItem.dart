import 'package:flutter/material.dart';
import 'package:pray_time/config/constants.dart';
import 'package:pray_time/config/sizeConf.dart';

class MenuItem extends StatelessWidget {
  MenuItem(
      {required this.title,
      this.content,
      required this.press,
      this.titleColor,
        this.isSubTitle,
      super.key});

  String title;
  Color? titleColor;
  String? content;
  bool? isSubTitle;
  Function() press;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Container(
          width: SizeConf.screenWidth,
          height: getProportionateScreenHeight(85),
          decoration: BoxDecoration(color: backGround, boxShadow: [
            BoxShadow(
                color: Colors.white.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 0.5,
                blurStyle: BlurStyle.values.last)
          ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(title,
                  style: TextStyle(
                      fontSize: (isSubTitle == true) ? getProportionateScreenWidth(18) : getProportionateScreenWidth(24),
                      color: (titleColor != null) ? titleColor : Colors.white)),
              (content != null)
                  ? Column(
                      children: [
                        SizedBox(
                          height: getProportionateScreenHeight(15),
                        ),
                        Text(content.toString(),
                            style: TextStyle(
                                fontSize: getProportionateScreenWidth(14),
                                color: Colors.white))
                      ],
                    )
                  : const SizedBox(),
            ],
          )),
    );
  }
}
