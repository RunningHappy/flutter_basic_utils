import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

CommonTansAppBar(
  double opacity, //导航栏背景透明度
  Function()? clickBack, //返回按钮回调
  {
    String? title, //标题
    double? fontSize, //标题文字打下
    bool? showBack = true, //是否显示返回按钮
    List<Widget>? actions, //右侧按钮集合
    FontWeight? fontWeight, //标题文字粗细
    Color? backIconColor, //返回按钮背景颜色
    String? backIconPath //返回按钮图片地址
  }){

  return AppBar(
    backgroundColor: Color.fromRGBO(255, 255, 255, opacity),
    elevation: 0,
    leadingWidth: 50.w,
    title: Offstage(
      offstage: title != null ? false : true,
      child: Text(
        title??'',
        style: TextStyle(
          fontSize: fontSize??14.sp,
          fontWeight: fontWeight??FontWeight.normal,
          color: opacity > 0.4 ? Color.fromRGBO(0, 0, 0, opacity) : Colors.white,
        ),
      ),
    ),
    leading: Offstage(
      offstage: showBack! ? false : true,
      child: GestureDetector(
        onTap: (){
          if(clickBack != null){
            clickBack();
          }
        },
        child: Container(
          margin: EdgeInsets.only(left: 15.w,top: 8.w,bottom: 8.w),
          width: 32.w,
          height: 32.w,
          padding: EdgeInsets.all(4.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6.w),
            color: backIconColor??const Color(0x20FFFFFF)
          ),
          child: Image.asset(
            backIconPath??'',
            width: 24.w,
            height: 24.w,
            color: opacity > 0.4 ? Color.fromRGBO(0, 0, 0, opacity) : Colors.white,
          ),
        ),
      ),
    ),
    actions: actions??[],
  );
}