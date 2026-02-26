import 'package:scroll_challenge/src/core/packages/async_handler/lib/async_handler.dart';

import '../model/product/product.dart';
import '../model/product_pagination_param.dart';

abstract class ProductRepo {
  AsyncRequest<List<String>> getCategories();

  AsyncRequest<ProductPage> getProducts(ProductQueryParams params);

  AsyncRequest<Product?> getProductById(String id);

  AsyncRequest<List<ProductVariant>> getVariantsByProductId(String productId);
}
