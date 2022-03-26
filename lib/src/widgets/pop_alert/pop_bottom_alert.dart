library app_assembly;

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

FixedExtentScrollController _controller =
    FixedExtentScrollController(initialItem: 0);
var state = '';

/// 底部弹出框
Future<void> popBottomSheetAlert(BuildContext context,
    {int? index,
    required List pickerChildren,
    required Function sureCallBack}) async {
  for (int i = 0; i < pickerChildren.length; i++) {
    if (i == index) {
      _controller = FixedExtentScrollController(initialItem: i);
    }
  }

  showCupertinoModalPopup(
      context: context,
      builder: (BuildContext conetxt) {
        return Container(
          height: 250,
          color: Colors.white,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 29.w, vertical: 14.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        '取消',
                        style: TextStyle(fontSize: 33.sp, color: Colors.blue),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        int idx = 0;
                        for (int i = 0; i < pickerChildren.length; i++) {
                          var item = pickerChildren[i];
                          if (item['state'] == state) {
                            idx = i;
                          }
                        }
                        Navigator.pop(context);
                        sureCallBack(idx);
                      },
                      child: Text(
                        '确定',
                        style: TextStyle(fontSize: 33.sp, color: Colors.blue),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                  child: CupertinoPicker(
                scrollController: _controller,
                useMagnifier: true,

                /// 使用放大镜
                magnification: 1.1,

                /// 当前选中item放大倍数
                itemExtent: 50,

                /// 行高
                backgroundColor: Colors.white,

                /// 选中器背景色
                onSelectedItemChanged: (value) {
                  state = pickerChildren[value]['state'];
                },
                children: pickerChildren.map((data) {
                  return Center(
                    child: Text(
                      data['name'],
                      style: TextStyle(fontSize: 33.sp, color: Colors.black),
                    ),
                  );
                }).toList(),
              ))
            ],
          ),
        );
      });
}
