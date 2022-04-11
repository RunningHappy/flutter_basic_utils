import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///
/// 上文本，下图片 button
///
class TopTextBottomIconButton extends StatelessWidget {
  final String icon;
  final String title;
  final double height;
  final double width;
  final GestureTapCallback? tapCallback;

  const TopTextBottomIconButton(
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
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 6.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 28.sp, color: Colors.black),
            ),
            SizedBox(height: 4.h),
            Image.asset(icon, fit: BoxFit.cover, height: height, width: width),
          ],
        ),
      ),
    );
  }
}
