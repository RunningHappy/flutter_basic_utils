import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///
/// 圆角按钮
///
class DetailBtn extends GestureDetector {
  final Color lineColor;
  final Color titleColor;
  final String title;
  final double fontSize;
  final double? radius;
  final Function? callBack;

  DetailBtn(
      {Key? key,
      this.radius,
      required this.title,
      required this.titleColor,
      this.callBack,
      required this.lineColor,
      required this.fontSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: () {
        if (callBack != null) {
          callBack!();
        }
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius ?? 40.w),
            border: Border.all(width: 1.w, color: lineColor)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: fontSize, color: titleColor),
            )
          ],
        ),
      ),
    );
  }
}
