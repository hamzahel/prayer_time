import 'dart:convert';

List<DataModel> dataModelFromJson(String str) =>
    List<DataModel>.from(json.decode(str).map((x) => DataModel.fromJson(x)));

String dataModelToJson(List<DataModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DataModel {
  DataModel({
    required this.gregorianDate,
    required this.hijriDate,
    this.remainingTime,
    required this.times,
  });

  Date gregorianDate;
  Date hijriDate;
  dynamic remainingTime;
  List<TimeElement> times;

  factory DataModel.fromJson(Map<String, dynamic> json) => DataModel(
        gregorianDate: Date.fromJson(json["gregorianDate"]),
        hijriDate: Date.fromJson(json["hijriDate"]),
        remainingTime: json["remainingTime"],
        times: List<TimeElement>.from(
            json["times"].map((x) => TimeElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "gregorianDate": gregorianDate.toJson(),
        "hijriDate": hijriDate.toJson(),
        "remainingTime": remainingTime,
        "times": List<dynamic>.from(times.map((x) => x.toJson())),
      };
}

class Date {
  Date({
    required this.day,
    required this.month,
  });

  int day;
  int month;

  factory Date.fromJson(Map<String, dynamic> json) => Date(
        day: json["day"],
        month: json["month"],
      );

  Map<String, dynamic> toJson() => {
        "day": day,
        "month": month,
      };
}

class TimeElement {
  TimeElement({
    required this.prayerTimeName,
    required this.isUpComming,
    required this.time,
    required this.universalTime,
  });

  String prayerTimeName;
  bool isUpComming;
  UniversalTimeClass time;
  UniversalTimeClass universalTime;

  factory TimeElement.fromJson(Map<String, dynamic> json) => TimeElement(
        prayerTimeName: json["prayerTimeName"],
        isUpComming: json["isUpComming"],
        time: UniversalTimeClass.fromJson(json["time"]),
        universalTime: UniversalTimeClass.fromJson(json["universalTime"]),
      );

  Map<String, dynamic> toJson() => {
        "prayerTimeName": prayerTimeName,
        "isUpComming": isUpComming,
        "time": time.toJson(),
        "universalTime": universalTime.toJson(),
      };
}

class UniversalTimeClass {
  UniversalTimeClass({
    required this.hour,
    required this.minutes,
  });

  int hour;
  int minutes;

  factory UniversalTimeClass.fromJson(Map<String, dynamic> json) =>
      UniversalTimeClass(
        hour: json["hour"],
        minutes: json["minutes"],
      );

  Map<String, dynamic> toJson() => {
        "hour": hour,
        "minutes": minutes,
      };
}
