import 'package:flutter/material.dart';
import 'package:pray_time/components/Button.dart';
import 'package:pray_time/config/appLocal.dart';
import 'package:pray_time/config/constants.dart';
import 'package:pray_time/config/localStorage.dart';
import 'package:pray_time/config/sizeConf.dart';
import 'package:pray_time/functions/audioManager.dart';
import 'package:pray_time/main.dart';
import 'package:pray_time/models/audioModel.dart';
import 'package:pray_time/provider/states.dart';
import 'package:pray_time/screens/Settings/components/MenuItem.dart';
import 'package:provider/provider.dart';

class SettingsContainer extends StatefulWidget {
  const SettingsContainer({super.key});
  @override
  State<SettingsContainer> createState() => _SettingsContainerState();
}

class _SettingsContainerState extends State<SettingsContainer> {
  @override
  Widget build(BuildContext context) {
    return Consumer<States>(builder: (context, value, child) {
      return Container(
        width: SizeConf.screenWidth,
        height: SizeConf.screenHeight,
        child: Column(
          crossAxisAlignment: (value.getLanIndex == 1) ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          // shrinkWrap: true,
          // primary: true,
          children: [
            SizedBox(
              height: getProportionateScreenHeight(12),
            ),
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: getProportionateScreenWidth(10),
              children: [
                InkWell(
                    onTap: () => Navigator.pop(context), child: arrowLeftIcon),
                // Text(
                //   getLang(context, "Settings"),
                //   style: TextStyle(
                //       fontSize: getProportionateScreenWidth(26),
                //       color: Colors.white),
                // ),
              ],
            ),
            SizedBox(
              height: getProportionateScreenHeight(40),
            ),
            MenuItem(
              title: getLang(context, "RemainingTime"),
              content: value.getRemainingTime.toString() + getLang(context, "minutes"),
              press: () {
                showModalBottomSheet<void>(
                    context: context,
                    backgroundColor: backGround,
                    builder: (BuildContext context) {
                      return  StatefulBuilder(
                            builder: (context, StateSetter setState) {
                          return Container(
                            child: Stack(
                              children: [
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    color: Colors.red,
                                    height: SizeConf.screenHeight * 0.54,
                                    child: ListView.builder(
                                        itemCount: 31,
                                        itemBuilder: (context, index) {
                                          return MenuItem(
                                            title: index.toString() + getLang(context, "minutesBefore"),
                                            isSubTitle: true,
                                            titleColor:
                                                (value.getRemainingTime == index)
                                                    ? primaryColor
                                                    : Colors.white,
                                            press: () {
                                              setState(() {
                                                value.setRemainingTime(index);
                                              });
                                            },
                                          );
                                        }),
                                  ),
                                ),
                                Align(
                                    alignment: Alignment.topRight,
                                    child: Button(
                                      title: "x",
                                      width: getProportionateScreenWidth(45),
                                      height: getProportionateScreenHeight(45),
                                      press: () {
                                        Navigator.pop(context);
                                      },
                                    )),
                              ],
                            ),
                          );
                        });
                    });
              },
            ),
            MenuItem(
              title: getLang(context, "Sound"),
              content: audios[value.getAudioIndex].title,
              press: () {
                showModalBottomSheet<void>(
                    context: context,
                    backgroundColor: backGround,
                    builder: (BuildContext context) {
                      return StatefulBuilder(
                            builder: (context, StateSetter setState) {
                          return Container(
                            height: SizeConf.screenHeight * 0.6,
                            width: SizeConf.screenWidth * 0.70,
                            child: Stack(
                              children: [
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    color: Colors.red,
                                    height: SizeConf.screenHeight * 0.54,
                                    child: ListView.builder(
                                        itemCount: audios.length - 1,
                                        itemBuilder: (context, index) {
                                          return MenuItem(
                                            title: audios[index].title,
                                            isSubTitle: true,
                                            titleColor:
                                                (value.getAudioIndex == index)
                                                    ? primaryColor
                                                    : Colors.white,
                                            press: ()  {
                                              setState(() {
                                                value.setAudioIndex(index);
                                                initAudio(player, audios[value.getAudioIndex].src);
                                                player.play();
                                              });
                                            },
                                          );
                                        }),
                                  ),
                                ),
                                Align(
                                    alignment: Alignment.topRight,
                                    child: Button(
                                      title: "x",
                                      backGroundColor: backGround,
                                      width: getProportionateScreenWidth(45),
                                      height: getProportionateScreenHeight(45),
                                      press: () {
                                        player.stop();
                                        Navigator.pop(context);
                                      },
                                    )),
                              ],
                            ),
                          );
                        });
                    });
              },
            ),
            MenuItem(
              title: getLang(context, "Language"),
              content: getLang(context, languages[value.getLanIndex]),
              press: () {
                showModalBottomSheet<void>(
                    context: context,
                    backgroundColor: backGround,
                    builder: (BuildContext context) {
                      return StatefulBuilder(
                          builder: (context, StateSetter setState) {
                            return Container(
                              height: SizeConf.screenHeight * 0.6,
                              width: SizeConf.screenWidth * 0.70,
                              child: Stack(
                                children: [
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Container(
                                      height: SizeConf.screenHeight * 0.54,
                                      child: ListView.builder(
                                          itemCount: 2,
                                          itemBuilder: (context, index) {
                                            return MenuItem(
                                              title: getLang(context, languages[index]),
                                              isSubTitle: true,
                                              titleColor:
                                              (value.getAudioIndex == index)
                                                  ? primaryColor
                                                  : Colors.white,
                                              press: ()  {
                                                setState(() {
                                                  value.setLanIndex(index);
                                                  if (index == 1)
                                                    {
                                                      addStringValue('lang', 'ar');
                                                      MaterialAppChanger.setLocale(context, Locale('ar', ''));
                                                    }
                                                  else {
                                                    addStringValue('lang', 'en');
                                                    MaterialAppChanger.setLocale(context, Locale('en', ''));
                                                  }

                                                });
                                              },
                                            );
                                          }),
                                    ),
                                  ),
                                  Align(
                                      alignment: Alignment.topRight,
                                      child: Button(
                                        title: "x",
                                        backGroundColor: backGround,
                                        width: getProportionateScreenWidth(45),
                                        height: getProportionateScreenHeight(45),
                                        press: () {
                                          player.stop();
                                          Navigator.pop(context);
                                        },
                                      )),
                                ],
                              ),
                            );
                          });
                    });
              },
            ),
            MenuItem(
              title: getLang(context, "PrivacyAndPolicy"),
              // content: "15 min",
              press: () {},
            ),
          ],
        ),
      );
    });
  }
}


































  // SizedBox(
  //                   height: SizeConf.screenHeight * 0.8,
  //                   child: ListView.builder(
  //                       // primary: true,
  //                       shrinkWrap: true,
  //                       itemCount: value.getListOfDataModel.length,
  //                       itemBuilder: (context, index) {
  //                         return Text("this is a line " +
  //                             value.getListOfDataModel[index].gregorianDate.day
  //                                 .toString());
  //                       }),
  //                 ),