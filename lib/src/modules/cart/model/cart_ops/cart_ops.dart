import 'package:freezed_annotation/freezed_annotation.dart';

import '../cart/cart.dart';
import '../cart_item/cart_item.dart';

part 'cart_ops.freezed.dart';
part 'cart_ops.g.dart';

@Freezed(toJson: true, fromJson: true)
class CartOp with _$CartOp {
  const CartOp._();

  /// Pending operation used for offline-first sync.
  @JsonSerializable(explicitToJson: true)
  const factory CartOp({
    required String id,
    required String type,
    CartItem? item,
    String? variantId,
    int? quantity,
    required DateTime createdAt,
  }) = _CartOp;

  factory CartOp.fromJson(Map<String, dynamic> json) =>
      _$CartOpFromJson(json);
}
