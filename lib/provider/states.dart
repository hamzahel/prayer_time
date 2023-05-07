import 'dart:ffi';
import 'dart:io';
import 'dart:math';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';
import 'package:pray_time/config/localStorage.dart';
import 'package:pray_time/models/DataModle.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:pray_time/functions/workmanager.dart';

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
  int _indexIt = 0;
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

  int get getRemainingTime => _remainingTime;


  List<dynamic> get getListOfActivePray => _listOFActivePray;

  void setLanIndex(int value) async {
    _lanIndex = value;
    await addStringValue("lang", (_lanIndex == 0) ? "en" : "ar");
    notifyListeners();
  }

  Future<void> getOnePrayTimeState() async {
    int index = 0;
    while (index < _listOFActivePray.length) {
      if (await checkValue(_listOFActivePray[index]["name"])) {
        _listOFActivePray[index]["state"] =
            await getBoolValue(_listOFActivePray[index]["name"]);
      }
      index++;
    }
    notifyListeners();
  }

  void disableOrEnablePrayTime(int index) async {
    _listOFActivePray[index]["state"] = !_listOFActivePray[index]["state"];
    await addBoolValue(
        _listOFActivePray[index]["name"], _listOFActivePray[index]["state"]);
    destroyWorks();
    notifyListeners();
  }

  void destroyWorks() async
  {
    await removeValue("trigger");
    await init();
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
    destroyWorks();
    notifyListeners();
  }

// setters
  Future<bool> setCurrentData() {
    DateTime currentDate = _currentTime;
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
    DateTime currentDate = _currentTime;
    for (var element in _currentData.times) {
      if (currentDate.hour != 0 && (element.time.hour >= currentDate.hour ||
          (element.time.hour >= currentDate.hour &&
              element.time.minutes >= currentDate.minute))) {
        _nextPrayList.add(element);
      }
    }
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


  Future<void> triggerNotificationAndAzan() async {
    int add;
    int diff;
    DateTime currentDate = _currentTime;
    int addCurrent = (currentDate.hour * 60) + currentDate.minute;
    int i = 0;
    bool check = false;

    // while (i < _nextPrayList.length) {
    //   check = _listOFActivePray[i]["state"];
    //   add =
    //       (getNextPrayList[i].time.hour * 60) + getNextPrayList[i].time.minutes;
    //   if (getNextPrayList[i].prayerTimeName == "Fajr" && addCurrent > add)
    //     diff = ( 24 - addCurrent ) + add;
    //   else
    //     diff = add - addCurrent;
    //   if (check && (diff >= 0)) {
    //     await Workmanager().registerOneOffTask(
    //         "azantasks" + _nextPrayList[i].prayerTimeName, "azanTime",
    //         // tag:"azan" + _nextPrayList[0].prayerTimeName,
    //         initialDelay: Duration(minutes: diff),
    //         existingWorkPolicy: ExistingWorkPolicy.replace);
    //   }
    //   if (check && (diff >= _remainingTime)) {
    //     await Workmanager().registerOneOffTask(
    //         "remainingtasks" + _nextPrayList[i].prayerTimeName, "remainingTime",
    //         // tag:"remaining" + _nextPrayList[0].prayerTimeName,
    //         initialDelay: Duration(minutes: diff - _remainingTime),
    //         existingWorkPolicy: ExistingWorkPolicy.replace);
    //   }
    //   i++;
    // }
    return Future.value(true);
  }

  Future<bool> checkInit() async
  {
    return (this._nextPrayList.length > 2 && this.getCurrentData != null);
  }

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

    AndroidAlarmManager.periodic(Duration(seconds: 20),  Random().nextInt(pow(2, 31) as int) , callbackDispatcher);

    // int? trigger = await getIntValue("trigger");
    // if (trigger == null) {
    //   Workmanager().cancelAll();
    //   triggerNotificationAndAzan();
    //   Workmanager().registerPeriodicTask("initTask", "initAll",
    //       initialDelay: Duration(minutes: (24 * 60) - ((_currentTime.hour * 60) + _currentTime.minute)),
    //       frequency: Duration(hours: 24),
    //       existingWorkPolicy: ExistingWorkPolicy.replace);
    //   await addIntValue("trigger" , 1);
    // }
  }
}
