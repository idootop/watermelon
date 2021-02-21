import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/foundation.dart';

import '../game/game_state.dart';

class AudioTool {
  // static Future<String> save(Image img) async {
  //   final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
  //   final bytes = await img.toBytes();
  //   final path = '/audios/$timestamp.a';
  //   await FileTool.write(path, bytes);
  //   return path;
  // }

  static void loadAll() async {
    if (kIsWeb) return; //audioplayers不支持web端音频缓存
    await FlameAudio.audioCache.loadAll([
      'boom.mp3',
      'boom1.mp3',
      'boom2.mp3',
      'cheer.mp3',
      'coin.wav',
      'fall.mp3',
      'mix.wav',
    ]);
  }

  static int boomCount = 0;

  static void play(String path) async {
    if (!GameState.gameSetting.music) return;
    await FlameAudio.play(path);
  }

  static void fall() => play('fall.mp3');
  static void win() => play('cheer.mp3');
  static void dead() => play('boom1.mp3');

  static void mix() async {
    boomCount++;
    Future.delayed(Duration(milliseconds: 100), () {
      if (boomCount == 1) {
        play('boom2.mp3');
      } else if (boomCount == 2) {
        play('mix.wav');
      } else if (boomCount == 3) {
        play('coin.wav');
      } else if (boomCount > 3) {
        play('boom.mp3');
      }
      boomCount = 0;
    });
  }
}
