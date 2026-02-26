import 'package:flutter/material.dart';
import 'package:scroll_challenge/src/core/packages/async_handler/lib/async_handler.dart';

import '../core/di/repo_di.dart';
import '../core/shared/product_card/product_card.dart';
import '../modules/product/model/product/product.dart';
import '../modules/product/model/product_pagination_param.dart';
import '../modules/product/repo/product_repo.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with TickerProviderStateMixin {
  final ProductRepo _repo = serviceLocator<ProductRepo>();
  final TextEditingController _searchController = TextEditingController();

  final Map<String, Future<List<Product>>> _tabProductFutures = {};
  TabController? _tabController;
  List<String> _categories = const [];
  String _query = '';
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _bootstrap();
  }

  Future<void> _bootstrap() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    final res = await _repo.getCategories();
    if (!mounted) {
      return;
    }
    if (res is SuccessResponse<List<String>> && res.data != null) {
      final fetched =
          res.data!
              .map((e) => e.trim())
              .where((e) => e.isNotEmpty)
              .toSet()
              .toList()
            ..sort();
      final categories = <String>['all', ...fetched];

      _tabController?.dispose();
      _tabController = TabController(length: categories.length, vsync: this);
      _categories = categories;
      _tabProductFutures.clear();
      setState(() {
        _loading = false;
      });
      return;
    }
    setState(() {
      _loading = false;
      _error = res.message;
    });
  }

  Future<List<Product>> _loadProductsForTab(String category) async {
    final params = ProductQueryParams(
      categoryId: category == 'all' ? null : category,
      query: _query.trim().isEmpty ? null : _query.trim(),
      page: 1,
      limit: 40,
    );
    final res = await _repo.getProducts(params);
    if (res is SuccessResponse<ProductPage> && res.data != null) {
      return res.data!.items;
    }
    throw Exception(res.message);
  }

  Future<List<Product>> _productsFuture(String category) {
    final key = '$category|$_query';
    return _tabProductFutures.putIfAbsent(
      key,
      () => _loadProductsForTab(category),
    );
  }

  void _applySearch() {
    final query = _searchController.text.trim();
    if (_query == query) {
      return;
    }
    setState(() {
      _query = query;
      _tabProductFutures.clear();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    if (_error != null) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(_error!),
              const SizedBox(height: 8),
              TextButton(onPressed: _bootstrap, child: const Text('Retry')),
            ],
          ),
        ),
      );
    }
    final controller = _tabController;
    if (controller == null) {
      return const SizedBox.shrink();
    }

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverSafeArea(
              bottom: false,
              sliver: SliverToBoxAdapter(
                child: _HomeHeader(
                  searchController: _searchController,
                  onSearchPressed: _applySearch,
                ),
              ),
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: _AdaptiveTabBarHeader(
                tabController: controller,
                tabs: _categories.map(_readableCategory).toList(),
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: controller,
          children: _categories.map((category) {
            return _TabProductGrid(
              key: ValueKey('tab-$category'),
              productsFuture: _productsFuture(category),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class _TabProductGrid extends StatelessWidget {
  const _TabProductGrid({super.key, required this.productsFuture});

  final Future<List<Product>> productsFuture;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Product>>(
      future: productsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(
            child: Text(
              'Could not load products',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          );
        }
        final products = snapshot.data ?? const <Product>[];
        if (products.isEmpty) {
          return const Center(child: Text('No products found'));
        }
        return GridView.builder(
          padding: const EdgeInsets.fromLTRB(12, 12, 12, 24),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.64,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: products.length,
          itemBuilder: (context, index) {
            return ProductCard(product: products[index]);
          },
        );
      },
    );
  }
}

class _HomeHeader extends StatelessWidget {
  const _HomeHeader({
    required this.searchController,
    required this.onSearchPressed,
  });

  final TextEditingController searchController;
  final VoidCallback onSearchPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: searchController,
                  textInputAction: TextInputAction.search,
                  onSubmitted: (_) => onSearchPressed(),
                  decoration: InputDecoration(
                    hintText: 'Search products',
                    isDense: true,
                    prefixIcon: const Icon(Icons.search_rounded),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              FilledButton(
                onPressed: onSearchPressed,
                child: const Text('Search'),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 34,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final labels = ['Safe Payment', 'Fast Delivery', 'Free Return'];
                return Chip(label: Text(labels[index]));
              },
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemCount: 3,
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 110,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              itemBuilder: (context, index) {
                final colors = [
                  const Color(0xFFFFE9D8),
                  const Color(0xFFE7F6FF),
                  const Color(0xFFFFE9F2),
                ];
                return Container(
                  width: 260,
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: colors[index],
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        index == 0
                            ? 'Welcome: 15% OFF + Free Delivery'
                            : index == 1
                            ? 'Grand Bazaar Deals'
                            : 'Today: Shop More, Save More',
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text('Task mock banner'),
                    ],
                  ),
                );
              },
              separatorBuilder: (_, __) => const SizedBox(width: 8),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

class _AdaptiveTabBarHeader extends SliverPersistentHeaderDelegate {
  _AdaptiveTabBarHeader({required this.tabController, required this.tabs});

  final TabController tabController;
  final List<String> tabs;

  @override
  double get minExtent => 50;

  @override
  double get maxExtent => 70;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final pinnedLike = shrinkOffset >= (maxExtent - minExtent - 2);
    return Container(
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(8, pinnedLike ? 0 : 8, 8, 0),
      alignment: Alignment.centerLeft,
      child: TabBar(
        controller: tabController,
        isScrollable: true,
        labelPadding: const EdgeInsets.symmetric(horizontal: 12),
        indicatorSize: TabBarIndicatorSize.label,
        dividerColor: Colors.transparent,
        labelStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
        labelColor: pinnedLike
            ? Theme.of(context).colorScheme.primary
            : Colors.black,
        unselectedLabelColor: const Color(0xFF5F5F5F),
        indicator: pinnedLike
            ? UnderlineTabIndicator(
                borderRadius: BorderRadius.circular(999),
                borderSide: BorderSide(
                  width: 3,
                  color: Theme.of(context).colorScheme.primary,
                ),
              )
            : BoxDecoration(
                color: const Color(0xFFF2F2F2),
                borderRadius: BorderRadius.circular(10),
              ),
        tabs: tabs.map((label) => Tab(text: label)).toList(),
      ),
    );
  }

  @override
  bool shouldRebuild(covariant _AdaptiveTabBarHeader oldDelegate) {
    return oldDelegate.tabController != tabController ||
        oldDelegate.tabs != tabs;
  }
}

String _readableCategory(String raw) {
  if (raw == 'all') {
    return 'For You';
  }
  return raw
      .split(RegExp(r"[-\s]+"))
      .where((word) => word.isNotEmpty)
      .map(
        (word) => '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}',
      )
      .join(' ');
}
