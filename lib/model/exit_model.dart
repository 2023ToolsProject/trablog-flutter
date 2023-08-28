import 'package:fluttertoast/fluttertoast.dart';

class ExitModel{

  DateTime? _fastBackTime;

  Future<bool> onWillPop() async{
    DateTime now = DateTime.now();

    if(_fastBackTime == null || now.difference(_fastBackTime!) > const Duration(seconds: 2)){
      _fastBackTime = now;

      Fluttertoast.showToast(msg: '뒤로가기를 한 번 더 누르면 종료 됩니다.');

      return Future.value(false);
    }

    return Future.value(true);

  }

}