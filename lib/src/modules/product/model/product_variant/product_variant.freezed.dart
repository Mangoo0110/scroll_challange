// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_variant.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ProductVariant _$ProductVariantFromJson(Map<String, dynamic> json) {
  return _ProductVariant.fromJson(json);
}

/// @nodoc
mixin _$ProductVariant {
  String get id => throw _privateConstructorUsedError;
  String get productId => throw _privateConstructorUsedError;
  double get price => throw _privateConstructorUsedError;
  double? get salePrice => throw _privateConstructorUsedError;
  String? get sku => throw _privateConstructorUsedError;
  String? get barcode => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  bool get inStock => throw _privateConstructorUsedError;
  List<VariantAttribute> get attributes => throw _privateConstructorUsedError;

  /// Serializes this ProductVariant to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProductVariant
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProductVariantCopyWith<ProductVariant> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductVariantCopyWith<$Res> {
  factory $ProductVariantCopyWith(
    ProductVariant value,
    $Res Function(ProductVariant) then,
  ) = _$ProductVariantCopyWithImpl<$Res, ProductVariant>;
  @useResult
  $Res call({
    String id,
    String productId,
    double price,
    double? salePrice,
    String? sku,
    String? barcode,
    String? imageUrl,
    bool isActive,
    bool inStock,
    List<VariantAttribute> attributes,
  });
}

/// @nodoc
class _$ProductVariantCopyWithImpl<$Res, $Val extends ProductVariant>
    implements $ProductVariantCopyWith<$Res> {
  _$ProductVariantCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProductVariant
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? productId = null,
    Object? price = null,
    Object? salePrice = freezed,
    Object? sku = freezed,
    Object? barcode = freezed,
    Object? imageUrl = freezed,
    Object? isActive = null,
    Object? inStock = null,
    Object? attributes = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            productId: null == productId
                ? _value.productId
                : productId // ignore: cast_nullable_to_non_nullable
                      as String,
            price: null == price
                ? _value.price
                : price // ignore: cast_nullable_to_non_nullable
                      as double,
            salePrice: freezed == salePrice
                ? _value.salePrice
                : salePrice // ignore: cast_nullable_to_non_nullable
                      as double?,
            sku: freezed == sku
                ? _value.sku
                : sku // ignore: cast_nullable_to_non_nullable
                      as String?,
            barcode: freezed == barcode
                ? _value.barcode
                : barcode // ignore: cast_nullable_to_non_nullable
                      as String?,
            imageUrl: freezed == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            isActive: null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                      as bool,
            inStock: null == inStock
                ? _value.inStock
                : inStock // ignore: cast_nullable_to_non_nullable
                      as bool,
            attributes: null == attributes
                ? _value.attributes
                : attributes // ignore: cast_nullable_to_non_nullable
                      as List<VariantAttribute>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ProductVariantImplCopyWith<$Res>
    implements $ProductVariantCopyWith<$Res> {
  factory _$$ProductVariantImplCopyWith(
    _$ProductVariantImpl value,
    $Res Function(_$ProductVariantImpl) then,
  ) = __$$ProductVariantImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String productId,
    double price,
    double? salePrice,
    String? sku,
    String? barcode,
    String? imageUrl,
    bool isActive,
    bool inStock,
    List<VariantAttribute> attributes,
  });
}

/// @nodoc
class __$$ProductVariantImplCopyWithImpl<$Res>
    extends _$ProductVariantCopyWithImpl<$Res, _$ProductVariantImpl>
    implements _$$ProductVariantImplCopyWith<$Res> {
  __$$ProductVariantImplCopyWithImpl(
    _$ProductVariantImpl _value,
    $Res Function(_$ProductVariantImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProductVariant
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? productId = null,
    Object? price = null,
    Object? salePrice = freezed,
    Object? sku = freezed,
    Object? barcode = freezed,
    Object? imageUrl = freezed,
    Object? isActive = null,
    Object? inStock = null,
    Object? attributes = null,
  }) {
    return _then(
      _$ProductVariantImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        productId: null == productId
            ? _value.productId
            : productId // ignore: cast_nullable_to_non_nullable
                  as String,
        price: null == price
            ? _value.price
            : price // ignore: cast_nullable_to_non_nullable
                  as double,
        salePrice: freezed == salePrice
            ? _value.salePrice
            : salePrice // ignore: cast_nullable_to_non_nullable
                  as double?,
        sku: freezed == sku
            ? _value.sku
            : sku // ignore: cast_nullable_to_non_nullable
                  as String?,
        barcode: freezed == barcode
            ? _value.barcode
            : barcode // ignore: cast_nullable_to_non_nullable
                  as String?,
        imageUrl: freezed == imageUrl
            ? _value.imageUrl
            : imageUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        isActive: null == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool,
        inStock: null == inStock
            ? _value.inStock
            : inStock // ignore: cast_nullable_to_non_nullable
                  as bool,
        attributes: null == attributes
            ? _value._attributes
            : attributes // ignore: cast_nullable_to_non_nullable
                  as List<VariantAttribute>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ProductVariantImpl extends _ProductVariant {
  const _$ProductVariantImpl({
    required this.id,
    required this.productId,
    required this.price,
    this.salePrice,
    this.sku,
    this.barcode,
    this.imageUrl,
    this.isActive = true,
    this.inStock = true,
    final List<VariantAttribute> attributes = const <VariantAttribute>[],
  }) : _attributes = attributes,
       super._();

  factory _$ProductVariantImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProductVariantImplFromJson(json);

  @override
  final String id;
  @override
  final String productId;
  @override
  final double price;
  @override
  final double? salePrice;
  @override
  final String? sku;
  @override
  final String? barcode;
  @override
  final String? imageUrl;
  @override
  @JsonKey()
  final bool isActive;
  @override
  @JsonKey()
  final bool inStock;
  final List<VariantAttribute> _attributes;
  @override
  @JsonKey()
  List<VariantAttribute> get attributes {
    if (_attributes is EqualUnmodifiableListView) return _attributes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_attributes);
  }

  @override
  String toString() {
    return 'ProductVariant(id: $id, productId: $productId, price: $price, salePrice: $salePrice, sku: $sku, barcode: $barcode, imageUrl: $imageUrl, isActive: $isActive, inStock: $inStock, attributes: $attributes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductVariantImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.salePrice, salePrice) ||
                other.salePrice == salePrice) &&
            (identical(other.sku, sku) || other.sku == sku) &&
            (identical(other.barcode, barcode) || other.barcode == barcode) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.inStock, inStock) || other.inStock == inStock) &&
            const DeepCollectionEquality().equals(
              other._attributes,
              _attributes,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    productId,
    price,
    salePrice,
    sku,
    barcode,
    imageUrl,
    isActive,
    inStock,
    const DeepCollectionEquality().hash(_attributes),
  );

  /// Create a copy of ProductVariant
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductVariantImplCopyWith<_$ProductVariantImpl> get copyWith =>
      __$$ProductVariantImplCopyWithImpl<_$ProductVariantImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ProductVariantImplToJson(this);
  }
}

