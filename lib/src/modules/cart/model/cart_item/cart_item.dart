import 'package:freezed_annotation/freezed_annotation.dart';
part 'cart_item.freezed.dart';
part 'cart_item.g.dart';

/// Muatable cart item. Represents a product variant in the cart with quantity and pricing info.
/// 
/// Mutable properties: 
/// - quantity
/// - salePrice (can be set when a promotion is applied)
/// Other properties are immutable and should be set when the item is added to the cart.
@Freezed(toJson: true, fromJson: true)
class CartItem with _$CartItem {
  const CartItem._();

  const factory CartItem({
    required String productId,
    required String cartItemId,
    required String name,
    String? imageUrl,
    String? unitLabel,
    required double price,
    double? salePrice,
    @Default(1) int quantity,
  }) = _CartItem;

  factory CartItem.fromJson(Map<String, dynamic> json) =>
      _$CartItemFromJson(json);

  double get effectivePrice => salePrice ?? price;
  double get lineTotal => effectivePrice * quantity;
}