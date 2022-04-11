import 'package:app_assembly/app_assembly.dart';
import 'package:app_assembly/src/utils/under_line_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///
/// 获取Appbar
///
AppBar getAppBar(BuildContext context,
    {String title = "",
    appBarTitleType = AppBarTitleType.text,
    List? pages,
    VoidCallback? onTap,
    Color? backgroundColor,
    Color? color,
    Widget? leading,
    List<Widget>? action,
    Widget? flexibleSpace,
    PreferredSizeWidget? bottom,
    TabController? controller}) {
  Widget titleContent = getTitle(title, color: color ?? Colors.black);
  if (appBarTitleType == AppBarTitleType.tabs) {
    assert(pages != null);
    titleContent = getTabs(pages!, controller: controller!);
  }
  return AppBar(
    title: titleContent,
    backgroundColor: backgroundColor ?? Colors.white,
    leading: leading ??
        getLeading(context, onTap: () {
          if (onTap != null) {
            onTap.call();
          }
        }, color: color ?? Colors.black),
    actions: action,
    flexibleSpace: flexibleSpace,
    // bottom: bottom,
  );
}

Widget getLeading(BuildContext context, {VoidCallback? onTap, Color? color}) {
  return IconButton(
    icon: Icon(
      Icons.arrow_back_ios,
      color: color ?? const Color(0xFF606972),
      size: 40.w,
    ),
    onPressed: onTap ??
        () {
          back(context);
        },
  );
}

Widget getTitle(String title, {Color? color}) {
  return Text(
    title,
    style: TextStyle(color: color ?? const Color(0xFF1D2023), fontSize: 40.sp),
  );
}

Widget getTabs(List pages, {bool? isScrollable, required TabController controller}) {
  return TabBar(
    isScrollable: isScrollable ?? true,
    controller: controller,
    labelPadding: isScrollable != null
        ? const EdgeInsets.only(bottom: 15, top: 16)
        : EdgeInsets.only(bottom: 15, top: 16, left: 24.w, right: 24.w),
    indicator: MyUnderlineTabIndicator(
        borderSide: BorderSide(width: 6.h, color: const Color(0xFF177FF3))),
    tabs: pages
        .map((e) => Text(
              e,
              style: TextStyle(fontSize: 28.sp),
            ))
        .toList(),
    unselectedLabelColor: const Color(0xFF999999),
    unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w400),
    labelColor: const Color(0xFF1D2023),
    labelStyle: const TextStyle(fontWeight: FontWeight.w600),
  );
}

enum AppBarTitleType { text, tabs }
