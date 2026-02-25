

import 'pagination_mem.dart';

class InfinityScrollPaginationMem<T> extends PaginationMem<T>{
  InfinityScrollPaginationMem({required super.perPageLimit, required super.onMemUpdate, required this.maxCapacity});
  final int maxCapacity;
  int _removedFromFront = 0;
  final List<T> _items = [];
  
  @override
  void addFrontPage(List<T> items) {
    // Base case
    _items.insertAll(0, items);
    // Update removed from front
    _removedFromFront -= items.length.clamp(0, _removedFromFront); // This clamp prevents negative value assignment
    onMemUpdate();
  }

  @override
  void addNextPage(List<T> items) {
    _items.addAll(items);
    onMemUpdate();
  }

  @override
  void clear() {
    _items.clear();
  }

  @override
  void deleteItemAt(int index) {
    _items.removeAt(index);
    onMemUpdate();
  }

  @override
  T? get first => _items.isEmpty ? null : _items.first;

  @override
  bool get isEmpty => _items.isEmpty;

  @override
  T? itemAt(int index) {
    if(_items.isEmpty) {
      return null;
    }
    return _items[index];
  }

  @override
  T? get last => _items.isEmpty ? null : _items.last;

  @override
  int get length => _items.length;

  @override
  int get nextPageToFetch => _items.length ~/ perPageLimit;

  @override
  // TODO: implement previousPageToFetch
  int get previousPageToFetch => throw UnimplementedError();

  @override
  void updateItemAt(int index, T item) {
    if(!_isOutOfBound(index)) {
      _items[index] = item;
    }
  }

  /// Returns true if index is out of bound and you should not use that index to read data from the list.
  /// 
  /// Else returns false
  bool _isOutOfBound(int index) {
    if(index < 0 || index >= _items.length) return true;
    return false;
  }
}