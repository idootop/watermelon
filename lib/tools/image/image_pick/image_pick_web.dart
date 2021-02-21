import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:image_picker_web_redux/image_picker_web_redux.dart';

import '../image_tool.dart';

class ImagePickTool {
  static Future<Uint8List> pickImageAsBytes() async {
    if (kIsWeb) {
      return await ImagePickerWeb.getImage(outputType: ImageType.bytes);
    }
    return null;
  }

  static Future<String> pickImageAndSave() async {
    final bytes = await pickImageAsBytes();
    if (bytes == null) return null;
    return await ImageTool.saveBytes(bytes);
  }
}
