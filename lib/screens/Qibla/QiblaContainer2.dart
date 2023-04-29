import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:pray_time/config/constants.dart';
import 'package:pray_time/config/sizeConf.dart';
import 'package:pray_time/screens/Qibla/qiblah_compass.dart';

class QiblaContainer2 extends StatefulWidget {
  const QiblaContainer2({super.key});

  @override
  State<QiblaContainer2> createState() => _QiblaContainer2State();
}

class _QiblaContainer2State extends State<QiblaContainer2> {
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
              InkWell(
                onTap: (){
                  Navigator.pop(context);
                },
                child: arrowLeftIcon),
              QiblahCompass(),
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
