
sealed class PageFetchResponse<T> {
  final int page;
  const PageFetchResponse({required this.page});
}

class PaginationPage<T> extends PageFetchResponse<T> {
  final List<T> items;  

  PaginationPage({
    required this.items,
    required super.page,
  });

  int get total => items.length;


  @override
  String toString() {
      return 'PaginationPage(items: $items, page: $page, total: $total)';
  }
}

class PaginationError<T> extends PageFetchResponse<T> {
  final String message;
  /// If critical, means previous data is not valid anymore and should be cleared. 
  /// If not critical, previous data is still valid and new data will be added to it.
  final bool isCritical;
  PaginationError({required super.page, required this.message, this.isCritical = false});
}