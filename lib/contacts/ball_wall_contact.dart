import 'package:flame_forge2d/contact_callbacks.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

import '../components/ball.dart';
import '../components/boundaries.dart';
import '../game/game_state.dart';
import '../tools/audio_tool.dart';

class BallWallContactCallback extends ContactCallback<Ball, Wall> {
  @override
  void begin(Ball ball, Wall wall, Contact contact) {
    if (GameState.gameStatus != GameStatus.start) return;
    if (wall.side != 3) return; //非底边
    if (!ball.landed) {
      AudioTool.fall();
    }
    ball.landed = true;
  }

  @override
  void end(Ball ball, Wall wall, Contact contact) {}
}
