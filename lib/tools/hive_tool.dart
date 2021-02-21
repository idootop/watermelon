import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class HiveTool {
  factory HiveTool() => _singleton;
  HiveTool._();
  static final HiveTool _singleton = HiveTool._();

  Box box;
  String boxName = 'app';

  bool get inited => box != null;

  Future<void> init() async {
    if (kIsWeb) {
      //nothing
    } else {
      final directory = await getApplicationDocumentsDirectory();
      Hive.init(directory.path);
    }
    box = await Hive.openBox(boxName);
  }

  Future<T> get<T>(String key) async {
    if (!inited) await HiveTool().init();
    final value = await HiveTool().box.get(key);
    return value as T;
  }

  Future<void> set<T>(String key, T value) async {
    if (!HiveTool().inited) await HiveTool().init();
    await HiveTool().box.put(key, value);
  }
}
