


import 'package:flutter/material.dart';

SliverGridDelegate sliverGridDelegateConfig1() {
  return const SliverGridDelegateWithMaxCrossAxisExtent(
    maxCrossAxisExtent: 250,
    crossAxisSpacing: 2,
    mainAxisSpacing: 12,
    childAspectRatio: .6,
  );
}

SliverGridDelegate sliverGridDelegateConfig2() {
  return const SliverGridDelegateWithMaxCrossAxisExtent(
    maxCrossAxisExtent: 250,
    crossAxisSpacing: 2,
    mainAxisSpacing: 12,
    childAspectRatio: .8,
  );
}
