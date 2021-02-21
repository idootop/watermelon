import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class ScreenTool {
  factory ScreenTool() => _instance;
  ScreenTool._();
  static final ScreenTool _instance = ScreenTool._();

  static const Size defaultSize = Size(1080, 1920);

  /// 设计稿尺寸，单位px
  Size uiSize;

  /// 是否允许字体大小缩放
  bool allowFontScaling;

  double _pixelRatio = 1;
  double _textScaleFactor = 1;
  double _screenWidth = 0;
  double _screenHeight = 0;
  double _statusBarHeight = 0;
  double _bottomBarHeight = 0;

  void init(
    BoxConstraints constraints, {
    Size designSize,
    bool allowFontScaling,
  }) {
    designSize ??= defaultSize;
    allowFontScaling ??= false;
    uiSize = designSize;
    this.allowFontScaling = allowFontScaling;

    _screenWidth = constraints.maxWidth; //此处是当前组件的最大宽度
    _screenHeight = constraints.maxHeight; //此处是当前组件的最大高度度

    var window = WidgetsBinding.instance?.window ?? ui.window;

    _pixelRatio = window.devicePixelRatio;
    _statusBarHeight = window.padding.top;
    _bottomBarHeight = window.padding.bottom;
    _textScaleFactor = window.textScaleFactor;
  }

  /// 根据UI设计的设备宽度适配
  double width(num width) => width * scaleWidth;

  /// 根据UI设计的设备高度适配
  double height(num height) => height * scaleHeight;

  /// 根据宽度或高度中的较小值进行适配
  double radius(num r) => r * scaleText;

  /// 字体大小适配方法,单位px.
  double font(num fontSize, {bool allowScaling}) => allowScaling == null
      ? (allowFontScaling
          ? (fontSize * scaleText) * _textScaleFactor
          : (fontSize * scaleText))
      : (allowScaling
          ? (fontSize * scaleText) * _textScaleFactor
          : (fontSize * scaleText));

  /// 每个逻辑像素的字体像素数，字体的缩放比例
  double get textScaleFactor => _textScaleFactor;

  /// 设备的像素密度
  double get pixelRatio => _pixelRatio;

  /// 当前设备宽度 dp
  double get screenWidth => _screenWidth;

  /// 当前设备高度 dp
  double get screenHeight => _screenHeight;

  /// 当前设备最短边 dp
  double get screenMin => min(_screenWidth, _screenHeight);

  /// 当前设备最长边 dp
  double get screenMax => max(_screenWidth, _screenHeight);

  /// 状态栏高度 dp 刘海屏会更高
  double get statusBarHeight => _statusBarHeight / _pixelRatio;

  /// 底部安全区距离 dp
  double get bottomBarHeight => _bottomBarHeight / _pixelRatio;

  /// 实际宽度与设计宽度的比例
  double get scaleWidth => _screenWidth / uiSize.width;

  /// 实际高度与设计高度的比例
  double get scaleHeight => _screenHeight / uiSize.height;

  /// 实际字体大小与设计字体大小的比例
  double get scaleText => min(scaleWidth, scaleHeight);
}
