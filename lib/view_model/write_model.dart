import 'package:flutter/material.dart';

class WriteModel extends ChangeNotifier {

  final TextEditingController _controller = TextEditingController();

  TextEditingController get textCon => _controller;

}