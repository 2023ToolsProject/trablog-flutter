import 'dart:async';
import 'package:flutter/material.dart';

class TitleModel extends ChangeNotifier {

  toNextPage(FutureOr<dynamic> Function() function) async {
    return await Future.delayed(const Duration(seconds: 1), function);
  }

}