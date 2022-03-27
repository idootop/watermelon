import 'package:crop/crop.dart';
import 'package:flutter/material.dart';

import '../../tools/image/image_pick_tool.dart';
import '../../tools/image/image_tool.dart';
import '../../tools/navigator_tool.dart';
import '../../tools/screen/screen_config.dart';
import '../../tools/screen/screen_extension.dart';
import '../../widgets/base_widget.dart';

class ImageCropPage extends StatefulWidget {
  @override
  _ImageCropPageState createState() => _ImageCropPageState();
}

class _ImageCropPageState extends State<ImageCropPage> {
  void _back() {
    NavigatorTool.pop();
  }

  final cropController = CropController(aspectRatio: 1);
  final cropShape = BoxShape.circle;
  final cropFit = BoxFit.contain;

  Widget cropImage;

  Future<void> _crop() async {
    final pixelRatio = MediaQuery.of(context).devicePixelRatio;
    final cropped = await cropController.crop(pixelRatio: pixelRatio);
    final path = await ImageTool.saveImage(cropped);
    NavigatorTool.pop(path);
    CircleAvatar();
  }

  void _pickImage() async {
    final bytes = await ImagePickTool.pickImageAsBytes();
    if (bytes != null) {
      cropImage = Image.memory(
        bytes,
        fit: cropFit,
      );
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    cropImage = Image.asset(
      'assets/images/friuts/10.png',
      fit: cropFit,
    );
    _pickImage();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenConfig(
      builder: () => Scaffold(
        backgroundColor: Colors.grey[100],
        body: SafeArea(
          child: Center(
            child: Column(
              children: [
                _topAction(),
                lExpanded(
                  child: _cropArea(),
                ),
                _bottomAction(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _cropArea() {
    return AspectRatio(
      aspectRatio: 1,
      child: Crop(
        controller: cropController,
        shape: cropShape,
        fit: cropFit,
        child: cropImage,
      ),
    );
  }

  Widget _topAction() => Container(
        padding: EdgeInsets.all(5.vw),
        child: Row(
          children: [
            lIconButton(
              Icons.chevron_left,
              size: 10.vw,
              color: Colors.black,
              onTap: _back,
            ),
            lExpanded(
                child: lText(
              '裁剪图片',
              bold: true,
              size: 18,
            )),
            lIconButton(
              Icons.chevron_left,
              size: 10.vw,
              color: Colors.transparent,
            ),
          ],
        ),
      );

  Widget _bottomAction() => Container(
        padding: EdgeInsets.all(10.vw),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            lButton(
              '确定',
              onTap: _crop,
              height: 5.vw * 2.2,
              colorBg: Colors.black,
              colorText: Colors.white,
            ),
          ],
        ),
      );
}
