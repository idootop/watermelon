import 'package:flame/components.dart';
import 'package:flame_forge2d/viewport.dart';

import '../game/level/levels.dart';
import '../tools/image/image_tool.dart';

class Background extends SpriteComponent {
  Background.create(Viewport viewport) {
    resize(viewport);
    sprite = Sprite(ImageTool.image(Levels.background));
  }

  void resize(Viewport viewport) {
    width = viewport.size.x;
    height = viewport.size.y;
  }
}
