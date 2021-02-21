import 'package:flame/components.dart';
import 'package:flame_forge2d/sprite_body_component.dart';
import 'package:flame_forge2d/viewport.dart';
import 'package:flutter/foundation.dart';
import 'package:forge2d/forge2d.dart';

import '../game/level/levels.dart';

class Ball extends SpriteBodyComponent {
  ///下落位置
  Vector2 fallPosition;

  ///是否下落
  bool isFalling;

  ///等级
  int level;

  ///半径
  double _radius;

  ///是否落地
  bool landed = false;

  ///level up
  bool levelUp = false;

  ///是否remove
  bool removed = false;

  ///是否开始移动
  bool moving = true;

  ///是否弹动
  bool bouncing = false;

  Vector2 get position =>
      viewport.getWorldToScreen(body?.position ?? Vector2.zero());

  double get radius => _radius * viewport.scale;

  static Ball create(
    Viewport viewport, {
    @required Vector2 position,
    @required int level,
    bool moving,
    bool canFall,
    bool landed,
    bool bounce,
  }) {
    position ??= Vector2.zero();
    level ??= 1;
    canFall ??= false;
    landed ??= false;
    moving ??= true;
    bounce ??= false;
    return Ball(
      level: level,
      position: position,
      canFall: canFall,
      landed: landed,
      moving: moving,
      bounce: bounce,
      sprite: Levels.sprite(level),
      radius: Levels.radius(level) * (viewport.size.x / viewport.scale / 100),
    );
  }

  Ball({
    @required Vector2 position,
    @required Sprite sprite,
    @required double radius,
    @required this.level,
    this.landed,
    this.moving,
    bool canFall,
    bool bounce,
  }) : super(
          sprite,
          bounce ? Vector2.zero() : Vector2(radius * 2, radius * 2),
        ) {
    fallPosition = position;
    isFalling = canFall;
    bouncing = bounce;
    _radius = radius;
  }

  ///物理实体
  @override
  Body createBody() {
    final shape = CircleShape()..radius = size.x / 2;
    var position = fallPosition.clone();
    if (!isFalling) {
      position.x = viewport.center.x;
    }
    var worldPosition = viewport.getScreenToWorld(position);

    final fixtureDef = FixtureDef()
      ..shape = shape
      ..restitution = 0.1 //弹性
      ..density = 0.1 //密度
      ..friction = 0.1; //摩擦力

    final bodyDef = BodyDef()
      ..userData = this //开启检测碰撞
      ..angularDamping = 0.1 //角速度阻尼
      ..position = worldPosition
      ..type = isFalling ? BodyType.DYNAMIC : BodyType.KINEMATIC;

    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
}
