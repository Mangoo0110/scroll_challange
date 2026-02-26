
import 'product/product.dart';

class ProductPage{
  final List<Product> items;
  final int page;
  final int limit;

  ProductPage({
    required this.items,
    required this.page,
    required this.limit,
  });
}

