
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../game/level/level.dart';
import '../../game/level/levels.dart';
import '../../game/level/levels_inner.dart';
import '../../tools/image/image_tool.dart';
import '../../tools/navigator_tool.dart';
import '../../tools/screen/screen_config.dart';
import '../../tools/screen/screen_extension.dart';
import '../../widgets/base_widget.dart';

class InnerLevelPage extends StatefulWidget {
  @override
  _InnerLevelPageState createState() => _InnerLevelPageState();
}

class _InnerLevelPageState extends State<InnerLevelPage> {
  void _back() {
    NavigatorTool.pop();
  }

  bool loaded = false;

  List innerLevels = LevelsInner.levels.values.toList();

  @override
  void initState() {
    super.initState();
    loadInnerLevels();
  }

  Future<void> loadInnerLevels() async {
    await ImageTool.loadInnerLevels();
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
                lExpanded(child: _innerLevelsList()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  int checkedIndex;

  Widget _innerLevelsList() {
    return !loaded
        ? CircularProgressIndicator()
        : ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: innerLevels.length,
            itemBuilder: (_, index) {
              return Container(
                padding: EdgeInsets.all(2.vw),
                margin: EdgeInsets.all(5.vw),
                decoration: BoxDecoration(
                  color: checkedIndex == index
                      ? Colors.greenAccent
                      : Colors.grey[200],
                  borderRadius: BorderRadiusDirectional.circular(5.vw),
                ),
                child: LevelImageList(
                  items: innerLevels[index],
                  onTap: () async {
                    checkedIndex = index;
                    await Levels.sets(innerLevels[index]);
                    setState(() {});
                  },
                ),
              );
            },
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
              '更换主题',
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
}

class LevelImageList extends StatefulWidget {
  final Function onTap;
  final double width, height;
  final List<Level> items;
  LevelImageList({
    this.items,
    this.width,
    this.height,
    this.onTap,
  });
  @override
  _LevelImageListState createState() => _LevelImageListState();
}

class _LevelImageListState extends State<LevelImageList> {
  PageController controller;

  void onTapImage(Level level) async {
    if (widget.onTap != null) await widget.onTap();
  }

  int currentPage = 0;

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
  void initState() {
    super.initState();
    controller = PageController(viewportFraction: _height / _screenWidth);
    controller.addListener(_pageListener);
    Future.delayed(Duration.zero, () async {
      if (widget.items.length > 1) {
        await controller.animateToPage(
          2, //居中
          duration: Duration(milliseconds: 100),
          curve: Curves.easeOutQuint,
        );
      }
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  Widget levelImageView(Level level, bool active) {
    var top = active ? 0 : _height * 0.2;
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
              width: _height,
              height: _height - top,
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
        itemCount: widget.items.length,
        itemBuilder: (context, int currentIndex) {
          var active = currentIndex == currentPage;
          return levelImageView(widget.items[currentIndex], active);
        },
      ),
    );
  }
}
