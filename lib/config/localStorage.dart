import 'package:shared_preferences/shared_preferences.dart';

//Retrieve the values
// Set<String> set = myScores.getStringSet("key", null);

//Set the values
// Set<String> set = new HashSet<String>();
// set.addAll(listOfExistingScores);
// scoreEditor.putStringSet("key", set);
// scoreEditor.commit();
//
// Future<void> addSetString (String key, Set<String> value) async
// {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//
// }

Future<void> addStringValue(String key, String value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(key, value);
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
