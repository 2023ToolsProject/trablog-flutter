import 'package:flutter/material.dart';

class MemoryModel extends ChangeNotifier {

  int? _index;
  List? _data;
  bool _isBack = false;
  final PageController _con = PageController(viewportFraction: 0.7);

  int? get index => _index;
  List? get data => _data;
  bool get isBack => _isBack;
  PageController get con => _con;
  MemoryModel get mm => this;

  setIndex(int i){
    _index = i;
    notifyListeners();
  }

  getData(){

  }

  flipImage(){
    _isBack = !_isBack;
    notifyListeners();
  }



  @override
  void dispose() {
    // TODO: implement dispose
    print('dispose 실행');
  }

}