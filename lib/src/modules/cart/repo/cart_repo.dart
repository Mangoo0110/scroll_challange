
import 'package:scroll_challenge/src/core/packages/async_handler/lib/async_handler.dart';

import '../model/cart/cart.dart';
import '../model/cart_item/cart_item.dart';

class GetCartParam {
  final String? userId;
  final String cartId;
  final bool isOnline;
  final bool preferRemote;

  const GetCartParam({
    required this.userId,
    this.cartId = 'default',
    this.isOnline = false,
    this.preferRemote = false,
  });
}

abstract class CartRepo with ErrorHandler {
  /// Returns the cart for the given user/cart context.
  AsyncRequest<Cart> getCart(GetCartParam param);

  /// Add or merge an item into the cart.
  AsyncRequest<Cart> upsertItem(CartItem item);

  /// Set quantity for a variant; <= 0 removes the item.
  AsyncRequest<Cart> updateQuantity({
    required String cartItemId,
    required int quantity,
  });

  /// Remove a single item by variant id.
  AsyncRequest<Cart> removeItem(String variantId);

  /// Clear all cart items.
  AsyncRequest<Cart> clear();

  /// Push any queued offline operations when online.
  AsyncRequest<void> syncPending(GetCartParam param);
}
