import 'package:flutter/material.dart';

import '../../game/level/level.dart';
import '../../game/level/levels.dart';
import '../../tools/image/image_crop_tool.dart';
import '../../tools/image/image_tool.dart';
import '../../tools/navigator_tool.dart';
import '../../tools/screen/screen_config.dart';
import '../../tools/screen/screen_extension.dart';
import '../../widgets/base_widget.dart';

class LevelSettingPage extends StatefulWidget {
  @override
  _LevelSettingPageState createState() => _LevelSettingPageState();
}

class _LevelSettingPageState extends State<LevelSettingPage> {
  void _back() {
    NavigatorTool.pop();
  }

  Future<void> _pickImage() async {
    final path = await ImageCropTool.crop();
    if (path != null) {
      await Levels.update(
        levels[currentPage]..image = path,
        index: currentPage,
      );
      setState(() {});
    }
  }

  Future<void> onTapImage(Level level) async => _pickImage();

  Future<void> next() async {
    if (isLast) return;
    await controller.nextPage(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOutQuint,
    );
  }

  Future<void> pre() async {
    if (isFirst) return;
    await controller.previousPage(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOutQuint,
    );
  }

  bool get isLast => currentPage == levels.length - 1;
  bool get isFirst => currentPage < 1;
  int get currentPage => controller.page.toInt();

  bool loaded = false;

  List get levels => Levels.kLevels;

  PageController controller = PageController(viewportFraction: 1);

  @override
  void initState() {
    super.initState();
    loadInnerLevels();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  Future<void> loadInnerLevels() async {
    await ImageTool.loadAll();
    setState(() {
      loaded = true;
    });
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
                  child: _body(),
                ),
                _bottomAction(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _body() {
    return !loaded
        ? CircularProgressIndicator()
        : Container(
            child: Stack(
              alignment: Alignment.center,
              children: [
                _Levels(),
                Container(
                  padding: EdgeInsets.all(5.vw),
                  child: Row(
                    children: [
                      lIconButton(
                        Icons.chevron_left,
                        color: Colors.black,
                        onTap: pre,
                      ),
                      lExpanded(),
                      lIconButton(
                        Icons.chevron_right,
                        color: Colors.black,
                        onTap: next,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
  }

  Widget _Levels() {
    return LevelEditImageList(
      width: 100.vw,
      height: 100.vw,
      controller: controller,
      onTap: onTapImage,
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
              '自定义图片',
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

class LevelEditImageList extends StatefulWidget {
  final Function(Level level) onTap;
  final double width, height;
  final PageController controller;
  LevelEditImageList({
    this.width,
    this.height,
    this.onTap,
    this.controller,
  });
  @override
  _LevelEditImageListState createState() => _LevelEditImageListState();
}

class _LevelEditImageListState extends State<LevelEditImageList> {
  PageController controller;

  void onTapImage(Level level) async {
    if (widget.onTap != null) await widget.onTap(level);
  }

  int currentPage = 0;
  List get levels => Levels.kLevels;

  void _pageListener() {
    var next = controller.page.round();
    if (currentPage != next) {
      setState(() {
        currentPage = next;
      });
    }
  }

  double get _screenWidth => widget.width ?? 100.vw;
  double get _height => widget.height ?? 20.vw;

  @override
  void dispose() {
    if (widget.controller == null) {
      controller?.dispose();
    }
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    controller = widget.controller ??
        PageController(viewportFraction: _height / _screenWidth);
    controller.addListener(_pageListener);
  }

  Widget levelImageView(Level level, bool active) {
    final size = Levels.radius(currentPage).vw * 2;
    var top = active ? 0 : size * 0.3;
    return GestureDetector(
      onTap: () async {
        await onTapImage(level);
      },
      child: Container(
        width: _height,
        height: _height,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AnimatedContainer(
              width: size,
              height: size - top,
              duration: Duration(milliseconds: 500),
              curve: Curves.easeOutQuint,
              child: RawImage(
                image: ImageTool.image(level.image),
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _screenWidth,
      height: _height,
      alignment: Alignment.center,
      child: PageView.builder(
        physics: BouncingScrollPhysics(),
        controller: controller,
        itemCount: levels.length,
        itemBuilder: (context, int currentIndex) {
          var active = currentIndex == currentPage;
          return levelImageView(levels[currentIndex], active);
        },
      ),
    );
  }
}
