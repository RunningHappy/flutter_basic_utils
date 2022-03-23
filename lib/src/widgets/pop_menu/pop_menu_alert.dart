import 'package:app_assembly/app_assembly.dart';
import 'package:app_assembly/src/widgets/pop_menu/pop_route.dart';
import 'package:app_assembly/src/widgets/pop_menu/pop_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 弹出菜单
class PopupMenuAlert extends StatefulWidget {
  final double? containerWidth;
  final Widget child;
  final List titles;
  final Function? tapCallback;

  const PopupMenuAlert(
      {Key? key,
      this.containerWidth,
      required this.child,
      required this.titles,
      this.tapCallback})
      : super(key: key);

  @override
  _PopupMenuAlertState createState() => _PopupMenuAlertState();
}

class _PopupMenuAlertState extends State<PopupMenuAlert> {
  final GlobalKey _globalKey = GlobalKey();
  double _width = 0.0;

  @override
  void initState() {
    _init();
    super.initState();
  }

  _init() {
    if (widget.containerWidth == null) {
      _width = 175.w;
    } else {
      _width = widget.containerWidth!;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return _buildWidget();
  }

  _buildWidget() {
    return GestureDetector(
      onTap: _showPopMenu,
      child: widget.child,
      key: _globalKey,
    );
  }

  _buildMenuWidget(bool isUp) {
    double height = 84.h * widget.titles.length + 5.h * 2;
    return Column(
      children: [
        // Image.asset("img/public_image/menu_up_arrow.png", height: 20.h, width: 40.w, fit: BoxFit.cover, color: const Color(KColors.color_10000000)),
        isUp
            ? Container()
            : Container(
                width: 40.w,
                height: 0,
                decoration: BoxDecoration(
                    border: Border(
                      // 四个值 top right bottom left
                      bottom: BorderSide(
                          color: const Color(0x10000000),
                          width: 20.w),
                      right: BorderSide(color: Colors.transparent, width: 20.w),
                      left: BorderSide(color: Colors.transparent, width: 20.w),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: const Color(0x10000000),
                          offset: Offset(0, 4.w), // 阴影xy轴偏移量
                          blurRadius: 24.w, // 阴影模糊程度
                          spreadRadius: 2.w // 阴影扩散程度
                          )
                    ]),
              ),
        Container(
          height: height,
          width: _width,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.h),
              boxShadow: [
                BoxShadow(
                    color: const Color(0x10000000),
                    offset: Offset(0, 4.w), // 阴影xy轴偏移量
                    blurRadius: 24.w, // 阴影模糊程度
                    spreadRadius: 2.w // 阴影扩散程度
                    )
              ]),
          child: ListView.builder(
            padding: EdgeInsets.symmetric(vertical: 13.h),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  if (widget.tapCallback != null) {
                    Navigator.pop(context);
                    widget.tapCallback!(index);
                  }
                },
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 32.w, vertical: 13.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        widget.titles[index],
                        style: TextStyle(
                            fontSize: 28.sp,
                            color: const Color(0xFF41485D)),
                      )
                    ],
                  ),
                ),
              );
            },
            itemCount: widget.titles.length,
          ),
        ),
        !isUp
            ? Container()
            : Container(
                width: 40.w,
                height: 0,
                decoration: BoxDecoration(
                    border: Border(
                      // 四个值 top right bottom left
                      top: BorderSide(
                          color: const Color(0x10000000),
                          width: 20.w),
                      right: BorderSide(color: Colors.transparent, width: 20.w),
                      left: BorderSide(color: Colors.transparent, width: 20.w),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: const Color(0x10000000),
                          offset: Offset(0, 4.w), // 阴影xy轴偏移量
                          blurRadius: 24.w, // 阴影模糊程度
                          spreadRadius: 2.w // 阴影扩散程度
                          )
                    ]),
              )
      ],
    );
  }

  _showPopMenu() {
    Rect rect = globalPaintBounds(_globalKey);
    double screenHeight = MediaQuery.of(context).size.height;
    double boxHeight = 84.h * widget.titles.length + 5.h * 2;

    if (rect.top > screenHeight / 2) {
      Navigator.push(
          context,
          PopRoute(
            child: Popup(
              child: _buildMenuWidget(true),
              left: rect.left - 85.w,
              top: rect.top - boxHeight - 20.w,
              onClick: () {},
            ),
          ));
    } else {
      Navigator.push(
          context,
          PopRoute(
            child: Popup(
              child: _buildMenuWidget(false),
              left: rect.left - 85.w,
              top: rect.top + 70.h,
              onClick: () {},
            ),
          ));
    }
  }
}
