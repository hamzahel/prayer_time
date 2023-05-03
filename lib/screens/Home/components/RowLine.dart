import 'package:flutter/material.dart';
import 'package:pray_time/config/constants.dart';
import 'package:pray_time/config/sizeConf.dart';
import 'package:pray_time/provider/states.dart';
import 'package:pray_time/components/GenerateIcon.dart';
import 'package:provider/provider.dart';
import 'package:pray_time/config/tools.dart';

class RowLine extends StatefulWidget {
  RowLine(
      {required this.title,
      required this.hours,
      required this.minutes,
      required this.isNextPray,
      required this.indexPray,
      super.key});

  String title;
  int hours;
  int minutes;
  bool isNextPray;
  int indexPray;

  @override
  State<RowLine> createState() => _RowLineState();
}


class _RowLineState extends State<RowLine> {

  bool isActive = false;
  Color color = Colors.white;

  @override
  void initState() {

    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<States>(builder: (context, value, child) {
      isActive = value.getListOfActivePray[widget.indexPray]["state"];
      color = (isActive == false) ? Colors.white.withOpacity(0.7): Colors.white;
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "${widget.title.toUpperCase()}",
            style: TextStyle(
                fontSize: getProportionateScreenHeight(24),
                color: color),
          ),
          Wrap(
            spacing: getProportionateScreenWidth(20),
            children: [
              Text(
                  "${add0ToInt(widget.hours)}:${add0ToInt(widget.minutes)} min",
                  style: TextStyle(
                      fontSize: getProportionateScreenHeight(24),
                      color: color)),
              InkWell(
                  onTap: () async {

                    setState(() {
                      value.disableOrEnablePrayTime(widget.indexPray);
                      value.getOnePrayTimeState();
                    });
                  },
                  child: IconGenerate(type: IconsType.Notification, color: (isActive == false) ? color : primaryColor)),
            ],
          )
        ],
      );
    });
  }
}
