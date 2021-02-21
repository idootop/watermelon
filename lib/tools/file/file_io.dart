import 'dart:io';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';

class FileTool {
  static Future<Uint8List> read(String path) async {
    final directory = await getApplicationDocumentsDirectory();
    var file = File(directory.path + path);
    if (!await file.exists()) return null;
    return await file.readAsBytes();
  }

  static Future<void> write(String path, Uint8List bytes) async {
    final directory = await getApplicationDocumentsDirectory();
    var file = File(directory.path + path);
    if (!await file.exists()) {
      file = await file.create(recursive: true);
    }
    await file.writeAsBytes(bytes, flush: true);
  }

  static Future<void> delete(String path) async {
    final directory = await getApplicationDocumentsDirectory();
    var file = File(directory.path + path);
    if (!await file.exists()) return;
    file.deleteSync();
  }
}
