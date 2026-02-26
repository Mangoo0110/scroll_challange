import 'package:flutter/material.dart';

import '../../../../core/themes/app_colors.dart';
import '../../model/cart/cart.dart';

class CheckoutBar extends StatelessWidget {
  const CheckoutBar({
    super.key,
    required this.cart,
    required this.onTap,
    required this.height,
    required this.priceBoxWidth,
  });

  final Cart cart;
  final VoidCallback onTap;
  final double height;
  final double priceBoxWidth;

  @override
  Widget build(BuildContext context) {
    final accent = Theme.of(context).primaryColor.withAlpha(200);
    //final accentDark = const Color.fromARGB(220, 188, 128, 75);
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(6000000),
        onTap: onTap,
        child: Container(
          height: height,
          padding: const EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
            color: accent,
            borderRadius: BorderRadius.circular(600000),
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Row(
                children: [
                  // Container(
                  //   height: 36,
                  //   width: 36,
                  //   decoration: BoxDecoration(
                  //     shape: BoxShape.circle,
                  //     color: accent.withOpacity(0.85),
                  //     border: Border.all(color: Colors.white, width: 1.4),
                  //   ),
                  //   child: Center(
                  //     child: Text(
                  //       '${cart.itemCount}',
                  //       style: const TextStyle(
                  //         color: Colors.white,
                  //         fontWeight: FontWeight.w600,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // const SizedBox(width: 12),
                  SizedBox(
                    width: constraints.maxWidth - priceBoxWidth,
                    child: Center(
                      child: Text(
                        'Checkout',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: priceBoxWidth,
                    height: height - 16,
                    decoration: BoxDecoration(
                      //color: accentDark,
                      borderRadius: BorderRadius.circular(6000000),
                    ),
                    child: Center(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          _money(cart.total),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              );
            }
          ),
        ),
      ),
    );
  }
}

String _money(double value) => '৳${value.toStringAsFixed(0)}';
