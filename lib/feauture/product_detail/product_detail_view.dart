import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bootcamp_project/product/constants/api_constants.dart';
import 'package:flutter_bootcamp_project/product/cubit/product_detail_cubit.dart';
import 'package:flutter_bootcamp_project/product/init/app_initialize.dart';
import 'package:flutter_bootcamp_project/product/init/language/locale_keys.g.dart';
import 'package:flutter_bootcamp_project/product/model/product.dart';
import 'package:flutter_bootcamp_project/product/utility/extension/context_extension.dart';
import 'package:flutter_bootcamp_project/product/utility/extension/string_extension.dart';

class ProductDetailView extends StatelessWidget {
  final Product product;

  const ProductDetailView({required this.product, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ProductDetailCubit>(),
      child: ProductDetailContent(product: product),
    );
  }
}

class ProductDetailContent extends StatelessWidget {
  final Product product;

  const ProductDetailContent({required this.product, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.onPrimary,
      body: SafeArea(
        child: BlocConsumer<ProductDetailCubit, ProductDetailState>(
          listenWhen: (previous, current) => previous.status != current.status,
          listener: (context, state) {
            if (state.status == ProductDetailStatus.success) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text(
                        LocaleKeys.productDetail_productAddedToCart.localize)),
              );
            } else if (state.status == ProductDetailStatus.failure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text(state.errorMessage ??
                        LocaleKeys.productDetail_errorOccurred.localize)),
              );
            }
          },
          builder: (context, state) {
            return Column(
              children: [
                _buildTopPart(context),
                _buildbottomPart(context, state),
              ],
            );
          },
        ),
      ),
    );
  }

  Expanded _buildbottomPart(BuildContext context, ProductDetailState state) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: _buildProductDetailPart(context, state),
        ),
      ),
    );
  }

  Stack _buildTopPart(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: context.screenHeight * 0.5,
          decoration: BoxDecoration(
            color: context.colorScheme.onPrimary,
          ),
        ),
        Positioned(
          top: 16,
          left: 16,
          child: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 60),
            child: Image.network(ApiConstants.imageUrl + product.resim!),
          ),
        ),
      ],
    );
  }

  Column _buildProductDetailPart(
      BuildContext context, ProductDetailState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          product.ad ?? '',
          style: context.textTheme.headlineLarge
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: context.screenHeight * 0.05),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      context.read<ProductDetailCubit>().decrementQuantity();
                    },
                    icon: Icon(
                      Icons.remove_circle_outline_outlined,
                      size: context.screenHeight * 0.04,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Text(
                      state.quantity.toString(),
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      context.read<ProductDetailCubit>().incrementQuantity();
                    },
                    icon: Icon(
                      Icons.add_circle_outline_sharp,
                      color: context.colorScheme.onPrimary,
                      size: context.screenHeight * 0.04,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              '${(state.quantity * (product.fiyat ?? 0)).toStringAsFixed(1)} TL',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ],
        ),
        SizedBox(height: context.screenHeight * 0.02),
        if (product.marka != null) ...[
          Text(
            LocaleKeys.productDetail_brand.localize + ": ${product.marka}",
            style: context.textTheme.bodyLarge,
          ),
          const SizedBox(height: 8),
        ],
        Text(
            LocaleKeys.productDetail_category.localize +
                ": ${product.kategori!}",
            style: context.textTheme.bodyLarge),
        const SizedBox(height: 8),
        Spacer(),
        _buildAddToCartButton(context, state),
      ],
    );
  }

  SizedBox _buildAddToCartButton(
      BuildContext context, ProductDetailState state) {
    return SizedBox(
      width: double.infinity,
      height: context.screenHeight * 0.06,
      child: ElevatedButton(
        onPressed: state.status == ProductDetailStatus.loading
            ? null
            : () {
                context.read<ProductDetailCubit>().addToCart(product);
              },
        style: ElevatedButton.styleFrom(
          backgroundColor: context.colorScheme.onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: state.status == ProductDetailStatus.loading
            ? CircularProgressIndicator(
                strokeWidth: 2,
              )
            : Text(
                LocaleKeys.productDetail_addToCart.localize,
                style: TextStyle(color: Colors.white),
              ),
      ),
    );
  }
}
