import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_bootcamp_project/product/constants/enums/product_service_path.dart';
import 'package:flutter_bootcamp_project/product/model/base_response.dart';
import 'package:flutter_bootcamp_project/product/model/cart_product_response.dart';
import 'package:flutter_bootcamp_project/product/service/network/iproduct_service.dart';
import 'package:flutter_bootcamp_project/product/service/network/product_network_service.dart';

class CartService extends ICartService {
  final NetworkService networkService;

  CartService(this.networkService);

  @override
  Future<List<CartProduct>?> getAllProductFromCartByUserName(
      String username) async {
    final response = await networkService.dio.post(
      ProductServicePath.getAllProductFromCart.value,
      data: {
        'kullaniciAdi': username,
      },
      options: Options(contentType: Headers.formUrlEncodedContentType),
    );

    if (response.data.toString().trim() == "") {
      return [];
    }
    final cartProductResponse =
        CartProductResponse.fromJson(jsonDecode(response.data));
    return cartProductResponse.urunlerSepeti;
  }

  @override
  Future<bool> addProductToCartByUserName(CartProduct cartProduct) async {
    final allCartProducts =
        await getAllProductFromCartByUserName(cartProduct.kullaniciAdi!);

    if (allCartProducts != null) {
      for (var product in allCartProducts) {
        if (product.ad == cartProduct.ad) {
          await deleteProductFromCartByUserName(
              cartProduct.kullaniciAdi!, product.sepetId!);
        }
      }
    }
    final response = await networkService.dio.post(
      ProductServicePath.addProductToCart.value,
      data: cartProduct.toJson(),
      options: Options(contentType: Headers.formUrlEncodedContentType),
    );
    final cartResponse = BaseResponse.fromJson(jsonDecode(response.data));
    if (cartResponse.success == 1) {
      return true;
    }
    return false;
  }

  @override
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
    if (cartResponse.success == 1) {
      return true;
    }
    return false;
  }
}
