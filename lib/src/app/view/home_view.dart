import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pagination_pkg/pagination_pkg.dart';
import 'package:scroll_challenge/src/app/widget/search_input.dart';
import 'package:scroll_challenge/src/core/shared/widget/paginated_grid.dart';
import 'package:scroll_challenge/src/app/helpers/pagination_response_converter.dart';
import 'package:scroll_challenge/src/modules/category/model/category.dart';
import 'package:scroll_challenge/src/modules/category/repo/category_repo.dart';

import '../../core/di/repo_di.dart';
import '../widget/product_card/product_card.dart';
import '../../core/utils/utils.dart';
import '../../modules/product/model/product/product.dart';
import '../../modules/product/repo/product_repo.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with TickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();

  late final InfinityScrollPaginationController<String, Category>
  _categoryPagination;
  final Map<String, InfinityScrollPaginationController<String, Product>>
  _tapProductsPaginations = {};

  TabController? _tabController;
  String? _error;

  @override
  void initState() {
    super.initState();
    _categoryPagination = InfinityScrollPaginationController<String, Category>(
      maxCapacityCount: 10000,
      onDemandPageCall: ({required onDemandPage}) async {
        final res = await serviceLocator<CategoryRepo>().getCategories();
        return res.toCategoryPaginationResponse(onDemandPage: onDemandPage);
      },
    );
    _categoryPagination.refresh();
    _categoryPagination.addListener(_decideProductTabSetup);
  }

  _decideProductTabSetup() {
    if (_categoryPagination.state.value == PaginationLoadState.loaded) {
      _setTabController();
    } else if (_categoryPagination.state.value == PaginationLoadState.error) {
      _error = "Failed to load categories. Please try again.";
      setState(() {});
    }
  }

  _setTabController() {
    _tapProductsPaginations["*For You"] =
        InfinityScrollPaginationController<String, Product>(
          maxCapacityCount: 100,
          onDemandPageCall: ({required onDemandPage}) async {
            final res = await serviceLocator<ProductRepo>().getProducts(
              ProductQueryParams(
                categoryId: null,
                page: onDemandPage.pageNo,
                limit: onDemandPage.limit,
              ),
            );
            return res.toProductPaginationResponse(onDemandPage: onDemandPage);
          },
        );

    for (int index = 0; index < _categoryPagination.length; index++) {
      final category = _categoryPagination.itemAt(index);
      if (category == null) continue;
      _tapProductsPaginations[category
          .id] = InfinityScrollPaginationController<String, Product>(
        maxCapacityCount: 100,
        onDemandPageCall: ({required onDemandPage}) async {
          final res = await serviceLocator<ProductRepo>().getProducts(
            ProductQueryParams(
              categoryId: category.id,
              page: onDemandPage.pageNo,
              limit: onDemandPage.limit,
            ),
          );
          return res.toProductPaginationResponse(onDemandPage: onDemandPage);
        },
      );
    }

    // Initialize the TabController after setting up the paginations for all tabs
    _tabController = TabController(
      length: _tapProductsPaginations.length,
      vsync: this,
    );

    // Updates ui with new tabs and their paginations
    setState(() {});
  }

  Future<void> _handleRefresh() async {
    await _categoryPagination.refresh();
    for (final controller in _tapProductsPaginations.values) {
      await controller.refresh();
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _tabController?.dispose();
    _categoryPagination.removeListener(_decideProductTabSetup);
    _categoryPagination.dispose();
    _tapProductsPaginations.forEach((_, controller) => controller.dispose());
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
        final controller =
            _tabController; // Referencing the controller here to ensure it's initialized before use and reference not removed by outside operations
        if (controller == null) {
          return const SizedBox.shrink();
        }
        final nested = RefreshIndicator(
          onRefresh: _handleRefresh,
          triggerMode: RefreshIndicatorTriggerMode.onEdge,
          edgeOffset: 0,
          notificationPredicate: (notification) => notification.depth == 2,
          child: NestedScrollView(
            physics: BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()
            ),
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                // CupertinoSliverRefreshControl(
                //   onRefresh: _handleRefresh,
                //   builder: (context, refreshState, pulledExtent, refreshTriggerPullDistance, refreshIndicatorExtent) {
                //     return Padding(
                //       padding: const EdgeInsets.only(top: 100),
                //       child: CupertinoSliverRefreshControl.buildRefreshIndicator(
                //         context,
                //         refreshState,
                //         pulledExtent,
                //         refreshTriggerPullDistance,
                //         refreshIndicatorExtent,
                //       ),
                //     );
                //   },
                // ),
                // CupertinoSliverRefreshControl(
                //   refreshTriggerPullDistance: 110,
                //   refreshIndicatorExtent: 80,
                //   onRefresh: _handleRefresh,
                //   builder: (context, mode, pulledExtent, _, __) {
                //     final progress = (pulledExtent / 110).clamp(0.0, 1.0);
                //     return _DarazRefreshIndicator(
                //       mode: mode,
                //       progress: progress,
                //     );
                //   },
                // ),
          
                SliverSafeArea(
                  bottom: false,
                  sliver: SliverToBoxAdapter(
                    child: _HomeHeader(
                      searchController: _searchController,
                      onSearchPressed: () {},
                    ),
                  ),
                ),
                
                SliverOverlapAbsorber(
                  handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                    context,
                  ),
                  sliver: SliverPersistentHeader(
                    pinned: true,
                    delegate: _AdaptiveTabBarHeader(
                      tabController: controller,
                      tabs: _tapProductsPaginations.keys.toList(),
                    ),
                  ),
                ),
              ];
            },
            body: TabBarView(
              controller: controller,
              children: _tapProductsPaginations.entries.map((entry) {
                return _TabProductGrid(
                  key: ValueKey('tab-${entry.key}'),
                  tabId: entry.key,
                  pagination: _tapProductsPaginations[entry.key]!,
                );
              }).toList(),
            ),
          ),
        );

        return Scaffold(body: nested);
      },
    );
  }
}

