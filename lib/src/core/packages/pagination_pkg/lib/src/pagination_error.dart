class PaginationError {
  final int page;
  final String message;
  /// If critical, means previous data is not valid anymore and should be cleared. 
  /// If not critical, previous data is still valid and new data will be added to it.
  final bool isCritical;
  PaginationError({required this.page, required this.message, this.isCritical = false});
}