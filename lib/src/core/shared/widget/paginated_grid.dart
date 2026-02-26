import 'package:pagination_pkg/pagination_pkg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:scroll_challenge/src/core/utils/utils.dart';

class PaginatedGridView<T> extends StatefulWidget {
  final PaginationEngine<T> pagination;

  /// Widget shown as skeleton cell (provided by the caller)
  final Widget skeleton;

  /// How many skeletons to show when loading / refreshing
  final int skeletonCount;

  final String emptyMessage;

  /// Caller decides how each grid item looks
  final Widget Function(int index, T data) itemBuilder;

  /// Caller decides the grid layout
  final SliverGridDelegate gridDelegate;

  /// Optional: control scroll physics
  final ScrollPhysics? physics;

  /// Optional: padding for the grid
  final EdgeInsetsGeometry? padding;

  /// Optional: if you use this inside another scroll view (like your List version),
  /// keep it non-scrollable. Default matches your List behavior.
  final bool shrinkWrap;
  final bool disableScroll;

  const PaginatedGridView({
    super.key,
    required this.pagination,
    required this.skeleton,
    required this.skeletonCount,
    required this.itemBuilder,
    required this.gridDelegate,
    this.emptyMessage = "No data found",
    this.physics,
    this.padding,
    this.shrinkWrap = true,
    this.disableScroll = true,
  });

  @override
  State<PaginatedGridView<T>> createState() => _PaginatedGridViewState<T>();
}

class _PaginatedGridViewState<T> extends State<PaginatedGridView<T>> {
  static const double _loadMoreThreshold = 200.0;
  final ScrollController scrollController = ScrollController();

  // void _maybeLoadMore() {
  //   if (!scrollController.hasClients) return;
  //   final position = scrollController.position;
  //   if (position.extentAfter <= _loadMoreThreshold) {
  //     widget.pagination.loadNextPage();
  //   }
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // scrollController.addListener(_maybeLoadMore);
    // WidgetsBinding.instance.addPostFrameCallback((_) => _maybeLoadMore());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.pagination,
      builder: (context, _) {
        final state = widget.pagination.state.value;
        debugPrint("State: $state");
    
        if (state == PaginationLoadState.nopages) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(child: Text(widget.emptyMessage)),
              IconButton(
                onPressed: widget.pagination.refresh,
                icon: const Icon(Icons.refresh),
              ),
            ],
          ).animate().fadeIn(duration: 300.ms);
        }
    
        final itemCount = widget.pagination.totalItemsCount;
        debugPrint("Total items: ${widget.pagination.totalItemsCount}");
        return NotificationListener<ScrollNotification>(
          onNotification: (notification) {
            if (notification.metrics.axis != Axis.vertical) return false;

            final state = widget.pagination.state.value;
            final canLoad =
                state != PaginationLoadState.loading &&
                state != PaginationLoadState.refreshing &&
                state != PaginationLoadState.allLoaded &&
                state != PaginationLoadState.nopages;

            if (canLoad && notification.metrics.extentAfter < 250) {
              widget.pagination.loadNextPage();
            }
            return false;
          },
          child: CustomScrollView(
            primary: true,
            //controller: scrollController,
            physics: widget.physics,
            slivers: [
              SliverGrid.builder(
                // padding: widget.padding,
                // shrinkWrap: widget.shrinkWrap,
                // physics: widget.disableScroll
                //     ? const NeverScrollableScrollPhysics()
                //     : (widget.physics ?? const AlwaysScrollableScrollPhysics()),
                gridDelegate: widget.gridDelegate,
                itemCount: itemCount,
                itemBuilder: (context, index) {
                  final isFooter =
                      index == widget.pagination.totalItemsCount - 1;
              
                  // Footer: Loading/Refreshing => show skeleton tiles
                  // if (isFooter &&
                  //     (state == PaginationLoadState.loading ||
                  //         state == PaginationLoadState.refreshing)) {
                  //   return _SkeletonGrid(
                  //     skeleton: widget.skeleton,
                  //     count: widget.skeletonCount,
                  //   ).animate().fadeIn(duration: 300.ms);
                  // }
              
                  // Footer: All loaded => show "End"
              
                  // Normal grid item
                  if (!isFooter) {
                    final element = widget.pagination.itemAt(index);
                    if (element == null) {
                      return const SizedBox.shrink();
                    }
                    return widget
                        .itemBuilder(index, element)
                        .animate()
                        .slideY(
                          begin: 0.1,
                          end: 0,
                          duration: 300.ms,
                          curve: Curves.easeOutCubic,
                        )
                        .fadeIn(duration: 300.ms, curve: Curves.easeOutCubic);
                  }
              
                  // Footer: default empty space (when not loading / not allLoaded)
                  return Container(child: const SizedBox.shrink());
                },
              ),
              SliverToBoxAdapter(
                child: Container(
                  //color: Colors.amber,
                  height: 150,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: ValueListenableBuilder(
                      valueListenable: widget.pagination.state,
                      builder: (context, value, child) {
                        debugPrint("load end indication state ${value.name}");
                        if (value == PaginationLoadState.allLoaded) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "End of the page",
                              style: const TextStyle(
                                fontStyle: FontStyle.normal,
                                fontSize: 14,
                                color: Colors.grey,
                              ).bold,
                            ),
                          ).animate().fadeIn(duration: 300.ms);
                        } else if (value == PaginationLoadState.loading ||
                            value == PaginationLoadState.refreshing) {
                          return Center(
                            child: SizedBox(
                              height: 30,
                              width: 30,
                              child: CircularProgressIndicator(
                                strokeWidth: 4,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                          );
                        }
                        return Container();
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

/// A helper that renders N skeletons in a grid-friendly way.
/// This is returned as ONE grid tile; it uses a Wrap to visually look like multiple cells.
class _SkeletonGrid extends StatelessWidget {
  final Widget skeleton;
  final int count;

  const _SkeletonGrid({required this.skeleton, required this.count});

  @override
  Widget build(BuildContext context) {
    // This tile will occupy exactly one grid cell.
    // Inside it, we show multiple skeletons vertically.
    // If you want them to look like multiple grid cells, see note below.
    return Column(
      children: List.generate(
        count,
        (i) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: skeleton,
        ),
      ),
    );
  }
}
