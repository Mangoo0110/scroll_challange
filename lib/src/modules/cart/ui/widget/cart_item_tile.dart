import 'package:flutter/material.dart';

import '../../../../core/shared/widget/image_placeholder_widget.dart';
import '../../../../core/themes/app_colors.dart';
import '../../model/cart/cart.dart';
import '../../model/cart_item/cart_item.dart';

class CartItemTile extends StatelessWidget {
  const CartItemTile({
    super.key,
    required this.item,
    required this.onIncrement,
    required this.onDecrement,
  });

  final CartItem item;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  @override
  Widget build(BuildContext context) {
    final accent = AppColors.context(context).primaryColor;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 52,
          width: 52,
          child: Image.network(
            item.imageUrl ?? '',
            errorBuilder: (_, __, ___) => const ImagePlaceholderWidget(
              displayHeight: 52,
              displayWidth: 52,
            ),
          )
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1F1F1F),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '${_money(item.effectivePrice)}${item.unitLabel != null ? ' | ${item.unitLabel}' : ''}',
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF8A8A8A),
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            _QtyButton(
              icon: Icons.remove,
              onTap: onDecrement,
              accent: accent,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFFE2E2E2)),
              ),
              child: Text(
                '${item.quantity}',
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            _QtyButton(
              icon: Icons.add,
              onTap: onIncrement,
              accent: accent,
            ),
          ],
        ),
      ],
    );
  }
}

class _QtyButton extends StatelessWidget {
  const _QtyButton({
    required this.icon,
    required this.onTap,
    required this.accent,
  });

  final IconData icon;
  final VoidCallback onTap;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: onTap,
      radius: 18,
      child: Icon(icon, size: 20, color: accent),
    );
  }
}

String _money(double value) => '৳${value.toStringAsFixed(0)}';
