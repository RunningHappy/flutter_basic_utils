import 'package:flutter/material.dart';

///
/// 中心弹出框框架，可以自定义中心弹窗内容
///
class PopCenterFrameAlert extends Dialog {
  final Widget? childWidget;

  const PopCenterFrameAlert({Key? key, this.childWidget}) : super(key: key);

  /// 取消对话框
  static disMissDialog(BuildContext context) {
    Navigator.of(context).pop();
  }

  /// 显示对话框
  static showAlert(BuildContext context, {required Widget childWidget}) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return _CenterContent(childWidget: childWidget);
        });
  }
}

class _CenterContent extends StatefulWidget {
  final Widget? childWidget;

  const _CenterContent({Key? key, this.childWidget}) : super(key: key);

  @override
  _CenterContentState createState() => _CenterContentState();
}

class _CenterContentState extends State<_CenterContent> {
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
                    children: [widget.childWidget!],
                  ))),
        ));
  }
}
