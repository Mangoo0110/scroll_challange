import 'package:scroll_challenge/src/core/packages/async_handler/lib/async_handler.dart';
import 'package:scroll_challenge/src/modules/category/model/category.dart';
import 'package:scroll_challenge/src/modules/product/model/product/product.dart';
import 'package:pagination_pkg/pagination_pkg.dart';
import '../../modules/product/model/product_pagination_param.dart';

extension ProductPaginationResponseConverter on ApiResponse<ProductPage> {
  PageFetchResponse<String, Product> toProductPaginationResponse({required OnDemandPage<Product> onDemandPage}) {
    switch (this) {        
      case SuccessResponse<ProductPage> _:
        if (data == null) {
          return PaginationError(page: onDemandPage.pageNo, message: "No products found");
        }
        final items = <String, Product>{};
        for (var product in data!.items) {
          items[product.id] = product;
        }
        return PaginationPage(
          items: items,
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
  PageFetchResponse<String, Category> toCategoryPaginationResponse({required OnDemandPage<Category> onDemandPage}) {
    switch (this) {
      case SuccessResponse<List<Category>> _:
        if (data == null) {
          return PaginationError(page: onDemandPage.pageNo, message: "No categories found");
        }
        final items = <String, Category>{};
        for (var category in data!) {
          items[category.id] = category;
        }
        return PaginationPage(
          items: items,
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
