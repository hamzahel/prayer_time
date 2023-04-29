import 'package:flutter/material.dart';
import 'package:pray_time/components/CustomBottomNavBar.dart';
import 'package:pray_time/config/constants.dart';
import 'package:pray_time/config/sizeConf.dart';
import 'package:pray_time/provider/states.dart';
import 'package:pray_time/screens/Home/components/BoxTime.dart';
import 'package:pray_time/screens/Home/components/BoxTimesPray.dart';
import 'package:pray_time/screens/Home/index.dart';
import 'package:provider/provider.dart';
import 'package:pray_time/components/Date.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:math' as math;
import 'package:vector_math/vector_math.dart' as math;
import 'package:flutter_qiblah/flutter_qiblah.dart';
// import 'package:vector_math/vector_math.dart'

class QiblaContainer extends StatefulWidget {
  const QiblaContainer({super.key});

  @override
  State<QiblaContainer> createState() => _QiblaContainerState();
}

class _QiblaContainerState extends State<QiblaContainer> {
  late Position _currentPosition;
  late double _qiblaDirection = 0.0;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  // Méthode pour récupérer la position actuelle de l'utilisateur
  _getCurrentLocation() async {
    final GeolocatorPlatform geolocator = GeolocatorPlatform.instance;
    LocationPermission permission = await geolocator.requestPermission();
    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      Position position = await geolocator.getCurrentPosition();
      setState(() {
        _currentPosition = position;
        print("\n\n\nthe position is latitude" + position.latitude.toString());
        print("\n\n\nthe position is longtude" + position.longitude.toString());
      });
    }
  }

  void _updateQiblaDirection(double latitude, double longitude) {
    final double kaabaLatitude = 21.422471;
    final double kaabaLongitude = 39.826199;

    final double phiK = math.radians(kaabaLatitude);
    final double lambdaK = math.radians(kaabaLongitude);
    final double phi = math.radians(latitude);
    final double lambda = math.radians(longitude);

    final double psi = math.atan2(
        math.sin(lambdaK - lambda),
        math.cos(phi) * math.tan(phiK) -
            math.sin(phi) * math.cos(lambdaK - lambda));

    setState(() {
      _qiblaDirection = math.degrees(psi);
      print("\n\nqibla direction : " + _qiblaDirection.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<States>(builder: (context, value, child) {
      // print("\n\n\nthe value is : " + value.getPackageInfo.version);
      return InkWell(
        onDoubleTap: () => _updateQiblaDirection(
            _currentPosition.latitude, _currentPosition.longitude),
        child: SizedBox(
            height: SizeConf.screenHeight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Transform.rotate(
                  angle: math.pi / 180 * -_qiblaDirection,
                  child: qiblaIcon,
                ),
                SizedBox(height: 20.0),
                Text(
                  'Direction de la Qibla : ${_qiblaDirection.toStringAsFixed(2)} degrés',
                  style: TextStyle(fontSize: 18.0),
                ),
                // SizedBox(
                //   height: getProportionateScreenHeight(120),
                // ),
                // Text("QIBLA COMPASS",
                //     style: TextStyle(
                //         color: backGround,
                //         fontWeight: FontWeight.w700,
                //         fontSize: getProportionateScreenWidth(34))),
                // Stack(
                //   children: [qiblaIcon, qiblaBallIcon],
                // ),
              ],
            )),
      );
    });
  }
}

// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   Position _currentPosition;

//   @override
//   void initState() {
//     super.initState();
//     _getCurrentLocation();
//   }

//   // Méthode pour récupérer la position actuelle de l'utilisateur
//   _getCurrentLocation() async {
//     final GeolocatorPlatform geolocator = GeolocatorPlatform.instance;
//     LocationPermission permission = await geolocator.requestPermission();
//     if (permission == LocationPermission.whileInUse ||
//         permission == LocationPermission.always) {
//       Position position = await geolocator.getCurrentPosition(
//           desiredAccuracy: LocationAccuracy.high);
//       setState(() {
//         _currentPosition = position;
//       });
//     }
//   }

//   void _updateQiblaDirection(double latitude, double longitude) {
//     final double kaabaLatitude = 21.422471;
//     final double kaabaLongitude = 39.826199;

//     final double phiK = math.radians(kaabaLatitude);
//     final double lambdaK = math.radians(kaabaLongitude);
//     final double phi = math.radians(latitude);
//     final double lambda = math.radians(longitude);

//     final double psi = math.atan2(
//         math.sin(lambdaK - lambda),
//         math.cos(phi) * math.tan(phiK) -
//             math.sin(phi) * math.cos(lambdaK - lambda));

//     setState(() {
//       _qiblaDirection = math.degrees(psi);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Boussole Qibla'),
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           Transform.rotate(
//             angle: math.pi / 180 * -_qiblaDirection,
//             child: Image.asset(
//               'assets/images/compass.png',
//               width: 300.0,
//               height: 300.0,
//               fit: BoxFit.cover,
//             ),
//           ),
//           SizedBox(height: 20.0),
//           Text(
//             'Direction de la Qibla : ${_qiblaDirection.toStringAsFixed(2)} degrés',
//             style: TextStyle(fontSize: 18.0),
//           ),
//         ],
//       ),
//     );
//   }
// }
