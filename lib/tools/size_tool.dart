import 'package:flame/game.dart';
import 'package:flame_forge2d/viewport.dart';
import 'package:flutter/widgets.dart' hide Viewport;

extension Size2Vector on Size {
  Vector2 get toVector => Vector2(width, height);
}

extension Offset2Vector on Offset {
  Vector2 get toVector => Vector2(dx, dy);
}

extension Vector2Offset on Vector2 {
  Offset get toVector => Offset(x, y);
  double get gravitySize => y / 600 * 50;
  double get velocitySize => x / 6;
}

extension SizeVector on BuildContext {
  Size get size => MediaQuery.of(this).size;
  Vector2 get vector => Vector2(size.width, size.height);
}

extension VW on Viewport {
  double vw(double percent) => percent * (size.x / 100);
  double vh(double percent) => percent * (size.y / 100);
}
