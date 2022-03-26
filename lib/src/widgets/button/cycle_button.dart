import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CycleButton extends GestureDetector {
  final String title;
  final Color color;
  final double? radius;
  final double fontSize;
  final bool isShowLoading;
  final bool canTap;
  final Function? callBack;

  CycleButton(
      {Key? key,
      required this.title,
      required this.color,
      required this.radius,
      required this.fontSize,
      this.isShowLoading = false,
      this.canTap = false,
      required this.callBack})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: () {
        if (canTap) {
          if (callBack != null) {
            callBack!();
          }
        }
      },
      child: Container(
        decoration: BoxDecoration(
            color: canTap ? color : color.withAlpha(120),
            borderRadius: BorderRadius.circular(radius ?? 8.w)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: fontSize, color: Colors.white),
            ),
            isShowLoading
                ? Row(
                    children: [
                      SizedBox(width: 10.w),
                      const CupertinoActivityIndicator(radius: 8)
                    ],
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
