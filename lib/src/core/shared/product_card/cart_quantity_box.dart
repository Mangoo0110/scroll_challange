import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../di/repo_di.dart';
import '../../themes/app_colors.dart';
import '../../../modules/cart/controller/cart_store.dart';
import '../../../modules/cart/model/cart/cart.dart';
import '../../../modules/cart/model/cart_item/cart_item.dart';

class CartQuantityBox extends StatefulWidget {
  const CartQuantityBox({
    super.key,
    required this.initialCartImage,
    required this.maxWidth, 
    required this.iconSize,
  });

  final CartItem initialCartImage;
  final double maxWidth;
  final double iconSize;

  @override
  State<CartQuantityBox> createState() => _CartQuantityBoxState();
}

class _CartQuantityBoxState extends State<CartQuantityBox> {
  bool _showEditor = false;
  Timer? _hideTimer;

  void _showEditorTemporarily() {
    if (!_showEditor) {
      setState(() => _showEditor = true);
    }
    _hideTimer?.cancel();
    _hideTimer = Timer(const Duration(seconds: 5), () {
      if (mounted) {
        setState(() => _showEditor = false);
      }
    });
  }

  void _toggleEditor(int quantity) {
    if (quantity == 0) return;
    _showEditorTemporarily();
  }

  @override
  void dispose() {
    _hideTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cartStore = serviceLocator<CartStore>();
    return ValueListenableBuilder<Cart>(
      valueListenable: cartStore.cart,
      builder: (context, cart, _) {
        final quantity = cartStore.quantityForVariant(widget.initialCartImage.cartItemId);
        final accentColor = AppColors.context(context).primaryColor;
        return LayoutBuilder(
          builder: (context, constraints) {
            
            final double height = 45;
            final double width = _showEditor ? widget.maxWidth : height;

            final double iconSize = 22;
            final double textSize = 20;

            final baseDecoration = BoxDecoration(
              border: Border.all(color: accentColor, width: 1.0),
              borderRadius: BorderRadius.circular(9000000000),
              color: _showEditor ? Colors.white : quantity > 0 ? accentColor : Colors.white,
            );

            return AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              curve: Curves.easeOutCubic,
              //clipBehavior: Clip.hardEdge,
              height: height,
              width: width,
              decoration: baseDecoration,
              child: _showEditor
                  ? Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            await cartStore.setQuantity(
                              cartItemId: widget.initialCartImage.cartItemId,
                              quantity: max(0, quantity - 1),
                            );
                            _showEditorTemporarily();
                          },
                          child: Icon(Icons.remove,
                              size: iconSize, color: accentColor),
                        ),
                        Text(
                          '$quantity',
                          style: TextStyle(
                            fontSize: textSize,
                            fontWeight: FontWeight.w600,
                            color: accentColor,
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            // Increase quantity by 1
                            await cartStore.setQuantity(
                              cartItemId: widget.initialCartImage.cartItemId,
                              quantity: quantity + 1,
                            );
                            _showEditorTemporarily();
                          },
                          child: Icon(Icons.add,
                              size: iconSize , color: accentColor),
                        ),
                      ],
                    ).animate().fadeIn(delay: Duration(milliseconds: 100), duration: Duration(milliseconds: 250))
                  : quantity == 0
                      ? GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () async {
                            await cartStore.addItem(
                              widget.initialCartImage.copyWith(quantity: 1),
                            );

                            _showEditorTemporarily();
                          },
                          child: Icon(Icons.add,
                              size: iconSize * 1.4, color: accentColor),
                        )
                      : GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () => _toggleEditor(quantity),
                          child: SizedBox.expand(
                            child: Center(
                              child: Text(
                                '$quantity',
                                style: TextStyle(
                                  fontSize: iconSize,
                                  fontWeight: FontWeight.w700,
                                  color:
                                      AppColors.context(context).invertTextColor,
                                ),
                              ),
                            ),
                          ),
                        ),
            );
          },
        );
      },
    );
  }
}
