import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonButton extends StatelessWidget {
  final bool isDisable;

  /// 判断是否可点击
  final double h;
  final String buttonName;
  final VoidCallback onPressed;
  final double? fontSize;

  const CommonButton({
    Key? key,
    this.isDisable = false,
    required this.buttonName,
    required this.h,
    required this.onPressed,
    this.fontSize
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SizedBox(
      width: double.infinity,
      height: h.h,
      child: RaisedButton(
        elevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(h))),
        disabledColor: Colors.blueAccent.withOpacity(.5),
        color: Colors.blueAccent,
        child: Text(buttonName,
            style: TextStyle(
                color: isDisable ? Colors.white : Colors.grey,
                fontWeight: FontWeight.w400,
                fontSize: fontSize??32.sp)),
        onPressed: isDisable ? onPressed : null,
      ),
    );
  }
}
