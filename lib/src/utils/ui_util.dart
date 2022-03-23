import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UIUtils {
  static BoxDecoration boxDecoration = BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(16.h)),
      boxShadow: [
        BoxShadow(
            color: Colors.black12,
            offset: Offset(2.w, 3.h), // 阴影xy轴偏移量
            blurRadius: 16.w, // 阴影模糊程度
            spreadRadius: 0 // 阴影扩散程度
            )
      ]);

  static Border border =
      const Border(top: BorderSide(width: 1, color: Color(0xFFDDDDDD)));

  static BorderRadius borderRadius = BorderRadius.all(Radius.circular(16.h));

  static BoxDecoration borderWaybillCardImg = const BoxDecoration(
    image: DecorationImage(
      fit: BoxFit.fill,
      image: AssetImage('images/settlement/card_bg.png'),
    ),
  );

  static AppBar getAppBar(BuildContext context, {required Map params}) {
    return AppBar(
        title: Text(
          params['name'],
          style: TextStyle(fontSize: 32.sp, color: const Color(0xFF1D2023)),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              size: 40.sp,
              color: const Color(0xFF1D2023),
            ),
            onPressed: () {
              Navigator.pop(context);
            }));
  }
}
