import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///
/// 底部弹窗框架
///
class PopBottomFrameSheet extends Dialog {
  final Widget childWidget;
  final Function? backCallBack;

  const PopBottomFrameSheet(
      {Key? key, required this.childWidget, this.backCallBack})
      : super(key: key);

  /// 取消对话框
  static disMissDialog(BuildContext context) {
    Navigator.of(context).pop();
  }

  /// 显示对话框
  static showBottomFrameDialog(BuildContext context,
      {required Widget childWidget, Function? backCallBack}) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return _BottomContent(
              childWidget: childWidget, backCallBack: backCallBack);
        });
  }
}

class _BottomContent extends StatefulWidget {
  final Widget? childWidget;
  final Function? backCallBack;

  const _BottomContent({Key? key, this.childWidget, this.backCallBack})
      : super(key: key);

  @override
  _BottomContentState createState() => _BottomContentState();
}

class _BottomContentState extends State<_BottomContent> {
  /// 拦截返回键
  Future<bool> _requestPop() {
    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
        onWillPop: _requestPop,
        child: GestureDetector(
          onTap: () {
            Navigator.pop(context);
            if (widget.backCallBack != null) {
              widget.backCallBack!.call();
            }
          },
          child: Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.transparent,
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
                  children: [widget.childWidget!],
                ),
              ),
            ),
          ),
        ));
  }
}
