import '../model/category.dart';
import 'package:async_handler/async_handler.dart';

abstract class CategoryRepo {
  AsyncRequest<List<Category>> getCategories({bool onlyActive = true});

  AsyncRequest<Category?> getCategoryById(String id);

  AsyncRequest<List<Category>> searchCategories(String query,
      {bool onlyActive = true});
}
