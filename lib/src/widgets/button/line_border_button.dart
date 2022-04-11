import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///
/// 含边框线的按钮
///
class LineBorderBtn extends StatelessWidget {
  final String title;
  final double? fontSize;
  final double? paddingH;
  final double? paddingV;
  final Color? textColor;
  final double? radius;
  final Function? onTap;

  const LineBorderBtn(
      {Key? key,
      required this.title,
      this.onTap,
      this.fontSize,
      this.paddingH,
      this.paddingV,
      this.radius,
      this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap!();
        }
      },
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
                width: 1.w, color: textColor ?? const Color(0xFF177FF3)),
            borderRadius: BorderRadius.circular(radius ?? 4.h)),
        padding: EdgeInsets.symmetric(
            horizontal: paddingH ?? 25.w, vertical: paddingV ?? 18.h),
        child: Row(
          mainAxisSize: paddingH != null ? MainAxisSize.max : MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                  fontSize: fontSize ?? 28.sp,
                  color: textColor ?? const Color(0xFF177FF3)),
            )
          ],
        ),
      ),
    );
  }
}
