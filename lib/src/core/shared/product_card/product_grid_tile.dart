import 'dart:math';

import 'package:flutter/material.dart';

import '../../themes/app_colors.dart';
import '../../../modules/product/model/product/product.dart';
import '../widget/image_placeholder_widget.dart';
import 'cart_quantity_box.dart';

class ProductGridTile extends StatelessWidget {
  const ProductGridTile({
    super.key,
    required this.product,
    this.overlayBuilder,
  });

  final Product product;
  final Widget Function(Rect imageRect)? overlayBuilder;

  @override
  Widget build(BuildContext context) {
    final priceInfo = priceInfoForProduct(product);
    final deliveryLabel = _deliveryLabel(product);
    final unitLabel = _unitLabel(product);

    return LayoutBuilder(
      builder: (context, constraints) {

        debugPrint('ProductCard constraints: $constraints');
        final width = constraints.maxWidth;
        final height = constraints.maxHeight;
        final hPad = width * 0.08;
        final vPadTop = height * 0.06;
        final vPadBottom = height * 0.08;
        final imageHeight = height * 0.38;
        final priceFont = width * 0.10;
        final labelFont = width * 0.09;
        final nameFont = width * 0.07;
        final smallFont = width * 0.07;

        return Stack(
          children: [
            // Product details container
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(width * 0.08),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image container
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                      hPad,
                      vPadTop,
                      hPad,
                      height * 0.02,
                    ),
                    child: Center(
                      child: Container(
                        height: imageHeight,
                        width: double.infinity,
                        decoration: BoxDecoration(),
                        child: ProductImage(imageUrl: product.imageUrl),
                      ),
                    ),
                  ),
                  // Details container
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                      hPad,
                      height * 0.01,
                      hPad,
                      vPadBottom,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FittedBox(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              if (priceInfo.hasMultipleVariants)
                                Text(
                                  'From ',
                                  style: TextStyle(
                                    fontSize: labelFont,
                                    color: const Color(0xFF6B6B6B),
                                  ),
                                ),
                              Text(
                                moneyFormat(priceInfo.minPrice),
                                style: TextStyle(
                                  fontSize: priceFont,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              if (priceInfo.originalPrice != null) ...[
                                SizedBox(width: width * 0.03),
                                Text(
                                  moneyFormat(priceInfo.originalPrice!),
                                  style: TextStyle(
                                    fontSize: labelFont,
                                    color: const Color(0xFF9A9A9A),
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                        Text(
                          product.name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: nameFont,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: height * 0.03),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: width * 0.4,
                              child: Text(
                                unitLabel,
                                maxLines: 2,
                                style: TextStyle(
                                  fontSize: smallFont,
                                  color: const Color(0xFF8A8A8A),
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.timer_outlined,
                                  size: smallFont * 1.1,
                                  color: const Color(0xFFB0B0B0),
                                ),
                                SizedBox(width: width * 0.02),
                                Text(
                                  deliveryLabel,
                                  style: TextStyle(
                                    fontSize: smallFont,
                                    color: const Color(0xFF8A8A8A),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Overlay builder (e.g. for cart quantity box)
            if (overlayBuilder != null)
              Positioned.fill(
                child: LayoutBuilder(
                  builder: (context, overlayConstraints) {
                    final imageRect = Rect.fromLTWH(
                      hPad,
                      vPadTop,
                      overlayConstraints.maxWidth - 2 * hPad,
                      imageHeight,
                    );
                    return overlayBuilder!(imageRect);
                  },
                ),
              ),
          ],
        );
      },
    );
  }
}

class ProductImage extends StatelessWidget {
  const ProductImage({super.key, this.imageUrl});

  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    final url = imageUrl?.trim() ?? '';
    if (url.isEmpty) {
      return const ImagePlaceholderWidget(displayHeight: 90, displayWidth: 90);
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.network(
        url,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          return const ImagePlaceholderWidget(
            displayHeight: 90,
            displayWidth: 90,
          );
        },
      ),
    );
  }
}

class PriceInfo {
  const PriceInfo({
    required this.minPrice,
    required this.originalPrice,
    required this.hasMultipleVariants,
  });

  final double minPrice;
  final double? originalPrice;
  final bool hasMultipleVariants;
}

PriceInfo priceInfoForProduct(Product product) {
  if (product.variants.isEmpty) {
    return const PriceInfo(
      minPrice: 0,
      originalPrice: null,
      hasMultipleVariants: false,
    );
  }
  ProductVariant? selected;
  for (final variant in product.variants) {
    if (selected == null || variant.effectivePrice < selected!.effectivePrice) {
      selected = variant;
    }
  }
  final original = (selected!.salePrice != null) ? selected!.price : null;
  return PriceInfo(
    minPrice: selected!.effectivePrice,
    originalPrice: original,
    hasMultipleVariants: product.variants.length > 1,
  );
}

String moneyFormat(double value) => '৳${value.toStringAsFixed(2)}';

String _unitLabel(Product product) {
  if (product.variants.isEmpty) return '';
  final first = product.variants.first;
  if (first.attributes.isEmpty) return '';
  return first.attributes.first.value;
}

String _deliveryLabel(Product product) {
  final hasStock = product.variants.any((v) => v.inStock);
  return hasStock ? '1 hr' : 'Next Day';
}
