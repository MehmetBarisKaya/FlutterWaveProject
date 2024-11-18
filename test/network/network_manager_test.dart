import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_bootcamp_project/product/constants/enums/product_service_path.dart';
import 'package:flutter_bootcamp_project/product/model/base_response.dart';
import 'package:flutter_bootcamp_project/product/model/cart_product_response.dart';
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
  test('Add product to shopping cart by username', () async {
    final response = await networkService.dio.post(
      '/urunler/sepeteUrunEkle.php',
      data: {
        'ad': 'Kulaklık Test',
        'resim': 'kulaklik.png',
        'kategori': 'Teknoloji',
        'fiyat': 1000,
        'marka': 'Apple',
        'siparisAdeti': 1,
        'kullaniciAdi': 'baris_kaya',
      },
      options: Options(contentType: Headers.formUrlEncodedContentType),
    );
    final cartResponse = BaseResponse.fromJson(jsonDecode(response.data));

    expect(cartResponse.message, isNotNull);
  });

  test('Get all product to shopping cart by username', () async {
    final response = await networkService.dio.post(
      '/urunler/sepettekiUrunleriGetir.php',
      data: {
        'kullaniciAdi': 'baris_kaya',
      },
      options: Options(contentType: Headers.formUrlEncodedContentType),
    );
    final cartProductResponse =
        CartProductResponse.fromJson(jsonDecode(response.data));

    expect(cartProductResponse.urunlerSepeti, isNotNull);
  });

  test('Get all product to shopping cart by username', () async {
    final response = await networkService.dio.post(
      '/urunler/sepettekiUrunleriGetir.php',
      data: {
        'kullaniciAdi': 'baris_kaya',
      },
      options: Options(contentType: Headers.formUrlEncodedContentType),
    );
    final cartProductResponse =
        CartProductResponse.fromJson(jsonDecode(response.data));

    expect(cartProductResponse.urunlerSepeti, isNotNull);
  });
}
