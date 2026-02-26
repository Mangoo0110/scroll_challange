import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_variant.freezed.dart';
part 'product_variant.g.dart';

@freezed
class ProductVariant with _$ProductVariant {
  const ProductVariant._();

  const factory ProductVariant({
    required String id,
    required String productId,
    required double price,
    double? salePrice,
    String? sku,
    String? barcode,
    String? imageUrl,
    @Default(true) bool isActive,
    @Default(true) bool inStock,
    @Default(<VariantAttribute>[]) List<VariantAttribute> attributes,
  }) = _ProductVariant;

  factory ProductVariant.fromJson(Map<String, dynamic> json) =>
      _$ProductVariantFromJson(json);

  double get effectivePrice => salePrice ?? price;
}

@freezed
class VariantAttribute with _$VariantAttribute {
  const VariantAttribute._();

  const factory VariantAttribute({
    required String name,
    required String value,
  }) = _VariantAttribute;

  factory VariantAttribute.fromJson(Map<String, dynamic> json) =>
      _$VariantAttributeFromJson(json);
}
