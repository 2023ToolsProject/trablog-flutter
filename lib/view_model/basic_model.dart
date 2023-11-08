import 'package:flutter/material.dart';
import 'package:trablog/model/exit_model.dart';
import 'package:trablog/page/main_pages/main_page.dart';
import 'package:trablog/page/memory_pages/memory_first.dart';
import 'package:trablog/page/plan_pages/plan_page.dart';

class BasicModel extends ChangeNotifier {

  late BuildContext context;
  int _index = 0;
  final List _page = [
    const MainPage(),
    const PlanPage(),
    const MemoryFirst(),
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