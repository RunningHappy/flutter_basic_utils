import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum ActionWorld {
  sendGoods,
  historyBtn,
  changePounds,
}

newAppBar(BuildContext context, String title, Color backgroundColor,
    Color backIconColor, bool showBack, String iconPath,
    {Function? goBack,
    Function? actionAction,
    ActionWorld? actionWorld,
    required String titleWorld,
    Color titleColor = Colors.black,
    Color iconColor = Colors.black}) {
  void back() async {
    if (goBack != null) {
      goBack();
    } else {
      Navigator.pop(context);
    }
  }

  void actionMoth() {
    if (actionAction != null) {
      actionAction();
    } else {}
  }

  List<Widget> setNewAction() {
    if (actionWorld != null) {
      if (actionWorld == ActionWorld.sendGoods) {
        return [
          InkWell(
              child: Container(
                padding: EdgeInsets.all(ScreenUtil().setWidth(30)),
                child: Text(
                  titleWorld,
                  style: const TextStyle(color: Colors.black),
                ),
              ),
              onTap: actionMoth)
        ];
      } else if (actionWorld == ActionWorld.historyBtn) {
        return [
          InkWell(
              child: Container(
                padding: EdgeInsets.only(
                    top: ScreenUtil().setWidth(32),
                    right: ScreenUtil().setHeight(42)),
                child: Text(
                  titleWorld,
                  style: const TextStyle(color: Colors.black),
                ),
              ),
              onTap: actionMoth)
        ];
      } else if (actionWorld == ActionWorld.changePounds) {
        return [
          InkWell(
              child: Container(
                padding: EdgeInsets.only(
                    top: ScreenUtil().setWidth(32),
                    right: ScreenUtil().setHeight(42)),
                child: Text(
                  titleWorld,
                  style: const TextStyle(color: Colors.black),
                ),
              ),
              onTap: actionMoth)
        ];
      } else {
        return [];
      }
    }
    return [];
  }

  return AppBar(
      title: Text(
        title,
        style: TextStyle(
            fontSize: 33.w, color: titleColor, fontWeight: FontWeight.w600),
      ),
      elevation: 0,
      centerTitle: true,
      backgroundColor: backgroundColor,
      leading: showBack
          ? GestureDetector(
              onTap: back,
              child: iconPath == ""
                  ? Container()
                  : Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 29.w, vertical: 28.w),
                      child: Image.asset(
                        iconPath,
                        width: 43.w,
                        height: 43.w,
                        color: iconColor,
                      ),
                    ),
            )
          : Container(),
      actions: setNewAction());
}
