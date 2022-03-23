library app_assembly;

import 'package:flutter/material.dart';

/// 中心弹出框
class PopCenterAlert extends Dialog {
  final Widget? childWidget;

  const PopCenterAlert({Key? key, this.childWidget}) : super(key: key);

  /// 取消对话框
  static disMissDialog(BuildContext context) {
    Navigator.of(context).pop();
  }

  /// 显示对话框
  static showMyDialog(BuildContext context, {required Widget childWidget}) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return PopCenterAlert(childWidget: childWidget);
        });
  }

  /// 拦截返回键
  Future<bool> _requestPop() {
    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _requestPop,
        child: Container(
          color: const Color(0x4A000000),
          child: Center(
              child: SizedBox(
                  height: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [childWidget!],
                  ))),
        ));
  }
}
