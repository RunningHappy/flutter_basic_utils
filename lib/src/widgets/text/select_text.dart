import 'package:app_assembly/app_assembly.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 文本选择
class SelectText extends StatelessWidget {
  const SelectText({
    Key? key,
    this.isSelect = true,
    this.title,
  }) : super(key: key);

  final bool isSelect;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      color: Colors.black.withOpacity(0),
      child: Text(
        title ?? '??',
        textAlign: TextAlign.center,
        style:
            isSelect ? StandardTextStyle.big : StandardTextStyle.bigWithOpacity,
      ),
    );
  }
}
