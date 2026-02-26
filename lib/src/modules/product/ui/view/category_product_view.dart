
import 'package:flutter/material.dart';
import 'package:scroll_challenge/src/core/packages/pagination_pkg/lib/pagination_pkg.dart';
import '../../../../core/shared/widget/paginated_grid.dart';
import '../../../../core/shared/product_card/product_grid_tile.dart';
import '../../model/product/product.dart';

class CategoryProductView extends StatefulWidget {
  final String title;
  final SinglePagePaginationController<Product> productPagination;
  const CategoryProductView({
    super.key,
    required this.title,
    required this.productPagination,
  });

  @override
  State<CategoryProductView> createState() => _CategoryProductViewState();
}

class _CategoryProductViewState extends State<CategoryProductView> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: PaginatedGridView<Product>(
        physics: AlwaysScrollableScrollPhysics(),
        pagination: widget.productPagination,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 180,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          childAspectRatio: .7,
        ),
        skeleton: SizedBox(
          height: 100,
          width: double.infinity,
          child: SizedBox(
            height: 30,
            width: 30,
            child: CircularProgressIndicator(
              strokeWidth: 3,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
        skeletonCount: 1,
        itemBuilder: (index, product) {
          return SizedBox(
            height: 120,
            width: 120,
            child: ProductGridTile(product: product),
          );
        },
        
      ),
    );
  }
}
