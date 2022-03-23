import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

searchTextFieldWidget(BuildContext context,
    TextEditingController searchController, TextInputType type, String holdText,
    {List<TextInputFormatter>? inputFormatters,
    Widget? leftWidget,
    Widget? rightWidget,
    String? imgPath,
    Function? searchAction}) {
  String _searchText = '';

  return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(37.h),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Color(0x20000000),

            /// 底色,阴影颜色
            offset: Offset(0, 2),

            /// 阴影位置,从什么位置开始
            blurRadius: 1,

            /// 阴影模糊层度
            spreadRadius: 0,

            /// 阴影模糊大小
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
              child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 22.w,
            ),
            height: 63.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32.w), color: Colors.white),
            child: Row(
              children: [
                Image.asset(
                  imgPath!,
                  width: 29.w,
                  height: 29.w,
                ),
                Expanded(
                    child: Container(
                        margin: EdgeInsets.only(left: 14.w),
                        child: TextField(
                          controller: searchController,
                          inputFormatters: inputFormatters,
                          keyboardType: type,
                          style:
                              TextStyle(fontSize: 29.sp, color: Colors.black),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: holdText,
                            hintStyle: TextStyle(
                              fontSize: 29.sp,
                              color: const Color(0xFF999999),
                            ),
                            isDense: true,
                            isCollapsed: true, // 高度包裹
                          ),
                          onChanged: (value) {
                            _searchText = value;
                            if (searchAction != null) {
                              searchAction(value);
                            }
                          },
                          onSubmitted: (value) {
                            _searchText = value;
                            if (searchAction != null) {
                              searchAction(value);
                            }
                          },
                        )))
              ],
            ),
          )),
          GestureDetector(
            onTap: () {
              if (searchAction != null) {
                searchAction(searchController.text);
              }
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 29.w),
              child: Row(
                children: [
                  Container(
                    width: 1.w,
                    height: 29.h,
                    color: const Color(0xFFD8D8D8),
                  ),
                  SizedBox(width: 14.w),
                  Text(
                    '搜索',
                    style: TextStyle(
                        fontSize: 29.sp, color: const Color(0xFF177FF3)),
                  )
                ],
              ),
            ),
          ),
        ],
      ));
}

searchLineWidget(BuildContext context, TextEditingController searchController,
    TextInputType type, String holdText,
    {bool enableInteractiveSelection = true,
    Widget? leftWidget,
    Widget? rightWidget,
    String? imgPath,
    Function? searchAction}) {
  String _searchText = '';

  return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(37.h),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Color(0x20000000),

            /// 底色,阴影颜色
            offset: Offset(0, 2),

            /// 阴影位置,从什么位置开始
            blurRadius: 1,

            /// 阴影模糊层度
            spreadRadius: 0,

            /// 阴影模糊大小
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
              child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 22.w,
            ),
            height: 63.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32.w), color: Colors.white),
            child: Row(
              children: [
                Image.asset(
                  imgPath!,
                  width: 29.w,
                  height: 29.w,
                ),
                Expanded(
                    child: Container(
                        margin: EdgeInsets.only(left: 14.w),
                        child: TextField(
                          controller: searchController,
                          keyboardType: type,
                          enableInteractiveSelection:
                              enableInteractiveSelection,
                          style:
                              TextStyle(fontSize: 29.sp, color: Colors.black),
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: holdText,
                              hintStyle: TextStyle(
                                fontSize: 29.sp,
                                color: const Color(0xFF999999),
                              ),
                              isDense: true,
                              contentPadding: EdgeInsets.only(top: 1.h)),
                          onChanged: (value) {
                            _searchText = value;
                          },
                          onSubmitted: (value) {
                            _searchText = value;
                            if (searchAction != null) {
                              searchAction(value);
                            }
                          },
                          onTap: () {
                            FocusScope.of(context).requestFocus(FocusNode());
                            searchAction!('');
                          },
                        )))
              ],
            ),
          ))
        ],
      ));
}

searchMapWidget(
  BuildContext context,
  TextEditingController searchController,
  TextInputType type,
  String holdText, {
  Widget? leftWidget,
  Widget? rightWidget,
  String? imgPath,
  Function? searchAction,
  Function? cancelAction,
}) {
  return Container(
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
              child: Container(
            padding: EdgeInsets.symmetric(horizontal: 22.w),
            margin: EdgeInsets.symmetric(horizontal: 22.w),
            height: 63.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32.w),
                color: const Color(0xFFF2F2F2)),
            child: Row(
              children: [
                Image.asset(
                  imgPath!,
                  width: 29.w,
                  height: 29.w,
                ),
                Expanded(
                    child: Container(
                        margin: EdgeInsets.only(left: 14.w),
                        child: TextField(
                          controller: searchController,
                          keyboardType: type,
                          style:
                              TextStyle(fontSize: 29.sp, color: Colors.black),
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: holdText,
                              hintStyle: TextStyle(
                                fontSize: 29.sp,
                                color: const Color(0xFF999999),
                              ),
                              isDense: true,
                              contentPadding: EdgeInsets.only(top: 1.h)),
                          onChanged: (value) {
                            if (searchAction != null) {
                              searchAction(value);
                            }
                          },
                          onSubmitted: (value) {
                            if (searchAction != null) {
                              searchAction(value);
                            }
                          },
                        )))
              ],
            ),
          )),
          GestureDetector(
            onTap: () {
              cancelAction!();
            },
            child: Container(
              margin: EdgeInsets.only(right: 29.w),
              child: Row(
                children: [
                  rightWidget ??
                      Text(
                        '取消',
                        style: TextStyle(
                            fontSize: 29.sp, color: const Color(0xFF1D2023)),
                      )
                ],
              ),
            ),
          ),
        ],
      ));
}
