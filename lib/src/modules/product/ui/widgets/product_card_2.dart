import 'package:flutter/material.dart';
import 'package:scroll_challenge/src/modules/product/model/product/product.dart';

class ProductCard2 extends StatelessWidget {
  const ProductCard2({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          product.imageUrl != null ? Image.network(
            product.imageUrl!,
            height: 120,
            width: double.infinity,
            fit: BoxFit.cover,
          ) : const Icon(Icons.image, size: 80, color: Colors.grey),
          Text(product.name, ),
          Text('\$${product.variants.first.price.toStringAsFixed(2)}', style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor),),
        ],
      ),
    );
  }
}