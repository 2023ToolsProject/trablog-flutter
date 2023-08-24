import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trablog/page/main_page.dart';
import 'package:trablog/page/memory_page/memory_first.dart';
import 'package:trablog/page/write_page.dart';
import 'package:trablog/view_model/memory_model.dart';

class BasicModel extends ChangeNotifier {

  late BuildContext context;
  int _index = 0;
  final List _page = [
    const MainPage(),
    const WritePage(),
    ChangeNotifierProvider(
        create: (context)=>MemoryModel(),
        child: const MemoryFirst(),
    )
  ];

  int get i => _index;
  List get page => _page;

  changeIndex(int i){
    _index = i;
    notifyListeners();
  }

}