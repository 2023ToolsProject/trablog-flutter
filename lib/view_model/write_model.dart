import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trablog/model/image_model.dart';
import 'package:trablog/model/location_model.dart';

class WriteModel extends ChangeNotifier {

  final ImageModel _imgModel = ImageModel();
  final LocationModel _locationModel = LocationModel();
  final TextEditingController _controller = TextEditingController();
  Position? _p;
  late String _address;
  late String _building;
  List<XFile>? _img;

  TextEditingController get textCon => _controller;
  List<XFile>? get img => _img;

  getXImage() async{
    _img = await _imgModel.getMultiXFile();
    if(_img!.length > 6){
      _img = null;
      notifyListeners();
      return Future.error('사진 개수를 6개 이하로 해주세요');
    }
    notifyListeners();
  }

  getPosition() async {
    _p = await _locationModel.getPosition();
    if(_p != null){
      var addResult = await _locationModel.getAddress(_p!,option: 1);
      if(addResult['results'].isNotEmpty){
        _address = addResult['results'][0]['formatted_address'];
      } else {
        _address = '';
      }
      print(_address);
      var buildResult = await _locationModel.getAddress(_p!,option: 2);
      if(buildResult['results'].isNotEmpty){
        _building = buildResult['results'][0]['address_components'][0]['long_name'];
      } else {
        _building = '';
      }
      print(_building);

    }
  }

  post(){
    if(_img != null && _img!.isNotEmpty){
      List<MultipartFile> files = _img!.map((img) => MultipartFile.fromFileSync(img.path)).toList();
      FormData data = FormData.fromMap({
      });
    } else {
      FormData data = FormData.fromMap({
      });
    }

  }

  modify(){

  }

}