abstract class _ProductVariant extends ProductVariant {
  const factory _ProductVariant({
    required final String id,
    required final String productId,
    required final double price,
    final double? salePrice,
    final String? sku,
    final String? barcode,
    final String? imageUrl,
    final bool isActive,
    final bool inStock,
    final List<VariantAttribute> attributes,
  }) = _$ProductVariantImpl;
  const _ProductVariant._() : super._();

  factory _ProductVariant.fromJson(Map<String, dynamic> json) =
      _$ProductVariantImpl.fromJson;

  @override
  String get id;
  @override
  String get productId;
  @override
  double get price;
  @override
  double? get salePrice;
  @override
  String? get sku;
  @override
  String? get barcode;
  @override
  String? get imageUrl;
  @override
  bool get isActive;
  @override
  bool get inStock;
  @override
  List<VariantAttribute> get attributes;

  /// Create a copy of ProductVariant
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProductVariantImplCopyWith<_$ProductVariantImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

VariantAttribute _$VariantAttributeFromJson(Map<String, dynamic> json) {
  return _VariantAttribute.fromJson(json);
}

/// @nodoc
mixin _$VariantAttribute {
  String get name => throw _privateConstructorUsedError;
  String get value => throw _privateConstructorUsedError;

  /// Serializes this VariantAttribute to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of VariantAttribute
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VariantAttributeCopyWith<VariantAttribute> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VariantAttributeCopyWith<$Res> {
  factory $VariantAttributeCopyWith(
    VariantAttribute value,
    $Res Function(VariantAttribute) then,
  ) = _$VariantAttributeCopyWithImpl<$Res, VariantAttribute>;
  @useResult
  $Res call({String name, String value});
}

/// @nodoc
class _$VariantAttributeCopyWithImpl<$Res, $Val extends VariantAttribute>
    implements $VariantAttributeCopyWith<$Res> {
  _$VariantAttributeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of VariantAttribute
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? name = null, Object? value = null}) {
    return _then(
      _value.copyWith(
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            value: null == value
                ? _value.value
                : value // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$VariantAttributeImplCopyWith<$Res>
    implements $VariantAttributeCopyWith<$Res> {
  factory _$$VariantAttributeImplCopyWith(
    _$VariantAttributeImpl value,
    $Res Function(_$VariantAttributeImpl) then,
  ) = __$$VariantAttributeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String value});
}

/// @nodoc
class __$$VariantAttributeImplCopyWithImpl<$Res>
    extends _$VariantAttributeCopyWithImpl<$Res, _$VariantAttributeImpl>
    implements _$$VariantAttributeImplCopyWith<$Res> {
  __$$VariantAttributeImplCopyWithImpl(
    _$VariantAttributeImpl _value,
    $Res Function(_$VariantAttributeImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of VariantAttribute
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? name = null, Object? value = null}) {
    return _then(
      _$VariantAttributeImpl(
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        value: null == value
            ? _value.value
            : value // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$VariantAttributeImpl extends _VariantAttribute {
  const _$VariantAttributeImpl({required this.name, required this.value})
    : super._();

  factory _$VariantAttributeImpl.fromJson(Map<String, dynamic> json) =>
      _$$VariantAttributeImplFromJson(json);

  @override
  final String name;
  @override
  final String value;

  @override
  String toString() {
    return 'VariantAttribute(name: $name, value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VariantAttributeImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.value, value) || other.value == value));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, value);

  /// Create a copy of VariantAttribute
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VariantAttributeImplCopyWith<_$VariantAttributeImpl> get copyWith =>
      __$$VariantAttributeImplCopyWithImpl<_$VariantAttributeImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$VariantAttributeImplToJson(this);
  }
}

abstract class _VariantAttribute extends VariantAttribute {
  const factory _VariantAttribute({
    required final String name,
    required final String value,
  }) = _$VariantAttributeImpl;
  const _VariantAttribute._() : super._();

  factory _VariantAttribute.fromJson(Map<String, dynamic> json) =
      _$VariantAttributeImpl.fromJson;

  @override
  String get name;
  @override
  String get value;

  /// Create a copy of VariantAttribute
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VariantAttributeImplCopyWith<_$VariantAttributeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
