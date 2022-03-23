import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IconTitleButton extends GestureDetector {
  final String iconPath;
  final String title;
  final double iconWidth;
  final double titleSize;
  final Function callBack;

  IconTitleButton(
      {Key? key,
      required this.title,
      required this.iconPath,
      required this.callBack,
      required this.iconWidth,
      required this.titleSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: () {
        callBack();
      },
      child: Column(
        children: [
          Image.asset(
            iconPath,
            width: iconWidth,
            height: iconWidth,
          ),
          Container(
            margin: EdgeInsets.only(top: 14.h),
            child: Text(
              title,
              style: TextStyle(fontSize: titleSize, color: Colors.black),
            ),
          )
        ],
      ),
    );
  }
}
