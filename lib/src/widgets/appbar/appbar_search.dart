import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

searchAppBar(BuildContext context, TextEditingController searchController,
    TextInputType type, String holdText, String backImgPath,
    {Function? searchAction, List<TextInputFormatter>? inputFormatters}) {
  return AppBar(
    elevation: 0,
    centerTitle: true,
    backgroundColor: const Color(0xFFFFFFFF),
    automaticallyImplyLeading: false,
    title: Row(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Image.asset(
            backImgPath,
            width: 43.w,
            height: 43.w,
          ),
        ),
        Expanded(
            child: Container(
          margin: EdgeInsets.symmetric(horizontal: 22.w),
          padding: EdgeInsets.symmetric(
            horizontal: 22.w,
          ),
          height: 63.w,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32.w),
              color: const Color(0xFFF2F2F2)),
          child: Row(
            children: [
              Image.asset(
                'img/my_page_icon/get_in_car_search.png',
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
                        style: TextStyle(fontSize: 29.sp, color: Colors.black),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: holdText,
                            hintStyle: TextStyle(
                              fontSize: 29.sp,
                              color: const Color(0xFF999999),
                            ),
                            isDense: true,
                            contentPadding: EdgeInsets.only(top: 1.h)),
                        onSubmitted: (value) {
                          searchAction!();
                        },
                      )))
            ],
          ),
        )),
        Image.asset(
          backImgPath,
          width: 43.h,
          height: 43.h,
          color: Colors.transparent,
        ),
      ],
    ),
  );
}
