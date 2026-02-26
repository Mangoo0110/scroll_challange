import 'package:flutter/material.dart';

class ImagePlaceholderWidget extends StatelessWidget {
  final double displayHeight;
  final double displayWidth;
  const ImagePlaceholderWidget({super.key, required this.displayHeight, required this.displayWidth});

  @override
  Widget build(BuildContext context) {
    return Icon(
        Icons.image,
        size: displayHeight * 0.5,
        color: Colors.grey[400],
      );
  }
}