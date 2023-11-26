import 'dart:convert';

import 'package:trablog/singleton/storage.dart';
import 'package:trablog/const/const_value.dart';
import 'package:trablog/singleton/http.dart';

class RefreshModel {

  refreshToken(String rToken) async {
    var response = await trabDio.post(REFRESH, data: { "refreshToken" : rToken});
    var data = json.decode(response.toString());
    await Storage.pref!.setString('accessToken', data['accessToken']);
    await Storage.pref!.setString('refreshToken', data['refreshToken']);
    String bToken = 'Bearer ${data['accessToken']}';
    trabDio.options.headers['Authorization'] = bToken;
  }

}