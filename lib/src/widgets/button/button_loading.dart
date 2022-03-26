import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 包含 loading 的加载的 button
class LoadingButton extends StatefulWidget {
  final String title;
  final double height;
  final double width;
  final bool isShowLoading;
  final GestureTapCallback? tapCallback;

  const LoadingButton(
      {Key? key,
      required this.height,
      required this.width,
      required this.title,
      this.isShowLoading = false,
      this.tapCallback})
      : super(key: key);

  @override
  _LoadingButtonState createState() => _LoadingButtonState();
}

class _LoadingButtonState extends State<LoadingButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: !widget.isShowLoading ? widget.tapCallback : null,
      child: Container(
        height: widget.height,
        width: widget.width,
        color: !widget.isShowLoading ? Colors.blue : Colors.black12,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.title,
              style: TextStyle(fontSize: 28.sp, color: Colors.black),
              textAlign: TextAlign.center,
            ),
            widget.isShowLoading
                ? Row(
                    children: [
                      SizedBox(width: 10.w),
                      const CupertinoActivityIndicator(radius: 8)
                    ],
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
