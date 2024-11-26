import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bootcamp_project/product/constants/api_constants.dart';
import 'package:flutter_bootcamp_project/product/cubit/cart_cubit.dart';
import 'package:flutter_bootcamp_project/product/init/language/locale_keys.g.dart';
import 'package:flutter_bootcamp_project/product/model/cart_product_response.dart';
import 'package:flutter_bootcamp_project/product/service/cart_service.dart';
import 'package:flutter_bootcamp_project/product/service/network/product_network_service.dart';
import 'package:flutter_bootcamp_project/product/utility/extension/context_extension.dart';
import 'package:flutter_bootcamp_project/product/utility/extension/string_extension.dart';

part 'widget/cart_view_appBar.dart';

class CartView extends StatelessWidget {
  const CartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(context.screenHeight * 0.1),
        child: CartViewAppBar(),
      ),
      body: BlocProvider(
        create: (context) => CartCubit(CartService(NetworkService.instance)),
        child: BlocConsumer<CartCubit, CartState>(
          listener: (context, state) {
            if (state.status == CartStatus.failure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage ??
                      LocaleKeys.cart_errorOccurred.localize),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state.status == CartStatus.initial) {
              //final username = context.read<AuthCubit>().state.user?.displayName;

              context.read<CartCubit>().fetchCart();
              return const SizedBox();
            }

            if (state.status == CartStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.cartItems.isEmpty) {
              return _buildEmptyCart();
            }

            return _buildbody(context, state);
          },
        ),
      ),
    );
  }

  Column _buildbody(BuildContext context, CartState state) {
    return Column(
      children: [
        SizedBox(
          height: context.screenHeight * 0.02,
        ),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: state.cartItems.length,
            separatorBuilder: (_, __) => const Divider(),
            itemBuilder: (context, index) {
              return _buildCartItem(
                context,
                state.cartItems[index],
              );
            },
          ),
        ),
        _buildBottomBar(context, state),
      ],
    );
  }

  Widget _buildEmptyCart() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.shopping_cart_outlined,
            size: 100,
            color: Colors.grey,
          ),
          const SizedBox(height: 16),
          Text(
            'Sepetiniz boş',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Alışverişe başlamak için ürünleri keşfedin',
            style: TextStyle(
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCartItem(BuildContext context, CartProduct item) {
    return Dismissible(
      key: Key('${item.sepetId}'),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 16),
        color: Colors.red,
        child: const Icon(
          Icons.delete_outline,
          color: Colors.white,
        ),
      ),
      onDismissed: (_) {
        if (item.sepetId != null) {
          context.read<CartCubit>().removeFromCart(item.sepetId!);
        }
      },
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              ApiConstants.imageUrl + item.resim!,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.ad!,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                Text(
                  item.marka!,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
                Text(
                  '${(item.fiyat! * item.siparisAdeti!)} TL',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: context.colorScheme.onPrimary,
                  ),
                ),
              ],
            ),
          ),
          _buildQuantityControls(context, item),
        ],
      ),
    );
  }

  Widget _buildQuantityControls(BuildContext context, CartProduct item) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.remove),
            onPressed: () {
              context.read<CartCubit>().updateQuantity(
                    item,
                    (item.siparisAdeti ?? 1) - 1,
                  );
            },
          ),
          Text(
            '${item.siparisAdeti ?? 1}',
            style: const TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              context.read<CartCubit>().updateQuantity(
                    item,
                    (item.siparisAdeti ?? 1) + 1,
                  );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context, CartState state) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  LocaleKeys.cart_totalAmount.localize,
                  style: context.textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  '${state.totalPrice.toStringAsFixed(2)} TL',
                  style: context.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: context.colorScheme.onPrimary,
                  ),
                ),
              ],
            ),
            SizedBox(height: context.screenHeight * 0.02),
            SizedBox(
              width: double.infinity,
              height: context.screenHeight * 0.06,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: context.colorScheme.onPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  // TODO: Implement checkout
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Ödeme işlemi yakında eklenecek'),
                    ),
                  );
                },
                child: Text(
                  LocaleKeys.cart_goToPayment.localize,
                  style: TextStyle(color: context.colorScheme.surface),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
