import 'package:flame/components.dart';

import '../components/ball.dart';
import '../game/game_state.dart';
import '../game/my_game.dart';
import '../tools/size_tool.dart';

class UpdateBallsFalling extends Component with HasGameRef<MyGame> {
  @override
  void update(double t) {
    if (gameRef.hide) return;
    if (GameState.gameStatus != GameStatus.start) return;
    gameRef.components
        .where((e) => e is Ball && e.isFalling == false)
        .forEach((ball) {
      Ball b = ball;
      if (!b.moving) return;
      final p = b.position;
      final fp = b.fallPosition;
      final width = gameRef.viewport.vw(100);
      final left = fp.x < gameRef.viewport.center.x;
      final center =
          (fp.x - gameRef.viewport.center.x).abs() < gameRef.viewport.vw(5);
      if (!center && b.body.linearVelocity.x == 0) {
        b.body.linearVelocity =
            Vector2((left ? -1 : 1) * gameRef.viewport.size.velocitySize, 0);
      }
      if (center ||
          (left && (p.x < b.radius || p.x < fp.x)) ||
          (!left && (width - p.x < b.radius || p.x > fp.x))) {
        gameRef.remove(ball);
        gameRef.add(Ball.create(gameRef.viewport,
            position: p, level: b.level, canFall: true));
      }
    });
  }
}
