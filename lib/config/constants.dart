import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:just_audio/just_audio.dart';
import 'package:pray_time/config/sizeConf.dart';

const primaryColor = Color(0xFFFFC16D);
final lightPrimaryColor = Color(0xFF56969E).withOpacity(0.61);
const backGround = Color(0xFF003E46);
const backGroundLight = Color(0xFFFEF3E4);
const primaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFC0AEE7), Color(0xFFF3D5ED)],
);
const secondaryColor = Color(0XFF38777F);
const textColor = Colors.black87;
const animationDuration = Duration(milliseconds: 200);

final arrowLeftIcon = SvgPicture.asset(
  "assets/icons/arrowLeft.svg",
  width: getProportionateScreenWidth(74),
);

final arrowRightIcon = SvgPicture.asset(
  "assets/icons/arrowRight.svg",
  width: getProportionateScreenWidth(74),
);



final homeIcon = Image.asset(
  "assets/icons/home.png",
  width: getProportionateScreenWidth(34),
);

enum IconsType {Home, Compass, Settings, Notification, Intro}




final notifierIcon = SvgPicture.asset(
  "assets/icons/notifier.svg",
  width: SizeConf.screenWidth,
);


final settingIcon = Image.asset(
  "assets/icons/setting.png",
  width: getProportionateScreenWidth(34),
);

final compassIcon = Image.asset(
  "assets/icons/compass.png",
  width: getProportionateScreenWidth(34),
);

final introIcon = Image.asset(
  "assets/icons/intro.png",
  width: SizeConf.screenWidth * 0.7,
);

final smallBallIcon = SvgPicture.asset("assets/icons/smallBall.svg",
    width: SizeConf.screenWidth * 0.25);

final bigBallIcon = SvgPicture.asset(
  "assets/icons/bigBall.svg",
  width: SizeConf.screenWidth * 0.65,
);

final qiblaBallIcon = Image.asset(
  "assets/icons/qiblaball.png",
  width: getProportionateScreenWidth(124),
);

final qiblaIcon = Image.asset(
  "assets/icons/qibla.png",
  width: SizeConf.screenWidth * 0.99,
  height: SizeConf.screenHeight * 0.8,
);

final languages = ["english", "arabic"];

//sizes 
final mFontSize = getProportionateScreenWidth(24);
final sFontSize =  getProportionateScreenWidth(18);
final xsFontSize = getProportionateScreenWidth(12);
final mlFontSize = getProportionateScreenWidth(32);
final lFontSize = getProportionateScreenWidth(48);
final xlFontSize = getProportionateScreenWidth(64);


const String oneSignalId = "157e7ac8-711d-4822-9b57-dbb129aabed3";
