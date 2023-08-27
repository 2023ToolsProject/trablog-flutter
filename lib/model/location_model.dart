import 'package:geolocator/geolocator.dart';

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

}