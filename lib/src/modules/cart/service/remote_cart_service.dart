import '../model/cart/cart.dart';
import '../model/cart_item/cart_item.dart';
import 'cart_service.dart';

class RemoteCartService implements CartService {
  @override
  Future<Cart> getCart({required String? userId, String cartId = 'default'}) async {
    // TODO: replace with real API call.
    throw UnimplementedError('Remote cart not implemented');
  }

  @override
  Future<Cart> upsertItem({
    required String? userId,
    required CartItem item,
    String cartId = 'default',
  }) async {
    // TODO: replace with real API call.
    throw UnimplementedError('Remote cart not implemented');
  }

  @override
  Future<Cart> updateQuantity({
    required String? userId,
    required String cartItemId,
    required int quantity,
    String cartId = 'default',
  }) async {
    // TODO: replace with real API call.
    throw UnimplementedError('Remote cart not implemented');
  }

  @override
  Future<Cart> removeItem({
    required String? userId,
    required String variantId,
    String cartId = 'default',
  }) async {
    // TODO: replace with real API call.
    throw UnimplementedError('Remote cart not implemented');
  }

  @override
  Future<Cart> clear({required String? userId, String cartId = 'default'}) async {
    // TODO: replace with real API call.
    throw UnimplementedError('Remote cart not implemented');
  }
}
