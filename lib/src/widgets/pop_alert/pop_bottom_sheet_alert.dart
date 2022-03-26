import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PopBottomSheetAlert extends Dialog {
  final Widget childWidget;

  const PopBottomSheetAlert({Key? key, required this.childWidget})
      : super(key: key);

  /// 取消对话框
  static disMissDialog(BuildContext context) {
    Navigator.of(context).pop();
  }

  /// 显示对话框
  static showMyConfirmDialog(BuildContext context,
      {required Widget childWidget}) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return PopBottomSheetAlert(
            childWidget: childWidget,
          );
        });
  }

  /// 拦截返回键
  Future<bool> _requestPop() {
    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
        onWillPop: _requestPop,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: Platform.isAndroid
                ? 703.h
                : 703.h + MediaQuery.of(context).padding.bottom,
            padding: EdgeInsets.fromLTRB(
                29.w,
                51.h,
                29.w,
                Platform.isAndroid
                    ? 22.h
                    : 22.h + MediaQuery.of(context).padding.bottom),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(14.w),
                    topLeft: Radius.circular(14.w)),
                color: Colors.white),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [childWidget],
            ),
          ),
        ));
  }
}
