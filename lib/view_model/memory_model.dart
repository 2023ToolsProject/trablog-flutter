import 'package:flutter/material.dart';

class MemoryModel extends ChangeNotifier {

  List? _data;
  final PageController _con = PageController(viewportFraction: 0.7);

  List? get data => _data;
  PageController get con => _con;

}