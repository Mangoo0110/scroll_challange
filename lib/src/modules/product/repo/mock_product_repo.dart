import 'package:async_handler/async_handler.dart';

import '../model/product/product.dart';
import '../model/product_pagination_param.dart';
import 'product_repo.dart';

class MockProductRepo implements ProductRepo {
  MockProductRepo({this.simulatedLatency = const Duration(milliseconds: 250)});

  final Duration simulatedLatency;

  static const List<Product> _products = [
    Product(
      id: 'p1',
      name: 'Fresh Spinach',
      categoryIds: ['c1'],
      description: 'Fresh green spinach bunch.',
      imageUrl:
          'https://www.citypng.com/public/uploads/preview/vegetable-salad-spinach-leaf-hd-png-7040816948632195a90wtaeu8.png',
      variants: [
        ProductVariant(
          id: 'v1',
          productId: 'p1',
          price: 1.99,
          salePrice: 1.59,
          sku: 'SPN-001',
          inStock: true,
          attributes: [VariantAttribute(name: 'Size', value: 'Bunch')],
        ),
      ],
    ),
    Product(
      id: 'p2',
      name: 'Carrots',
      categoryIds: ['c1'],
      description: 'Crunchy orange carrots.',
      imageUrl:
          'https://img.favpng.com/25/8/16/carrot-fresh-orange-carrot-GQfSkVKQ_t.jpg',
      variants: [
        ProductVariant(
          id: 'v2',
          productId: 'p2',
          price: 0.99,
          sku: 'CRT-001',
          attributes: [VariantAttribute(name: 'Weight', value: '1kg')],
        ),
        ProductVariant(
          id: 'v3',
          productId: 'p2',
          price: 1.79,
          salePrice: 1.59,
          sku: 'CRT-002',
          attributes: [VariantAttribute(name: 'Weight', value: '2kg')],
        ),
      ],
    ),
    Product(
      id: 'p3',
      name: 'Red Apples',
      categoryIds: ['c2'],
      description: 'Sweet and crisp apples.',
      imageUrl:
          'https://pngdownload.io/wp-content/uploads/2023/12/Fresh-Red-Apples-crisp-and-juicy-fruit-natural-goodness-transparent-png-jpg-300x300.webp',
      variants: [
        ProductVariant(
          id: 'v4',
          productId: 'p3',
          price: 2.49,
          sku: 'APL-001',
          attributes: [VariantAttribute(name: 'Weight', value: '1kg')],
        ),
      ],
    ),
    Product(
      id: 'p4',
      name: 'Bananas',
      categoryIds: ['c2'],
      description: 'Naturally sweet bananas.',
      imageUrl:
          'https://e7.pngegg.com/pngimages/595/523/png-clipart-six-ripe-banana-juice-banana-powder-flavor-fruit-yellow-bananas-natural-foods-food-thumbnail.png',
      variants: [
        ProductVariant(
          id: 'v5',
          productId: 'p4',
          price: 1.29,
          sku: 'BAN-001',
          attributes: [VariantAttribute(name: 'Pack', value: 'Dozen')],
        ),
      ],
    ),
    Product(
      id: 'p5',
      name: 'Whole Milk',
      categoryIds: ['c3'],
      description: 'Rich and creamy milk.',
      imageUrl:
          'https://e7.pngegg.com/pngimages/397/314/png-clipart-clear-glass-pitcher-raw-milk-soy-milk-buttermilk-hemp-milk-milk-spray-food-lactose-thumbnail.png',
      variants: [
        ProductVariant(
          id: 'v6',
          productId: 'p5',
          price: 2.99,
          salePrice: 2.49,
          sku: 'MLK-001',
          attributes: [VariantAttribute(name: 'Volume', value: '1L')],
        ),
        ProductVariant(
          id: 'v7',
          productId: 'p5',
          price: 5.49,
          sku: 'MLK-002',
          attributes: [VariantAttribute(name: 'Volume', value: '2L')],
        ),
      ],
    ),
    Product(
      id: 'p6',
      name: 'Greek Yogurt',
      categoryIds: ['c3'],
      description: 'Thick and creamy yogurt.',
      imageUrl:
          'https://w7.pngwing.com/pngs/566/649/png-transparent-milk-greek-yogurt-yoghurt-soy-yogurt-food-curd-cream-food-frozen-dessert.png',
      variants: [
        ProductVariant(
          id: 'v8',
          productId: 'p6',
          price: 3.49,
          sku: 'YOG-001',
          attributes: [VariantAttribute(name: 'Weight', value: '500g')],
        ),
      ],
    ),
    Product(
      id: 'p7',
      name: 'Potato Chips',
      categoryIds: ['c4'],
      description: 'Crispy salted chips.',
      imageUrl:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT2dVbteoI93cJfXAsgq_vbIHy1tQd0C3j65w&s",
      variants: [
        ProductVariant(
          id: 'v9',
          productId: 'p7',
          price: 1.59,
          sku: 'CHP-001',
          attributes: [VariantAttribute(name: 'Size', value: '150g')],
        ),
      ],
    ),
    Product(
      id: 'p8',
      name: 'Mixed Nuts',
      categoryIds: ['c4'],
      description: 'Roasted mixed nuts.',
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTfDBmxfPnOFns2iu4YuSUYQqpTRiCSGpsaUw&s',
      variants: [
        ProductVariant(
          id: 'v10',
          productId: 'p8',
          price: 4.99,
          salePrice: 4.49,
          sku: 'NUT-001',
          attributes: [VariantAttribute(name: 'Weight', value: '250g')],
        ),
      ],
    ),
    Product(
      id: 'p9',
      name: 'Baguette',
      categoryIds: ['c5'],
      description: 'Freshly baked baguette.',
      imageUrl:
          'https://icon2.cleanpng.com/20240313/vez/transparent-white-background-basket-of-baguette-rolls-with-open-1710838115511.webp',
      variants: [
        ProductVariant(
          id: 'v11',
          productId: 'p9',
          price: 1.29,
          sku: 'BRD-001',
          attributes: [VariantAttribute(name: 'Size', value: '1 piece')],
        ),
      ],
    ),
    Product(
      id: 'p11',
      name: 'Chicken Breast',
      categoryIds: ['c6'],
      description: 'Boneless chicken breast.',
      imageUrl:
          'https://images.rawpixel.com/image_png_800/cHJpdmF0ZS9sci9pbWFnZXMvd2Vic2l0ZS8yMDIzLTAzL3B4OTgzNDAxLWltYWdlLWpvYjE3MjhfMS5wbmc.png',
      variants: [
        ProductVariant(
          id: 'v13',
          productId: 'p11',
          price: 5.99,
          sku: 'CHK-001',
          attributes: [VariantAttribute(name: 'Weight', value: '500g')],
        ),
      ],
    ),
    Product(
      id: 'p12',
      name: 'Salmon Fillet',
      categoryIds: ['c6'],
      description: 'Fresh salmon fillet.',
      imageUrl:
          'https://e7.pngegg.com/pngimages/437/581/png-clipart-two-sliced-salmons-salmon-fillets-food-seafood-thumbnail.png',
      variants: [
        ProductVariant(
          id: 'v14',
          productId: 'p12',
          price: 8.99,
          sku: 'SLM-001',
          attributes: [VariantAttribute(name: 'Weight', value: '300g')],
        ),
      ],
    ),
    Product(
      id: 'p13',
      name: 'Frozen Peas',
      categoryIds: ['c7'],
      description: 'Quick frozen green peas.',
      imageUrl:
          'https://png.pngtree.com/png-vector/20250408/ourlarge/pngtree-frozen-green-peas-in-small-bucket-for-kitchen-use-png-image_15949772.png',
      variants: [
        ProductVariant(
          id: 'v15',
          productId: 'p13',
          price: 2.19,
          sku: 'FPS-001',
          attributes: [VariantAttribute(name: 'Weight', value: '500g')],
        ),
      ],
    ),
    Product(
      id: 'p14',
      name: 'Ice Cream',
      categoryIds: ['c7'],
      description: 'Creamy vanilla ice cream.',
      imageUrl:
          'https://img.freepik.com/free-psd/delicious-vanilla-ice-cream-cone-with-chocolate-nuts_191095-80144.jpg?semt=ais_hybrid&w=740&q=80',
      variants: [
        ProductVariant(
          id: 'v16',
          productId: 'p14',
          price: 3.99,
          sku: 'ICE-001',
          attributes: [VariantAttribute(name: 'Volume', value: '1L')],
        ),
      ],
    ),
    Product(
      id: 'p15',
      name: 'Orange Juice',
      categoryIds: ['c8'],
      description: 'Fresh orange juice.',
      imageUrl:
          'https://img.freepik.com/free-psd/refreshing-orange-juice-with-mint-garnish-summertime-delight_191095-85559.jpg?semt=ais_hybrid&w=740&q=80',
      variants: [
        ProductVariant(
          id: 'v17',
          productId: 'p15',
          price: 2.59,
          sku: 'OJ-001',
          attributes: [VariantAttribute(name: 'Volume', value: '1L')],
        ),
      ],
    ),
    Product(
      id: 'p16',
      name: 'Green Tea',
      categoryIds: ['c8'],
      description: 'Refreshing green tea.',
      imageUrl: 'https://picsum.photos/seed/tea/600/600',
      variants: [
        ProductVariant(
          id: 'v18',
          productId: 'p16',
          price: 3.29,
          sku: 'TEA-001',
          attributes: [VariantAttribute(name: 'Pack', value: '25 bags')],
        ),
      ],
    ),
    Product(
      id: 'p17',
      name: 'Breakfast Cereal',
      categoryIds: ['c9', 'c10'],
      description: 'Crunchy breakfast cereal.',
      imageUrl: 'https://picsum.photos/seed/cereal/600/600',
      variants: [
        ProductVariant(
          id: 'v19',
          productId: 'p17',
          price: 3.79,
          sku: 'CER-001',
          attributes: [VariantAttribute(name: 'Weight', value: '500g')],
        ),
      ],
    ),
    Product(
      id: 'p18',
      name: 'Peanut Butter',
      categoryIds: ['c9', 'c10'],
      description: 'Creamy peanut butter.',
      imageUrl: 'https://picsum.photos/seed/peanut/600/600',
      variants: [
        ProductVariant(
          id: 'v20',
          productId: 'p18',
          price: 4.49,
          salePrice: 3.99,
          sku: 'PBT-001',
          attributes: [VariantAttribute(name: 'Weight', value: '350g')],
        ),
      ],
    ),
    Product(
      id: 'p19',
      name: 'Basmati Rice',
      categoryIds: ['c10'],
      description: 'Aromatic basmati rice.',
      imageUrl:
          'https://e7.pngegg.com/pngimages/345/524/png-clipart-cooked-rice-basmati-grocery-store-gunny-sack-rice-bags-food-supermarket.png',
      variants: [
        ProductVariant(
          id: 'v21',
          productId: 'p19',
          price: 6.49,
          sku: 'RIC-001',
          attributes: [VariantAttribute(name: 'Weight', value: '2kg')],
        ),
      ],
    ),
    Product(
      id: 'p20',
      name: 'Olive Oil',
      categoryIds: ['c12'],
      description: 'Extra virgin olive oil.',
      imageUrl:
          'https://images.rawpixel.com/image_png_800/cHJpdmF0ZS9sci9pbWFnZXMvd2Vic2l0ZS8yMDIzLTA4L3Jhd3BpeGVsX29mZmljZV8zX3Bob3RvX29mX29saXZlc19vaWxfaW5fYV9ib3R0bGVfY2xvc2UtdXBfaXNvbF8yMTVkYzFjNC1hNDQ5LTQxYjUtODVjYy0wM2NjYzM4ZGQ0MTUucG5n.png',
      variants: [
        ProductVariant(
          id: 'v22',
          productId: 'p20',
          price: 7.99,
          salePrice: 6.99,
          sku: 'OIL-001',
          attributes: [VariantAttribute(name: 'Volume', value: '1L')],
        ),
      ],
    ),
    Product(
      id: 'p21',
      name: 'Dishwashing Liquid',
      categoryIds: ['c13'],
      description: 'Lemon fresh dishwash liquid.',
      imageUrl: 'https://picsum.photos/seed/dishwash/600/600',
      variants: [
        ProductVariant(
          id: 'v23',
          productId: 'p21',
          price: 2.39,
          sku: 'DSH-001',
          attributes: [VariantAttribute(name: 'Volume', value: '500ml')],
        ),
      ],
    ),
    Product(
      id: 'p22',
      name: 'Shampoo',
      categoryIds: ['c14'],
      description: 'Herbal care shampoo.',
      imageUrl: 'https://picsum.photos/seed/shampoo/600/600',
      variants: [
        ProductVariant(
          id: 'v24',
          productId: 'p22',
          price: 4.29,
          sku: 'SHP-001',
          attributes: [VariantAttribute(name: 'Volume', value: '400ml')],
        ),
      ],
    ),
    Product(
      id: 'p23',
      name: 'Baby Diapers',
      categoryIds: ['c15'],
      description: 'Soft and dry diapers.',
      imageUrl: 'https://picsum.photos/seed/diapers/600/600',
      variants: [
        ProductVariant(
          id: 'v25',
          productId: 'p23',
          price: 9.99,
          sku: 'BBD-001',
          attributes: [VariantAttribute(name: 'Size', value: 'M')],
        ),
        ProductVariant(
          id: 'v26',
          productId: 'p23',
          price: 9.99,
          sku: 'BBD-002',
          attributes: [VariantAttribute(name: 'Size', value: 'L')],
        ),
      ],
    ),
    Product(
      id: 'p24',
      name: 'Cat Food',
      categoryIds: ['c16'],
      description: 'Nutritious cat food.',
      imageUrl: 'https://picsum.photos/seed/catfood/600/600',
      variants: [
        ProductVariant(
          id: 'v27',
          productId: 'p24',
          price: 5.79,
          sku: 'CAT-001',
          attributes: [VariantAttribute(name: 'Weight', value: '1kg')],
        ),
      ],
    ),
  ];

