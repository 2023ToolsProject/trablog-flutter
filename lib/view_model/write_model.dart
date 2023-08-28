import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trablog/model/image_model.dart';
import 'package:trablog/model/location_model.dart';
import 'package:trablog/singleton/http.dart';
import 'dart:convert';

class WriteModel extends ChangeNotifier {

  final ImageModel _imgModel = ImageModel();
  final LocationModel _locationModel = LocationModel();
  final TextEditingController _controller = TextEditingController();
  Position? _p;
  List<XFile>? _img;

  TextEditingController get textCon => _controller;
  List<XFile>? get img => _img;

  Future<bool> getXImage() async{
    _img = await _imgModel.getMultiXFile();
    notifyListeners();
    return _img == null;
  }

  getPosition() async {
    _p = await _locationModel.getPosition();
    return _p;
  }

  post(){

  }

}