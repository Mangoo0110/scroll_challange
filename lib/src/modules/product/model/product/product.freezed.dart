// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Product _$ProductFromJson(Map<String, dynamic> json) {
  return _Product.fromJson(json);
}

/// @nodoc
mixin _$Product {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  List<String> get categoryIds => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;
  List<ProductVariant> get variants => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;

  /// Serializes this Product to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProductCopyWith<Product> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductCopyWith<$Res> {
  factory $ProductCopyWith(Product value, $Res Function(Product) then) =
      _$ProductCopyWithImpl<$Res, Product>;
  @useResult
  $Res call({
    String id,
    String name,
    List<String> categoryIds,
    String? description,
    String? imageUrl,
    List<ProductVariant> variants,
    bool isActive,
  });
}

/// @nodoc
class _$ProductCopyWithImpl<$Res, $Val extends Product>
    implements $ProductCopyWith<$Res> {
  _$ProductCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? categoryIds = null,
    Object? description = freezed,
    Object? imageUrl = freezed,
    Object? variants = null,
    Object? isActive = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            categoryIds: null == categoryIds
                ? _value.categoryIds
                : categoryIds // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            imageUrl: freezed == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            variants: null == variants
                ? _value.variants
                : variants // ignore: cast_nullable_to_non_nullable
                      as List<ProductVariant>,
            isActive: null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ProductImplCopyWith<$Res> implements $ProductCopyWith<$Res> {
  factory _$$ProductImplCopyWith(
    _$ProductImpl value,
    $Res Function(_$ProductImpl) then,
  ) = __$$ProductImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    List<String> categoryIds,
    String? description,
    String? imageUrl,
    List<ProductVariant> variants,
    bool isActive,
  });
}

/// @nodoc
class __$$ProductImplCopyWithImpl<$Res>
    extends _$ProductCopyWithImpl<$Res, _$ProductImpl>
    implements _$$ProductImplCopyWith<$Res> {
  __$$ProductImplCopyWithImpl(
    _$ProductImpl _value,
    $Res Function(_$ProductImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? categoryIds = null,
    Object? description = freezed,
    Object? imageUrl = freezed,
    Object? variants = null,
    Object? isActive = null,
  }) {
    return _then(
      _$ProductImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        categoryIds: null == categoryIds
            ? _value._categoryIds
            : categoryIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        imageUrl: freezed == imageUrl
            ? _value.imageUrl
            : imageUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        variants: null == variants
            ? _value._variants
            : variants // ignore: cast_nullable_to_non_nullable
                  as List<ProductVariant>,
        isActive: null == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ProductImpl extends _Product {
  const _$ProductImpl({
    required this.id,
    required this.name,
    required final List<String> categoryIds,
    this.description,
    this.imageUrl,
    required final List<ProductVariant> variants,
    this.isActive = true,
  }) : _categoryIds = categoryIds,
       _variants = variants,
       super._();

  factory _$ProductImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProductImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  final List<String> _categoryIds;
  @override
  List<String> get categoryIds {
    if (_categoryIds is EqualUnmodifiableListView) return _categoryIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_categoryIds);
  }

  @override
  final String? description;
  @override
  final String? imageUrl;
  final List<ProductVariant> _variants;
  @override
  List<ProductVariant> get variants {
    if (_variants is EqualUnmodifiableListView) return _variants;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_variants);
  }

  @override
  @JsonKey()
  final bool isActive;

  @override
  String toString() {
    return 'Product(id: $id, name: $name, categoryIds: $categoryIds, description: $description, imageUrl: $imageUrl, variants: $variants, isActive: $isActive)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(
              other._categoryIds,
              _categoryIds,
            ) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            const DeepCollectionEquality().equals(other._variants, _variants) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    const DeepCollectionEquality().hash(_categoryIds),
    description,
    imageUrl,
    const DeepCollectionEquality().hash(_variants),
    isActive,
  );

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductImplCopyWith<_$ProductImpl> get copyWith =>
      __$$ProductImplCopyWithImpl<_$ProductImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProductImplToJson(this);
  }
}

