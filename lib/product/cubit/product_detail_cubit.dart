import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bootcamp_project/product/init/language/locale_keys.g.dart';
import 'package:flutter_bootcamp_project/product/model/cart_product_response.dart';
import 'package:flutter_bootcamp_project/product/model/product.dart';
import 'package:flutter_bootcamp_project/product/service/cart_service.dart';
import 'package:flutter_bootcamp_project/product/service/user_setvice.dart';
import 'package:flutter_bootcamp_project/product/utility/extension/string_extension.dart';

enum ProductDetailStatus { initial, loading, success, failure }

class ProductDetailState extends Equatable {
  final ProductDetailStatus status;
  final int quantity;
  final String? errorMessage;
  final bool isInCart;
  final bool isFavorite;

  const ProductDetailState({
    this.status = ProductDetailStatus.initial,
    this.quantity = 1,
    this.errorMessage,
    this.isInCart = false,
    this.isFavorite = false,
  });

  ProductDetailState copyWith({
    ProductDetailStatus? status,
    int? quantity,
    String? errorMessage,
    bool? isInCart,
    bool? isFavorite,
  }) {
    return ProductDetailState(
      status: status ?? this.status,
      quantity: quantity ?? this.quantity,
      errorMessage: errorMessage ?? this.errorMessage,
      isInCart: isInCart ?? this.isInCart,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  @override
  List<Object?> get props =>
      [status, quantity, errorMessage, isInCart, isFavorite];
}

class ProductDetailCubit extends Cubit<ProductDetailState> {
  final CartService cartService;
  final String username;

  ProductDetailCubit({
    required this.cartService,
    required this.username,
  }) : super(const ProductDetailState());

  void incrementQuantity() {
    emit(state.copyWith(quantity: state.quantity + 1));
  }

  void decrementQuantity() {
    if (state.quantity > 1) {
      emit(state.copyWith(quantity: state.quantity - 1));
    }
  }

  Future<void> addToCart(Product product) async {
    try {
      emit(state.copyWith(status: ProductDetailStatus.loading));
      final userName = FirebaseAuth.instance.currentUser!.displayName!
          .split(' ')
          .map((e) => e.toLowerCase())
          .join('_');

      print(userName);

      final cartProduct = CartProduct(
        ad: product.ad,
        resim: product.resim,
        kategori: product.kategori,
        fiyat: product.fiyat,
        marka: product.marka,
        siparisAdeti: state.quantity,
        kullaniciAdi: userName,
      );

      final result = await cartService.addProductToCartByUserName(
        cartProduct,
      );

      if (result) {
        emit(state.copyWith(
          status: ProductDetailStatus.success,
          isInCart: true,
        ));
      } else {
        emit(state.copyWith(
          status: ProductDetailStatus.failure,
          errorMessage: LocaleKeys.general_error.localize,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: ProductDetailStatus.failure,
        errorMessage: LocaleKeys.general_error.localize,
      ));
    }
  }

  Future<void> toggleFavorite(int productId) async {
    emit(state.copyWith(isFavorite: !state.isFavorite));
    await FirebaseAuthService().toggleFavorite(productId);
  }
}
