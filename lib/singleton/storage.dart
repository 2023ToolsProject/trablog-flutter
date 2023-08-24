import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  static SharedPreferences? _pref;
  static SharedPreferences? get pref => _pref;

  static init() async{
    _pref ??= await SharedPreferences.getInstance(); // 이거 못만들 경우
    print(_pref);
  }

}