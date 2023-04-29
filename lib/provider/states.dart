import 'dart:io';
import 'dart:ui';
import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';
import 'package:audio_session/audio_session.dart';
import 'package:pray_time/config/localStorage.dart';
import 'package:pray_time/models/DataModle.dart';
import 'package:pray_time/models/audioModel.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:convert';

import 'package:pray_time/models/localNotificationModel.dart';
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
  List _listOFActivePray = [
    {"name": "Fajr", "state": true},
    {"name": "Sunrise", "state": true},
    {"name": "Dhuhr", "state": true},
    {"name": "Asr", "state": true},
    {"name": "Maghrib", "state": true},
    {"name": "Isha", "state": true},
  ];

  List<TimeElement> _nextPrayList = [];
  int _audioIndex = 0;
  int _remainingTime = 15;
  AudioModel _audioSource = audios.first;
  int _indexIt = 0;


// getters
  int get getLanIndex => _lanIndex;

  List<DataModel> get getListOfDataModel => _dataModel;

  DataModel get getCurrentData => _currentData;

  List<TimeElement> get getNextPrayList => _nextPrayList;

  bool get isLoading => _isLoading;

  int get getAudioIndex => _audioIndex;

  int get getRemainingTime => _remainingTime;

  AudioModel get getAudioSource => _audioSource;

  List<dynamic> get getListOfActivePray => _listOFActivePray;

  void setLanIndex(int value) async
  {
    _lanIndex = value;
    await addStringValue("lang", (_lanIndex == 0) ?  "en" : "ar");
    notifyListeners();
  }


  Future<void> getOnePrayTimeState() async
  {
    int index = 0;
    while (index < _listOFActivePray.length)
      {
        if (await checkValue( _listOFActivePray[index]["name"])) {
          _listOFActivePray[index]["state"] =
          await getBoolValue(_listOFActivePray[index]["name"]);
        }
        index++;
      }
    notifyListeners();
  }

  void disableOrEnablePrayTime (int index) async
  {
    _listOFActivePray[index]["state"] = !_listOFActivePray[index]["state"];
    await addBoolValue(_listOFActivePray[index]["name"], _listOFActivePray[index]["state"]);
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
    notifyListeners();
  }

// setters
  Future<bool> setCurrentData() {
    DateTime currentDate = DateTime.now();
    // _indexIt = 0;
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
    DateTime currentDate = DateTime.now();
    for (var element in _currentData.times) {
      if (element.time.hour >= currentDate.hour ||
          (element.time.hour >= currentDate.hour &&
              element.time.minutes >= currentDate.minute)) {
        _nextPrayList.add(element);
      }
    }
    if (_nextPrayList.length < 2) {
      for (var element in _dataModel) {
        if (element.gregorianDate.day == currentDate.day + 1 &&
            element.gregorianDate.month == currentDate.month) {
          _nextPrayList.add(element.times[0]);
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

  void setAudioSource(int index) {
    _audioSource = audios[index];
    notifyListeners();
  }


  void triggerNotificationAndAzan() async {
    int add;
    int diff;
    DateTime currentDate = DateTime.now();
    // developer.log("the value from current time is : "+ currentDate.hour.toString());
    int addCurrent = (currentDate.hour * 60) + currentDate.minute;
    int i = 0;
    bool check = false;

    while (_nextPrayList.length > i) {
      check = _listOFActivePray[i]["state"];
      add =
          (getNextPrayList[i].time.hour * 60) +
              getNextPrayList[i].time.minutes;
      developer.log("the value of add is and addCurrent: "+ add.toString() + " :: "+ addCurrent.toString());
      diff = add - addCurrent;
      print("the value of diff is : " + diff.toString());
      if (check && (diff >= 0)) {
        developer.log("you enter to if check workmanager");
        await Workmanager().registerOneOffTask (
            "azantasks" + i.toString(), "azanTime",
            initialDelay: Duration(minutes: diff),
            existingWorkPolicy: ExistingWorkPolicy.replace,
            constraints: Constraints(networkType: NetworkType.not_required));
      }
      i++;
    }
  }

  // Future<void> fillWorkManagerEveryDay() async
  // {
  //   await Workmanager().registerPeriodicTask(
  //       "azantasks ",
  //       "azanTime",
  //       inputData: {
  //         "index": _audioIndex,
  //         "diff": 0
  //       },
  //       initialDelay: Duration(seconds: 0),
  //       frequency: Duration(hours: 24),
  //       // existingWorkPolicy: ExistingWorkPolicy.replace,
  //       constraints: Constraints(networkType: NetworkType.not_required)
  //   );
  // }

  //  init main
  Future<void> init() async {
    await readJson();
    getIntValue("remainingTime").then((value) {
      _remainingTime = value != null ? value : 15;
    });
    getIntValue("audioIndex").then((value) {
      _audioIndex = value != null ? value : 0;
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
    await getOnePrayTimeState();
    triggerNotificationAndAzan();
  }
}
