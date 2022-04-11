import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///
/// 自带搜索的Appbar
///
commonSearchBar(
  TextEditingController controller, // TextEditingController
  String? pleaseHolderText, // 默认显示文字
  {
  double? fontSize, // 字体大小
  Function(String)? callBack, // 输入中回调
  Function()? tapTextField, // 点击输入框回调
  bool showRightBtn = true, // 是否显示右侧按钮
  bool enable = true, // 是否可以输入
  FocusNode? focusNode, // FocusNode
  bool showCancel = false, // 是否显示取消按钮
  Function()? clickCancel, // 点击取消按钮回调
  String? iconPath, // 输入框左侧图片路径
  String? rightIconPath, // 右侧按钮图片路径
  String? cancelText, // 取消按钮文字
  double? cancelTextSize, // 取消按钮文字大小
}) {
  return AppBar(
    backgroundColor: Colors.white,
    elevation: 0,
    leadingWidth: 0,
    title: showRightBtn
        ? Row(
            children: [
              Expanded(
                  child: GestureDetector(
                onTap: () {
                  if (!enable) {
                    if (tapTextField != null) {
                      tapTextField();
                    }
                  }
                },
                child: Container(
                  height: 37.h,
                  padding:
                      EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.5.h),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.h),
                      color: const Color(0xFFF3F5F7)),
                  child: Row(
                    children: [
                      iconPath != null
                          ? Row(
                              children: [
                                Image.asset(
                                  iconPath,
                                  height: 20.h,
                                  width: 20.h,
                                ),
                                SizedBox(
                                  width: 6.w,
                                ),
                              ],
                            )
                          : Container(),
                      Expanded(
                          child: TextField(
                        controller: controller,
                        style: TextStyle(
                            fontSize: fontSize ?? 14.sp, color: Colors.black),
                        enabled: enable,
                        decoration: InputDecoration(
                          isCollapsed: true,
                          // 高度包裹
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          hintText: pleaseHolderText,
                          hintStyle: TextStyle(
                            fontSize: fontSize ?? 14.sp,
                            color: const Color(0xFFBDBDBD),
                          ),
                        ),
                        onChanged: (value) {
                          callBack!(value);
                        },
                      ))
                    ],
                  ),
                ),
              )),
              rightIconPath != null
                  ? Row(
                      children: [
                        SizedBox(
                          width: 16.w,
                        ),
                        Image.asset(
                          rightIconPath,
                          width: 36.h,
                          height: 36.h,
                        )
                      ],
                    )
                  : Container()
            ],
          )
        : Row(
            children: [
              Expanded(
                  child: GestureDetector(
                onTap: () {
                  if (!enable) {
                    if (tapTextField != null) {
                      tapTextField();
                    }
                  }
                },
                child: Container(
                  height: 37.h,
                  padding:
                      EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.5.h),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.h),
                      color: const Color(0xFFF3F5F7),
                      border: Border.all(
                          width: showCancel ? 1.w : 0,
                          color: showCancel
                              ? const Color(0xFF5151C6)
                              : Colors.transparent)),
                  child: Row(
                    children: [
                      iconPath != null
                          ? Row(
                              children: [
                                Image.asset(
                                  iconPath,
                                  height: 20.h,
                                  width: 20.h,
                                ),
                                SizedBox(
                                  width: 6.w,
                                ),
                              ],
                            )
                          : Container(),
                      Expanded(
                          child: TextField(
                        controller: controller,
                        style: TextStyle(
                            fontSize: fontSize ?? 14.sp, color: Colors.black),
                        enabled: enable,
                        focusNode: focusNode!,
                        decoration: InputDecoration(
                          isCollapsed: true,
                          // 高度包裹
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          hintText: pleaseHolderText,
                          hintStyle: TextStyle(
                            fontSize: fontSize ?? 14.sp,
                            color: const Color(0xFFBDBDBD),
                          ),
                        ),
                        onChanged: (value) {
                          callBack!(value);
                        },
                      ))
                    ],
                  ),
                ),
              )),
              Offstage(
                offstage: showCancel ? false : true,
                child: GestureDetector(
                  onTap: () {
                    clickCancel!();
                  },
                  child: Row(
                    children: [
                      SizedBox(
                        width: 16.w,
                      ),
                      Text(
                        cancelText ?? 'Cancel',
                        style: TextStyle(
                            fontSize: cancelTextSize ?? 14.sp,
                            color: Colors.black),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
  );
}
