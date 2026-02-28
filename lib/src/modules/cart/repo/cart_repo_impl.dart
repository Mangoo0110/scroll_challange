import 'dart:io';

import 'package:async_handler/async_handler.dart';
import '../model/cart/cart.dart';
import '../model/cart_item/cart_item.dart';
import '../model/cart_ops/cart_ops.dart';
import '../service/cart_service.dart';
import '../service/local_cart_service.dart';
import 'cart_repo.dart';

class CartRepoImpl extends CartRepo with ErrorHandler {
  CartRepoImpl({
    required this.localService,
    required this.remoteService,
    this.userId,
    this.cartId = 'default',
  });

  /// Local-first service (Hive) for offline usage.
  final CartService localService;
  /// Remote service (API) used when online.
  final CartService remoteService;
  final String? userId;
  final String cartId;

  @override
  AsyncRequest<Cart> getCart(GetCartParam param) async {
    // Prefer remote when online; fall back to local on network errors.
    // if (param.isOnline && param.preferRemote) {
    //   final remoteRes = await asyncTryCatch(
    //     tryFunc: () async {
    //       final remote = await remoteService.getCart(
    //         userId: param.userId,
    //         cartId: param.cartId,
    //       );
    //       return SuccessResponse<Cart>(data: remote);
    //     },
    //   );
    //   if (remoteRes is SuccessResponse<Cart>) {
    //     return remoteRes;
    //   }
      // if (remoteRes is ErrorResponse &&
      //     (remoteRes as ErrorResponse).exception is! SocketException) {
      //   return remoteRes;
      // }
    //}
    return await asyncTryCatch(
      tryFunc: () async {
        final local = await localService.getCart(
          userId: param.userId,
          cartId: param.cartId,
        );
        return SuccessResponse<Cart>(data: local);
      },
    );
  }

  @override
  AsyncRequest<Cart> upsertItem(CartItem item) async{
    // final res = await asyncTryCatch(tryFunc: () async{
    //   final onlineRes = await remoteService.upsertItem(userId: userId, cartId: cartId, item: item);
    //   return SuccessResponse<Cart>(data: onlineRes);
    // });
    // if (res is SuccessResponse<Cart>) {
    //   return res;
    // }

    // if(res is ErrorResponse && (res as ErrorResponse).exception is! SocketException) {
    //   return res;
    // }
    // If we reach here, either res is SucccessResponse or user is offline (SocketException).
    // In this case, use local service.
    return await asyncTryCatch(tryFunc: () async{
      final localRes = await localService.upsertItem(userId: userId, cartId: cartId, item: item);
      return SuccessResponse<Cart>(data: localRes);
    });
  }

  @override
  AsyncRequest<Cart> updateQuantity({
    required String cartItemId,
    required int quantity,
  }) {
    return asyncTryCatch(
      tryFunc: () async {
        final local = await localService.updateQuantity(
          userId: userId,
          cartId: cartId,
          cartItemId: cartItemId,
          quantity: quantity,
        );
        return SuccessResponse<Cart>(data: local);
      },
    );
  }

  @override
  AsyncRequest<Cart> removeItem(String variantId) {
    return asyncTryCatch(
      tryFunc: () async {
        final local = await localService.removeItem(
          userId: userId,
          cartId: cartId,
          variantId: variantId,
        );
        return SuccessResponse<Cart>(data: local);
      },
    );
  }

  @override
  AsyncRequest<Cart> clear() {
    return asyncTryCatch(
      tryFunc: () async {
        final local = await localService.clear(userId: userId, cartId: cartId);
        return SuccessResponse<Cart>(data: local);
      },
    );
  }

  @override
  AsyncRequest<void> syncPending(GetCartParam param) async {
    if (!param.isOnline) {
      return SuccessResponse<void>(data: null);
    }
    if (localService is! LocalCartService) {
      return ErrorResponse<void>(
        message: 'Local service does not support ops',
        exception: Exception('Local service does not support ops'),
        stackTrace: StackTrace.current,
      );
    }
    final ops = await (localService as LocalCartService).getOps(
      userId: param.userId,
      cartId: param.cartId,
    );
    if (ops.isEmpty) {
      return SuccessResponse<void>(data: null);
    }
    try {
      // Replay operations in order to the remote service.
      for (final op in ops) {
        await _applyOpRemote(op, param);
      }
      await (localService as LocalCartService).clearOps(
        userId: param.userId,
        cartId: param.cartId,
      );
      return SuccessResponse<void>(data: null);
    } on SocketException catch (error, stackTrace) {
      return ErrorResponse<void>(
        message: 'Network error during sync',
        exception: error,
        stackTrace: stackTrace,
      );
    } catch (error, stackTrace) {
      return ErrorResponse<void>(
        message: 'Failed to sync cart',
        exception: error is Exception ? error : Exception(error.toString()),
        stackTrace: stackTrace,
      );
    }
  }

  Future<void> _applyOpRemote(CartOp op, GetCartParam param) async {
    // Map queued op types to remote service calls.
    switch (op.type) {
      case 'upsert':
        if (op.item != null) {
          await remoteService.upsertItem(
            userId: param.userId,
            cartId: param.cartId,
            item: op.item!,
          );
        }
        return;
      case 'update':
        await remoteService.updateQuantity(
          userId: param.userId,
          cartId: param.cartId,
          cartItemId: op.variantId ?? '',
          quantity: op.quantity ?? 0,
        );
        return;
      case 'remove':
        await remoteService.removeItem(
          userId: param.userId,
          cartId: param.cartId,
          variantId: op.variantId ?? '',
        );
        return;
      case 'clear':
        await remoteService.clear(userId: param.userId, cartId: param.cartId);
        return;
      default:
        return;
    }
  }


}
