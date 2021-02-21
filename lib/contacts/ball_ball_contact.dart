import 'package:flame_forge2d/contact_callbacks.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

import '../components/ball.dart';
import '../game/game_state.dart';

class BallBallContactCallback extends ContactCallback<Ball, Ball> {
  @override
  void begin(Ball ball1, Ball ball2, Contact contact) {
    if (GameState.gameStatus != GameStatus.start) return;
    ball1.landed = true;
    ball2.landed = true;
    if (ball1.level == ball2.level) {
      if (ball1.position.y < ball2.position.y) {
        ball1.removed = true;
        ball2.levelUp = true;
      } else {
        ball2.removed = true;
        ball1.levelUp = true;
      }
    }
  }

  @override
  void end(Ball ball1, Ball ball2, Contact contact) {}
}
