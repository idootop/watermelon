import 'package:flame/components.dart';

import '../game/game_state.dart';
import '../game/my_game.dart';
import '../tools/sensor_tool.dart';
import '../tools/size_tool.dart';

class UpdateGravity extends Component with HasGameRef<MyGame> {
  void changeGravity(Vector2 gravity) => gameRef.world.setGravity(gravity);

  double get p {
    final x = SensorTool.xyz.x;
    if (x.abs() > 1) {
      return -2 * (x / 10);
    }
    return 0; //middle
  }

  @override
  void update(double t) {
    if (gameRef.hide) return;
    // if (GameState.gameStatus != GameStatus.start) return;
    final size = gameRef.size.gravitySize;
    final gravity = Vector2(0, -1 * size);
    if (GameState.gameSetting.gravity) {
      final size = gameRef.size.gravitySize;
      final offset = Vector2(size, 0) * p;
      final newGravity = Vector2(0, -1 * size) + offset;
      changeGravity(newGravity);
    } else {
      if (gameRef.world.getGravity() != gravity) {
        changeGravity(gravity);
      }
    }
  }
}
