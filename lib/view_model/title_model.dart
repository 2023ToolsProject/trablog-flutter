import 'dart:async';
import 'package:flutter/material.dart';
import 'package:trablog/model/exit_model.dart';
import 'package:trablog/singleton/storage.dart';
import 'package:trablog/singleton/http.dart';
import 'package:trablog/const/const_value.dart';

class TitleModel extends ChangeNotifier {

  final ExitModel _exModel = ExitModel();

  toNextPage(FutureOr<dynamic> Function() function) async {
    return await Future.delayed(const Duration(seconds: 1), function);
  }

  checkToken() async{
    await Storage.init();
    String? token = await Storage.pref!.getString('accessToken');
    throw Future.error('바로 실행'); // 임시
    trabDio.options.headers = {'authorization' : token};
    var response = await trabDio.get(SIGN_CHECK);
    print(response);
  }




  Future<bool> onWillPop(){
    return _exModel.onWillPop();
  }

}