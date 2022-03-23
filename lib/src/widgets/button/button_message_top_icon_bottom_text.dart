import 'package:app_assembly/app_assembly.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 上图片，下文字，右边有角标数的 button
class MessageNumTopIconBottomTextButton extends StatelessWidget {
  final String icon;
  final String title;
  final double height;
  final double width;
  final int count;
  final GestureTapCallback? tapCallback;

  const MessageNumTopIconBottomTextButton(
      {Key? key,
      required this.height,
      required this.width,
      required this.icon,
      required this.title,
      this.count = 0,
      this.tapCallback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: tapCallback,
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 6.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(icon,
                    fit: BoxFit.cover, height: height, width: width),
                SizedBox(height: 4.h),
                Text(
                  title,
                  style: TextStyle(fontSize: 28.sp, color: Colors.black),
                ),
              ],
            ),
          ),

          /// 未读数
          Positioned(
            top: 10.h,
            right: 5.w,
            child: unreadCountWidget(
              count,
            ),
          ),
        ],
      ),
    );
  }
}
