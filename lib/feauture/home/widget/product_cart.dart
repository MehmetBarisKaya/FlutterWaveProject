import 'package:flutter/material.dart';
import 'package:flutter_bootcamp_project/product/constants/api_constants.dart';
import 'package:flutter_bootcamp_project/product/model/product.dart';
import 'package:flutter_bootcamp_project/product/utility/extension/context_extension.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({
    required this.product,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      //color: context.colorScheme.onSecondary,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image.network(
              ApiConstants.imageUrl + product.resim!,
              fit: BoxFit.contain,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.ad!,
                  style: context.textTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: context.screenHeight * 0.005),
                Text(
                  product.marka!,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  '${product.fiyat!.toStringAsFixed(2)} TL',
                  style: context.textTheme.bodyLarge
                      ?.copyWith(color: context.colorScheme.onPrimary),
                ),
                SizedBox(height: context.screenHeight * 0.01),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
