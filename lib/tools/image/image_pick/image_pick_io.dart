import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';

import '../image_tool.dart';

class ImagePickTool {
  static final picker = ImagePicker();

  static Future<Uint8List> pickImageAsBytes() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    return await pickedFile?.readAsBytes();
  }

  static Future<String> pickImageAndSave() async {
    final bytes = await pickImageAsBytes();
    if (bytes == null) return null;
    return await ImageTool.saveBytes(bytes);
  }
}
