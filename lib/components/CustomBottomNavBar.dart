import 'package:flutter/material.dart';
import 'package:pray_time/config/constants.dart';
import 'package:pray_time/config/sizeConf.dart';
import 'package:pray_time/screens/Home/index.dart';
// import 'package:pray_time/screens/Qibla/index.dart';
import 'package:pray_time/screens/Settings/index.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({
    super.key,
  });

  // final MenuState selectedMenu;
  // final PageController pageController;

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
              color: Colors.grey.shade600,
              spreadRadius: 0.5,
              blurRadius: 1,
              blurStyle: BlurStyle.solid)
        ],
        color: backGround,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
              onTap: () => Navigator.pushNamed(context, Home.routeName),
              child: homeIcon),
          // InkWell(
          //     onTap: () => Navigator.pushNamed(context, Qibla.routeName),
          //     child: compassIcon),
          InkWell(
              onTap: () => Navigator.pushNamed(context, Settings.routeName),
              child: settingIcon)
        ],
      ),
    );
  }
}
