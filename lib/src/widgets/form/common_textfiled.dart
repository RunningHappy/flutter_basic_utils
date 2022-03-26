import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum CommonTextFieldType {
  normal,
  password,
}

class CommonTextField extends Container{
  TextEditingController controller;
  String? plaseText;
  double? fontSize;
  CommonTextFieldType? commonType;
  TextInputType? textInputType;
  Function(String)? callBack;
  List<TextInputFormatter>? inputFormatter;
  TextAlign? textAlign;
  String? iconPath;
  double? height;
  double? paddingH;
  double? paddingV;
  double? radius;
  double? iconWidth;
  Color? backColor;
  Color? placeColor;
  CommonTextField({
    Key? key,
    required this.controller,
    this.plaseText,
    this.fontSize,
    this.commonType = CommonTextFieldType.normal,
    this.callBack,
    this.textInputType,
    this.inputFormatter,
    this.textAlign,
    this.iconPath,
    this.height,
    this.paddingV,
    this.paddingH,
    this.radius,
    this.iconWidth,
    this.backColor,
    this.placeColor
  }) : super(key: key);
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: height??50.h,
      padding: EdgeInsets.symmetric(horizontal: paddingH??20.w,vertical: paddingV??13.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius??30.h),
        color: backColor??const Color(0xFFF3F5F7),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              style: TextStyle(
                fontSize: fontSize ?? 16.sp,
                color: Colors.black
              ),
              textAlign: textAlign??TextAlign.left,
              keyboardType: textInputType,
              decoration: InputDecoration(
                isCollapsed: true, // 高度包裹
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                hintText: plaseText,
                hintStyle: TextStyle(
                  fontSize: fontSize ?? 16.sp,
                  color: placeColor??const Color(0xFFBDBDBD),
                ),
              ),
              inputFormatters: inputFormatter,
              onChanged: (value) {
                callBack!(value);
              },
            )
          ),
          commonType == CommonTextFieldType.password ? iconPath != null ? Container(
            margin: EdgeInsets.only(left: 24.w),
            child: Image.asset(
              iconPath!,
              height: iconWidth??24.h,
              width: iconWidth??24.h,
            ),
          ) : Container() : Container()
        ],
      ),
    );
  }
}