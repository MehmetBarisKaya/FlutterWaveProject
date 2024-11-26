import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bootcamp_project/product/init/language/locale_keys.g.dart';
import 'package:flutter_bootcamp_project/product/model/product.dart';
import 'package:flutter_bootcamp_project/product/service/network/iproduct_service.dart';
import 'package:flutter_bootcamp_project/product/utility/extension/string_extension.dart';

enum ProductStatus { initial, loading, success, failure }

class ProductState extends Equatable {
  final ProductStatus status;
  final List<Product> products;
  final String? errorMessage;

  const ProductState({
    this.status = ProductStatus.initial,
    this.products = const [],
    this.errorMessage,
  });

  ProductState copyWith({
    ProductStatus? status,
    List<Product>? products,
    String? errorMessage,
  }) {
    return ProductState(
      status: status ?? this.status,
      products: products ?? this.products,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, products, errorMessage];
}

class ProductCubit extends Cubit<ProductState> {
  final IProductService productService;

  ProductCubit(this.productService) : super(const ProductState());

  Future<void> fetchProducts() async {
    try {
      emit(state.copyWith(status: ProductStatus.loading));

      final response = await productService.getAllProducts();

      if (response.urunler != null) {
        emit(state.copyWith(
          status: ProductStatus.success,
          products: response.urunler,
        ));
      } else {
        emit(state.copyWith(
          status: ProductStatus.failure,
          errorMessage: LocaleKeys.general_error.localize,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: ProductStatus.failure,
        errorMessage: LocaleKeys.general_error.localize,
      ));
    }
  }

  Future<void> searchProducts(String query) async {
    try {
      if (query.isEmpty) {
        await fetchProducts();
        return;
      }

      emit(state.copyWith(status: ProductStatus.loading));

      final response = await productService.searchProducts(query);

      if (response.urunler != null) {
        emit(state.copyWith(
          status: ProductStatus.success,
          products: response.urunler,
        ));
      } else {
        emit(state.copyWith(
          status: ProductStatus.failure,
          errorMessage: LocaleKeys.general_error.localize,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: ProductStatus.failure,
        errorMessage: LocaleKeys.general_error.localize,
      ));
    }
  }
}
