import 'package:flame/components.dart';

import '../components/ball.dart';
import '../game/game_life.dart';
import '../game/game_state.dart';
import '../game/level/levels.dart';
import '../game/my_game.dart';
import '../particles/bloom_particle.dart';
import '../tools/audio_tool.dart';

class UpdateLevelUp extends Component with HasGameRef<MyGame> {
  @override
  void update(double t) {
    if (gameRef.hide) return;
    if (GameState.gameStatus != GameStatus.start) return;
    gameRef.components
        .where((e) => e is Ball && e.removed)
        .forEach(gameRef.remove);
    gameRef.components.where((e) => e is Ball && e.levelUp).forEach((ball) {
      Ball b = ball;
      final isLastLevel = Levels.isLastLevel(b.level + 1);
      gameRef.remove(ball);
      AudioTool.mix();
      GameState.updateScore(GameState.score + b.level);
      final radius = Levels.radius(b.level + 1);
      gameRef.add(Ball.create(
        gameRef.viewport,
        position: b.position..y += (radius - b.radius),
        level: b.level + 1,
        canFall: true,
        landed: true,
        bounce: true,
      ));
      BloomPartcle(gameRef).show(b.position.toOffset(), radius);
      if (isLastLevel) {
        GameLife(gameRef).win();
      }
    });
  }
}
