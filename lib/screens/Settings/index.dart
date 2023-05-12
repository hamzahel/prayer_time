import 'package:flutter/material.dart';
import 'package:pray_time/config/appLocal.dart';
import 'package:pray_time/config/constants.dart';
import 'package:pray_time/config/sizeConf.dart';
import 'package:pray_time/screens/Settings/SettingsContainer.dart';

class Settings extends StatefulWidget {
  static String routeName = "/Settings";
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    SizeConf().init(context);
    return Scaffold(
        backgroundColor: backGround,
        body: SafeArea(
          child: SizedBox(
            height: SizeConf.screenHeight,
            child: Stack(
              children: [
                const SettingsContainer(),
                Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      width: double.infinity,
                      height: getProportionateScreenHeight(70),
                      child: Column(children: [
                        Text(
                            getLang(context, "VersionNumber") ?? "", textScaleFactor: 1.0,
                          style: TextStyle(color: Colors.white),
                        ),
                        Text("1.0.1", textScaleFactor: 1.0,style: TextStyle(color: Colors.white))
                        // Consumer<States>(builder: (context, value, child) {
                        //   // provider = value;
                        //   value.initPackageInfo();
                        //   return Text(value.getPackageInfo.version.toString(),
                        //       style: TextStyle(color: Colors.white));
                        // })
                      ]),
                    )),
              ],
            ),
          ),
        ));
  }
}
