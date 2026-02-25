import 'package:hive_ce/hive.dart';

enum HiveBox {
  user,
  settings,
  tokens,
  onboarding,
  cart,
  cartOps,
}

class HiveService {
  static final HiveService _instance = HiveService._internal();
  factory HiveService() => _instance;
  HiveService._internal();

  final Map<HiveBox, Box> _openedBoxes = {};

  /// Convert enum to proper box name string
  String _boxName(HiveBox box) => box.name;

  /// Must be called once in main()
  Future<void> init(List<Future<void> Function()> registerAdapters) async {
    for (final register in registerAdapters) {
      await register();
    }
  }

  /// Open a box (only once)
  Future<void> openBox(HiveBox box) async {
    final name = _boxName(box);
    if (!_openedBoxes.containsKey(box)) {
      final opened = await Hive.openBox(name);
      _openedBoxes[box] = opened;
    }
  }

  Box _getBox(HiveBox box) {
    if (_openedBoxes.containsKey(box)) {
      return _openedBoxes[box]!;
    }
    throw Exception("Box ${box.name} not opened. Call openBox() first.");
  }

  /// Typed read
  T? get<T>(HiveBox box, String key) {
    return _getBox(box).get(key) as T?;
  }

  /// Typed write
  Future<void> put<T>(HiveBox box, String key, T value) async {
    await _getBox(box).put(key, value);
  }

  /// Delete
  Future<void> delete(HiveBox box, String key) async {
    await _getBox(box).delete(key);
  }

  /// Clear entire box
  Future<void> clear(HiveBox box) async {
    await _getBox(box).clear();
  }
}
