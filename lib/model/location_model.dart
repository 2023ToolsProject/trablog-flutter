import 'package:trablog/singleton/http.dart';
import 'package:geolocator/geolocator.dart';
import 'package:trablog/const/const_key.dart';
import 'package:trablog/const/const_value.dart';
import 'dart:convert';

class LocationModel {

  Future<Position> _determinePosition() async{
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if(!serviceEnabled){
      return Future.error('서비스 이용 불가');
    }
    permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.denied){
      permission = await Geolocator.requestPermission();
      if(permission == LocationPermission.denied){
        return Future.error('권한이 거부됨');
      }
    }
    if(permission == LocationPermission.deniedForever){
      return Future.error('권한이 영구적으로 거부됨');
    }

    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

  Future<Position> getPosition() async{
    return await _determinePosition();
  }

  getAddress(Position p,{int option = 1}) async {

    switch(option){
      case 1:
        Map<String,String> queryData = {
          'latlng' : '${p.latitude},${p.longitude}',
          'key' : KEY,
          'result_type' : 'street_address',
        };
        var enResult = await googleDio.get(REGEOCODE, queryParameters: queryData);
        var deResult = json.decode(enResult.toString());
        return deResult;
      case 2:
        Map<String,String> queryData = {
          'latlng' : '${p.latitude},${p.longitude}',
          'key' : KEY,
          'result_type' : 'premise',
        };
        var enResult = await googleDio.get(REGEOCODE, queryParameters: queryData);
        var deResult = json.decode(enResult.toString());
        return deResult;
    }

  }


}