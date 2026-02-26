


import 'package:flutter/material.dart';

SliverGridDelegate sliverGridDelegateConfig() {
  return const SliverGridDelegateWithMaxCrossAxisExtent(
    maxCrossAxisExtent: 250,
    crossAxisSpacing: 18,
    mainAxisSpacing: 12,
    childAspectRatio: .6,
  );
}
