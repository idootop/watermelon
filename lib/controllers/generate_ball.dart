import 'package:flame/components.dart';

import '../components/ball.dart';
import '../game/game_state.dart';
import '../game/level/levels.dart';
import '../game/my_game.dart';
import '../tools/size_tool.dart';

class GenerateBall {
  MyGame gameRef;
  GenerateBall(this.gameRef);

  bool get canGenerateBall => gameRef.components
      .where((e) => e is Ball && e.moving && !e.landed)
      .isEmpty;

  ///生成新球
  Future<void> generateBall([double x = 0]) async {
    if (gameRef.hide) return;
    if (!canGenerateBall) return;
    if (GameState.gameStatus != GameStatus.start) return;
    if (GameState.lastBall != null) {
      GameState.lastBall.fallPosition.x = x;
      GameState.lastBall.moving = true;
    }
    final level = await Levels.generateLevel();
    final position = Vector2(x, gameRef.viewport.vw(Levels.radius(level) + 5));
    final ball = Ball.create(
      gameRef.viewport,
      position: position,
      level: level,
      moving: false,
      bounce: true,
    );
    Future.delayed(Duration(milliseconds: 600), () {
      gameRef.add(ball);
    });
    GameState.lastBall = ball;
  }
}
