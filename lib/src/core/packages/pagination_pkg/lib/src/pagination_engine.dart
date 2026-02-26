
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pagination_pkg/src/pagination_error.dart';
import '../debouncer.dart';
import 'cache/pagination_mem.dart';
import 'pagination_page.dart';

enum PaginationLoadState {
  idle,
  loading,
  refreshing,
  loaded,
  allLoaded,
  nopages,
  error
}

sealed class OnDemandPage<T> {
  final T? cursor;
  final int limit;
  final int pageNo;
  OnDemandPage({required this.limit, required this.pageNo, this.cursor});
}

class LoadNextPage<T> extends OnDemandPage<T> {
  LoadNextPage({required super.limit, required super.pageNo, super.cursor});
}

class LoadPreviousPage<T> extends OnDemandPage<T> {
  LoadPreviousPage({required super.limit, required super.pageNo, super.cursor});
}


typedef OnAddPage<T> = void Function(PaginationPage<T> page);
typedef OnError = void Function(PaginationError error);


class PaginationEngine<T> extends ChangeNotifier{
  
  PaginationEngine({ List<T>? items, required PaginationMem<T> mem, required this.onDemandPageCall, this.perPageLimit = 10}) : _mem = mem {
    if(items != null) _mem.addNextPage(items);
  }
  
  /// Cache memory
  final PaginationMem<T> _mem;

  final Function({required OnDemandPage<T> onDemandPage, required OnAddPage<T> onAddPage, required OnError onError}) onDemandPageCall;

  final ValueNotifier<PaginationLoadState> _state = ValueNotifier(PaginationLoadState.idle);
  final ValueNotifier<String> searchText = ValueNotifier('');

  ValueNotifier<PaginationLoadState> get state => _state;

  /// Default is set to 10 by the constructor.
  /// This is the number of items to be fetched per page. You should maintain this number. If you return more they will be added to the next page
  /// or previous page or skipped depending on the situation.
  final int perPageLimit;
  Debouncer debouncer = Debouncer(milliseconds: 1000);

  DateTime _lastFetchTime = DateTime.now();

  int get totalItemsCount => _mem.length;

  T? itemAt(int index) => _mem.itemAt(index);

  int get length => _mem.length;

  void deleteItemAt(int index) => _mem.deleteItemAt(index);

  void updateItemAt(int index, T item) => _mem.updateItemAt(index, item);

  Future<PaginationPage<T>?> requestData({
    required OnDemandPage<T> onDemandPage,
  }) async{

    PaginationPage<T>? page;
    debugPrint("Fetching page: ${onDemandPage.pageNo}");
    await onDemandPageCall( 
      onDemandPage: onDemandPage,
      onAddPage: (p) {
        page = p;
      },
      onError: (error) => setError(error: error),
    );

    _lastFetchTime = DateTime.now();
    return page;
  }

  void search(String text) async{
    if( state.value == PaginationLoadState.refreshing) {
      return;
    }
    searchText.value = text;
    setRefresh();
  
    final page = await requestData(
      onDemandPage: LoadNextPage<T>(
        limit: perPageLimit,
        pageNo: 1,
        cursor: null,
      ),
    );

    if(page != null) {
      debugPrint("Adding items: ${page.items.length}");
      _mem.addNextPage(page.items);
      state.value = PaginationLoadState.loaded;
    } else {
      debugPrint("No items to add");
    }
    notifyListeners();
  }

  /// Sets the state to [PaginationLoadState.refreshing]
  /// Clears the [PaginationMem]
  /// 
  /// Triggers [notifyListeners], as memory along with state has changed
  void setRefresh() {
    _mem.clear();
    state.value = PaginationLoadState.refreshing;
    notifyListeners();
  }

  /// Sets the state to [PaginationLoadState.loading]
  /// #### NOTE: This does not trigger [notifyListeners]
  setError({PaginationError? error}) {
    state.value = PaginationLoadState.error;
  }

  /// Sets the state to [PaginationLoadState.loading]
  /// #### NOTE: This does not trigger [notifyListeners]
  void setLoading() {
    state.value = PaginationLoadState.loading;
  }

  /// Triggers [notifyListeners]
  void setNoPages() {
    state.value = PaginationLoadState.nopages;
    notifyListeners();
  }
  
  /// Checks if current state is [PaginationLoadState.allLoaded] or [PaginationLoadState.nopages] and last fetch time is less than 3.5 minutes
  bool _shouldTryLoadMore() {
    if((state.value == PaginationLoadState.allLoaded || state.value == PaginationLoadState.nopages) && _lastFetchTime.difference(DateTime.now()).inMilliseconds.abs() < (1000 * 60 * 3.5)) {
      debugPrint("Should not try to load more.. ${_lastFetchTime.difference(DateTime.now()).inMilliseconds.abs()}ms and state: ${state.value}");
      return false;
    }
    return true;
  }

  Future<void> loadNextPage() async{
    if(!_shouldTryLoadMore()) {
      return;
    }
    
    state.value = PaginationLoadState.loading;
    final res = await requestData(
      onDemandPage: LoadNextPage(
        limit: perPageLimit,
        pageNo: _mem.nextPageToFetch,
        cursor: _mem.last,
      ),
    );

    _mem.addNextPage(res?.items ?? []);
    if(res?.items.isEmpty ?? false) {
      state.value = PaginationLoadState.allLoaded;
    } else {
      state.value = PaginationLoadState.loaded;
    }
    notifyListeners();
  }



  Future<void> loadPreviousPage() async{
    if(!_shouldTryLoadMore() || (_mem.previousPageToFetch < _mem.firstPageVal)) {
      return;
    }

    debugPrint("Previous page(${_mem.previousPageToFetch}) in demand...");

    final res = await requestData(
      onDemandPage: LoadPreviousPage(
        limit: perPageLimit,
        pageNo: _mem.previousPageToFetch,
        cursor: _mem.first,
      ),
    );

    _mem.addFrontPage(res?.items ?? []);
  }

  Future<void> refresh() async{
    print("Refreshing...");
    search(searchText.value);
  }

  @override
  void dispose() {
    super.dispose();
    _mem.clear();
    _state.dispose();
    searchText.dispose();
  }
}