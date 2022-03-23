import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 圆角 渐变色 阴影 button
class CircleGradientButton extends StatelessWidget {
  final double height;
  final double width;
  final double radius;
  final String title;
  final GestureTapCallback? tapCallback;

  const CircleGradientButton(
      {Key? key,
      required this.height,
      required this.width,
      required this.title,
      required this.radius,
      this.tapCallback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: tapCallback,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          // 圆角
          borderRadius: BorderRadius.circular(radius),
          // 渐变色
          gradient: const LinearGradient(
              // Where the linear gradient begins and ends
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              // Add one stop for each color. Stops should increase from 0 to 1
              stops: [0.0, 1.0],
              colors: [Colors.blue, Colors.red]),
          // 阴影
          boxShadow: const [
            BoxShadow(
              color: Color(0x20000000),

              /// 底色,阴影颜色
              offset: Offset(0, 2),

              /// 阴影位置,从什么位置开始
              blurRadius: 1,

              /// 阴影模糊层度
              spreadRadius: 0,

              /// 阴影模糊大小
            ),
          ],
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(fontSize: 28.sp, color: Colors.black),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
