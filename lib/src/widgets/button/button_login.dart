import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginButton extends GestureDetector {
  final String title;
  final bool type;
  final double fontSize;
  final Function callBack;

  LoginButton(
      {Key? key,
      required this.title,
      required this.type,
      required this.fontSize,
      required this.callBack})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: () {
        if (type) {
          callBack();
        }
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(51.w),
            color: !type ? Colors.blue : Colors.blueAccent),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: fontSize, color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
