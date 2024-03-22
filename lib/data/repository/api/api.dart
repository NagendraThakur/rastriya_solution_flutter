import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class API {
  final Dio _dio = Dio();

  API() {
    // _dio.options.baseUrl = "http://192.168.254.155:8000"; //server
    _dio.options.baseUrl = "https://dev.sajilo360.com"; //server
    _dio.interceptors.add(PrettyDioLogger());
  }
  Dio get sendRequest => _dio;
}
