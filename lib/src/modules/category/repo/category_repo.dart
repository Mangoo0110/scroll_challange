import 'package:scroll_challenge/src/core/packages/async_handler/lib/async_handler.dart';
import '../model/category.dart';

abstract class CategoryRepo {
  AsyncRequest<List<Category>> getCategories({bool onlyActive = true});

  AsyncRequest<Category?> getCategoryById(String id);

  AsyncRequest<List<Category>> searchCategories(String query,
      {bool onlyActive = true});
}
