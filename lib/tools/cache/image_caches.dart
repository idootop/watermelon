import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/services.dart';

import '../file_tool.dart';

class ImageCaches {
  final Map<String, _ImageLoader> _loadedFiles = {};

  void clear() {
    _loadedFiles.clear();
  }

  Image fromCache(String fileName) {
    final image = _loadedFiles[fileName];
    //todo default img
    return image?.loadedImage ?? _loadedFiles.values.first.loadedImage;
  }

  Future<Image> loadBytes(String path, Uint8List bytes) async {
    _loadedFiles[path] = _ImageLoader(_loadBytes(bytes));
    return await _loadedFiles[path].retrieve();
  }

  Future<Image> loadImage(String path, Image img) async {
    _loadedFiles[path] = _ImageLoader(Future.value(img));
    return await _loadedFiles[path].retrieve();
  }

  Future<List<Image>> loadAll(List<String> fileNames) async {
    return Future.wait(fileNames.map(load));
  }

  Future<Image> load(String fileName) async {
    return fileName.startsWith('/') ? fromFile(fileName) : fromBundle(fileName);
  }

  Future<Image> fromBundle(String fileName) async {
    if (!_loadedFiles.containsKey(fileName)) {
      _loadedFiles[fileName] = _ImageLoader(_fetchToMemory(fileName));
    }
    return await _loadedFiles[fileName].retrieve();
  }

  Future<Image> fromFile(String path) async {
    if (!_loadedFiles.containsKey(path)) {
      _loadedFiles[path] = _ImageLoader(_fetchFromFile(path));
    }
    return await _loadedFiles[path].retrieve();
  }

  Future<Image> _fetchFromFile(String path) async {
    final bytes = await FileTool.read(path);
    return _loadBytes(bytes);
  }

  Future<Image> _fetchToMemory(String name) async {
    final data = await rootBundle.load('assets/images/' + name);
    final bytes = Uint8List.view(data.buffer);
    return _loadBytes(bytes);
  }

  Future<Image> _loadBytes(Uint8List bytes) {
    final completer = Completer<Image>();
    decodeImageFromList(bytes, (image) => completer.complete(image));
    return completer.future;
  }
}

class _ImageLoader {
  _ImageLoader(this.future);

  Image loadedImage;
  Future<Image> future;

  Future<Image> retrieve() async {
    loadedImage ??= await future;
    return loadedImage;
  }
}
