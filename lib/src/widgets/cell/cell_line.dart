import 'package:app_assembly/app_assembly.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 单元格
class CellLine extends StatelessWidget {
  final double height;
  final Widget leftWidget;
  final Widget rightWidget;
  final Widget bottomWidget;
  final LocationType locationType;
  final GestureTapCallback? tapCallback;

  const CellLine(
      {Key? key,
      required this.height,
      this.locationType = LocationType.start,
      required this.leftWidget,
      required this.rightWidget,
      required this.bottomWidget,
      this.tapCallback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start;
    if (locationType == LocationType.start) {
      mainAxisAlignment = MainAxisAlignment.start;
    } else if (locationType == LocationType.end) {
      mainAxisAlignment = MainAxisAlignment.end;
    } else {
      mainAxisAlignment = MainAxisAlignment.spaceBetween;
    }

    return GestureDetector(
      onTap: tapCallback,
      child: SizedBox(
        height: height,
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: mainAxisAlignment,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      leftWidget,
                      locationType != LocationType.between
                          ? SizedBox(width: 10.w)
                          : Container(),
                      rightWidget,
                    ],
                  ),
                  SizedBox(height: 4.h),
                  bottomWidget,
                ],
              ),
            ),
            Container(height: 1, color: Colors.black12)
          ],
        ),
      ),
    );
  }
}

enum LocationType { start, end, between }
