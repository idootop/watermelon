import 'package:flutter/material.dart';

import 'pages/home_page.dart';
import 'tools/navigator_tool.dart';
import 'tools/system_tool.dart';

void main() async {
  runApp(MyApp());
  SystemTool.keepPortrait();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '合成大瓜',
      navigatorObservers: [NavigatorTool()],
      home: HomePage(),
    );
  }
}
