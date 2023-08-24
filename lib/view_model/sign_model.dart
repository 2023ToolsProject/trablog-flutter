import 'package:flutter/material.dart';
import 'package:trablog/singleton/storage.dart';

class SignModel extends ChangeNotifier {
  SignModel(this.con1,this.con2, {this.con3});

  late final TextEditingController con1;
  late final TextEditingController con2;
  late final TextEditingController? con3;
  final _key = GlobalKey<FormState>();
  bool _remember = false;

  bool get remember => _remember;
  GlobalKey<FormState> get key => _key;

  signInInit() async{
    _remember = await (Storage.pref!.getBool('remember') ?? false);
    con1.text = await (Storage.pref!.getString('email') ?? '');
    notifyListeners();
  }

  Future<bool> signIn() async {
    if(_remember == true){
      await Storage.pref!.setString('email', con1.text);
    }

    if(con1.text == 'test@gmail.com' && con2.text == 'test'){
      await Storage.pref!.setString('accessToken', '1234');
      return true;
    } else {
      return false;
    }
  }

  Future<bool> signUp() async{
    if(_key.currentState!.validate()){
      await Storage.pref!.setString('accessToken', '1234');
      return true;
    } else {
      return false;
    }
  }

  rememberEmail() async {
    _remember = !_remember;
    await Storage.pref!.setBool('remember', _remember);

    if(_remember == false){
      await Storage.pref!.remove('email');
    }
    notifyListeners();
  }


}