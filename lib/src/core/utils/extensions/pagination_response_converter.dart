import 'package:scroll_challenge/src/core/packages/async_handler/lib/async_handler.dart';
import 'package:scroll_challenge/src/core/packages/pagination_pkg/lib/pagination_pkg.dart';
import 'package:scroll_challenge/src/modules/category/model/category.dart';
import 'package:scroll_challenge/src/modules/product/model/product/product.dart';

import '../../../modules/product/model/product_pagination_param.dart';

extension ProductPaginationResponseConverter on ApiResponse<ProductPage> {
  PageFetchResponse<Product> toProductPaginationResponse({required OnDemandPage<Product> onDemandPage}) {
    switch (this) {        
      case SuccessResponse<ProductPage> _:
        if (data != null) {
          return PaginationError(page: onDemandPage.pageNo, message: "No products found");
        }
        return PaginationPage(
          items: data!.items,
          page: onDemandPage.pageNo,
        );
      case ErrorResponse<ProductPage> _:
        return PaginationError(
          message: message,
          page: onDemandPage.pageNo,
        );
    }
  }
}

extension CategoryPaginationResponseConverter on ApiResponse<List<Category>> {
  PageFetchResponse<Category> toCategoryPaginationResponse({required OnDemandPage<Category> onDemandPage}) {
    switch (this) {
      case SuccessResponse<List<Category>> _:
        if (data != null) {
          return PaginationError(page: onDemandPage.pageNo, message: "No categories found");
        }
        return PaginationPage(
          items: data!,
          page: onDemandPage.pageNo,
        );
      case ErrorResponse<List<Category>> _:
        return PaginationError(
          message: message,
          page: onDemandPage.pageNo,
        );
    }
  }
}
