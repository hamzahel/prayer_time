import 'package:flutter/material.dart';
import 'package:pray_time/config/constants.dart';
import 'package:pray_time/config/localStorage.dart';
import 'package:pray_time/provider/states.dart';
import 'package:pray_time/components/GenerateIcon.dart';
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


  void navigationPage() async {
    await provider.init();
    while (provider.checkInit() == false);
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
                        child: IconGenerate(type: IconsType.Intro,),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
