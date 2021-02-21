import 'package:flame_forge2d/body_component.dart';
import 'package:flame_forge2d/viewport.dart';
import 'package:forge2d/forge2d.dart';

List<Wall> createBoundaries(Viewport viewport) {
  final screenSize = Vector2(viewport.size.x, viewport.size.y) / viewport.scale;
  final topRight = (screenSize / 2);
  final bottomLeft = topRight * -1;
  final topLeft = Vector2(bottomLeft.x, topRight.y);
  final bottomRight = topLeft * -1;

  return [
    Wall(topLeft, topRight, 1),
    Wall(topRight, bottomRight, 2),
    Wall(bottomRight, bottomLeft, 3),
    Wall(bottomLeft, topLeft, 4),
  ];
}

class Wall extends BodyComponent {
  final Vector2 start;
  final Vector2 end;
  final int side;

  Wall(this.start, this.end, this.side);

  @override
  Body createBody() {
    final shape = PolygonShape();
    shape.setAsEdge(start, end);

    final fixtureDef = FixtureDef()
      ..shape = shape
      ..restitution = 0.0
      ..friction = 0.1;

    final bodyDef = BodyDef()
      ..userData = this //检测碰撞
      ..position = Vector2.zero()
      ..type = BodyType.STATIC;

    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
}
