import 'package:flutter_bootcamp_project/product/model/product_response.dart';

abstract class IProductService {
  Future<ProductResponse> getAllProducts();
}
