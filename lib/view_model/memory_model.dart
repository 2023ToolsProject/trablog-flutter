import 'package:custom_marker/marker_icon.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:trablog/const/const_value.dart';
import 'package:trablog/model/refresh_model.dart';
import 'package:trablog/page/memory_pages/memory_second.dart';
import 'package:trablog/singleton/http.dart';
import 'package:trablog/singleton/storage.dart';

class MemoryModel extends ChangeNotifier {

  late BuildContext context;

  Map _clickedData = {};
  List _data = [];
  bool _isBack = false;
  BitmapDescriptor? _markerImage;
  Set<Marker> _markers = {};
  final PageController _con = PageController(viewportFraction: 0.7);
  final RefreshModel _rModel = RefreshModel();

  Map get clickedData => _clickedData;
  List get data => _data;
  bool get isBack => _isBack;
  Set<Marker> get markers => _markers;
  PageController get con => _con;
  MemoryModel get mm => this;

  _getMarkerImage() async {
    _markerImage ??= await MarkerIcon.pictureAsset(assetPath: 'assets/marker.png', width: 250, height: 250);
  }

  getContext(BuildContext context){
    this.context = context;
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

    _data = response.data;
    await _getMarkerImage();

    Set<Marker> newMarkerSet = {};
    for (var d in _data) {
      var newMarker = Marker(
          markerId: MarkerId(d['id'].toString()),
          position: LatLng(d['latitude'], d['longitude']),
          icon: _markerImage!,
          onTap: (){ _markerTap(d['id']);}
      );
      newMarkerSet.add(newMarker);
    }
    _markers = newMarkerSet;

    notifyListeners();
  }

  flipImage(){
    _isBack = !_isBack;
    notifyListeners();
  }

  getOnlyData(int i) async{
    try{
      Response r = await trabDio.get('$BOARD/$i');
      _clickedData = r.data;
      notifyListeners();
    } catch(e){
        var rToken = Storage.pref!.getString('refreshToken');
        if(rToken == null){
          throw Future.error('토큰 없음');
        }
        await _rModel.refreshToken(rToken);

        Response r = await trabDio.get('$BOARD/$i');
        _clickedData = r.data;
        notifyListeners();
    }

  }

  deleteData(int i) async{
    try{
      await trabDio.delete('$BOARD/$i');
      _clickedData = {};
      notifyListeners();
    } catch(e){
      var rToken = Storage.pref!.getString('refreshToken');
      if(rToken == null){
        throw Future.error('토큰 없음');
      }
      await _rModel.refreshToken(rToken);

      await trabDio.delete('$BOARD/$i');
      _clickedData = {};
      notifyListeners();
    }
  }


  _markerTap(int i) async{
    try{
      await getOnlyData(i);
      // ignore: use_build_context_synchronously
      Navigator.push(context, MaterialPageRoute(
          builder: (context) => const MemorySecond()
      ));
    } catch(e){
      // ignore: use_build_context_synchronously
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context){
            return AlertDialog(
              title: const Text('로딩하는데 실패했습니다'),
              actions: [
                TextButton(onPressed: (){Navigator.pop(context);}, child: const Text('확인'))
              ],
            );
          }
      );
    }


  }

}