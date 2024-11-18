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

  // Future<BaseResponse> baseRequest(
  //   ProductServicePath endPoint,
  //   APIRequestMethod method,
  //   Map<String, dynamic>? data,
  // ) async {
  //   final response = await _dio.request<Map<String, dynamic>>(
  //     ApiConstants.url + endPoint.value,
  //     data: data,
  //     options: Options(
  //       method: method.value,
  //     ),
  //   );
  //   return BaseResponse.fromResponse(response);
  //}
}
