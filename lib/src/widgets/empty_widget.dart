import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 空页面
class EmptyPage extends StatefulWidget {
  final bool showEmpty;
  final String title;
  final String iconPath;
  final Widget childWidget;

  const EmptyPage(
      {Key? key,
      required this.showEmpty,
      required this.title,
      required this.iconPath,
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
                  margin: EdgeInsets.only(bottom: 44.h),
                  child: Container(
                    width: 476.w,
                    height: 320.h,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(widget.iconPath),
                    )),
                  )),
              Text(
                widget.title,
                style: TextStyle(
                  fontSize: 24.sp,
                  color: Colors.black,
                ),
              )
            ],
          ))
        : widget.childWidget;
  }
}
