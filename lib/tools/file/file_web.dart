import 'dart:typed_data';

import '../hive_tool.dart';
import '../image/ui_image_tool.dart';

class FileTool {
  static Future<Uint8List> read(String path) async {
    if (!HiveTool().inited) await HiveTool().init();
    final value = await HiveTool().box.get(path);
    if (value == null) return null;
    return (value as String).toBytes();
  }

  static Future<void> write(String path, Uint8List bytes) async {
    if (!HiveTool().inited) await HiveTool().init();
    await HiveTool().box.put(path, bytes.toBase64());
  }

  static Future<void> delete(String path) async {
    if (!HiveTool().inited) await HiveTool().init();
    await HiveTool().box.delete(path);
  }
}
