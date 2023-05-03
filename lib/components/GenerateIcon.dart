import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pray_time/config/constants.dart';
import 'package:pray_time/config/sizeConf.dart';

class IconGenerate extends StatelessWidget {
  final IconsType type;
  Color? color;
  double? size;
  IconGenerate({required this.type, this.color, this.size});

  @override
  Widget build(BuildContext context) {
    switch (type)
    {
      case IconsType.Compass:
        return SvgPicture.asset(
          "assets/icons/compass.svg",
          width: getProportionateScreenWidth(size ?? 24),
          color: color ?? Colors.white,
        );
      case IconsType.Settings:
        return SvgPicture.asset(
          "assets/icons/setting.svg",
          width: getProportionateScreenWidth(size ?? 24),
          color: color ?? Colors.white,
        );
      case IconsType.Notification:
        return SvgPicture.asset(
          "assets/icons/notification.svg",
          width: getProportionateScreenWidth(size ?? 24),
          color: color ?? Colors.white,
        );
      case IconsType.Intro:
        return Image.asset(
          "assets/icons/intro.png",
          width: getProportionateScreenWidth(328),
          height: getProportionateScreenHeight(407.8),
          color: color ?? Colors.white,
        );
      default:
        return SvgPicture.asset(
          "assets/icons/home.svg",
          width: getProportionateScreenWidth(size ?? 24),
          color: color ?? Colors.white,
        );
    }
  }
}