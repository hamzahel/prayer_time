import "package:flutter/material.dart";
import "package:pray_time/components/CustomBottomNavBar.dart";
import "package:pray_time/config/sizeConf.dart";
import "package:pray_time/screens/Home/HomeContainer.dart";

class Home extends StatefulWidget {
  static String routeName = "/Home";
  const Home({super.key});

  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    SizeConf().init(context);
    return Scaffold(
        body: Stack(
      children: const [
        HomeContainer(),
        Align(alignment: Alignment.bottomCenter, child: CustomBottomNavBar())
      ],
    ));
  }
}
