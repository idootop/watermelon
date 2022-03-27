import 'package:flame/components.dart';
import 'package:flame_forge2d/viewport.dart';
import 'package:flutter/material.dart' hide Viewport;

import '../tools/size_tool.dart';

class Scores extends TextComponent {
  static double margin = 5;

  @override
  Vector2 position;

  static Scores create(
    Viewport viewport, {
    String text,
    Color color,
    double size,
  }) {
    color ??= Colors.orange;
    size ??= viewport.vw(10);
    return Scores(
        text: text,
        config: TextConfig(color: color, fontSize: size),
        position: Vector2(viewport.vw(margin), viewport.vw(margin)));
  }

  Scores({
    String text,
    TextConfig config,
    this.position,
  }) : super(text, config: config);
}
