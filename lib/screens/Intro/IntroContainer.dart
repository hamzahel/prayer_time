import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:pray_time/config/constants.dart';
import 'package:pray_time/config/sizeConf.dart';
import 'package:pray_time/provider/states.dart';
import 'package:pray_time/screens/Home/index.dart';
import 'package:provider/provider.dart';

class IntroContainer extends StatefulWidget {
  const IntroContainer({super.key});

  @override
  State<IntroContainer> createState() => _IntroContainerState();
}

class _IntroContainerState extends State<IntroContainer>
    with SingleTickerProviderStateMixin {
  late Animation<double> opacity;
  late AnimationController controller;
  late States provider = States();

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 3500), vsync: this);
    opacity = Tween<double>(begin: 0.0, end: 1.0).animate(controller)
      ..addListener(() {
        setState(() {});
      });
    controller.forward().then((_) {
      navigationPage();
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

//   void runAction(SendPort port) async {
//   final receivePort = ReceivePort();

//     // final sendPort = await IsolateNameServer.lookupPortByName('my_port');

//     // Subscribe to the Provider stream
//     // final streamSubscription =
//     // Provider.of<States>(context, listen: false).myStream.listen((data) {
//     //   // Send data to the background Isolate
//     //   port.send(data);
//     // });

//     // Wait for messages from the main Isolate
//     // receivePort.listen((port) async {
//     //   // Update the Provider data in the background Isolate
//     //   await Provider.of<States>(context, listen: false).triggerNotificationAndAzan();
  
//     // });

//     // Clean up resources
//     // streamSubscription.cancel();
//     // receivePort.close();
//     // port.close();
//   port.send("something");
// }
  //  final receiveport = ReceivePort();
  //   final isolate = FlutterIsolate.spawn(runAction, receiveport.sendPort);

  void navigationPage() async {
    // provider.setCurrentData();
    // await provider.initAudio();
    await provider.init();
    while (provider.getCurrentData.gregorianDate.day == 0);
    // provider.getAdanTime();
    // provider.getPlayer.play();
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (_) => const Home()));
  }

  Widget build(BuildContext context) {
    return Consumer<States>(builder: (context, value, child) {
      provider = value;
      return Scaffold(
        backgroundColor: backGround,
        body: Container(
          width: double.infinity,
          // height: getProportionateScreenHeight(900),
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Stack(
                  children: [
                    AnimatedPositioned(
                      duration: const Duration(seconds: 1),
                      curve: Curves.easeInOut,
                      left: opacity.value == 0 ? -100 : 180,
                      top: opacity.value == 0 ? -100 : 120,
                      child: bigBallIcon,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Opacity(
                        opacity: opacity.value,
                        child: introIcon,
                      ),
                    ),
                  ],
                ),
              ),
              // const Padding(
              //   padding: EdgeInsets.all(8.0),
              // )
            ],
          ),
        ),
      );
    });
  }
}