abstract class _Product extends Product {
  const factory _Product({
    required final String id,
    required final String name,
    required final List<String> categoryIds,
    final String? description,
    final String? imageUrl,
    required final List<ProductVariant> variants,
    final bool isActive,
  }) = _$ProductImpl;
  const _Product._() : super._();

  factory _Product.fromJson(Map<String, dynamic> json) = _$ProductImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  List<String> get categoryIds;
  @override
  String? get description;
  @override
  String? get imageUrl;
  @override
  List<ProductVariant> get variants;
  @override
  bool get isActive;

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProductImplCopyWith<_$ProductImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ProductQueryParams _$ProductQueryParamsFromJson(Map<String, dynamic> json) {
  return _ProductQueryParams.fromJson(json);
}

/// @nodoc
mixin _$ProductQueryParams {
  String? get query => throw _privateConstructorUsedError;
  String? get categoryId => throw _privateConstructorUsedError;
  double? get minPrice => throw _privateConstructorUsedError;
  double? get maxPrice => throw _privateConstructorUsedError;
  int get page => throw _privateConstructorUsedError;
  int get limit => throw _privateConstructorUsedError;
  bool get onlyActive => throw _privateConstructorUsedError;

  /// Serializes this ProductQueryParams to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProductQueryParams
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProductQueryParamsCopyWith<ProductQueryParams> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductQueryParamsCopyWith<$Res> {
  factory $ProductQueryParamsCopyWith(
    ProductQueryParams value,
    $Res Function(ProductQueryParams) then,
  ) = _$ProductQueryParamsCopyWithImpl<$Res, ProductQueryParams>;
  @useResult
  $Res call({
    String? query,
    String? categoryId,
    double? minPrice,
    double? maxPrice,
    int page,
    int limit,
    bool onlyActive,
  });
}

/// @nodoc
class _$ProductQueryParamsCopyWithImpl<$Res, $Val extends ProductQueryParams>
    implements $ProductQueryParamsCopyWith<$Res> {
  _$ProductQueryParamsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProductQueryParams
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? query = freezed,
    Object? categoryId = freezed,
    Object? minPrice = freezed,
    Object? maxPrice = freezed,
    Object? page = null,
    Object? limit = null,
    Object? onlyActive = null,
  }) {
    return _then(
      _value.copyWith(
            query: freezed == query
                ? _value.query
                : query // ignore: cast_nullable_to_non_nullable
                      as String?,
            categoryId: freezed == categoryId
                ? _value.categoryId
                : categoryId // ignore: cast_nullable_to_non_nullable
                      as String?,
            minPrice: freezed == minPrice
                ? _value.minPrice
                : minPrice // ignore: cast_nullable_to_non_nullable
                      as double?,
            maxPrice: freezed == maxPrice
                ? _value.maxPrice
                : maxPrice // ignore: cast_nullable_to_non_nullable
                      as double?,
            page: null == page
                ? _value.page
                : page // ignore: cast_nullable_to_non_nullable
                      as int,
            limit: null == limit
                ? _value.limit
                : limit // ignore: cast_nullable_to_non_nullable
                      as int,
            onlyActive: null == onlyActive
                ? _value.onlyActive
                : onlyActive // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ProductQueryParamsImplCopyWith<$Res>
    implements $ProductQueryParamsCopyWith<$Res> {
  factory _$$ProductQueryParamsImplCopyWith(
    _$ProductQueryParamsImpl value,
    $Res Function(_$ProductQueryParamsImpl) then,
  ) = __$$ProductQueryParamsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? query,
    String? categoryId,
    double? minPrice,
    double? maxPrice,
    int page,
    int limit,
    bool onlyActive,
  });
}

/// @nodoc
class __$$ProductQueryParamsImplCopyWithImpl<$Res>
    extends _$ProductQueryParamsCopyWithImpl<$Res, _$ProductQueryParamsImpl>
    implements _$$ProductQueryParamsImplCopyWith<$Res> {
  __$$ProductQueryParamsImplCopyWithImpl(
    _$ProductQueryParamsImpl _value,
    $Res Function(_$ProductQueryParamsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProductQueryParams
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? query = freezed,
    Object? categoryId = freezed,
    Object? minPrice = freezed,
    Object? maxPrice = freezed,
    Object? page = null,
    Object? limit = null,
    Object? onlyActive = null,
  }) {
    return _then(
      _$ProductQueryParamsImpl(
        query: freezed == query
            ? _value.query
            : query // ignore: cast_nullable_to_non_nullable
                  as String?,
        categoryId: freezed == categoryId
            ? _value.categoryId
            : categoryId // ignore: cast_nullable_to_non_nullable
                  as String?,
        minPrice: freezed == minPrice
            ? _value.minPrice
            : minPrice // ignore: cast_nullable_to_non_nullable
                  as double?,
        maxPrice: freezed == maxPrice
            ? _value.maxPrice
            : maxPrice // ignore: cast_nullable_to_non_nullable
                  as double?,
        page: null == page
            ? _value.page
            : page // ignore: cast_nullable_to_non_nullable
                  as int,
        limit: null == limit
            ? _value.limit
            : limit // ignore: cast_nullable_to_non_nullable
                  as int,
        onlyActive: null == onlyActive
            ? _value.onlyActive
            : onlyActive // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ProductQueryParamsImpl extends _ProductQueryParams {
  const _$ProductQueryParamsImpl({
    this.query,
    this.categoryId,
    this.minPrice,
    this.maxPrice,
    this.page = 1,
    this.limit = 20,
    this.onlyActive = true,
  }) : super._();

  factory _$ProductQueryParamsImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProductQueryParamsImplFromJson(json);

  @override
  final String? query;
  @override
  final String? categoryId;
  @override
  final double? minPrice;
  @override
  final double? maxPrice;
  @override
  @JsonKey()
  final int page;
  @override
  @JsonKey()
  final int limit;
  @override
  @JsonKey()
  final bool onlyActive;

  @override
  String toString() {
    return 'ProductQueryParams(query: $query, categoryId: $categoryId, minPrice: $minPrice, maxPrice: $maxPrice, page: $page, limit: $limit, onlyActive: $onlyActive)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductQueryParamsImpl &&
            (identical(other.query, query) || other.query == query) &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.minPrice, minPrice) ||
                other.minPrice == minPrice) &&
            (identical(other.maxPrice, maxPrice) ||
                other.maxPrice == maxPrice) &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.limit, limit) || other.limit == limit) &&
            (identical(other.onlyActive, onlyActive) ||
                other.onlyActive == onlyActive));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    query,
    categoryId,
    minPrice,
    maxPrice,
    page,
    limit,
    onlyActive,
  );

  /// Create a copy of ProductQueryParams
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductQueryParamsImplCopyWith<_$ProductQueryParamsImpl> get copyWith =>
      __$$ProductQueryParamsImplCopyWithImpl<_$ProductQueryParamsImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ProductQueryParamsImplToJson(this);
  }
}

abstract class _ProductQueryParams extends ProductQueryParams {
  const factory _ProductQueryParams({
    final String? query,
    final String? categoryId,
    final double? minPrice,
    final double? maxPrice,
    final int page,
    final int limit,
    final bool onlyActive,
  }) = _$ProductQueryParamsImpl;
  const _ProductQueryParams._() : super._();

  factory _ProductQueryParams.fromJson(Map<String, dynamic> json) =
      _$ProductQueryParamsImpl.fromJson;

  @override
  String? get query;
  @override
  String? get categoryId;
  @override
  double? get minPrice;
  @override
  double? get maxPrice;
  @override
  int get page;
  @override
  int get limit;
  @override
  bool get onlyActive;

  /// Create a copy of ProductQueryParams
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProductQueryParamsImplCopyWith<_$ProductQueryParamsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
