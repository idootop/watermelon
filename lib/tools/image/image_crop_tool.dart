import 'package:flutter/foundation.dart';
import 'package:image/image.dart';

import '../../pages/setting/image_crop_page.dart';
import '../../tools/dialog_tool.dart';
import '../navigator_tool.dart';
import 'image_pick_tool.dart';
import 'image_tool.dart';

class ImageCropTool {
  static Future<String> crop() async {
    if (kIsWeb) {
      DialogTool.loading('加载中');
      final bytes = await ImagePickTool.pickImageAsBytes();
      final image = decodeImage(bytes);
      final croped = copyCropCircle(image);
      final path = await ImageTool.saveBytes(encodePng(croped));
      await DialogTool.close();
      return path;
    }
    return await NavigatorTool.push(ImageCropPage());
  }
}
