import 'package:flutter/cupertino.dart';

import '../tools/navigator_tool.dart';

class DialogTool {
  static Future<void> show(
    BuildContext context, {
    String title,
    String content,
    Function action,
    String actionText,
  }) async {
    await showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text('$title'),
            content: Text('$content'),
            actions: <Widget>[
              if (actionText != null)
                CupertinoDialogAction(
                  onPressed: () {
                    Navigator.of(context).pop();
                    if (action != null) action();
                  },
                  child: Text('$actionText'),
                ),
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('确定'),
              ),
            ],
          );
        });
  }

  static bool showing = false;

  static void loading(String title) {
    showing = true;
    showCupertinoDialog(
        context: NavigatorTool.gContext,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text('$title'),
            content: Container(
              padding: EdgeInsets.all(10),
              child: Text('这需要一点时间，请稍候...'),
            ),
          );
        });
  }

  static Future<void> close() async {
    if (!showing) return;
    await Navigator.of(NavigatorTool.gContext).pop();
    showing = false;
  }
}
