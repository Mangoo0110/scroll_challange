import 'package:app_pigeon/app_pigeon.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:scroll_challenge/src/core/constants/api_endpoints.dart';
import 'package:async_handler/async_handler.dart';
import 'package:scroll_challenge/src/modules/product/model/product/product.dart';
import 'package:scroll_challenge/src/modules/product/model/product_pagination_param.dart';
import 'package:scroll_challenge/src/modules/product/repo/fakestore_product_repo.dart';
import 'package:scroll_challenge/src/modules/product/repo/product_repo.dart';

void main() {
  group('FakeStoreProductRepo', () {
    late AppPigeon pigeon;
    late FakeStoreProductRepo repo;

    setUp(() {
      pigeon = GhostPigeon(baseUrl: ApiEndpoints.baseUrl);
      repo = FakeStoreProductRepo(
        appPigeon: pigeon,
        fallbackRepo: _NoFallbackProductRepo(),
      );
    });

    tearDown(() {
      pigeon.dispose();
    });

    test('getProducts filters by categoryId', () async {
      final res = await repo.getProducts(
        const ProductQueryParams(page: 1, limit: 20, categoryId: 'electronics'),
      );

      expect(res, isA<SuccessResponse<ProductPage>>());
      final page = (res as SuccessResponse<ProductPage>).data!;
      expect(page.items, isNotEmpty);
      expect(
        page.items.every((p) => p.categoryIds.contains('electronics')),
        true,
      );
    });

    test('getProductById maps single product response', () async {
      final productsRes = await repo.getProducts(
        const ProductQueryParams(page: 1, limit: 1),
      );
      final firstProduct =
          (productsRes as SuccessResponse<ProductPage>).data!.items.first;
      final res = await repo.getProductById(firstProduct.id);

      expect(res, isA<SuccessResponse<Product?>>());
      final product = (res as SuccessResponse<Product?>).data;
      expect(product, isNotNull);
      expect(product!.id, firstProduct.id);
      expect(product.name.trim().isNotEmpty, true);
      expect(product.variants, isNotEmpty);
      expect(product.variants.single.productId, product.id);
    });
  });
}

class _NoFallbackProductRepo implements ProductRepo {
  @override
  AsyncRequest<ProductPage> getProducts(ProductQueryParams params) async {
    throw StateError(
      'Fallback should not be used in this integration-like test',
    );
  }

  @override
  AsyncRequest<Product?> getProductById(String id) async {
    throw StateError(
      'Fallback should not be used in this integration-like test',
    );
  }

  @override
  AsyncRequest<List<ProductVariant>> getVariantsByProductId(
    String productId,
  ) async {
    throw StateError(
      'Fallback should not be used in this integration-like test',
    );
  }
}
