import 'dart:async';
import 'package:flutter/material.dart';
import 'package:trablog/model/exit_model.dart';

class TitleModel extends ChangeNotifier {

  ExitModel _exModel = ExitModel();

  toNextPage(FutureOr<dynamic> Function() function) async {
    return await Future.delayed(const Duration(seconds: 1), function);
  }

  Future<bool> onWillPop(){
    return _exModel.onWillPop();
  }

}