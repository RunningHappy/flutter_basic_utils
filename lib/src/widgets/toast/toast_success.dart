import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 含成功/失败的图片 toast
class SuccessToast {
  static OverlayEntry? overlayEntry;

  static final SuccessToast _showToast = SuccessToast._internal();

  factory SuccessToast() {
    return _showToast;
  }

  SuccessToast._internal();

  static toast(context, String text, String imgPath) {
    if (overlayEntry != null) return;
    overlayEntry = OverlayEntry(builder: (context) {
      return Container(
        color: const Color(0x4A000000),
        child: Center(
            child: Container(
                width: 408.w,
                height: 384.h,
                padding: EdgeInsets.fromLTRB(21.w, 29.h, 21.w, 42.h),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14.w)),
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Image.asset(
                      imgPath,
                      width: 366.w,
                      height: 313.h,
                    ),
                    Text(
                      text,
                      style: TextStyle(
                          fontSize: 29.sp, color: const Color(0xFF606972)),
                    )
                  ],
                ))),
      );
    });
    var overlayState = Overlay.of(context);
    overlayState!.insert(overlayEntry!);
    Future.delayed(const Duration(seconds: 3), () {
      overlayEntry!.remove();
      overlayEntry = null;
    });
  }

  static show(context, String text, String imgPath,
      {Function? delayedCallback}) {
    if (overlayEntry != null) return;
    overlayEntry = OverlayEntry(builder: (context) {
      return Container(
        color: const Color(0x4A000000),
        child: Center(
            child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
                width: 362.w,
                height: 340.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14.w),
                    color: Colors.white),
                padding: EdgeInsets.fromLTRB(30.w, 182.h, 50.w, 22.h),
                child: Row(
                  children: [
                    Expanded(
                        child: Text(
                      text,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 29.sp, color: const Color(0xFF606972)),
                    ))
                  ],
                )),
            Container(
              margin: EdgeInsets.only(top: 22.h),
              child: Image.asset(
                imgPath,
                width: 362.w,
                height: 138.h,
              ),
            ),
          ],
        )),
      );
    });
    var overlayState = Overlay.of(context);
    overlayState!.insert(overlayEntry!);
    Future.delayed(const Duration(seconds: 3), () {
      overlayEntry!.remove();
      overlayEntry = null;
      if (delayedCallback != null) {
        delayedCallback();
      }
    });
  }
}
