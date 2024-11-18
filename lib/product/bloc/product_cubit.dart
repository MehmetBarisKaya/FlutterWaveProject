import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bootcamp_project/product/model/product.dart';
import 'package:flutter_bootcamp_project/product/service/iproduct_service.dart';

// Events
abstract class ProductsEvent {}

class FetchProducts extends ProductsEvent {}

// States
abstract class ProductsState {}

class ProductsInitial extends ProductsState {}

class ProductsLoading extends ProductsState {}

class ProductsLoaded extends ProductsState {
  final List<Product> products;

  ProductsLoaded(this.products);
}

class ProductsError extends ProductsState {
  final String message;

  ProductsError(this.message);
}

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final IProductService _productRepository;

  ProductsBloc(this._productRepository) : super(ProductsInitial()) {
    on<FetchProducts>((event, emit) async {
      emit(ProductsLoading());
      try {
        final response = await _productRepository.getAllProducts();
        emit(ProductsLoaded(response.urunler!));
      } catch (e) {
        emit(ProductsError(e.toString()));
      }
    });
  }
}
