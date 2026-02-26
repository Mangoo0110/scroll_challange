// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CartImpl _$$CartImplFromJson(Map<String, dynamic> json) => _$CartImpl(
  userId: json['userId'] as String?,
  cartId: json['cartId'] as String? ?? 'default',
  items:
      (json['items'] as List<dynamic>?)
          ?.map((e) => CartItem.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <CartItem>[],
  deliveryFee: (json['deliveryFee'] as num?)?.toInt() ?? 59,
  discount: (json['discount'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$$CartImplToJson(_$CartImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'cartId': instance.cartId,
      'items': instance.items.map((e) => e.toJson()).toList(),
      'deliveryFee': instance.deliveryFee,
      'discount': instance.discount,
    };
