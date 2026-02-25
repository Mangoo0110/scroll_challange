
import 'package:flutter/material.dart';


/// Page starts from 1.
abstract class PaginationMem<T> {
  PaginationMem({required this.perPageLimit, required this.onMemUpdate});

  final int perPageLimit;
  final int firstPageVal = 1;

  // Implementors should call this method upon changes in the mem, so that listeners can be notified
  /// Notify listeners for ui updates
  VoidCallback onMemUpdate;

  /// Add next page
  void addNextPage(List<T> items);

  /// Add front page
  void addFrontPage(List<T> items);

  /// Delete item at index
  void deleteItemAt(int index);

  /// Update item at index
  void updateItemAt(int index, T item);

  /// Returns total number of items
  int get length;

  /// Returns item at index
  T? itemAt(int index);

  /// Returns last item
  T? get last;

  /// Returns first item
  T? get first;

  /// Returns true if mem is empty
  bool get isEmpty;

  /// Page number to fetch
  int get nextPageToFetch;

  /// Page number to fetch
  int get previousPageToFetch;

  void clear();
}


