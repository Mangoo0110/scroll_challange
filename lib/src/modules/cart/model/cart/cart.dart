import 'package:freezed_annotation/freezed_annotation.dart';

import '../cart_item/cart_item.dart';

part 'cart.freezed.dart';
part 'cart.g.dart';



@Freezed(toJson: true, fromJson: true)
class Cart with _$Cart {
  const Cart._();

  @JsonSerializable(explicitToJson: true)
  const factory Cart({
    String? userId,
    @Default('default') String cartId,
    @Default(<CartItem>[]) List<CartItem> items,
    @Default(59) int deliveryFee,
    @Default(0) int discount,
  }) = _Cart;

  factory Cart.fromJson(Map<String, dynamic> json) => _$CartFromJson(json);

  double get subtotal =>
      items.fold(0, (sum, item) => sum + item.lineTotal);

  double get total => subtotal + deliveryFee - discount;

  int get itemCount =>
      items.fold(0, (sum, item) => sum + item.quantity);
}
