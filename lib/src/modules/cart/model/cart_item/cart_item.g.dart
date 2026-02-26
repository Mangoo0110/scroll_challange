// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CartItemImpl _$$CartItemImplFromJson(Map<String, dynamic> json) =>
    _$CartItemImpl(
      productId: json['productId'] as String,
      cartItemId: json['cartItemId'] as String,
      name: json['name'] as String,
      imageUrl: json['imageUrl'] as String?,
      unitLabel: json['unitLabel'] as String?,
      price: (json['price'] as num).toDouble(),
      salePrice: (json['salePrice'] as num?)?.toDouble(),
      quantity: (json['quantity'] as num?)?.toInt() ?? 1,
    );

Map<String, dynamic> _$$CartItemImplToJson(_$CartItemImpl instance) =>
    <String, dynamic>{
      'productId': instance.productId,
      'cartItemId': instance.cartItemId,
      'name': instance.name,
      'imageUrl': instance.imageUrl,
      'unitLabel': instance.unitLabel,
      'price': instance.price,
      'salePrice': instance.salePrice,
      'quantity': instance.quantity,
    };
