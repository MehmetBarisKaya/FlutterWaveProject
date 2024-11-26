import 'package:dio/dio.dart';
import 'package:flutter_bootcamp_project/product/constants/api_constants.dart';

final class NetworkService {
  NetworkService._() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.url,
        connectTimeout: ApiConstants.connectTimeout,
        receiveTimeout: ApiConstants.receiveTimeout,
      ),
    );
  }

  static late final Dio _dio;

  Dio get dio => _dio;

  static final instance = NetworkService._();
}
