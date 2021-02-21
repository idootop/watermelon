import 'package:flutter/widgets.dart';

class NavigatorTool extends NavigatorObserver {
  factory NavigatorTool() => _instance;
  NavigatorTool._();
  static final NavigatorTool _instance = NavigatorTool._();

  static BuildContext get gContext => _instance.navigator.context;

  static void pop<T extends Object>([T result]) =>
      _instance.navigator.pop(result);

  static Future push(Widget child) => _instance.navigator.push(_page(child));

  static Future replace(Widget child) =>
      _instance.navigator.pushReplacement(_page(child));

  static Route _page(Widget child) {
    return PageRouteBuilder(
      opaque: false,
      pageBuilder: (_, animation, __) => _animationPage(animation, child),
      transitionsBuilder: (_, animation, __, child) =>
          _animationPage(animation, child),
    );
  }

  static Widget _animationPage(Animation<double> animation, Widget child) {
    final value = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animation,
        curve: Curves.fastOutSlowIn,
      ),
    );
    return FadeTransition(
        opacity: value,
        child: ScaleTransition(
          scale: value,
          child: child,
        ));
  }
}
