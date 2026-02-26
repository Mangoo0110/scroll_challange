import 'package:scroll_challenge/src/core/packages/async_handler/lib/async_handler.dart';

import '../model/category.dart';
import 'category_repo.dart';

class MockCategoryRepo implements CategoryRepo {
  MockCategoryRepo({this.simulatedLatency = const Duration(milliseconds: 250)});

  final Duration simulatedLatency;

  static const List<Category> _categories = [
    Category(
      id: 'c1',
      name: 'Vegetables',
      description: 'Fresh daily produce',
      imageUrl: 'https://picsum.photos/seed/veg/300/300',
      isActive: true,
    ),
    Category(
      id: 'c2',
      name: 'Fruits',
      description: 'Seasonal picks and staples',
      imageUrl: 'https://picsum.photos/seed/fruit/300/300',
      isActive: true,
    ),
    Category(
      id: 'c3',
      name: 'Dairy',
      description: 'Milk, yogurt, and more',
      imageUrl: 'https://picsum.photos/seed/dairy/300/300',
      isActive: true,
    ),
    Category(
      id: 'c4',
      name: 'Snacks',
      description: 'Chips, biscuits, and treats',
      imageUrl: 'https://picsum.photos/seed/snack/300/300',
      isActive: false,
    ),
    Category(
      id: 'c5',
      name: 'Bakery',
      description: 'Breads and pastries',
      imageUrl: 'https://picsum.photos/seed/bakery/300/300',
      isActive: true,
    ),
    Category(
      id: 'c6',
      name: 'Meat & Seafood',
      description: 'Fresh cuts and fillets',
      imageUrl: 'https://picsum.photos/seed/meat/300/300',
      isActive: true,
    ),
    Category(
      id: 'c7',
      name: 'Frozen Foods',
      description: 'Ready to cook meals',
      imageUrl: 'https://picsum.photos/seed/frozen/300/300',
      isActive: true,
    ),
    Category(
      id: 'c8',
      name: 'Beverages',
      description: 'Juices, tea, and coffee',
      imageUrl: 'https://picsum.photos/seed/drink/300/300',
      isActive: true,
    ),
    Category(
      id: 'c9',
      name: 'Breakfast',
      description: 'Cereals and spreads',
      imageUrl: 'https://picsum.photos/seed/breakfast/300/300',
      isActive: true,
    ),
    Category(
      id: 'c10',
      name: 'Pantry',
      description: 'Staples and essentials',
      imageUrl: 'https://picsum.photos/seed/pantry/300/300',
      isActive: true,
    ),
    Category(
      id: 'c11',
      name: 'Spices',
      description: 'Masalas and seasonings',
      imageUrl: 'https://picsum.photos/seed/spices/300/300',
      isActive: true,
    ),
    Category(
      id: 'c12',
      name: 'Cooking Oils',
      description: 'Everyday cooking oils',
      imageUrl: 'https://picsum.photos/seed/oil/300/300',
      isActive: true,
    ),
    Category(
      id: 'c13',
      name: 'Cleaning Supplies',
      description: 'Home cleaning essentials',
      imageUrl: 'https://picsum.photos/seed/cleaning/300/300',
      isActive: true,
    ),
    Category(
      id: 'c14',
      name: 'Personal Care',
      description: 'Daily care products',
      imageUrl: 'https://picsum.photos/seed/personal/300/300',
      isActive: true,
    ),
    Category(
      id: 'c15',
      name: 'Baby Care',
      description: 'Diapers and baby needs',
      imageUrl: 'https://picsum.photos/seed/baby/300/300',
      isActive: true,
    ),
    Category(
      id: 'c16',
      name: 'Pet Care',
      description: 'Food and accessories',
      imageUrl: 'https://picsum.photos/seed/pet/300/300',
      isActive: true,
    ),
    Category(
      id: 'c17',
      name: 'Home & Kitchen',
      description: 'Essentials for home',
      imageUrl: 'https://picsum.photos/seed/home/300/300',
      isActive: true,
    ),
    Category(
      id: 'c18',
      name: 'Stationery',
      description: 'Office and school',
      imageUrl: 'https://picsum.photos/seed/stationery/300/300',
      isActive: true,
    ),
    Category(
      id: 'c19',
      name: 'Beauty & Makeup',
      description: 'Cosmetics and skincare',
      imageUrl: 'https://picsum.photos/seed/beauty/300/300',
      isActive: true,
    ),
    Category(
      id: 'c20',
      name: 'Health & Wellness',
      description: 'Vitamins and care',
      imageUrl: 'https://picsum.photos/seed/health/300/300',
      isActive: true,
    ),
    Category(
      id: 'c21',
      name: 'Household',
      description: 'Daily household items',
      imageUrl: 'https://picsum.photos/seed/household/300/300',
      isActive: true,
    ),
    Category(
      id: 'c22',
      name: 'Confectionery',
      description: 'Chocolates and candy',
      imageUrl: 'https://picsum.photos/seed/candy/300/300',
      isActive: true,
    ),
  ];

  @override
  Future<ApiResponse<List<Category>>> getCategories(
      {bool onlyActive = true}) async {
    await Future<void>.delayed(simulatedLatency);
    final data = onlyActive
        ? _categories.where((c) => c.isActive).toList()
        : List<Category>.from(_categories);
    return SuccessResponse<List<Category>>(data: data);
  }

  @override
  Future<ApiResponse<Category?>> getCategoryById(String id) async {
    await Future<void>.delayed(simulatedLatency);
    try {
      final data = _categories.firstWhere((c) => c.id == id);
      return SuccessResponse<Category?>(data: data);
    } catch (error, stackTrace) {
      return ErrorResponse<Category?>(
        message: 'Category not found',
        exception: error is Exception ? error : Exception(error.toString()),
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future<ApiResponse<List<Category>>> searchCategories(String query,
      {bool onlyActive = true}) async {
    await Future<void>.delayed(simulatedLatency);
    final q = query.trim().toLowerCase();
    final data = (q.isEmpty)
        ? (onlyActive
            ? _categories.where((c) => c.isActive).toList()
            : List<Category>.from(_categories))
        : _categories
            .where((c) => (!onlyActive || c.isActive))
            .where((c) => c.name.toLowerCase().contains(q))
            .toList();
    return SuccessResponse<List<Category>>(data: data);
  }
}
