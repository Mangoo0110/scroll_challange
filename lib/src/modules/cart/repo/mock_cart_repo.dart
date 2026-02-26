import 'package:scroll_challenge/src/core/packages/async_handler/lib/async_handler.dart';
import '../model/cart/cart.dart';
import '../model/cart_item/cart_item.dart';
import 'cart_repo.dart';

class MockCartRepo extends CartRepo {
  MockCartRepo({this.simulatedLatency = const Duration(milliseconds: 150)});

  final Duration simulatedLatency;
  /// In-memory cart for local testing.
  Cart _cart = const Cart();

  @override
  Future<ApiResponse<Cart>> getCart(GetCartParam param) async {
    await Future<void>.delayed(simulatedLatency);
    // Simulate scoped cart by user/cart id.
    return SuccessResponse<Cart>(data: _cart.copyWith(userId: param.userId, cartId: param.cartId));
  }

  @override
  Future<ApiResponse<Cart>> upsertItem(CartItem item) async {
    await Future<void>.delayed(simulatedLatency);
    final index = _cart.items.indexWhere((i) => i.cartItemId == item.cartItemId);
    if (index == -1) {
      _cart = _cart.copyWith(items: [..._cart.items, item]);
    } else {
      final updated = _cart.items.toList();
      final existing = updated[index];
      updated[index] = existing.copyWith(
        quantity: existing.quantity + item.quantity,
      );
      _cart = _cart.copyWith(items: updated);
    }
    return SuccessResponse<Cart>(data: _cart);
  }

  @override
  Future<ApiResponse<Cart>> updateQuantity({
    required String cartItemId,
    required int quantity,
  }) async {
    await Future<void>.delayed(simulatedLatency);
    final updated = _cart.items.toList();
    final index = updated.indexWhere((i) => i.cartItemId == cartItemId);
    if (index == -1) {
      return ErrorResponse<Cart>(
        message: 'Item not found',
        exception: Exception('Item not found'),
        stackTrace: StackTrace.current,
      );
    }
    if (quantity <= 0) {
      updated.removeAt(index);
    } else {
      updated[index] = updated[index].copyWith(quantity: quantity);
    }
    _cart = _cart.copyWith(items: updated);
    return SuccessResponse<Cart>(data: _cart);
  }

  @override
  Future<ApiResponse<Cart>> removeItem(String variantId) async {
    await Future<void>.delayed(simulatedLatency);
    _cart = _cart.copyWith(
      items: _cart.items.where((i) => i.cartItemId != variantId).toList(),
    );
    return SuccessResponse<Cart>(data: _cart);
  }

  @override
  Future<ApiResponse<Cart>> clear() async {
    await Future<void>.delayed(simulatedLatency);
    _cart = _cart.copyWith(items: const []);
    return SuccessResponse<Cart>(data: _cart);
  }

  @override
  Future<ApiResponse<void>> syncPending(GetCartParam param) async {
    await Future<void>.delayed(simulatedLatency);
    // No-op for mock.
    return SuccessResponse<void>(data: null);
  }
}
