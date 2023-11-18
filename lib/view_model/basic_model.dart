import 'package:flutter/material.dart';
import 'package:trablog/model/exit_model.dart';
import 'package:trablog/page/main_pages/main_page.dart';
import 'package:trablog/page/memory_pages/write_page.dart';

class BasicModel extends ChangeNotifier {

  int _index = 0;
  final List _page = [
    const MainPage(),
    const WritePage(),
  ];
  final ExitModel _exModel = ExitModel();

  int get i => _index;
  List get page => _page;

  changeIndex(int i){
    _index = i;
    notifyListeners();
  }

  Future<bool> onWillPop(){
    return _exModel.onWillPop();
  }

}