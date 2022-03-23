import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonGradientBtn extends GestureDetector{
  String title;
  double? fontSize;
  Color? titleColor;
  double? width;
  double? height;
  Alignment? linearStart;
  Alignment? linearEnd;
  double? radius;
  List<Color>? linearColors;
  Color? backColor;
  FontWeight? fontWeight;
  Function()? callBack;
  String? iconPath;
  double? iconSize;
  CommonGradientBtn({Key? key,
    required this.title,
    this.fontSize,
    this.width,
    this.callBack,
    this.height,
    this.fontWeight,
    this.linearStart,
    this.linearEnd,
    this.linearColors,
    this.iconPath,
    this.iconSize,
    this.backColor,
    this.titleColor}) :
        super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: (){
        if(callBack != null){
          callBack!();
        }
      },
      child: Container(
        height: height??52.h,
        width: width??315.w,
        decoration: linearColors!.isNotEmpty ? BoxDecoration(
          borderRadius: BorderRadius.circular(radius??30.h),
          gradient: LinearGradient(
            begin: linearStart??Alignment.centerLeft,
            end: linearEnd??Alignment.centerRight,
            colors: linearColors??[const Color(0xFF5151C6),const Color(0xFF888BF4)]
          )
        ) : BoxDecoration(
          borderRadius: BorderRadius.circular(radius??30.h),
          color: backColor??Colors.white
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            iconPath != null ? Row(
              children: [
                Image.asset(
                  iconPath!,
                  width: iconSize??50.w,
                  height: iconSize??50.h,
                )
              ],
            ) : Container(),
            Text(
              title,
              style: TextStyle(
                fontSize: fontSize??16.sp,
                color: titleColor??Colors.white,
                fontWeight: fontWeight??FontWeight.w600
              ),
            )
          ],
        ),
      ),
    );
  }
}