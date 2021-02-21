import 'dart:convert';

class Level {
  String image;
  double radius;

  Level(this.radius, this.image);

  Level.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    radius = json['radius'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['image'] = image;
    data['radius'] = radius;
    return data;
  }

  static List<Level> fromJsonList(List list) {
    final results = <Level>[];
    for (var i = 0; i < list.length; i++) {
      results.add(Level.fromJson(list[i]));
    }
    return results;
  }

  static String toJsons(List<Level> levels) =>
      levels.map((e) => jsonEncode(e.toJson())).toList().join('|');

  static List<Level> fromJsons(String result) {
    final levels = result.split('|').map((e) => jsonDecode(e)).toList();
    return fromJsonList(levels);
  }
}
