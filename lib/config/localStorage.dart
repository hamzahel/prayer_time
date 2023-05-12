import 'package:shared_preferences/shared_preferences.dart';


Future<void> addStringValue(String key, String value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(key, value);
}

Future<void> addSetValue(String key, List<String> value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setStringList(key, value);
}

Future<void> addIntValue(String key, int value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setInt(key, value);
}

Future<void> addDoubleValue(String key, double value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setDouble(key, value);
}

Future<void> addBoolValue(String key, bool value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool(key, value);
}

Future<String?> getStringValue(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? stringValue = prefs.getString(key);
  return stringValue;
}

Future<List<String>?> getSetValue(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String>? stringValue = prefs.getStringList(key);
  return stringValue;
}

Future<bool> getBoolValue(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool boolValue = prefs.getBool(key) as bool;
  return boolValue;
}



Future<int?> getIntValue(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int? intValue = prefs.getInt(key);
  return intValue;
}

Future<double?> getDoubleValue(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getDouble(key);
}

Future<void> removeValue(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove(key);
}

Future cleanValues() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.clear();
}

Future<bool> checkValue(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool check = prefs.containsKey(key);
  return check;
}
