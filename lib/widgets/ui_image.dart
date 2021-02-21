import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../tools/image/image_tool.dart';

class UiImage extends StatelessWidget {
  final String path;
  final Function(Uint8List) builder;

  UiImage(this.path, {@required this.builder});

  @override
  Widget build(BuildContext context) {
    // 等价于
    // return RawImage(image: ImageTool.image(path));
    return FutureBuilder<Uint8List>(
      future: ImageTool.imageBytes(path),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            return builder(snapshot.data);
          default:
            return Container();
        }
      },
    );
  }
}
