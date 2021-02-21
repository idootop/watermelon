import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:sensors/sensors.dart';

class XYZ {
  XYZ(this.x, this.y, this.z);
  final double x;
  final double y;
  final double z;

  @override
  String toString() => 'x: $x, y: $y, z: $z';
}

class SensorTool {
  static StreamSubscription<dynamic> _stream;

  static XYZ _xyz;

  static XYZ get xyz => _xyz ?? XYZ(0, 0, 0);

  static Future<void> start() async {
    if (kIsWeb) return;
    await stop();
    _stream = accelerometerEvents.listen((data) {
      _xyz = XYZ(data.x, data.y, data.z);
    });
  }

  static Future<void> stop() async {
    if (!kIsWeb) await _stream?.cancel();
  }
}
