import 'package:app_assembly/app_assembly.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///
/// 列表滚动，改变 Appbar 透明度
///
class OpacityAppBar extends StatefulWidget {
  final Widget? child;
  final String title;
  final String imgPath;
  final String backImgPath;
  final double? bgHeight;
  final Color titleColor;
  final bool bottomInset;
  final Color bgColor;
  final num appbarScrollOffset;

  const OpacityAppBar(
      {Key? key,
      this.child,
      required this.title,
      required this.imgPath,
      this.backImgPath = "",
      this.bgHeight,
      this.titleColor = Colors.transparent,
      this.appbarScrollOffset = 100,
      this.bottomInset = false,
      this.bgColor = Colors.white})
      : super(key: key);

  @override
  _OpacityAppBarState createState() => _OpacityAppBarState();
}

class _OpacityAppBarState extends State<OpacityAppBar> {
  double appBarAlpha = 0;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        // MediaQuery.removePadding 移除顶部的 padding
        // 使用Stack 的作用就是让AppBar 叠加在上面
        backgroundColor: widget.bgColor,
        resizeToAvoidBottomInset: widget.bottomInset,
        body: Stack(
          children: <Widget>[
            MediaQuery.removePadding(
              removeTop: true,
              context: context,
              // 监听列表的滚动
              child: NotificationListener(
                  // 滚动的回调
                  onNotification: (scrollNotifation) {
                    // 判断ListView滚动的效果
                    if (scrollNotifation is ScrollUpdateNotification &&
                        scrollNotifation.depth == 0) {
                      // 滚动且是列表滚动的的的时候
                      double offset = scrollNotifation.metrics.pixels;
                      double alpha = offset / widget.appbarScrollOffset;
                      if (alpha < 0) {
                        alpha = 0;
                      } else if (alpha > 1) {
                        alpha = 1;
                      }
                      setState(() {
                        appBarAlpha = alpha;
                      });
                    }
                    return false;
                  },
                  child: Stack(
                    children: [
                      Stack(
                        children: [
                          Image.asset(
                            widget.imgPath,
                            width: double.infinity,
                            height: widget.bgHeight??570.h,
                            fit: BoxFit.fill,
                          ),
                        ],
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height,
                        color: appBarAlpha > 0
                            ? widget.bgColor
                            : Color.fromRGBO(255, 255, 255, appBarAlpha),
                        child: widget.child,
                      )
                    ],
                  )),
            ),
            // 创建AppBar
            appBarAlpha == 0
                ? Container(
                    height: kToolbarHeight + MediaQuery.of(context).padding.top,
                    decoration: const BoxDecoration(color: Colors.transparent),
                    child: AppBar(
                      elevation: 0,
                      backgroundColor: Colors.transparent,
                      title: Text(
                        widget.title,
                        style: TextStyle(
                            fontSize: 33.w,
                            color: widget.titleColor,
                            fontWeight: FontWeight.w600),
                      ),
                      leading: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: widget.backImgPath == ""
                            ? Container()
                            : Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 29.w, vertical: 28.w),
                                child: Image.asset(
                                  widget.backImgPath,
                                  width: 43.w,
                                  height: 43.w,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    ),
                  )
                : Opacity(
                    // 当列表滚动的时候 改变其透明度的值
                    opacity: appBarAlpha,
                    alwaysIncludeSemantics: true,
                    child: Container(
                      height:
                          kToolbarHeight + MediaQuery.of(context).padding.top,
                      decoration: const BoxDecoration(color: Colors.white),
                      child: newAppBar(
                          context,
                          widget.title,
                          Colors.white,
                          const Color(0xFF1D2023),
                          widget.backImgPath == "" ? false : true,
                          widget.backImgPath,
                          titleWorld: ''),
                    ))
          ],
        ));
  }
}
