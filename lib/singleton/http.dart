import 'package:dio/dio.dart';
import 'package:trablog/const/const_value.dart';

final googleDio = Dio(BaseOptions(baseUrl: BASE_LOCATION_URL));

final trabDio = Dio(BaseOptions(baseUrl: BASE_SERVER_URL));