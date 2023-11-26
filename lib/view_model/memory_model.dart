import 'package:custom_marker/marker_icon.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:trablog/const/const_value.dart';
import 'package:trablog/model/refresh_model.dart';
import 'package:trablog/singleton/http.dart';
import 'package:trablog/singleton/storage.dart';

class MemoryModel extends ChangeNotifier {

  int? _index;
  List? _data;
  bool _isBack = false;
  BitmapDescriptor? _markerImage;
  final Set<Marker> _markers = {};
  final PageController _con = PageController(viewportFraction: 0.7);
  final RefreshModel _rModel = RefreshModel();

  int? get index => _index;
  List? get data => _data;
  bool get isBack => _isBack;
  Set<Marker> get markers => _markers;
  PageController get con => _con;
  MemoryModel get mm => this;

  setIndex(int i){
    _index = i;
    notifyListeners();
  }
  getMarkerImage() async {
    _markerImage ??= await MarkerIcon.pictureAsset(assetPath: 'assets/marker.png', width: 250, height: 250);
  }

  getData() async {
    try{
      await trabDio.get(PROFILE);
    } catch(e){
      var rToken = Storage.pref!.getString('refreshToken');
      if(rToken == null){
        throw Future.error('토큰 없음');
      }
      await _rModel.refreshToken(rToken);
    }

    Response response = await trabDio.get(BOARD_GET_LIST);

    print(response);

    await getMarkerImage();

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