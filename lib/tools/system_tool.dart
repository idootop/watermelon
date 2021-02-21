import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SystemTool {
  static void changeStatusBarColor([Color color]) {
    color ??= Colors.white;
    final style = SystemUiOverlayStyle(
      statusBarColor: color,
      systemNavigationBarDividerColor: null,
      systemNavigationBarColor: color,
      systemNavigationBarIconBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
    );
    SystemChrome.setSystemUIOverlayStyle(style);
  }

  static void keepPortrait() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }
}
