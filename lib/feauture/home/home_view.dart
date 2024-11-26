import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bootcamp_project/feauture/home/widget/product_cart.dart';
import 'package:flutter_bootcamp_project/feauture/product_detail/product_detail_view.dart';
import 'package:flutter_bootcamp_project/product/cubit/product_cubit.dart';
import 'package:flutter_bootcamp_project/product/init/language/locale_keys.g.dart';
import 'package:flutter_bootcamp_project/product/model/product.dart';
import 'package:flutter_bootcamp_project/product/utility/extension/context_extension.dart';
import 'package:flutter_bootcamp_project/product/utility/extension/string_extension.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.menu_outlined)),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              LocaleKeys.home_welcomeMessage.localize,
              style: context.textTheme.headlineSmall,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Color(0xFFF3F4F9),
                hintText: LocaleKeys.home_searchPlaceholder.localize,
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (value) {
                context.read<ProductCubit>().searchProducts(value);
              },
            ),
          ),
          Expanded(child: BlocBuilder<ProductCubit, ProductState>(
            builder: (context, state) {
              switch (state.status) {
                case ProductStatus.initial:
                  return SizedBox();
                case ProductStatus.loading:
                  return Center(child: CircularProgressIndicator());
                case ProductStatus.failure:
                  return Center(
                      child: Text(state.errorMessage ??
                          LocaleKeys.general_error.localize));
                case ProductStatus.success:
                  return _buildProductGridView(state.products);
              }
            },
          )),
        ],
      ),
    );
  }

  GridView _buildProductGridView(List<Product> products) {
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.6,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) => GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProductDetailView(
                        product: products[index],
                      )));
        },
        child: ProductCard(
          product: products[index],
        ),
      ),
    );
  }
}
