import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 空页面
class EmptyPage extends StatefulWidget {
  final bool showEmpty;
  final String title;
  final String iconPath;
  final Widget childWidget;
  final double? titleSize;
  final double? imageWidth;
  final double? imageHeight;
  final double? imageTitlePadding;

  const EmptyPage(
      {Key? key,
        required this.showEmpty,
        required this.title,
        required this.iconPath,
        this.titleSize,
        this.imageWidth,
        this.imageHeight,
        this.imageTitlePadding,
        required this.childWidget})
      : super(key: key);

  @override
  _EmptyPageState createState() => _EmptyPageState();
}

class _EmptyPageState extends State<EmptyPage> {
  @override
  Widget build(BuildContext context) {
    return widget.showEmpty
        ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                margin: EdgeInsets.only(bottom: widget.imageTitlePadding??44.h),
                child: Container(
                  width: widget.imageWidth??476.w,
                  height: widget.imageHeight??320.h,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(widget.iconPath),
                      )),
                )),
            Text(
              widget.title,
              style: TextStyle(
                fontSize: widget.titleSize??24.sp,
                color: Colors.black,
              ),
            )
          ],
        ))
        : widget.childWidget;
  }
}
