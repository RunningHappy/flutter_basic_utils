import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///
/// 确认对话框,可实现一个按钮，也可以实现两个按钮
///
class MyConfirmDialog extends Dialog {
  final List<String> buttonItems;
  final String? title;
  final String? content;
  final Function? onTap;

  const MyConfirmDialog(
      {this.title,
        this.content,
        required this.buttonItems,
        this.onTap,
        Key? key})
      : assert(buttonItems.length > 0 && buttonItems.length <= 2),
        super(key: key);

  /// 取消对话框
  static disMissDialog(BuildContext context) {
    Navigator.of(context).pop();
  }

  // 显示对话框
  static showMyConfirmDialog(BuildContext context, List<String> buttonItems,
      {String? title, String? content, Function? onTap}) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return _ConfirmContent(
            title: title ?? "",
            content: content ?? "请您确认信息!",
            buttonItems: buttonItems,
            onTap: onTap,
          );
        });
  }
}

class _ConfirmContent extends StatefulWidget {
  final List<String> buttonItems;
  final String? title;
  final String? content;
  final Function? onTap;
  const _ConfirmContent({Key? key, required this.buttonItems, this.title, this.content, this.onTap}) : super(key: key);

  @override
  _ConfirmContentState createState() => _ConfirmContentState();
}

class _ConfirmContentState extends State<_ConfirmContent> {

  /// 拦截返回键
  Future<bool> _requestPop() {
    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
      onWillPop: _requestPop,
      child: Material(
        color: Colors.transparent,
        child: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.h),
            child: Container(
              color: Colors.white,
              width: 566.w,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  widget.title != ''
                      ? Container(
                    margin: EdgeInsets.only(bottom: 32.h, top: 32.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.title!,
                          style: TextStyle(
                              fontSize: 36.sp,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  )
                      : SizedBox(
                    height: 80.h,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 40.w, right: 40.w),
                    child: Text(
                      widget.content!,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 28.sp),
                    ),
                  ),
                  SizedBox(height: 60.h),
                  const Divider(
                    height: 0.5,
                  ),
                  _getButtons()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _getButtons() {
    return Row(
        children: widget.buttonItems.map((res) {
          int index = widget.buttonItems.indexOf(res);
          return Expanded(
            child: GestureDetector(
              onTap: () {
                widget.onTap!(index);
              },
              child: Container(
                alignment: Alignment.center,
                height: 90.h,
                decoration: BoxDecoration(
                    border: Border(
                        right: BorderSide(
                            width: 0.5,
                            color: widget.buttonItems.length == 2
                                ? const Color(0xFFDDDDDD)
                                : Colors.white))),
                child: Text(
                  res,
                  style: TextStyle(
                    fontSize: 32.sp,
                    color: widget.buttonItems.length == 2 && index == 1
                        ? const Color(0xFF177FF3)
                        : const Color(0xFF606972),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        }).toList());
  }
}

