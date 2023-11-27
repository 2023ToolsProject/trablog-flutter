import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trablog/const/const_value.dart';
import 'package:trablog/model/image_model.dart';
import 'package:trablog/model/location_model.dart';
import 'package:trablog/model/refresh_model.dart';
import 'package:trablog/singleton/http.dart';
import 'package:trablog/singleton/storage.dart';

class WriteModel extends ChangeNotifier {

  final RefreshModel _rModel = RefreshModel();
  final ImageModel _imgModel = ImageModel();
  final LocationModel _locationModel = LocationModel();
  final TextEditingController _titleCon = TextEditingController();
  final TextEditingController _textCon = TextEditingController();
  Position? _p;
  LatLng? _location;
  String? _address;
  String? _building;
  List<XFile>? _img;

  TextEditingController get titleCon => _titleCon;
  TextEditingController get textCon => _textCon;
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
      _location = LatLng(_p!.latitude, _p!.longitude);
      _getPositionInfo();
    }
  }

  setLocation(LatLng location){
    _location = location;
    _getPositionInfo();
  }

  _getPositionInfo() async {
      var addResult = await _locationModel.getAddress(_location!,option: 1);
      if(addResult['results'].isNotEmpty){
        _address = addResult['results'][0]['formatted_address'];
      } else {
        _address = '';
      }
      print(_address);
      var buildResult = await _locationModel.getAddress(_location!,option: 2);
      if(buildResult['results'].isNotEmpty){
        _building = buildResult['results'][0]['address_components'][0]['long_name'];
      } else {
        _building = '';
      }
      print(_building);

  }

  post() async {
    if(_img == null || _img!.isEmpty){
      return Future.error('이미지가 없습니다.');
    }
    // ignore: unnecessary_null_comparison
    if(_location == null || _address == null){
      return Future.error('주소 정보가 없습니다.');
    }

    //jpg만 올릴 수 있음
    List<MultipartFile> files = _img!.map((img) => MultipartFile.fromFileSync(img.path,filename: img.name,contentType: MediaType('image', 'jpeg'))).toList();
    Map boardDto = {
      'title': _titleCon.text,
      'content': _textCon.text,
      'latitude': _location!.latitude,
      'longitude': _location!.longitude,
      'address': _address!
    };
    String jBoardDto = json.encode(boardDto);
    FormData data = FormData.fromMap({
      'createBoardDto' : jBoardDto,
      'image' : files
    });

    try{
      await trabDio.get(PROFILE);
    } catch(e){
      var rToken = Storage.pref!.getString('refreshToken');
      if(rToken == null){
        throw Future.error('토큰 없음');
      }
      await _rModel.refreshToken(rToken);
    }

    await trabDio.post(BOARD,data: data,options: Options(contentType: 'multipart/form-data'));
    _resetValue();
  }

  modify(){

  }

  _resetValue(){
    _titleCon.text = '';
    _textCon.text = '';
    _p = null;
    _location = null;
    _address = '';
    _building = '';
    _img = null;
    notifyListeners();
  }


}