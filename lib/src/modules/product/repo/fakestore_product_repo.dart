import 'dart:convert';
import 'dart:io';

import 'package:scroll_challenge/src/core/packages/async_handler/lib/async_handler.dart';

import '../model/product/product.dart';
import '../model/product_pagination_param.dart';
import 'mock_product_repo.dart';
import 'product_repo.dart';

class FakeStoreProductRepo extends ProductRepo with ErrorHandler {
  FakeStoreProductRepo({
    HttpClient? client,
    ProductRepo? fallbackRepo,
    this.baseUrl = 'https://fakestoreapi.com',
  }) : _client = client ?? HttpClient(),
       _fallbackRepo = fallbackRepo ?? MockProductRepo();

  final HttpClient _client;
  final ProductRepo _fallbackRepo;
  final String baseUrl;

  List<Product>? _cache;

  @override
  AsyncRequest<List<String>> getCategories() async {
    final remote = await asyncTryCatch<List<String>>(
      tryFunc: () async {
        final categories = await _fetchCategories();
        return SuccessResponse<List<String>>(data: categories);
      },
    );
    if (remote is SuccessResponse<List<String>>) {
      return remote;
    }
    return _fallbackRepo.getCategories();
  }

  @override
  AsyncRequest<ProductPage> getProducts(ProductQueryParams params) async {
    final remote = await asyncTryCatch<ProductPage>(
      tryFunc: () async {
        final allProducts = await _fetchAllProducts();
        final filtered = _filterProducts(allProducts, params);
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
        final products = await _fetchAllProducts();
        Product? product;
        for (final item in products) {
          if (item.id == id) {
            product = item;
            break;
          }
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
        final products = await _fetchAllProducts();
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
    final start = (page - 1) * limit;
    if (start >= items.length) {
      return const <Product>[];
    }
    final end = (start + limit) > items.length ? items.length : (start + limit);
    return items.sublist(start, end);
  }

  Future<List<Product>> _fetchAllProducts() async {
    if (_cache != null) {
      return _cache!;
    }
    final uri = Uri.parse('$baseUrl/products');
    final req = await _client.getUrl(uri);
    final res = await req.close();
    final body = await utf8.decoder.bind(res).join();
    if (res.statusCode < 200 || res.statusCode >= 300) {
      throw HttpException('Failed to fetch products (${res.statusCode})');
    }
    final data = jsonDecode(body);
    if (data is! List) {
      throw const FormatException('Expected a product array');
    }
    _cache = data
        .whereType<Map>()
        .map((raw) => _mapFakeStoreProduct(Map<String, dynamic>.from(raw)))
        .toList(growable: false);
    return _cache!;
  }

  Future<List<String>> _fetchCategories() async {
    final uri = Uri.parse('$baseUrl/products/categories');
    final req = await _client.getUrl(uri);
    final res = await req.close();
    final body = await utf8.decoder.bind(res).join();
    if (res.statusCode < 200 || res.statusCode >= 300) {
      throw HttpException('Failed to fetch categories (${res.statusCode})');
    }
    final data = jsonDecode(body);
    if (data is! List) {
      throw const FormatException('Expected category array');
    }
    return data
        .map((e) => e.toString().trim())
        .where((e) => e.isNotEmpty)
        .toList(growable: false);
  }

  Product _mapFakeStoreProduct(Map<String, dynamic> json) {
    final id = json['id']?.toString() ?? '';
    final category = json['category']?.toString() ?? 'all';
    final priceRaw = json['price'];
    final price = (priceRaw is num) ? priceRaw.toDouble() : 0.0;

    final productId = 'fs_$id';
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
