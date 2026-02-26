// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cart_ops.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

CartOp _$CartOpFromJson(Map<String, dynamic> json) {
  return _CartOp.fromJson(json);
}

/// @nodoc
mixin _$CartOp {
  String get id => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  CartItem? get item => throw _privateConstructorUsedError;
  String? get variantId => throw _privateConstructorUsedError;
  int? get quantity => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this CartOp to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CartOp
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CartOpCopyWith<CartOp> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CartOpCopyWith<$Res> {
  factory $CartOpCopyWith(CartOp value, $Res Function(CartOp) then) =
      _$CartOpCopyWithImpl<$Res, CartOp>;
  @useResult
  $Res call({
    String id,
    String type,
    CartItem? item,
    String? variantId,
    int? quantity,
    DateTime createdAt,
  });

  $CartItemCopyWith<$Res>? get item;
}

/// @nodoc
class _$CartOpCopyWithImpl<$Res, $Val extends CartOp>
    implements $CartOpCopyWith<$Res> {
  _$CartOpCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CartOp
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? item = freezed,
    Object? variantId = freezed,
    Object? quantity = freezed,
    Object? createdAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String,
            item: freezed == item
                ? _value.item
                : item // ignore: cast_nullable_to_non_nullable
                      as CartItem?,
            variantId: freezed == variantId
                ? _value.variantId
                : variantId // ignore: cast_nullable_to_non_nullable
                      as String?,
            quantity: freezed == quantity
                ? _value.quantity
                : quantity // ignore: cast_nullable_to_non_nullable
                      as int?,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }

  /// Create a copy of CartOp
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CartItemCopyWith<$Res>? get item {
    if (_value.item == null) {
      return null;
    }

    return $CartItemCopyWith<$Res>(_value.item!, (value) {
      return _then(_value.copyWith(item: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CartOpImplCopyWith<$Res> implements $CartOpCopyWith<$Res> {
  factory _$$CartOpImplCopyWith(
    _$CartOpImpl value,
    $Res Function(_$CartOpImpl) then,
  ) = __$$CartOpImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String type,
    CartItem? item,
    String? variantId,
    int? quantity,
    DateTime createdAt,
  });

  @override
  $CartItemCopyWith<$Res>? get item;
}

/// @nodoc
class __$$CartOpImplCopyWithImpl<$Res>
    extends _$CartOpCopyWithImpl<$Res, _$CartOpImpl>
    implements _$$CartOpImplCopyWith<$Res> {
  __$$CartOpImplCopyWithImpl(
    _$CartOpImpl _value,
    $Res Function(_$CartOpImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CartOp
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? item = freezed,
    Object? variantId = freezed,
    Object? quantity = freezed,
    Object? createdAt = null,
  }) {
    return _then(
      _$CartOpImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
        item: freezed == item
            ? _value.item
            : item // ignore: cast_nullable_to_non_nullable
                  as CartItem?,
        variantId: freezed == variantId
            ? _value.variantId
            : variantId // ignore: cast_nullable_to_non_nullable
                  as String?,
        quantity: freezed == quantity
            ? _value.quantity
            : quantity // ignore: cast_nullable_to_non_nullable
                  as int?,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$CartOpImpl extends _CartOp {
  const _$CartOpImpl({
    required this.id,
    required this.type,
    this.item,
    this.variantId,
    this.quantity,
    required this.createdAt,
  }) : super._();

  factory _$CartOpImpl.fromJson(Map<String, dynamic> json) =>
      _$$CartOpImplFromJson(json);

  @override
  final String id;
  @override
  final String type;
  @override
  final CartItem? item;
  @override
  final String? variantId;
  @override
  final int? quantity;
  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'CartOp(id: $id, type: $type, item: $item, variantId: $variantId, quantity: $quantity, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CartOpImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.item, item) || other.item == item) &&
            (identical(other.variantId, variantId) ||
                other.variantId == variantId) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, type, item, variantId, quantity, createdAt);

  /// Create a copy of CartOp
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CartOpImplCopyWith<_$CartOpImpl> get copyWith =>
      __$$CartOpImplCopyWithImpl<_$CartOpImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CartOpImplToJson(this);
  }
}

abstract class _CartOp extends CartOp {
  const factory _CartOp({
    required final String id,
    required final String type,
    final CartItem? item,
    final String? variantId,
    final int? quantity,
    required final DateTime createdAt,
  }) = _$CartOpImpl;
  const _CartOp._() : super._();

  factory _CartOp.fromJson(Map<String, dynamic> json) = _$CartOpImpl.fromJson;

  @override
  String get id;
  @override
  String get type;
  @override
  CartItem? get item;
  @override
  String? get variantId;
  @override
  int? get quantity;
  @override
  DateTime get createdAt;

  /// Create a copy of CartOp
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CartOpImplCopyWith<_$CartOpImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
