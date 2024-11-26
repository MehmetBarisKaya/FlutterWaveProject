import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bootcamp_project/product/init/language/locale_keys.g.dart';
import 'package:flutter_bootcamp_project/product/model/cart_product_response.dart';
import 'package:flutter_bootcamp_project/product/service/network/iproduct_service.dart';
import 'package:flutter_bootcamp_project/product/utility/extension/string_extension.dart';

enum CartStatus { initial, loading, success, failure }

class CartState extends Equatable {
  final CartStatus status;
  final List<CartProduct> cartItems;
  final String? errorMessage;
  final double totalPrice;

  const CartState({
    this.status = CartStatus.initial,
    this.cartItems = const [],
    this.errorMessage,
    this.totalPrice = 0.0,
  });

  CartState copyWith({
    CartStatus? status,
    List<CartProduct>? cartItems,
    String? errorMessage,
    double? totalPrice,
  }) {
    return CartState(
      status: status ?? this.status,
      cartItems: cartItems ?? this.cartItems,
      errorMessage: errorMessage ?? this.errorMessage,
      totalPrice: totalPrice ?? this.totalPrice,
    );
  }

  @override
  List<Object?> get props => [status, cartItems, errorMessage, totalPrice];
}

class CartCubit extends Cubit<CartState> {
  final ICartService cartService;

  CartCubit(this.cartService) : super(const CartState());

  Future<void> fetchCart() async {
    try {
      emit(state.copyWith(status: CartStatus.loading));
      final userName = FirebaseAuth.instance.currentUser!.displayName!
          .split(' ')
          .map((e) => e.toLowerCase())
          .join('_');
      final cartItems = await cartService.getAllProductFromCartByUserName(
        userName,
      );

      if (cartItems != null) {
        final totalPrice = _calculateTotalPrice(cartItems);
        emit(state.copyWith(
          status: CartStatus.success,
          cartItems: cartItems,
          totalPrice: totalPrice,
        ));
      } else {
        emit(state.copyWith(
          status: CartStatus.failure,
          errorMessage: LocaleKeys.general_error.localize,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: CartStatus.failure,
        errorMessage: '${LocaleKeys.general_error.localize} ${e.toString()}',
      ));
    }
  }

  Future<void> removeFromCart(int cartId) async {
    try {
      emit(state.copyWith(status: CartStatus.loading));
      final userName = FirebaseAuth.instance.currentUser!.displayName!
          .split(' ')
          .map((e) => e.toLowerCase())
          .join('_');
      final success = await cartService.deleteProductFromCartByUserName(
        userName,
        cartId,
      );

      if (success) {
        final updatedItems =
            state.cartItems.where((item) => item.sepetId != cartId).toList();
        final totalPrice = _calculateTotalPrice(updatedItems);

        emit(state.copyWith(
          status: CartStatus.success,
          cartItems: updatedItems,
          totalPrice: totalPrice,
        ));
      } else {
        emit(state.copyWith(
          status: CartStatus.failure,
          errorMessage: LocaleKeys.general_error.localize,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: CartStatus.failure,
        errorMessage: LocaleKeys.general_error.localize,
      ));
    }
  }

  Future<void> updateQuantity(CartProduct item, int newQuantity) async {
    try {
      if (newQuantity < 1) return;

      emit(state.copyWith(status: CartStatus.loading));
      final username = FirebaseAuth.instance.currentUser!.displayName!
          .split(' ')
          .map((e) => e.toLowerCase())
          .join('_');

      final updatedProduct = CartProduct(
        sepetId: item.sepetId,
        ad: item.ad,
        resim: item.resim,
        fiyat: item.fiyat,
        marka: item.marka,
        kategori: item.kategori,
        kullaniciAdi: username,
        siparisAdeti: newQuantity,
      );

      final success =
          await cartService.addProductToCartByUserName(updatedProduct);

      if (success) {
        await fetchCart();
      } else {
        emit(state.copyWith(
          status: CartStatus.failure,
          errorMessage: LocaleKeys.general_error.localize,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: CartStatus.failure,
        errorMessage: LocaleKeys.general_error.localize,
      ));
    }
  }

  double _calculateTotalPrice(List<CartProduct> items) {
    return items.fold(
      0.0,
      (total, item) => total + (item.fiyat ?? 0) * (item.siparisAdeti ?? 1),
    );
  }
}
