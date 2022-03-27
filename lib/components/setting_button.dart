import 'package:flame/components.dart';
import 'package:flame_forge2d/viewport.dart';
import 'package:flutter/material.dart' hide Viewport;

import '../game/game_life.dart';
import '../tools/image/image_tool.dart';
import '../tools/size_tool.dart';

class SettingButton extends SpriteComponent with Tapable, HasGameRef {
  static double margin = 5;

  @override
  Vector2 position;

  @override
  bool onTapDown(TapDownDetails details) {
    GameLife(gameRef).setting();
    return true;
  }

  static SettingButton create(Viewport viewport) {
    final sprite = Sprite(ImageTool.image('setting.png'));
    return SettingButton(
        sprite: sprite,
        size: Vector2(
          viewport.vw(10),
          viewport.vw(10),
        ),
        position: Vector2(viewport.vw(100 - margin - 10), viewport.vw(margin)));
  }

  SettingButton({Sprite sprite, Vector2 size, this.position})
      : super.fromSprite(size, sprite);
}
