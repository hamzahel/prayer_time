import 'dart:ffi';
import 'dart:io';
import 'dart:isolate';
import 'dart:math';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:just_audio/just_audio.dart';
import 'package:pray_time/config/constants.dart';
import 'package:pray_time/config/localStorage.dart';
import 'package:pray_time/functions/localNotificationManager.dart';
import 'package:pray_time/main.dart';
import 'package:pray_time/models/DataModle.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:pray_time/functions/backgroundService.dart';
import 'package:pray_time/models/audioModel.dart';
import 'package:workmanager/workmanager.dart';

class States with ChangeNotifier {
// param init
  bool _isLoading = false;
  String _data = "";
  int _lanIndex = 0;

  List<DataModel> _dataModel = [];
  DataModel _currentData = DataModel(
      gregorianDate: Date(day: 0, month: 0),
      hijriDate: Date(day: 0, month: 0),
      times: []);
  final AudioPlayer _player = AudioPlayer();
  List _listOFActivePray = [
    {"name": "Fajr", "state": true, "time": {"hour": 0 , "minute": 0}},
    {"name": "Sunrise", "state": true, "time": {"hour": 0 , "minute": 0}},
    {"name": "Dhuhr", "state": true, "time": {"hour": 0 , "minute": 0}},
    {"name": "Asr", "state": true, "time": {"hour": 0 , "minute": 0}},
    {"name": "Maghrib", "state": true, "time": {"hour": 0 , "minute": 0}},
    {"name": "Isha", "state": true, "time": {"hour": 0 , "minute": 0}},
  ];

  List<TimeElement> _nextPrayList = [];
  int _audioIndex = 0;
  int _notificationIndex = 0;
  int _remainingTime = 1;
  int _indexIt = 0;
  // final int _offset = 1;
  //here whene i add 3 hours or represent timezone of qatar
  final DateTime _currentTime = DateTime.now().toUtc().add(Duration(hours: 3));


// getters
  AudioPlayer get getAudioPlayer => _player;
  DateTime get getCurrentTime => _currentTime;
  int get getLanIndex => _lanIndex;

  List<DataModel> get getListOfDataModel => _dataModel;

  DataModel get getCurrentData => _currentData;

  List<TimeElement> get getNextPrayList => _nextPrayList;

  bool get isLoading => _isLoading;

  int get getAudioIndex => _audioIndex;

  int get getNotificationIndex => _notificationIndex;

  int get getRemainingTime => _remainingTime;


  List<dynamic> get getListOfActivePray => _listOFActivePray;


  void setLanIndex(int value) async {
    _lanIndex = value;
    await addStringValue("lang", (_lanIndex == 0) ? "en" : "ar");
    notifyListeners();
  }

  // 6 pray witch means 6 id
  Future<void> takeOneShotPray({required int index, required int hour, required int minute,required String name}) async
  {
    try {
      // print("xthe value of take one shot is : " +
      //     oneDay[index].time.hour.toString() +
      //     " " +
      //     oneDay[index].time.minutes.toString());
      int minuter = (minute +
          (60 * hour) -
          _remainingTime);
      int hourr = (minuter >= 60 ? ( minuter / 60).floor() : 0);
      minuter =  minuter % 60;
      // print ("xthe value of hour : $hour and minute : $minute");
      await AndroidAlarmManager.oneShotAt(
          DateFormat("yyyy/MM/dd HH:mm:ss").parse(
              "${_currentTime.year}/${_currentData.gregorianDate.month}/${_currentData.gregorianDate.day} ${hourr}:${minuter}:00"),
          index + 7,
          callbackDispatcher,
          exact: true,
          wakeup: true,
          params: {
            "index": index + 7,
            "name": name,
            "delay": _remainingTime.toString()
          });
      DateTime time = DateFormat("yyyy/MM/dd HH:mm:ss").parse(
          "${_currentTime.year}/${_currentData.gregorianDate.month}/${_currentData.gregorianDate.day} $hour:$minute:00");
      print("time is : ${time}");
      await AndroidAlarmManager.oneShotAt(
          time,
          index,
          callbackDispatcher,
          exact: true,
          wakeup: true,
          params: {
            "index": index,
            "name": name,
          });
      return Future.value(true);
    } catch(e) {
      return Future.value(false);
    }
  }

  Future<void> setAlarmTriggerWithstate() async {
    DateTime currenttime = _currentTime;
    await destroyAlarms();
    debugPrint("time of qatar is : ${currenttime}");
    int index = 0;
    List<String> ids = [];
    while (index < _listOFActivePray.length) {
      if (await checkValue(_listOFActivePray[index]["name"])) {
        _listOFActivePray[index]["state"] =
            await getBoolValue(_listOFActivePray[index]["name"]);
      }
      if (_listOFActivePray[index]["state"] == true) {
        print("you enter : " + index.toString());
        if (((_listOFActivePray[index]["hour"] * 60) +
                _listOFActivePray[index]["minute"]) >
                ((_currentTime.hour * 60) + _currentTime.minute)) {
          ids.add(index.toString());
          ids.add((index + 7).toString());
          debugPrint("\n\nthe time from universe : ${_listOFActivePray[index]["hour"]} : ${_listOFActivePray[index]["minute"]} vs ${_currentTime.hour}: ${_currentTime.minute}");
          debugPrint("you enter to takeoneshot : " + index.toString());
          debugPrint("\n\n\nyou start name pray : " + _listOFActivePray[index]["name"]);
          debugPrint("\n[the index is ${index}\n the name is ${_listOFActivePray[index]["name"]}\n the hour is ${_listOFActivePray[index]["hour"]} and the minute is : ${_listOFActivePray[index]["minute"]}] \n");
          takeOneShotPray(
            index: index,
            hour: _listOFActivePray[index]["hour"],
            minute: _listOFActivePray[index]["minute"],
            name: _listOFActivePray[index]["name"],
          );
        }
      }
      index++;
    }
    await addSetValue("alarmIds", ids);
    notifyListeners();
  }

