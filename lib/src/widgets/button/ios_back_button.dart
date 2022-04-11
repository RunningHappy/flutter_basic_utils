import 'package:flutter/material.dart';
import 'package:tapped/tapped.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///
/// iOS 返回按钮
///
class IosBackButton extends StatelessWidget {
  final Function? backCall;

  const IosBackButton({Key? key, this.backCall}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tapped(
      child: Container(
        color: Colors.white.withOpacity(0),
        padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 16.h),
        child: Icon(
          Icons.arrow_back_ios,
          size: 18.h,
        ),
      ),
      onTap: () {
        Navigator.of(context).pop();
        if (backCall != null) {
          backCall!.call();
        }
      },
    );
  }
}
