import 'dart:convert';

import 'package:flutter_bootcamp_project/product/constants/enums/product_service_path.dart';
import 'package:flutter_bootcamp_project/product/model/product_response.dart';
import 'package:flutter_bootcamp_project/product/service/product_network_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late final NetworkService networkService;
  setUp(() {
    networkService = NetworkService.instance;
  });
  test('Get all product', () async {
    final response =
        await networkService.dio.get(ProductServicePath.getAllProduct.value);
    final productResponse = ProductResponse.fromJson(jsonDecode(response.data));
    expect(productResponse.success, equals(1));
  });
}
