import 'package:app_assembly/app_assembly.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///
/// 包含头像，右角标数的 button - 消息
///
class MessageAvatarNumButton extends StatelessWidget {
  final String avatarUrl;
  final String placeholder;
  final int count;
  final double? height;
  final GestureTapCallback? tapCallback;

  const MessageAvatarNumButton(
      {Key? key,
      required this.avatarUrl,
      required this.placeholder,
      this.count = 0,
      this.height,
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
      child: Stack(
        children: [
          /// 头像
          Positioned(
            child: Container(
              constraints: BoxConstraints(
                  maxHeight: height ?? 87.w, maxWidth: height ?? 87.w),
              margin: EdgeInsets.symmetric(vertical: 20.h),
              child: // 头像，可以替换为用户相关的头像url
                  ClipRRect(
                borderRadius: BorderRadius.circular(10.h),
                child: MyNetWorkImage(
                  url: avatarUrl,
                  width: double.infinity,
                  height: height ?? 87.w,
                  fit: BoxFit.cover,
                  placeHolderWidget: Image.asset(
                    placeholder,
                    width: height ?? 87.w,
                    height: height ?? 87.w,
                  ),
                ),
              ),
            ),
          ),

          /// 未读数
          Positioned(
            top: 0,
            right: 0,
            child: unreadCountWidget(
              count,
            ),
          ),
        ],
      ),
    );
  }
}

/// 未读数
unreadCountWidget(int unreadCount) {
  if (unreadCount == 0) return Container();
  String count;
  if (unreadCount > 99) {
    count = '99+';
  } else {
    count = unreadCount.toString();
  }
  return Container(
    padding: EdgeInsets.only(left: 6.w, right: 6.w),
    decoration: BoxDecoration(
      color: Colors.red,
      borderRadius: BorderRadius.all(
        Radius.circular(30.w),
      ),
    ),
    constraints: BoxConstraints(
      minWidth: 36.w,
      maxWidth: 60.w,
    ),
    child: Text(
      count,
      maxLines: 1,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 24.sp,
        color: Colors.white,
      ),
    ),
  );
}
