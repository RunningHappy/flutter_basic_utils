import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum ButtonType {
  defaultType,

  /// 默认按钮
  primaryType,

  /// 主要按钮
  infoType,

  /// 信息按钮
  warningType,

  /// 警告按钮
  dangerType

  /// 危险按钮
}


class LsjButton {
  Widget lsjButton(ButtonType type, GestureTapCallback? callback) {
    Widget? buttonWidget;
    if (type == ButtonType.defaultType) {
      buttonWidget = GestureDetector(
          onTap: callback,
          child: Container(
            width: 200.w,
            height: 80.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.h),
              border: Border.all(width: 1.w, color: Colors.black),
            ),
            child: Text(
              '默认按钮',
              style: TextStyle(fontSize: 28.sp, color: Colors.black),
            ),
          ));
    }
    return buttonWidget!;
  }
}
