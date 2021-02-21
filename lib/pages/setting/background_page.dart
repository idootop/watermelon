import 'package:flutter/material.dart';

import '../../game/level/levels.dart';
import '../../tools/image/image_pick_tool.dart';
import '../../tools/image/image_tool.dart';
import '../../tools/navigator_tool.dart';
import '../../tools/screen/screen_config.dart';
import '../../tools/screen/screen_extension.dart';
import '../../widgets/base_widget.dart';

class BackgroundPage extends StatefulWidget {
  @override
  _BackgroundPageState createState() => _BackgroundPageState();
}

class _BackgroundPageState extends State<BackgroundPage> {
  void _back() {
    NavigatorTool.pop();
  }

  void _pickImage() async {
    final path = await ImagePickTool.pickImageAndSave();
    if (path != null) {
      await Levels.setBackground(path);
      setState(() {});
    }
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
                  child: _background(),
                ),
                _bottomAction(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _background() {
    return Container(
      width: 100.vw,
      height: 100.vh,
      child: RawImage(
        image: ImageTool.image(Levels.background),
        fit: BoxFit.cover,
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
              '更换背景',
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
              '更换图片',
              onTap: _pickImage,
              height: 5.vw * 2.2,
              colorBg: Colors.black,
              colorText: Colors.white,
            ),
          ],
        ),
      );
}
