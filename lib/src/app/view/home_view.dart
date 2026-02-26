import 'package:flutter/material.dart';
import 'package:pagination_pkg/pagination_pkg.dart';
import 'package:scroll_challenge/src/core/shared/widget/paginated_grid.dart';
import 'package:scroll_challenge/src/modules/category/model/category.dart';
import 'package:scroll_challenge/src/modules/category/repo/category_repo.dart';

import '../../core/di/repo_di.dart';
import '../../core/shared/product_card/product_card.dart';
import '../../core/utils/utils.dart';
import '../../modules/product/model/product/product.dart';
import '../../modules/product/repo/product_repo.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with TickerProviderStateMixin {
  final ProductRepo _repo = serviceLocator<ProductRepo>();
  final TextEditingController _searchController = TextEditingController();
  late final InfinityScrollPaginationController<Category> _categoryPagination;
  final Map<String, InfinityScrollPaginationController<Product>>
  _tapProductsPaginations = {};
  TabController? _tabController;
  String? _error;

  @override
  void initState() {
    super.initState();
    _categoryPagination = InfinityScrollPaginationController<Category>(
      maxCapacityCount: 100,
      onDemandPageCall:
          ({
            required onAddPage,
            required onDemandPage,
            required onError,
          }) async {
            await handleFutureRequest(
              futureRequest: () async =>
                  serviceLocator<CategoryRepo>().getCategories(),
              onSuccess: (data) {
                onAddPage(
                  PaginationPage(
                    items: data,
                    page: onDemandPage.pageNo,
                    limit: onDemandPage.limit,
                  ),
                );
              },
              onError: (error) {
                debugPrint("Got error: ${error.message}");
                onError(
                  PaginationError(
                    message: error.message,
                    page: onDemandPage.pageNo,
                  ),
                );
              },
            );
          },
    );
    _categoryPagination.refresh();
  }

  _setTabController() {
    _tapProductsPaginations["*For You"] =
          InfinityScrollPaginationController<Product>(
            maxCapacityCount: 100,
            onDemandPageCall:
                ({
                  required onAddPage,
                  required onDemandPage,
                  required onError,
                }) async {
                  await handleFutureRequest(
                    futureRequest: () async =>
                        serviceLocator<ProductRepo>().getProducts(
                          ProductQueryParams(
                            categoryId: null,
                            page: onDemandPage.pageNo,
                            limit: onDemandPage.limit,
                          ),
                        ),
                    onSuccess: (data) {
                      onAddPage(
                        PaginationPage(
                          items: data.items,
                          page: onDemandPage.pageNo,
                          limit: onDemandPage.limit,
                        ),
                      );
                    },
                    onError: (error) {
                      onError(
                        PaginationError(
                          message: error.message,
                          page: onDemandPage.pageNo,
                        ),
                      );
                    },
                  );
                },
          );
    
    for (int index = 0; index < _categoryPagination.length; index++) {
      final category = _categoryPagination.itemAt(index);
      if (category == null) continue;

      _tapProductsPaginations[category.id] =
          InfinityScrollPaginationController<Product>(
            maxCapacityCount: 100,
            onDemandPageCall:
                ({
                  required onAddPage,
                  required onDemandPage,
                  required onError,
                }) async {
                  await handleFutureRequest(
                    futureRequest: () async =>
                        serviceLocator<ProductRepo>().getProducts(
                          ProductQueryParams(
                            categoryId: category.id,
                            page: onDemandPage.pageNo,
                            limit: onDemandPage.limit,
                          ),
                        ),
                    onSuccess: (data) {
                      onAddPage(
                        PaginationPage(
                          items: data.items,
                          page: onDemandPage.pageNo,
                          limit: onDemandPage.limit,
                        ),
                      );
                    },
                    onError: (error) {
                      onError(
                        PaginationError(
                          message: error.message,
                          page: onDemandPage.pageNo,
                        ),
                      );
                    },
                  );
                },
          );
    
    }
    _tabController = TabController(
      length: _tapProductsPaginations.length,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return ListenableBuilder(
      listenable: _categoryPagination,
      builder: (context, child) {
        debugPrint("State: ${_categoryPagination.state.value}");
        bool isLoading =
            _categoryPagination.state.value == PaginationLoadState.refreshing ||
            (_categoryPagination.state.value == PaginationLoadState.loading &&
                _categoryPagination.length == 0);

        if (isLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (_categoryPagination.state.value == PaginationLoadState.error &&
            _categoryPagination.length == 0) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(_error!),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: () => _categoryPagination.refresh(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          );
        }

        _setTabController();

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
                      onSearchPressed: () {},
                    ),
                  ),
                ),
                SliverPersistentHeader(
                  pinned: true,
                  delegate: _AdaptiveTabBarHeader(
                    tabController: controller,
                    tabs: _tapProductsPaginations.keys.toList(),
                  ),
                ),
              ];
            },
            body: TabBarView(
              controller: controller,
              children: _tapProductsPaginations.entries.map(
                (entry) {
                  return _TabProductGrid(
                    key: ValueKey('tab-${entry.key}'),
                    pagination: _tapProductsPaginations[entry.key]!,
                  );
                }).toList(),
            ),
          ),
        );
      },
    );
  }
}

class _TabProductGrid extends StatefulWidget {
  const _TabProductGrid({super.key, required this.pagination});

  final PaginationEngine<Product> pagination;

  @override
  State<_TabProductGrid> createState() => _TabProductGridState();
}

class _TabProductGridState extends State<_TabProductGrid>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    widget.pagination.refresh();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return PaginatedGridView(
      pagination: widget.pagination,
      skeleton: const Center(child: CircularProgressIndicator()),
      skeletonCount: 1,
      gridDelegate: sliverGridDelegateConfig(),
      itemBuilder: (index, data) {
        return Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: SizedBox(
            height: 120,
            width: 120,
            child: ProductCard(product: data),
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
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
                  onTapOutside: (event) => FocusScope.of(context).unfocus(),
                  controller: searchController,
                  textInputAction: TextInputAction.search,
                  onSubmitted: (_) => onSearchPressed(),

                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                    hintText: 'Search products',
                    isDense: true,
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: const Icon(Icons.search_rounded),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.redAccent, width: 2),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.redAccent, width: 2),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.redAccent, width: 2),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.redAccent, width: 1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
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
