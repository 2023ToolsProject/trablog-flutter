import 'package:trablog/const/const_value.dart';
import 'package:flutter/material.dart';
import 'package:trablog/singleton/storage.dart';
import 'package:trablog/singleton/http.dart';
import 'dart:convert';

class SignModel extends ChangeNotifier {
  SignModel(this.con1,this.con2, {this.con3});

  late final TextEditingController con1;
  late final TextEditingController con2;
  late final TextEditingController? con3;
  final _key = GlobalKey<FormState>();
  bool _remember = false;

  bool get remember => _remember;
  GlobalKey<FormState> get key => _key;

  signInInit() async{
    await Future.delayed(const Duration(milliseconds: 200));
    _remember = Storage.pref!.getBool('remember') ?? false;
    con1.text = Storage.pref!.getString('id') ?? '';
    notifyListeners();
  }

  signIn() async {
    if(_remember == true){
      await Storage.pref!.setString('id', con1.text);
    }
    Map<String,String> mapData = {
      'username' : con1.text,
      'password' : con2.text,
    };
    var response = await trabDio.post(LOGIN,data: mapData);
    var data = json.decode(response.toString());
    await Storage.pref!.setString('accessToken', data['accessToken']);
    await Storage.pref!.setString('refreshToken', data['refreshToken']);
    if(data['accessToken'] != null){
      String bToken = 'Bearer ${data['accessToken']}';
      trabDio.options.headers['Authorization'] = bToken;
    }
  }

  signUp() async{
    Map<String,String> mapData = {
      'username' : con1.text,
      'email' : con2.text,
      'password' : con3!.text,
    };
    var response = await trabDio.post(JOIN,data: mapData);
    var data = json.decode(response.toString());
    await Storage.pref!.setString('accessToken', data['accessToken']);
    await Storage.pref!.setString('refreshToken', data['refreshToken']);
  }

  rememberEmail() async {
    _remember = !_remember;
    await Storage.pref!.setBool('remember', _remember);

    if(_remember == false){
      await Storage.pref!.remove('id');
    }
    notifyListeners();
  }


}