import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_bootcamp_project/product/constants/enums/product_service_path.dart';
import 'package:flutter_bootcamp_project/product/model/base_response.dart';
import 'package:flutter_bootcamp_project/product/model/cart_product_response.dart';
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

  Future<bool> addProductToCartByUserName(CartProduct cartProduct) async {
    final response = await networkService.dio.post(
      ProductServicePath.addProductToCart.value,
      data: cartProduct.toJson(),
      options: Options(contentType: Headers.formUrlEncodedContentType),
    );
    final cartResponse = BaseResponse.fromJson(jsonDecode(response.data));
    if (cartResponse.message == 1) {
      return true;
    }
    return false;
  }

  Future<List<CartProduct>?> getAllProductFromCartByUserName(
      String username) async {
    final response = await networkService.dio.post(
      ProductServicePath.getAllProductFromCart.value,
      data: {
        'kullaniciAdi': username,
      },
      options: Options(contentType: Headers.formUrlEncodedContentType),
    );
    final cartProductResponse =
        CartProductResponse.fromJson(jsonDecode(response.data));
    return cartProductResponse.urunlerSepeti;
  }

  Future<bool> deleteProductFromCartByUserName(
      String username, int cartId) async {
    final response = await networkService.dio.post(
      ProductServicePath.deleteProductFromCart.value,
      data: {
        "sepetId": cartId,
        "kullaniciAdi": username,
      },
      options: Options(contentType: Headers.formUrlEncodedContentType),
    );
    final cartResponse = BaseResponse.fromJson(jsonDecode(response.data));
    if (cartResponse.message == 1) {
      return true;
    }
    return false;
  }
}
