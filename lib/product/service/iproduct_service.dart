import 'package:flutter_bootcamp_project/product/model/cart_product_response.dart';
import 'package:flutter_bootcamp_project/product/model/product_response.dart';

abstract class IProductService {
  Future<ProductResponse> getAllProducts();
  Future<bool> addProductToCartByUserName(CartProduct cartProduct);
  Future<List<CartProduct>?> getAllProductFromCartByUserName(String username);
  Future<bool> deleteProductFromCartByUserName(String username, int cartId);
}
