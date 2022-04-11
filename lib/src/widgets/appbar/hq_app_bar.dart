import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///
/// 自定义Appbar
///
class HqAppBar extends AppBar {
  HqAppBar(String title,
      {Key? key,
      required BuildContext con,
      required TabBar tabBar,
      String? backImg,
      List<Widget>? rightWidgets,
      bool isOpenCallBack = false,
      Function? backCallBack})
      : super(
            key: key,
            title: Title(
              color: Colors.white,
              child: Text(
                title,
                style: TextStyle(
                    fontSize: 33.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.w600),
              ),
            ),
            backgroundColor: Colors.white,
            leading: backImg == null
                ? Container()
                : GestureDetector(
                    onTap: () {
                      Navigator.pop(con);
                      if (isOpenCallBack) {
                        backCallBack!();
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 29.w, vertical: 28.w),
                      child: Image.asset(backImg,
                          width: 43.w, height: 43.w, fit: BoxFit.cover),
                    ),
                  ),
            actions: rightWidgets,
            bottom: tabBar);
}
