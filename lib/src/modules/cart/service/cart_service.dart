import '../model/cart/cart.dart';
import '../model/cart_item/cart_item.dart';

abstract class CartService {
  Future<Cart> getCart({required String? userId, String cartId = 'default'});

  Future<Cart> upsertItem({
    required String? userId,
    required CartItem item,
    String cartId = 'default',
  });

  Future<Cart> updateQuantity({
    required String? userId,
    required String cartItemId,
    required int quantity,
    String cartId = 'default',
  });

  Future<Cart> removeItem({
    required String? userId,
    required String variantId,
    String cartId = 'default',
  });

  Future<Cart> clear({
    required String? userId,
    String cartId = 'default',
  });
}
