// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_ops.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CartOpImpl _$$CartOpImplFromJson(Map<String, dynamic> json) => _$CartOpImpl(
  id: json['id'] as String,
  type: json['type'] as String,
  item: json['item'] == null
      ? null
      : CartItem.fromJson(json['item'] as Map<String, dynamic>),
  variantId: json['variantId'] as String?,
  quantity: (json['quantity'] as num?)?.toInt(),
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$$CartOpImplToJson(_$CartOpImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'item': instance.item?.toJson(),
      'variantId': instance.variantId,
      'quantity': instance.quantity,
      'createdAt': instance.createdAt.toIso8601String(),
    };
