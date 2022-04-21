import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///
/// 全局公共类管理
/// 所有 Widget 继承的抽象类
///
abstract class HQBase {
  // 网络
  static const baseHttpSchema = 'http';
  static const baseHttpsSchema = 'https';
  static const baseHost = '192.168.97.142';
  static const basePort = '1236';
  static const baseHttpUrl = '$baseHttpSchema://$baseHost:$basePort';
  static const baseHttpsUrl = '$baseHttpsSchema://$baseHost:$basePort';

  // 默认主题色
  static const defaultColor = Color(0xffff5d23);

  // 初始化设计稿尺寸
  static const double designWidth = 750.0;
  static const double designHeight = 1624.0;

  // 状态栏高度
  static final double statusBarHeight =
      MediaQueryData.fromWindow(window).padding.top;

  // 获appbar+状态栏高度
  static final double appBarAndStatusHeight = kToolbarHeight + statusBarHeight;

  // 屏幕高度
  static final double screenHeight =
      MediaQueryData.fromWindow(window).size.height;

  // 屏幕宽度
  static final double screenWidth =
      MediaQueryData.fromWindow(window).size.width;

  // px 转 dp
  double dp(double designValue) => ScreenUtil().setWidth(designValue);
}
