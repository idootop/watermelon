import 'dart:typed_data';
import 'dart:ui';

import '../../game/level/levels.dart';
import '../../game/level/levels_inner.dart';
import '../../tools/cache/image_caches.dart';
import '../file_tool.dart';

import 'ui_image_tool.dart';

class ImageTool {
  static ImageCaches imageCaches = ImageCaches();

  static Future<void> loadAll() async {
    if (!Levels.inited) {
      await Levels.init();
    }
    final levelImages = Levels.kLevels.map((e) => e.image).toList();
    await imageCaches.loadAll([
      'bg.png',
      'shine.png',
      'setting.png',
      'dead_line.png',
      ...levelImages,
      Levels.background,
    ]);
  }

  static Future<void> loadInnerLevels() async {
    if (!Levels.inited) {
      await Levels.init();
    }
    final levelsImages = <String>[];
    LevelsInner.levels.values.forEach((levels) {
      final images = levels.map((e) => e.image).toList();
      levelsImages.addAll(images);
    });
    await imageCaches.loadAll(levelsImages);
  }

  static Image image(String path) => imageCaches.fromCache(path);

  static Future<Uint8List> imageBytes(String path) async =>
      image(path).toBytes();

  static Future<String> saveImage(Image img) async {
    if (img == null) return null;
    final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    final path = '/images/$timestamp.m';
    final bytes = await img.toBytes();
    await imageCaches.loadImage(path, img); //直接加载到内存
    await FileTool.write(path, bytes); //持久化到本地
    // await imageCaches.load(path); //从本地加载到内存
    return path;
  }

  static Future<String> saveBytes(Uint8List bytes) async {
    if (bytes == null || bytes.isEmpty) return null;
    final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    final path = '/images/$timestamp.m';
    await imageCaches.loadBytes(path, bytes); //直接加载到内存
    await FileTool.write(path, bytes); //持久化到本地
    // await imageCaches.load(path); //从本地加载到内存
    return path;
  }
}
