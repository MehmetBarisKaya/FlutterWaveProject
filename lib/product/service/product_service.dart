import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_bootcamp_project/product/constants/enums/product_service_path.dart';
import 'package:flutter_bootcamp_project/product/model/product_response.dart';
import 'package:flutter_bootcamp_project/product/service/iproduct_service.dart';
import 'package:flutter_bootcamp_project/product/service/product_network_service.dart';

class ProductService extends IProductService {
  final NetworkService networkService;

  ProductService(this.networkService);

  @override
  Future<ProductResponse> getAllProducts() async {
    try {
      final response =
          await networkService.dio.get(ProductServicePath.getAllProduct.value);
      return ProductResponse.fromJson(jsonDecode(response.data));
    } on DioException catch (e) {
      throw Exception('Failed to fetch products: ${e.message}');
    }
  }
}
