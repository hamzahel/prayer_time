import 'dart:io';
import 'dart:isolate';
import 'dart:ui';
import 'dart:developer' as developer;

import 'package:audio_service/audio_service.dart';
import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';
import 'package:audio_session/audio_session.dart';
import 'package:pray_time/config/localStorage.dart';
import 'package:pray_time/functions/audioManager.dart';
import 'package:pray_time/models/DataModle.dart';
import 'package:pray_time/models/audioModel.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:convert';

import 'package:pray_time/models/localNotificationModel.dart';
import 'package:provider/provider.dart';
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
      if (element.time.hour >= currentDate.hour ||
          (element.time.hour >= currentDate.hour &&
              element.time.minutes >= currentDate.minute)) {
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

  // void setAudioSource(int index) {
  //   _audioSource = audios[index];
  //   notifyListeners();
  // }

  void playAudio() async
  {
    await player.play();
  }
  void triggerNotificationAndAzan() async {
    int add;
    int diff;
    DateTime currentDate = _currentTime;
    int addCurrent = (currentDate.hour * 60) + currentDate.minute;
    int i = 0;
    bool check = false;

    check = _listOFActivePray[0]["state"];
    add = (getNextPrayList[i].time.hour * 60) + getNextPrayList[i].time.minutes;
    diff = add - addCurrent;
    // Workmanager().registerOneOffTask("azantasks1", "azanTime",
    //     initialDelay: Duration(seconds: 10),
    //     existingWorkPolicy: ExistingWorkPolicy.replace);
    // Workmanager().registerOneOffTask("azantasks2", "azanTime",
    //     initialDelay: Duration(seconds: 40),
    //     existingWorkPolicy: ExistingWorkPolicy.replace);
    // Workmanager().registerOneOffTask("remainingtasks1", "remainingTime",
    //     initialDelay: Duration(seconds: 60),
    //     existingWorkPolicy: ExistingWorkPolicy.replace);
    // Workmanager().registerOneOffTask("remainingtasks2", "remainingTime",
    //     initialDelay: Duration(seconds: 80),
    //     existingWorkPolicy: ExistingWorkPolicy.replace);
    if (check && (diff >= 0)) {
      Workmanager().registerOneOffTask("azantasks" + _currentTime.minute.toString(), "azanTime",
          initialDelay: Duration(minutes: diff),
          existingWorkPolicy: ExistingWorkPolicy.replace);
    }
    if (check && (diff >= _remainingTime)) {
      Workmanager().registerOneOffTask("remainingtasks"+ _currentTime.minute.toString(), "remainingTime",
          initialDelay: Duration(minutes: diff - _remainingTime),
          existingWorkPolicy: ExistingWorkPolicy.replace);
    }
  }


  //  init main
  Future<void> init() async {
    developer.log("the current time is : " + _currentTime.toString());
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
    developer.log("\n\n\nyou enter here in state/....");
    await getAdanTime();
    await getOnePrayTimeState();
    triggerNotificationAndAzan();
  }
}
