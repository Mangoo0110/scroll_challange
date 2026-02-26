import 'package:flutter/material.dart';
import 'package:scroll_challenge/src/core/packages/async_handler/lib/async_handler.dart';
import '../../../../core/shared/reactive_notifier/process_notifier.dart';
import '../../../../core/shared/reactive_notifier/snackbar_notifier.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../../core/utils/helpers/handle_future_request.dart';
import '../../model/cart/cart.dart';
import '../../model/cart_item/cart_item.dart';
import '../../repo/cart_repo.dart';
import '../../repo/cart_repo_impl.dart';
import '../../service/local_cart_service.dart';
import '../../service/remote_cart_service.dart';
import '../widget/cart_item_tile.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  final CartRepo _repo = CartRepoImpl(
    localService: LocalCartService(),
    remoteService: RemoteCartService(),
  );
  final ValueNotifier<Cart> _cart = ValueNotifier<Cart>(const Cart());
  final ProcessStatusNotifier _status =
      ProcessStatusNotifier(initialStatus: ProcessLoading(message: 'Loading'));

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadCart());
  }

  AsyncRequest<Cart> _fetchCart() => _repo.getCart(
        const GetCartParam(userId: null),
      );

  Future<void> _loadCart() async {
    final snackbarNotifier = SnackbarNotifier(context: context);
    final res = await handleFutureRequest<Cart>(
      futureRequest: _fetchCart,
      processStatusNotifier: _status,
      errorSnackbarNotifier: snackbarNotifier,
      onSuccess: (data) => _cart.value = data,
    );
    if (res == null) {
      _status.setError(message: 'Failed');
    }
  }

  Future<void> _updateQuantity(CartItem item, int quantity) async {
    final res = await _repo.updateQuantity(
      cartItemId: item.cartItemId,
      quantity: quantity,
    );
    if (res is SuccessResponse<Cart> && res.data != null) {
      _cart.value = res.data!;
    }
  }

  @override
  void dispose() {
    _cart.dispose();
    _status.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final accent = AppColors.context(context).primaryColor;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Bag'),
        centerTitle: true,
      ),
      body: ListenableBuilder(
        listenable: _status,
        builder: (context, _) {
          if (_status.status is ProcessLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (_status.status is ProcessFailed) {
            return Center(
              child: TextButton(
                onPressed: _loadCart,
                child: const Text('Retry'),
              ),
            );
          }
          return ValueListenableBuilder<Cart>(
            valueListenable: _cart,
            builder: (context, cart, _) {
              if (cart.items.isEmpty) {
                return const Center(child: Text('Your cart is empty'));
              }
              return Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      padding: const EdgeInsets.all(16),
                      itemCount: cart.items.length,
                      separatorBuilder: (_, __) => const Divider(height: 24),
                      itemBuilder: (context, index) {
                        final item = cart.items[index];
                        return CartItemTile(
                          item: item,
                          onIncrement: () =>
                              _updateQuantity(item, item.quantity + 1),
                          onDecrement: () =>
                              _updateQuantity(item, item.quantity - 1),
                        );
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF7F7F7),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Text(
                          'Delivery fee: ${_money(cart.deliveryFee.toDouble())}',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF6B6B6B),
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Expanded(
                          child: Text(
                            'Add ৳219 to reduce fee',
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFF6B6B6B),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SafeArea(
                    top: false,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: accent,
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Row(
                          children: [
                            Container(
                              height: 36,
                              width: 36,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: accent.withOpacity(0.85),
                                border: Border.all(
                                    color: Colors.white, width: 1.4),
                              ),
                              child: Center(
                                child: Text(
                                  '${cart.itemCount}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            const Expanded(
                              child: Text(
                                'Review Address',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Text(
                              _money(cart.total),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

String _money(double value) => '৳${value.toStringAsFixed(0)}';
