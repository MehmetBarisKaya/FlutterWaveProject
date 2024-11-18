import 'package:dio/dio.dart';

final class BaseResponse {
  BaseResponse(this.statusCode, this.data);
  final int statusCode;
  final Map<String, dynamic> data;

  factory BaseResponse.fromResponse(
    Response<Map<String, dynamic>> response,
  ) {
    return BaseResponse(response.statusCode ?? 500, response.data ?? {});
  }

  String? get clientErrorMessage {
    if (statusCode >= 400 && statusCode <= 500) {
      if (data['error'] == null) {
        return 'Unexpected error';
      }
      return data['error'] as String;
    }
    return null;
  }
}
