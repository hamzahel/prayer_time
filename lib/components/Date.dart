import 'package:flutter/material.dart';
import 'package:pray_time/config/constants.dart';
import 'package:pray_time/config/sizeConf.dart';
// import 'package:pray_time/models/dataModels.dart';

class Date extends StatelessWidget {
  int day;
  String month;
  int year;

  Date({required this.day, required this.month, required this.year, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          day.toString(),
          style: TextStyle(color: Colors.white,
            fontSize: sFontSize
          ),

        ),
        SizedBox(width: getProportionateScreenWidth(8)),
        Text(
          month,
          style: TextStyle(color: Colors.white,
              fontSize: sFontSize),
        ),
        SizedBox(width: getProportionateScreenWidth(8)),
        Text(
          year.toString(),
          style: TextStyle(color: Colors.white,
              fontSize: sFontSize),
        ),
      ],
    );
  }
}
