class PaginationPage<T> {
  final List<T> items;
  final int page;
  final int limit;
  

  PaginationPage({
    required this.items,
    required this.page,
    required this.limit,
  });

  int get total => items.length;

  bool get hasMore => page * limit < total;

  @override
  String toString() {
    return 'PaginationPage(items: $items, page: $page, limit: $limit, total: $total)';
  }
}