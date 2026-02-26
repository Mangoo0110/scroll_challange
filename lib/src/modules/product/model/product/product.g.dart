// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductImpl _$$ProductImplFromJson(Map<String, dynamic> json) =>
    _$ProductImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      categoryIds: (json['categoryIds'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      description: json['description'] as String?,
      imageUrl: json['imageUrl'] as String?,
      variants: (json['variants'] as List<dynamic>)
          .map((e) => ProductVariant.fromJson(e as Map<String, dynamic>))
          .toList(),
      isActive: json['isActive'] as bool? ?? true,
    );

Map<String, dynamic> _$$ProductImplToJson(_$ProductImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'categoryIds': instance.categoryIds,
      'description': instance.description,
      'imageUrl': instance.imageUrl,
      'variants': instance.variants,
      'isActive': instance.isActive,
    };

_$ProductQueryParamsImpl _$$ProductQueryParamsImplFromJson(
  Map<String, dynamic> json,
) => _$ProductQueryParamsImpl(
  query: json['query'] as String?,
  categoryId: json['categoryId'] as String?,
  minPrice: (json['minPrice'] as num?)?.toDouble(),
  maxPrice: (json['maxPrice'] as num?)?.toDouble(),
  page: (json['page'] as num?)?.toInt() ?? 1,
  limit: (json['limit'] as num?)?.toInt() ?? 20,
  onlyActive: json['onlyActive'] as bool? ?? true,
);

Map<String, dynamic> _$$ProductQueryParamsImplToJson(
  _$ProductQueryParamsImpl instance,
) => <String, dynamic>{
  'query': instance.query,
  'categoryId': instance.categoryId,
  'minPrice': instance.minPrice,
  'maxPrice': instance.maxPrice,
  'page': instance.page,
  'limit': instance.limit,
  'onlyActive': instance.onlyActive,
};
