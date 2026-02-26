import 'dart:math';

import 'package:flutter/material.dart';
import 'package:scroll_challenge/src/core/shared/product_card/product_grid_tile.dart';
import 'package:scroll_challenge/src/modules/cart/model/cart_item/cart_item.dart';
import '../../../modules/cart/ui/widget/cart_quantity_box.dart';
import '../../../modules/product/model/product/product.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        return ProductGridTile(product: product, overlayBuilder: (imageRect) {
          return Stack(
            children: [
              Positioned(
                    right: 10,
                    top: imageRect.top + (imageRect.height * 0.55),
                    child: SizedBox(
                      height: min(imageRect.height * 0.45, 50),
                      child: CartQuantityBox(
                        initialCartImage: CartItem(productId: product.id, cartItemId: product.variants.first.id, name: product.name, price: product.variants.first.price, quantity: 0, salePrice: product.variants.first.salePrice),
                        maxWidth: min(120, width - 16),
                        iconSize: 20,
                      ),
                    ),
                  ),
            ],
          );
        },);
      },
    );
  }
}