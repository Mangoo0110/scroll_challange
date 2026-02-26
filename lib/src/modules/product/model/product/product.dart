import 'package:freezed_annotation/freezed_annotation.dart';

import '../product_variant/product_variant.dart';

export '../product_variant/product_variant.dart';

part 'product.freezed.dart';
part 'product.g.dart';

@freezed
class Product with _$Product {
  const Product._();

  const factory Product({
    required String id,
    required String name,
    required List<String> categoryIds,
    String? description,
    String? imageUrl,
    required List<ProductVariant> variants,
    @Default(true) bool isActive,
  }) = _Product;

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
}

@freezed
class ProductQueryParams with _$ProductQueryParams {
  const ProductQueryParams._();

  const factory ProductQueryParams({
    String? query,
    String? categoryId,
    double? minPrice,
    double? maxPrice,
    @Default(1) int page,
    @Default(20) int limit,
    @Default(true) bool onlyActive,
  }) = _ProductQueryParams;

  factory ProductQueryParams.fromJson(Map<String, dynamic> json) =>
      _$ProductQueryParamsFromJson(json);
}

