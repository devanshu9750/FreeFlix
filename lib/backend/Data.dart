import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Data {
  static SharedPreferences prefs;
  static Map data;

  static initialize() async {
    prefs = await SharedPreferences.getInstance();
    getData();
  }

  static getData() {
    data = jsonDecode(prefs.getString("starred") ?? '{}');
  }
}