class _TabProductGrid extends StatefulWidget {
  const _TabProductGrid({
    super.key,
    required this.tabId,
    required this.pagination,
  });

  final String tabId;
  final PaginationEngine<String, Product> pagination;

  @override
  State<_TabProductGrid> createState() => _TabProductGridState();
}

class _TabProductGridState extends State<_TabProductGrid> {
  @override
  void initState() {
    super.initState();
    if (widget.pagination.isEmplty) widget.pagination.refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final overlapHandle = NestedScrollView.sliverOverlapAbsorberHandleFor(
          context,
        );
        return PaginatedGridView(
          scrollViewKey: PageStorageKey<String>(
            'products-scroll-${widget.tabId}',
          ),
          overlapHandle: overlapHandle,
          pagination: widget.pagination,
          skeleton: const Center(child: CircularProgressIndicator()),
          skeletonCount: 1,
          gridDelegate: sliverGridDelegateConfig1(),
          itemBuilder: (index, data) {
            return Padding(
              padding: const EdgeInsets.only(right: 2.0),
              child: ProductCard(product: data),
            );
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
                child: SearchInput(
                  controller: searchController,
                  onSubmitted: onSearchPressed,
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
  double get maxExtent => 54;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final range = (maxExtent - minExtent).clamp(1.0, double.infinity);
    final progress = (shrinkOffset / range).clamp(0.0, 1.0);
    final currentHeight = (maxExtent - shrinkOffset).clamp(
      minExtent,
      maxExtent,
    );
    final bg = Color.lerp(const Color(0xFFF2F2F2), Colors.white, progress)!;
    final indicatorColor = Theme.of(context).colorScheme.primary;

    return SizedBox(
      height: currentHeight,
      child: ColoredBox(
        color: bg,
        child: Align(
          alignment: Alignment.bottomLeft,
          child: TabBar(
            controller: tabController,
            isScrollable: true,
            indicatorSize: TabBarIndicatorSize.label,
            dividerColor: Colors.transparent,
            labelStyle: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 12,
            ),
            unselectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
            labelColor: indicatorColor,
            unselectedLabelColor: const Color(0xFF5F5F5F),
            indicatorPadding: EdgeInsets.zero,
            padding: EdgeInsets.zero,
            indicator: DarazIndicator(
              progress: progress,
              color: indicatorColor,
              horizontalInset: 0,
            ),
            tabs: tabs
                .map(
                  (label) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Tab(text: label),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(covariant _AdaptiveTabBarHeader oldDelegate) {
    return oldDelegate.tabController != tabController ||
        oldDelegate.tabs != tabs;
  }
}

class _DarazRefreshIndicator extends StatelessWidget {
  const _DarazRefreshIndicator({required this.mode, required this.progress});

  final RefreshIndicatorMode mode;
  final double progress;

  @override
  Widget build(BuildContext context) {
    final bool isRefreshing = mode == RefreshIndicatorMode.refresh;
    final bool isArmed = mode == RefreshIndicatorMode.armed;
    final bgColor = const Color(0xFFF5EEE8);

    String text;
    if (isRefreshing) {
      text = 'Refreshing...';
    } else if (isArmed) {
      text = 'Release to refresh';
    } else {
      text = 'Pull to refresh';
    }

    return Container(
      color: bgColor,
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.only(bottom: 10),
      child: Opacity(
        opacity: (progress * 1.25).clamp(0.0, 1.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: 42,
              width: 42,
              decoration: BoxDecoration(
                color: Colors.orange,
                shape: BoxShape.circle,
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x22000000),
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: isRefreshing
                  ? const Padding(
                      padding: EdgeInsets.all(10),
                      child: CircularProgressIndicator(
                        strokeWidth: 2.4,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : Icon(
                      isArmed
                          ? Icons.keyboard_double_arrow_down_rounded
                          : Icons.keyboard_arrow_down_rounded,
                      color: Colors.white,
                      size: 24,
                    ),
            ),
            const SizedBox(height: 10),
            Text(
              text,
              style: const TextStyle(
                fontSize: 13.5,
                color: Color(0xFF8C8C8C),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DarazIndicator extends Decoration {
  const DarazIndicator({
    required this.progress,
    this.color = Colors.orange,
    this.thickness = 3,
    this.horizontalInset = 8,
  });

  final double progress; // 0 => unpinned bubble, 1 => pinned underline
  final Color color;
  final double thickness;
  final double horizontalInset;

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _DarazIndicatorPainter(this);
  }
}

class _DarazIndicatorPainter extends BoxPainter {
  _DarazIndicatorPainter(this.decoration);
  final DarazIndicator decoration;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration cfg) {
    final size = cfg.size;
    if (size == null) return;

    final p = decoration.progress.clamp(0.0, 1.0);

    final leftX = offset.dx + decoration.horizontalInset;
    final rightX = offset.dx + size.width - decoration.horizontalInset;
    final bottomY = offset.dy + size.height;
    final topY =
        offset.dy + lerpDouble(8, bottomY - 4 - decoration.thickness, p)!;

    // Unpinned bubble shape (with bottom notch-ish edges).
    final notchishIndicatorPath = Path()
      ..addRect(
        Rect.fromPoints(Offset(-10000, bottomY - 8), Offset(10000, bottomY)),
      )
      ..moveTo(leftX - 20, bottomY - 8)
      ..arcToPoint(
        Offset(leftX - 10, bottomY - 16),
        radius: const Radius.circular(16),
        clockwise: false,
      )
      ..lineTo(leftX, topY + 8)
      ..arcToPoint(
        Offset(leftX + 8, topY),
        radius: const Radius.circular(16),
        clockwise: true,
      )
      ..lineTo(rightX - 8, topY)
      ..arcToPoint(
        Offset(rightX, topY + 8),
        radius: const Radius.circular(16),
        clockwise: true,
      )
      ..lineTo(rightX + 10, bottomY - 16)
      ..arcToPoint(
        Offset(rightX + 20, bottomY - 8),
        radius: const Radius.circular(16),
        clockwise: false,
      );

    final bubblePaint = Paint()
      ..color = Colors.white.withValues(alpha: 1.0 - p)
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;

    // Pinned slim underline.
    final lineY = bottomY - 2;
    final underlinePath = Path()
      ..moveTo(leftX + 2, lineY)
      ..lineTo(rightX - 2, lineY);

    final underlinePaint = Paint()
      ..color = decoration.color.withValues(alpha: p)
      ..style = PaintingStyle.stroke
      ..strokeWidth = lerpDouble(2.0, decoration.thickness, p)!
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..isAntiAlias = true;

    canvas.drawPath(notchishIndicatorPath, bubblePaint);
    canvas.drawPath(underlinePath, underlinePaint);
  }
}
