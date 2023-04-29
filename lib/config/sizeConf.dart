import 'package:flutter/material.dart';

class SizeConf {
  static MediaQueryData _mediaQueryData = _mediaQueryData;
  static double screenWidth = 0;
  static double screenHeight = 0;
  static double defaultSize = 0;
  static Orientation orientation = Orientation.landscape;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    orientation = _mediaQueryData.orientation;
  }
}

double getProportionateScreenHeight(double inputHeight) {
  double screenHeight = SizeConf.screenHeight;
  if (screenHeight != null)
    return (inputHeight / 926) * screenHeight;
  else
    return (inputHeight);
}

double getProportionateScreenWidth(double inputWidth) { //20
  double screenWidth = SizeConf.screenWidth;
  if (screenWidth != null)
    return (inputWidth / 428) * screenWidth;
  else
    return (inputWidth);
}
