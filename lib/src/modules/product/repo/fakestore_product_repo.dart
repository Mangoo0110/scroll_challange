

import 'dart:math';

import 'package:app_pigeon/app_pigeon.dart';
import 'package:flutter/foundation.dart';
import 'package:scroll_challenge/src/core/constants/api_endpoints.dart';
import 'package:scroll_challenge/src/core/packages/async_handler/lib/async_handler.dart';

import 'package:scroll_challenge/src/core/utils/utils.dart';
import '../model/product/product.dart';
import '../model/product_pagination_param.dart';
import 'mock_product_repo.dart';
import 'product_repo.dart';

class FakeStoreProductRepo extends ProductRepo with ErrorHandler {
  FakeStoreProductRepo({
    ProductRepo? fallbackRepo,
    required this.appPigeon,
  }) :
       _fallbackRepo = fallbackRepo ?? MockProductRepo();

  final ProductRepo _fallbackRepo;
  final AppPigeon appPigeon;
  final Debugger _debugger = ServiceDebugger();

  List<Product>? _cache;


  @override
  AsyncRequest<ProductPage> getProducts(ProductQueryParams params) async {
    final remote = await asyncTryCatch<ProductPage>(
      tryFunc: () async {
        _debugger.dekhao('Fetching products from FakeStore API with params: $params');
        final res = await appPigeon.get(
          ApiEndpoints.getProducts,
        );
        final allProducts = (extractBodyData(res) as List<dynamic>)
            .map((e) => _mapFakeStoreProduct(Map<String, dynamic>.from(e)))
            .toList();
        final filtered = _filterProducts(allProducts, params);
        _debugger.dekhao("Filtered products count: ${filtered.length}");
        final pageItems = _paginate(
          items: filtered,
          page: params.page,
          limit: params.limit,
        );
        return SuccessResponse<ProductPage>(
          data: ProductPage(
            items: pageItems,
            page: params.page,
            limit: params.limit,
          ),
        );
      },
    );
    if (remote is SuccessResponse<ProductPage>) {
      return remote;
    }
    return _fallbackRepo.getProducts(params);
  }

  @override
  AsyncRequest<Product?> getProductById(String id) async {
    final remote = await asyncTryCatch<Product?>(
      tryFunc: () async {
        final res = await appPigeon.get(
          ApiEndpoints.singleProduct(id),
        );
        Product? product;
        if (extractBodyData(res) != null) {
          product = _mapFakeStoreProduct(extractBodyData(res));
        }
        return SuccessResponse<Product?>(data: product);
      },
    );
    if (remote is SuccessResponse<Product?>) {
      return remote;
    }
    return _fallbackRepo.getProductById(id);
  }

  @override
  AsyncRequest<List<ProductVariant>> getVariantsByProductId(
    String productId,
  ) async {
    final remote = await asyncTryCatch<List<ProductVariant>>(
      tryFunc: () async {
        final products = await getProducts(const ProductQueryParams(page: 1, limit: 100)).then(
          (res) => res is SuccessResponse<ProductPage> ? (res.data?.items ?? []) : [],
        );
        List<ProductVariant> variants = const <ProductVariant>[];
        for (final product in products) {
          if (product.id == productId) {
            variants = product.variants;
            break;
          }
        }
        return SuccessResponse<List<ProductVariant>>(data: variants);
      },
    );
    if (remote is SuccessResponse<List<ProductVariant>>) {
      return remote;
    }
    return _fallbackRepo.getVariantsByProductId(productId);
  }

  List<Product> _filterProducts(
    List<Product> products,
    ProductQueryParams params,
  ) {
    final query = params.query?.trim().toLowerCase() ?? '';
    return products.where((product) {
      if (params.onlyActive && !product.isActive) {
        return false;
      }
      if (params.categoryId != null &&
          !product.categoryIds.contains(params.categoryId)) {
        return false;
      }
      if (query.isNotEmpty && !product.name.toLowerCase().contains(query)) {
        return false;
      }
      final minVariantPrice = _minVariantPrice(product.variants);
      if (params.minPrice != null && minVariantPrice < params.minPrice!) {
        return false;
      }
      if (params.maxPrice != null && minVariantPrice > params.maxPrice!) {
        return false;
      }
      return true;
    }).toList();
  }

  List<Product> _paginate({
    required List<Product> items,
    required int page,
    required int limit,
  }) {
    debugPrint("paginating for page $page with limit $limit on items count ${items.length}");
    final start = (page - 1) * limit;
    if (start >= items.length || start < 0) {
      return const <Product>[];
    }
    final end = min(start + limit, items.length);
    if(end > items.length || end < 0) {
      _debugger.dekhao('Pagination end index $end is greater than total items ${items.length}. Adjusting end index to ${items.length}.');
      return const <Product>[];
    }
    return items.sublist(start, end);
  }


  Product _mapFakeStoreProduct(Map<String, dynamic> json) {
    final id = json['id']?.toString() ?? '';
    final category = json['category']?.toString() ?? 'all';
    final priceRaw = json['price'];
    final price = (priceRaw is num) ? priceRaw.toDouble() : 0.0;

    final productId = id;
    final variantId = 'fsv_$id';
    return Product(
      id: productId,
      name: (json['title']?.toString().trim().isNotEmpty ?? false)
          ? json['title'].toString()
          : 'Untitled',
      categoryIds: <String>[category],
      description: json['description']?.toString(),
      imageUrl: json['image']?.toString(),
      variants: <ProductVariant>[
        ProductVariant(
          id: variantId,
          productId: productId,
          price: price,
          attributes: <VariantAttribute>[
            VariantAttribute(name: 'Category', value: category),
          ],
        ),
      ],
      isActive: true,
    );
  }
}

double _minVariantPrice(List<ProductVariant> variants) {
  if (variants.isEmpty) {
    return 0;
  }
  var min = variants.first.effectivePrice;
  for (final variant in variants) {
    if (variant.effectivePrice < min) {
      min = variant.effectivePrice;
    }
  }
  return min;
}
