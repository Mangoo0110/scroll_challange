import 'package:flutter/material.dart';
import 'package:pagination_pkg/pagination_pkg.dart';
import '../../../../core/shared/widget/paginated_list.dart';
import '../../model/product/product.dart';
import '../widgets/product_grid_tile.dart';

class ProductListView extends StatelessWidget {
  final Axis scrollDirection;
  final bool isPaginated;
  final InfinityScrollPaginationController<String, Product> productsPagination;
  const ProductListView({
    super.key,
    required this.scrollDirection,
    this.isPaginated = false,
    required this.productsPagination,
  });

  @override
  Widget build(BuildContext context) {
    return PaginatedListWidget(
      isPaginated: isPaginated,
      pagination: productsPagination,
      skeleton: CircularProgressIndicator(
        color: Theme.of(context).primaryColor,
      ),
      skeletonCount: 1,
      scrollDirection: scrollDirection,
      builder: (index, product) => Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: SizedBox(
          height: 120,
          width: 120,
          child: ProductGridTile(product: product),
        ),
      ),
    );
  }
}
