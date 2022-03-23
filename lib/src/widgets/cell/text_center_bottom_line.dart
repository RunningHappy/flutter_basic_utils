import 'package:app_assembly/src/widgets/cell/line_cell.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 中心文字底部线
class TextCenterBottomLineCell extends StatelessWidget {
  final bool isCancel;
  final String title;
  final GestureTapCallback? tapCallback;

  const TextCenterBottomLineCell(
      {Key? key, required this.title, this.isCancel = false, this.tapCallback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: tapCallback,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.h),
                topRight: Radius.circular(12.h))),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 39.h),
              child: isCancel
                  ? Text(
                      title,
                      style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 36.sp,
                          color: const Color(0xFF41485D)),
                    )
                  : Text(
                      title,
                      style: TextStyle(
                          fontSize: 32.sp,
                          color: const Color(0xFF41485D)),
                    ),
            ),
            isCancel ? Container() : const LineCell()
          ],
        ),
      ),
    );
  }
}