  void disableOrEnablePrayTime(int index) async {
    _listOFActivePray[index]["state"] = !_listOFActivePray[index]["state"];
    await addBoolValue(
        _listOFActivePray[index]["name"], _listOFActivePray[index]["state"]);
    await setAlarmTriggerWithstate();
    notifyListeners();
  }

  Future<void> readJson() async {
    final String response = await rootBundle.loadString(
        "assets/data/Data.json"); // loadString('assets/data/Data.json');
    _dataModel = dataModelFromJson(response);
  }

  Future<void> WriteJson() async {
    final file = File("assets/data/Data.json");
    await file.writeAsString(_dataModel.toString());
  }

  void setRemainingTime(int minutes) async {
    await addIntValue("remainingTime", minutes);
    _remainingTime = minutes;
    await setAlarmTriggerWithstate();
    notifyListeners();
  }

// setters
  Future<bool> setCurrentData() {
    DateTime currentDate = _currentTime;
    for (var element in _dataModel) {
      if (element.gregorianDate.day == currentDate.day &&
          element.gregorianDate.month == currentDate.month) {
        _currentData = element;
        notifyListeners();
        return Future.value(true);
      }
      _indexIt++;
    }
    return Future.value(false);
  }

  void setIdLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> getAdanTime() {
    DateTime currentDate = _currentTime;
    int index = 0;
    for (var element in _currentData.times) {
      _listOFActivePray[index]["hour"] = element.time.hour;
      _listOFActivePray[index]["minute"] = element.time.minutes;
      // print ("element is ${element.time.hour}  and current time is : ${currentDate.hour}");
      // currentDate = (currentDate.hour == 0) ? currentDate.add(Duration(days: 1)) : currentDate;
      if (((element.time.hour * 60) + element.time.minutes) >
              ((currentDate.hour * 60) + currentDate.minute)) {
        _nextPrayList.add(element);
      }
      index++;
    }
    print("the lenght of next pray is : "+ _nextPrayList.length.toString());
    int i = 0;
    if (_nextPrayList.length < 2) {
      for (var element in _dataModel) {
        if (element.gregorianDate.day == currentDate.day + 1 &&
            element.gregorianDate.month == currentDate.month) {
          _nextPrayList.add(element.times[0]);
          if (_nextPrayList.length < 2) {
            _nextPrayList.add(element.times[1]);
          }
        }
      }
    }
    notifyListeners();
    return Future(() => null);
  }

  void setAudioIndex(int index) async {
    _audioIndex = index;
    await addIntValue("audioIndex", index);
    notifyListeners();
  }

  void setNotificationAudio(int index) async {
    _notificationIndex = index;
    await addIntValue("notificationIndex", index);
    notifyListeners();
  }


  Future<bool> checkInit() async
  {
    return (this._nextPrayList.length > 2 && this.getCurrentData != null);
  }

  Future<void> destroyAlarms() async {

    // while (await AndroidAlarmManager.)
    if (await checkValue("alarmIds")){
      List<String> ids = await getSetValue("alarmIds") ?? [];
      for (var id  in ids)
        {
          await AndroidAlarmManager.cancel(int.parse(id));
        }
    }
  }

  Future<void> exInit() async
  {
    await readJson();
    getIntValue("remainingTime").then((value) {
      _remainingTime = value != null ? value : 1;
    });
    getIntValue("audioIndex").then((value) {
      _audioIndex = value != null ? value : 0;
    });
    getIntValue("notificationIndex").then((value) {
      _notificationIndex = value != null ? value : 0;
    });
    getStringValue("lang").then((value) {
      if (value == "ar")
        _lanIndex = 1;
      else
        _lanIndex = 0;
    });
    bool check = await setCurrentData();
    while (check != true);
    await getAdanTime();
    await setAlarmTriggerWithstate();
  }

  //  init main
  Future<void> init() async {
    await readJson();
    getIntValue("remainingTime").then((value) {
      _remainingTime = value != null ? value : 1;
    });
    getIntValue("audioIndex").then((value) {
      _audioIndex = value != null ? value : 0;
    });
    getIntValue("notificationIndex").then((value) {
      _notificationIndex = value != null ? value : 0;
    });
    getStringValue("lang").then((value) {
      if (value == "ar")
        _lanIndex = 1;
      else
        _lanIndex = 0;
    });
    bool check = await setCurrentData();
    while (check != true);
    await getAdanTime();
    bool isTrigger= await checkValue("trigger");
    // DateTime time = DateFormat("yyyy/MM/dd HH:mm:ss")
    //     .parse(
    //     "${_currentTime.year}/${_currentData.gregorianDate.month}/${_currentData.gregorianDate.day} 16:5:00");
    // print ("time is lopping: "+ time.toString());
    if (!isTrigger)
      {
      // Workmanager().registerPeriodicTask("loppingtask", "initAlarm",
      //     frequency: Duration(minutes: 4), initialDelay: Duration(minutes: 2));
        AndroidAlarmManager.cancel(99);
        await AndroidAlarmManager.periodic(
          Duration(hours : 1), 99, callbackDispatcher,
          exact: true,
          wakeup: true,
          startAt: DateTime.now());
      addBoolValue("trigger", true);
    }

  }
}
