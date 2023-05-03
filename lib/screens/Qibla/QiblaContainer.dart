import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:pray_time/components/CustomBottomNavBar.dart';
import 'package:pray_time/config/constants.dart';
import 'package:pray_time/config/sizeConf.dart';
import 'package:pray_time/screens/Qibla/QiblahCompass.dart';

class QiblaContainer extends StatefulWidget {
  const QiblaContainer({super.key});

  @override
  State<QiblaContainer> createState() => _QiblaContainerState();
}

class _QiblaContainerState extends State<QiblaContainer> {
  final _deviceSupport = FlutterQiblah.androidDeviceSensorSupport();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _deviceSupport,
      builder: (_, AsyncSnapshot<bool?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return LoadingIndicator(
            indicatorType: Indicator.ballBeat,
          );
        if (snapshot.hasError)
          return Center(
            child: Text("Error: ${snapshot.error.toString()}"),
          );

        if (snapshot.data!) {
          print("the value is: " + snapshot.toString());
          return Stack(
            children: [
              QiblahCompass(),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: CustomBottomNavBar(
                    backgroundcolor: backGroundLight,
                    color: lightPrimaryColor,
                    index: 1,
                  )),
            ],
          );
        } else {
          return Text(
            "this is no error!",
            style: TextStyle(fontSize: getProportionateScreenWidth(42)),
          );
        }
      },
    );
  }
}
