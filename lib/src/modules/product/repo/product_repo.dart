import 'package:async_handler/async_handler.dart';

import '../model/product/product.dart';
import '../model/product_pagination_param.dart';

abstract class ProductRepo {
  AsyncRequest<ProductPage> getProducts(ProductQueryParams params);

  AsyncRequest<Product?> getProductById(String id);

  AsyncRequest<List<ProductVariant>> getVariantsByProductId(String productId);
}
