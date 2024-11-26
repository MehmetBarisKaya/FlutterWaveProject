import 'package:flutter_bootcamp_project/product/constants/api_constants.dart';
import 'package:flutter_bootcamp_project/product/model/cart_product_response.dart';
import 'package:flutter_bootcamp_project/product/service/cart_service.dart';
import 'package:flutter_bootcamp_project/product/service/network/iproduct_service.dart';
import 'package:flutter_bootcamp_project/product/service/network/product_network_service.dart';
import 'package:flutter_bootcamp_project/product/service/product_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late final IProductService _productService;
  late final ICartService _cartService;
  setUp(() {
    _productService = ProductService(
      NetworkService.instance,
    );
    _cartService = CartService(
      NetworkService.instance,
    );
  });
  test('Get all product', () async {
    final response = await _productService.getAllProducts();
    expect(response.urunler, isNotNull);
  });
  test('Add product to shopping cart by username', () async {
    final cartProduct = CartProduct(
      ad: "Test",
      resim: "saat.png",
      kategori: "Teknoloji",
      fiyat: 1200,
      marka: "Samsung",
      siparisAdeti: 1,
      kullaniciAdi: "baris_kaya",
    );

    final response = await _cartService.addProductToCartByUserName(cartProduct);

    expect(response, true);
  });

  test('Get all product to shopping cart by username', () async {
    final response = await _cartService
        .getAllProductFromCartByUserName(ApiConstants.username);

    expect(response, isNotNull);
  });

  test('Get all product to shopping cart by username', () async {
    final response = await _cartService.deleteProductFromCartByUserName(
        ApiConstants.username, 20880);

    expect(response, true);
  });
}
