import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///
/// 含渐变色的圆角按钮
///
class MoreColorLoginButton extends GestureDetector {
  final String title;
  final bool type;
  final double fontSize;
  final Function callBack;

  MoreColorLoginButton(
      {Key? key,
      required this.title,
      required this.type,
      required this.fontSize,
      required this.callBack})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: () {
        if (type) {
          callBack();
        }
      },
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                // 渐变位置
                begin: Alignment.centerLeft,
                end: Alignment.bottomRight,
                // 渐变颜色[始点颜色, 结束颜色]
                colors: type
                    ? [const Color(0xFF5E80FF), const Color(0xFF4E70F0)]
                    : [const Color(0x305E80FF), const Color(0x304E70F0)]),
            borderRadius: BorderRadius.circular(8.w)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: fontSize, color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
