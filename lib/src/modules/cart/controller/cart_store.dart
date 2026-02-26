import 'package:flutter/material.dart';
import 'package:scroll_challenge/src/core/packages/async_handler/lib/async_handler.dart';
import 'package:scroll_challenge/src/core/shared/reactive_notifier/process_notifier.dart';
import 'package:scroll_challenge/src/core/utils/utils.dart';
import '../model/cart/cart.dart';
import '../model/cart_item/cart_item.dart';
import '../repo/cart_repo.dart';

class CartStore {
  CartStore({required this.repo});

  /// Repository used for local/remote cart reads and writes.
  final CartRepo repo;
  /// Current cart state for UI binding.
  final ValueNotifier<Cart> cart = ValueNotifier<Cart>(const Cart());

  final ProcessStatusNotifier processStatusNotifier = ProcessStatusNotifier();

  /// Load cart into memory for the active user/cart id.
  /// 
  /// OFFLINE FEATURE
  Future<void> load({String? userId, String cartId = 'default'}) async {
    await handleFutureRequest(
      futureRequest: () async =>
          await repo.getCart(GetCartParam(userId: userId, cartId: cartId)),
      processStatusNotifier: processStatusNotifier,
      onSuccess: (data) {
        cart.value = data;
      },
    );

  }

  /// Returns quantity for a variant from the in-memory cart.
  int quantityForVariant(String variantId) {
    final item = cart.value.items
        .cast<CartItem?>()
        .firstWhere((i) => i?.cartItemId == variantId, orElse: () => null);
    return item?.quantity ?? 0;
  }

  /// Add or merge a cart item.
  Future<void> addItem(CartItem item) async {
    final res = await repo.upsertItem(item);
    if (res is SuccessResponse<Cart> && res.data != null) {
      debugPrint('Cart updated: ${res.data}');
      cart.value = res.data!;
    }
  }

  /// Set quantity for a variant; 0 removes it.
  Future<void> setQuantity({required String cartItemId, required int quantity}) async {
    debugPrint('Set quantity for $cartItemId to $quantity');
    final res = await repo.updateQuantity(cartItemId: cartItemId, quantity: quantity);
    if (res is SuccessResponse<Cart> && res.data != null) {
      cart.value = res.data!;
    }
  }
}
