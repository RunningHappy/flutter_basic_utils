import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TitleModel {
  String title;
  bool select;

  TitleModel(this.title, this.select);
}

///
///滑动选项卡
///
class CommonSegment extends Container {
  final List<TitleModel> titleList; // 选项卡集合
  final double? fontSize; // 字体大小
  final Color? normalColor; // 默认字体颜色
  final Color? selectColor; // 选中字体颜色
  final Color? normalBackColor; // 默认背景颜色
  final Color? selectBackColor; // 选中背景颜色
  final double? itemWidth; // 选项卡宽度
  final double? itemHeight; // 选项卡长度
  final double? height; // 组件高度
  final double? paddingLeft; //
  final double? paddingRight; //
  final double? radius; // 选项卡圆角
  final Function(dynamic)? callBack; // 选项卡点击回调
  CommonSegment(
    {Key? key,
    this.height,
    required this.titleList,
    this.itemWidth,
    this.itemHeight,
    this.fontSize,
    this.callBack,
    this.normalColor,
    this.selectColor,
    this.normalBackColor,
    this.selectBackColor,
    this.paddingRight,
    this.paddingLeft,
    this.radius})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.fromLTRB(0.w, 6.h, 0, 6.h),
      height: height ?? 51.h,
      color: Colors.white,
      child: ListView.builder(
        padding: EdgeInsets.only(left: paddingLeft ?? 10.w),
        itemCount: titleList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              if (callBack != null) {
                callBack!(index);
              }
            },
            child: Container(
              margin: EdgeInsets.only(right: paddingRight ?? 10.w),
              width: itemWidth ?? 118.w,
              height: itemHeight ?? 39.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radius ?? 6.h),
                color: titleList[index].select ? selectBackColor : normalBackColor
              ),
              child: Text(
                titleList[index].title,
                style: TextStyle(
                  fontSize: fontSize ?? 16.sp,
                  color: titleList[index].select ? selectColor : normalColor
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}
