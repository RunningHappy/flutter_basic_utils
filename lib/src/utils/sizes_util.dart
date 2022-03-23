import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Sizes extends SizedBox {
  const Sizes({Key? key}) : super(key: key);

  /// 盒子宽度
  static Widget boxW(double width) {
    return SizedBox(
      width: ScreenUtil().setWidth(width),
    );
  }

  /// 盒子高度
  static Widget boxH(double height) {
    return SizedBox(
      height: ScreenUtil().setWidth(height),
    );
  }

  /// 获appbar+状态栏高度
  static double getAppBarAndStatusHeight() {
    return kToolbarHeight + MediaQueryData.fromWindow(window).padding.top;
  }

  /// 获状态栏高度
  static double getStatusBarHeight() {
    return MediaQueryData.fromWindow(window).padding.top;
  }
}
