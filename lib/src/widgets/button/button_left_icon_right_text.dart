import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 左图片，右文本 button
class LeftIconRightTextButton extends StatelessWidget {
  final String icon;
  final String title;
  final double height;
  final double width;
  final GestureTapCallback? tapCallback;

  const LeftIconRightTextButton(
      {Key? key,
      required this.height,
      required this.width,
      required this.icon,
      required this.title,
      this.tapCallback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (tapCallback != null) {
          tapCallback!();
        }
      },
      child: SizedBox(
        height: height,
        width: width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(icon, height: 28.sp, width: 28.sp),
            SizedBox(width: 4.w),
            Text(
              title,
              style: TextStyle(fontSize: 28.sp, color: Colors.black),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
