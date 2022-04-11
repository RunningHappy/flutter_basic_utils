import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///
/// 横向图文按钮
/// reverse：false=左图右文，true=左文右图
///
class IconTitleHorizontalButton extends StatelessWidget {
  final bool reverse;
  final String icon;
  final String title;
  final double height;
  final double width;
  final GestureTapCallback? tapCallback;

  const IconTitleHorizontalButton(
      {Key? key,
        this.reverse = false,
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
        child: reverse ?
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(icon, height: 28.sp, width: 28.sp),
            SizedBox(width: 4.w),
            Text(
              title,
              style: TextStyle(fontSize: 28.sp, color: Colors.black),
              textAlign: TextAlign.center,
            )
          ],
        ) : Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 28.sp, color: Colors.black),
              textAlign: TextAlign.center,
            ),
            SizedBox(width: 4.w),
            Image.asset(icon, height: 28.sp, width: 28.sp)
          ],
        ),
      ),
    );
  }
}
