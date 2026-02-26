
import 'package:flutter/material.dart';
import 'package:scroll_challenge/src/core/packages/pagination_pkg/lib/src/pagination_controller.dart';
import 'package:scroll_challenge/src/core/shared/widget/paginated_grid.dart';
import '../../../../core/shared/product_card/product_grid_tile.dart';
import '../../model/product/product.dart';

class ProductGridView extends StatefulWidget {
  
  final SinglePagePaginationController<Product> productPaginationController;
  const ProductGridView({
    super.key,
    required this.productPaginationController,
  });

  @override
  State<ProductGridView> createState() => _ProductGridViewState();
}

class _ProductGridViewState extends State<ProductGridView> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PaginatedGridView<Product>(
      pagination: widget.productPaginationController,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 0.7,
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
          height: 140,
          width: 140,
          child: ProductGridTile(product: product),
        );
      },
      
    );
  }
}
