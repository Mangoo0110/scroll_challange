import 'package:flutter/material.dart';
import 'package:scroll_challenge/src/modules/product/model/product/product.dart';

class ProductCard2 extends StatelessWidget {
  const ProductCard2({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      elevation: .5,
      child: Column(
        children: [
          product.imageUrl != null ? Image.network(
            product.imageUrl!,
            height: 120,
            width: double.infinity,
            fit: BoxFit.cover,
          ) : const Icon(Icons.image, size: 80, color: Colors.grey),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product.name, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12),),
                Text(
                  '৳${product.variants.first.price.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                    fontSize: 14
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}