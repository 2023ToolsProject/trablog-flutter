import 'package:flutter/material.dart';

class MemoryModel extends ChangeNotifier {

  int? _index;
  List? _data;
  final PageController _con = PageController(viewportFraction: 0.7);

  int? get i => _index;
  List? get data => _data;
  PageController get con => _con;
  MemoryModel get mm => this;

  setIndex(int i){
    _index = i;
    notifyListeners();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    print(this._index);
    print('안 죽어');
  }

}