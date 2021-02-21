import 'dart:convert';

import '../game/game_state.dart';

class GameSetting {
  ///合成大/小瓜
  bool levelUp;

  ///随机/只生成小、大瓜模式
  bool random;

  ///音效
  bool music;

  ///动效
  bool bloom;

  ///重力感应
  bool gravity;

  GameSetting({
    this.levelUp,
    this.random,
    this.music,
    this.bloom,
    this.gravity,
  }) {
    levelUp ??= true;
    random ??= true;
    music ??= true;
    bloom ??= true;
    gravity ??= false;
  }

  GameSetting.fromJson(Map<String, dynamic> json) {
    levelUp = json['levelUp'];
    random = json['random'];
    music = json['music'];
    bloom = json['bloom'];
    gravity = json['gravity'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['levelUp'] = levelUp;
    data['random'] = random;
    data['music'] = music;
    data['bloom'] = bloom;
    data['gravity'] = gravity;
    return data;
  }

  String toJsonStr() => jsonEncode(toJson());

  static GameSetting fromJsonStr(String result) {
    return GameSetting.fromJson(jsonDecode(result));
  }

  Future<void> update() async => GameState.updateSetting(this);
}
