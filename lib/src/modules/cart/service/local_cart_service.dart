import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';

import '../../../core/local_db/hive_db.dart';
import '../model/model.dart';
import 'cart_service.dart';

class LocalCartService implements CartService {
  LocalCartService({this.userId, this.cartId = 'default'});

  final String? userId;
  final String cartId;

  final HiveService _hive = HiveService();

  /// Namespaced keys per user/cart to support multi-account.
  String _cartKey(String? uid, String cid) => 'cart_${uid ?? 'guest'}_$cid';
  String _opsKey(String? uid, String cid) => 'cart_ops_${uid ?? 'guest'}_$cid';

  Future<void> _ensureOpen() async {
    await _hive.openBox(HiveBox.cart);
  }

  Cart _defaultCart(String? uid, String cid) => Cart(userId: uid, cartId: cid);

  /// Read pending ops from Hive (FIFO order).
  Future<List<CartOp>> _getOps({required String? userId, required String cartId}) async {
    await _hive.openBox(HiveBox.cartOps);
    final raw = _hive.get<List>(HiveBox.cartOps, _opsKey(userId, cartId));
    if (raw == null) return <CartOp>[];
    return raw
        .map((e) => CartOp.fromJson(Map<String, dynamic>.from(jsonDecode(jsonEncode(e)))))
        .toList();
  }

  Future<void> _saveOps({
    required String? userId,
    required String cartId,
    required List<CartOp> ops,
  }) async {
    // Persist ops as JSON list for easy migration.
    await _hive.openBox(HiveBox.cartOps);
    await _hive.put(
      HiveBox.cartOps,
      _opsKey(userId, cartId),
      ops.map((e) => e.toJson()).toList(),
    );
  }

  Future<void> _enqueueOp({
    required String? userId,
    required String cartId,
    required CartOp op,
  }) async {
    // Append a single op to the queue.
    final ops = await _getOps(userId: userId, cartId: cartId);
    await _saveOps(userId: userId, cartId: cartId, ops: [...ops, op]);
  }

  Future<void> clearOps({required String? userId, required String cartId}) async {
    // Clear queue after a successful sync.
    await _saveOps(userId: userId, cartId: cartId, ops: []);
  }

  Future<List<CartOp>> getOps({required String? userId, required String cartId}) {
    return _getOps(userId: userId, cartId: cartId);
  }

  String _opId() => '${DateTime.now().millisecondsSinceEpoch}_${Random().nextInt(100000)}';

  @override
  Future<Cart> getCart({required String? userId, String cartId = 'default'}) async {
    await _ensureOpen();
    final key = _cartKey(userId, cartId);
    final map = _hive.get<Map>(HiveBox.cart, key);
    if (map == null) {
      // Initialize empty cart on first access.
      final cart = _defaultCart(userId, cartId);
      await _hive.put(HiveBox.cart, key, cart.toJson());
      return cart;
    }
    return Cart.fromJson(jsonDecode(jsonEncode(map as dynamic)));
  }

  @override
  Future<Cart> upsertItem({
    required String? userId,
    required CartItem item,
    String cartId = 'default',
  }) async {
    await _ensureOpen();
    debugPrint("getting cart for userId: $userId and cartId: $cartId");
    final cart = await getCart(userId: userId, cartId: cartId);
    debugPrint("got cart: ${cart.toJson()}");
    final index = cart.items.indexWhere((i) => i.cartItemId == item.cartItemId);
    final updated = cart.items.toList();
    if (index == -1) {
      updated.add(item);
    } else {
      final existing = updated[index];
      updated[index] = existing.copyWith(quantity: existing.quantity + item.quantity);
    }
    final next = cart.copyWith(items: updated);
    await _hive.put(HiveBox.cart, _cartKey(userId, cartId), next.toJson());
    await _enqueueOp(
      userId: userId,
      cartId: cartId,
      op: CartOp(
        id: _opId(),
        type: 'upsert',
        item: item,
        createdAt: DateTime.now(),
      ),
    );
    return next;
  }

  @override
  Future<Cart> updateQuantity({
    required String? userId,
    required String cartItemId,
    required int quantity,
    String cartId = 'default',
  }) async {
    await _ensureOpen();

    debugPrint("getting cart for userId: $userId and cartId: $cartId");
    final cart = await getCart(userId: userId, cartId: cartId);
    debugPrint("got cart: ${cart.toJson()}");
    final updated = cart.items.toList();
    final index = updated.indexWhere((i) => i.cartItemId == cartItemId);
    
    if (index == -1) {
      throw Exception('Item not found');
    }

    if (quantity <= 0) {
      updated.removeAt(index);
    } else {
      updated[index] = updated[index].copyWith(quantity: quantity);
    }

    final next = cart.copyWith(items: updated);

    await _hive.put(HiveBox.cart, _cartKey(userId, cartId), next.toJson());
    
    await _enqueueOp(
      userId: userId,
      cartId: cartId,
      op: CartOp(
        id: _opId(),
        type: 'update',
        variantId: cartItemId,
        quantity: quantity,
        createdAt: DateTime.now(),
      ),
    );

    return next;
  }

  @override
  Future<Cart> removeItem({
    required String? userId,
    required String variantId,
    String cartId = 'default',
  }) async {
    await _ensureOpen();
    final cart = await getCart(userId: userId, cartId: cartId);
    final next = cart.copyWith(
      items: cart.items.where((i) => i.cartItemId != variantId).toList(),
    );
    await _hive.put(HiveBox.cart, _cartKey(userId, cartId), next.toJson());
    await _enqueueOp(
      userId: userId,
      cartId: cartId,
      op: CartOp(
        id: _opId(),
        type: 'remove',
        variantId: variantId,
        createdAt: DateTime.now(),
      ),
    );
    return next;
  }

  @override
  Future<Cart> clear({required String? userId, String cartId = 'default'}) async {
    await _ensureOpen();
    final next = _defaultCart(userId, cartId).copyWith(items: const []);
    await _hive.put(HiveBox.cart, _cartKey(userId, cartId), next.toJson());
    await _enqueueOp(
      userId: userId,
      cartId: cartId,
      op: CartOp(
        id: _opId(),
        type: 'clear',
        createdAt: DateTime.now(),
      ),
    );
    return next;
  }
}
