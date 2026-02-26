import 'package:flutter/material.dart';
import 'package:scroll_challenge/src/core/packages/async_handler/lib/async_handler.dart';
import 'package:scroll_challenge/src/core/di/repo_di.dart';
import 'package:scroll_challenge/src/core/shared/reactive_notifier/process_notifier.dart';
import 'package:scroll_challenge/src/core/shared/reactive_notifier/snackbar_notifier.dart';
import '../../../../core/utils/helpers/handle_future_request.dart';
import '../../model/category.dart';
import '../../repo/category_repo.dart';

class CategoryView extends StatefulWidget {
  const CategoryView({super.key});

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  final CategoryRepo _repo = serviceLocator<CategoryRepo>();
  final ValueNotifier<List<Category>> _categories =
      ValueNotifier<List<Category>>([]);
  final ProcessStatusNotifier _status = ProcessStatusNotifier(
    initialStatus: ProcessLoading(message: 'Loading'),
  );

  final List<Color> _tileColors = const [
    Color(0xffedefea),
    Color(0xfff0e2d9),
    Color(0xffffe8cc),
    Color(0xFFF1E5F5),
    Color(0xffd5e5da),
    Color(0xFFF9E1E1),
    Color(0xFFF7E3C9),
    Color(0xFFEFE5F6),
    Color(0xFFE2F0F7),
    Color(0xFFF5E1E8),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadCategories());
  }

  AsyncRequest<List<Category>> _fetchCategories() {
    return _repo.getCategories();
  }

  Future<void> _loadCategories() async {
    final snackbarNotifier = SnackbarNotifier(context: context);
    final res = await handleFutureRequest<List<Category>>(
      futureRequest: _fetchCategories,
      processStatusNotifier: _status,
      errorSnackbarNotifier: snackbarNotifier,
      onSuccess: (data) => _categories.value = data,
    );
    if (res == null) {
      _status.setError(message: 'Failed');
    }
  }

  @override
  void dispose() {
    _categories.dispose();
    _status.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Categories'), centerTitle: true),
      body: ListenableBuilder(
        listenable: _status,
        builder: (context, _) {
          if (_status.status is ProcessLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (_status.status is ProcessFailed) {
            return Center(
              child: TextButton(
                onPressed: _loadCategories,
                child: const Text('Retry'),
              ),
            );
          }
          return ValueListenableBuilder<List<Category>>(
            valueListenable: _categories,
            builder: (context, categories, _) {
              if (categories.isEmpty) {
                return const Center(child: Text('No categories found'));
              }
              return GridView.builder(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 96),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 9 / 4.5,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  final color = _tileColors[index % _tileColors.length];
                  return _CategoryTile(
                    category: category,
                    backgroundColor: color,
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

class _CategoryTile extends StatelessWidget {
  const _CategoryTile({required this.category, required this.backgroundColor});

  final Category category;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () {},
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Stack(
              fit: StackFit.passthrough,
              children: [
                // Positioned(
                //   right: 0,
                //   bottom: 0,
                //   top: 0,
                //   child: _CategoryImage(imageUrl: category.imageUrl),
                // ),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: FractionallySizedBox(
                        widthFactor: 0.7,
                        child: Text(
                          category.name,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF2D2D2D),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CategoryImage extends StatelessWidget {
  const _CategoryImage({this.imageUrl});

  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    if (imageUrl == null || imageUrl!.isEmpty) {
      return const SizedBox(
        width: 90,
        child: Center(
          child: Icon(Icons.category_rounded, size: 36, color: Colors.black45),
        ),
      );
    }
    return SizedBox(
      width: 110,
      child: Image.network(
        imageUrl!,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) {
          return const Center(
            child: Icon(Icons.image_not_supported, color: Colors.black45),
          );
        },
      ),
    );
  }
}