  @override
  Future<ApiResponse<List<String>>> getCategories() async {
    await Future<void>.delayed(simulatedLatency);
    final categories =
        _products.expand((product) => product.categoryIds).toSet().toList()
          ..sort();
    return SuccessResponse<List<String>>(data: categories);
  }

  @override
  Future<ApiResponse<ProductPage>> getProducts(
    ProductQueryParams params,
  ) async {
    await Future<void>.delayed(simulatedLatency);
    final query = params.query?.trim().toLowerCase() ?? '';
    final filtered = _products.where((product) {
      if (params.onlyActive && !product.isActive) return false;
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

    final total = filtered.length;
    final start = (params.page - 1) * params.limit;
    if (start >= total) {
      return SuccessResponse<ProductPage>(
        data: ProductPage(
          items: const [],
          page: params.page,
          limit: params.limit,
        ),
      );
    }
    final end = (start + params.limit) > total ? total : (start + params.limit);
    final items = filtered.sublist(start, end);
    return SuccessResponse<ProductPage>(
      data: ProductPage(items: items, page: params.page, limit: params.limit),
    );
  }

  @override
  Future<ApiResponse<Product?>> getProductById(String id) async {
    await Future<void>.delayed(simulatedLatency);
    try {
      final product = _products.firstWhere((p) => p.id == id);
      return SuccessResponse<Product?>(data: product);
    } catch (error, stackTrace) {
      return ErrorResponse<Product?>(
        message: 'Product not found',
        exception: error is Exception ? error : Exception(error.toString()),
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future<ApiResponse<List<ProductVariant>>> getVariantsByProductId(
    String productId,
  ) async {
    await Future<void>.delayed(simulatedLatency);
    final product = _products.cast<Product?>().firstWhere(
      (p) => p!.id == productId,
      orElse: () => null,
    );
    return SuccessResponse<List<ProductVariant>>(
      data: product?.variants ?? <ProductVariant>[],
    );
  }
}

double _minVariantPrice(List<ProductVariant> variants) {
  if (variants.isEmpty) return 0;
  var minPrice = variants.first.effectivePrice;
  for (final variant in variants) {
    final price = variant.effectivePrice;
    if (price < minPrice) minPrice = price;
  }
  return minPrice;
}
