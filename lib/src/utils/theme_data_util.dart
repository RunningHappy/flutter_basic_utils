import 'package:flutter/material.dart';

ThemeData myAppTheme(
    Color primaryColor, Color scaffoldBackgroundColor, Color textThemeColor) {
  return ThemeData(
    /// fontFamily: "pingfang",
    primaryColor: primaryColor,
    scaffoldBackgroundColor: scaffoldBackgroundColor,

    /// 对话框背景颜色
    dialogBackgroundColor: Colors.white,

    /// 设置App导航栏主题
    appBarTheme: const AppBarTheme(
        elevation: 0, centerTitle: true, brightness: Brightness.light),
    dividerTheme: const DividerThemeData(
      space: 0,
    ),

    /// dividerColor: Color(KColors.divider_color),
    /// 通用文本信息设置
    textTheme: TextTheme(
        bodyText1:
            TextStyle(color: textThemeColor, fontWeight: FontWeight.w400)),
  );
}
