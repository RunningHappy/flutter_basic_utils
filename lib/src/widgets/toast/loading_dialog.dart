import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///
/// laoding 弹窗
///
class LoadingDialog extends Dialog {
  final String text;
  final bool isShowClose;
  final double? height;
  final double? width;
  final Function? closeCallback;

  const LoadingDialog(
      {Key? key,
      required this.text,
      this.isShowClose = true,
      this.height,
      this.width,
      this.closeCallback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: SizedBox(
          width: width ?? 200.w,
          height: height ?? 200.w,
          child: Container(
              decoration: const ShapeDecoration(
                color: Color(0xffffffff),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                ),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const CircularProgressIndicator(),
                      Padding(
                        padding: EdgeInsets.only(
                          top: 20.h,
                        ),
                        child: Text(
                          text,
                          style: const TextStyle(fontSize: 12.0),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    top: 10.h,
                    right: 10.w,
                    child: isShowClose
                        ? GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                              if (closeCallback != null) {
                                closeCallback!.call();
                              }
                            },
                            child: Icon(Icons.close, size: 40.w),
                          )
                        : Container(),
                  )
                ],
              )),
        ),
      ),
    );
  }
}
