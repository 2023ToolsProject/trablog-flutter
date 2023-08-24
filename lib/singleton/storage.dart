import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  static SharedPreferences? _pref;
  static SharedPreferences? get pref => _pref;

  static init() async{
    _pref ??= await SharedPreferences.getInstance();
  }

}