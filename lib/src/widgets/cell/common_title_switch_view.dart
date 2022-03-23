import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonTitleSwitchView extends Container{
  String title; //cell标题
  double? fontSize; //cell标题文字大小
  Color? titleNormalColor; //cell标题文字默认颜色
  Color? titleActivityColor; //cell标题文字选中颜色
  double? radius; //cell圆角大小
  Color? backColor; //cell背景颜色
  Color? switchNormalColor; //switch默认颜色
  Color? switchActivityColor; //switch选中颜色
  double? paddingH; //水平padding
  double? paddingV; //垂直padding
  bool activity; //是否选中
  Function(bool)? switchChange; //switch回调方法
  CommonTitleSwitchView({Key? key,required this.title,this.paddingH,required this.activity,this.paddingV,this.fontSize,this.titleNormalColor,this.titleActivityColor,this.radius,this.backColor,this.switchNormalColor,this.switchActivityColor,this.switchChange}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius??8.h),
        color: backColor??const Color(0xFFF6F7F9)
      ),
      padding: EdgeInsets.symmetric(horizontal: paddingH??20.w,vertical: paddingV??14.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: fontSize??16.sp,
              color: activity ? titleActivityColor??Colors.black : titleNormalColor??const Color(0xFF828282)
            ),
          ),
          Transform.scale(
            scale: 0.9,
            child: CupertinoSwitch(
              value: activity,
              activeColor: switchActivityColor??const Color(0xFF888BF4),
              trackColor: switchNormalColor??const Color(0xFFBDBDBD),
              onChanged: (bool value){
                if(switchChange != null){
                  switchChange!(value);
                }
              }
            ),
          )
        ],
      ),
    );
  }
}