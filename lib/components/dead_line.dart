import 'package:flame/components.dart';
import 'package:flame_forge2d/viewport.dart';

import '../tools/image/image_tool.dart';
import '../tools/size_tool.dart';

class DeadLine extends SpriteComponent {
  ///deadline距屏幕顶部距离，单位：vw
  static double marginTop = 36;

  ///触发deadline显示，ball距屏幕顶部距离，单位：vw
  static double showTop = marginTop + 44;

  ///是否显示
  static bool show = false;

  @override
  Vector2 position;

  static DeadLine create(Viewport viewport) {
    final sprite = Sprite(ImageTool.image('dead_line.png'));
    return DeadLine(
        sprite: sprite,
        size: Vector2(
          viewport.size.x,
          viewport.vw(1),
        ),
        position: Vector2(0, viewport.vw(marginTop)));
  }

  DeadLine({Sprite sprite, Vector2 size, this.position})
      : super.fromSprite(size, sprite);

  @override
  void render(canvas) {
    if (!show) return;
    super.render(canvas);
  }
}
