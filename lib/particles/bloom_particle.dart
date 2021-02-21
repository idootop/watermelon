import 'dart:math';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/composition.dart';
import 'package:flame/particles.dart';
import 'package:flutter/material.dart';

import '../game/game_state.dart';
import '../game/my_game.dart';
import '../tools/size_tool.dart';

class BloomPartcle {
  MyGame gameRef;
  BloomPartcle(this.gameRef);

  static final List<Color> bloomColors = [
    Colors.amberAccent,
    Colors.pink,
    Colors.blueAccent,
    Colors.greenAccent,
    Colors.purpleAccent,
    Colors.deepOrange,
  ];

  static final Random rnd = Random();
  double randomSpeed(double radius) =>
      (2 + rnd.nextDouble() * 1) * gameRef.viewport.vw(radius);
  double randomRadius(double radius) =>
      (2 + rnd.nextDouble() * 1) * gameRef.viewport.vw(radius);
  double randomAngle(double angle) => angle + rnd.nextDouble() * pi / 6;
  double randomTime(double radius) => 0.2 + rnd.nextDouble() * 0.5;
  int randomCount(double radius) => 6 + rnd.nextInt(4) + (radius ~/ 2);
  Color randomColor(double radius) =>
      bloomColors[(radius ~/ 2) % bloomColors.length];

  void show(Offset position, double radius) {
    if (!GameState.gameSetting.bloom) return;
    final n = randomCount(radius);
    final color = randomColor(radius);
    gameRef.add(
      ParticleComponent(
        particle: Particle.generate(
          count: n,
          lifespan: randomTime(radius),
          generator: (i) {
            final angle = randomAngle((2 * pi / n) * i);
            return generate(
              position: position,
              angle: Offset(sin(angle), cos(angle)),
              radius: randomRadius(radius),
              speed: randomSpeed(radius),
              color: color,
            );
          },
        ),
      ),
    );
  }

  AcceleratedParticle generate({
    Offset position,
    Offset angle,
    double speed,
    double radius,
    Color color,
  }) {
    return AcceleratedParticle(
        position: position,
        speed: angle * speed,
        acceleration: angle * radius,
        child: ComputedParticle(
            renderer: (canvas, particle) => canvas.drawCircle(
                  Offset.zero,
                  particle.progress * 5,
                  Paint()
                    ..color = Color.lerp(
                      color,
                      Colors.white,
                      particle.progress * 0.1,
                    ),
                )));
  }
}
