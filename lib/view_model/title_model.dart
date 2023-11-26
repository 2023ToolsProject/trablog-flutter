import 'dart:async';
import 'package:flutter/material.dart';
import 'package:trablog/model/exit_model.dart';
import 'package:trablog/model/refresh_model.dart';
import 'package:trablog/singleton/storage.dart';
import 'package:trablog/singleton/http.dart';
import 'package:trablog/const/const_value.dart';

class TitleModel extends ChangeNotifier {

  final ExitModel _exModel = ExitModel();
  final RefreshModel _rModel = RefreshModel();

  toNextPage(FutureOr<dynamic> Function() function) async {
    return await Future.delayed(const Duration(seconds: 1), function);
  }

  checkToken() async{
    await Storage.init();
    String? token = Storage.pref!.getString('accessToken');
    String? rToken = Storage.pref!.getString('refreshToken');
    if(token != null){
      String bToken = 'Bearr $token';
      trabDio.options.headers['Authorization'] = bToken;
    }
    try{
      await trabDio.get(PROFILE);
    } catch(e){
      if(rToken == null){
        throw Future.error('토큰 없음');
      }
      await _rModel.refreshToken(rToken);
      await trabDio.get(PROFILE);
    }
  }




  Future<bool> onWillPop(){
    return _exModel.onWillPop();
  }

}