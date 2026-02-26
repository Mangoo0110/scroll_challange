// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_variant.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductVariantImpl _$$ProductVariantImplFromJson(Map<String, dynamic> json) =>
    _$ProductVariantImpl(
      id: json['id'] as String,
      productId: json['productId'] as String,
      price: (json['price'] as num).toDouble(),
      salePrice: (json['salePrice'] as num?)?.toDouble(),
      sku: json['sku'] as String?,
      barcode: json['barcode'] as String?,
      imageUrl: json['imageUrl'] as String?,
      isActive: json['isActive'] as bool? ?? true,
      inStock: json['inStock'] as bool? ?? true,
      attributes:
          (json['attributes'] as List<dynamic>?)
              ?.map((e) => VariantAttribute.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <VariantAttribute>[],
    );

Map<String, dynamic> _$$ProductVariantImplToJson(
  _$ProductVariantImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'productId': instance.productId,
  'price': instance.price,
  'salePrice': instance.salePrice,
  'sku': instance.sku,
  'barcode': instance.barcode,
  'imageUrl': instance.imageUrl,
  'isActive': instance.isActive,
  'inStock': instance.inStock,
  'attributes': instance.attributes,
};

_$VariantAttributeImpl _$$VariantAttributeImplFromJson(
  Map<String, dynamic> json,
) => _$VariantAttributeImpl(
  name: json['name'] as String,
  value: json['value'] as String,
);

Map<String, dynamic> _$$VariantAttributeImplToJson(
  _$VariantAttributeImpl instance,
) => <String, dynamic>{'name': instance.name, 'value': instance.value};
