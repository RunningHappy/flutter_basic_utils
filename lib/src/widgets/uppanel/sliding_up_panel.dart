import 'package:app_assembly/app_assembly.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

///
/// 底部上拉抽屉效果
///
class SlidingUpPanelViewFrame extends StatefulWidget {
  final Widget topTapView;

  final Widget contentView;

  final Widget body;

  final double? topTapMinHeight;

  final double? topTapMaxHeight;

  final List<Widget>? rightActions;

  final double? titleSize;

  final String title;

  final String? backIconPath;

  final double? opactity;

  final double? radius;

  final double? marginH;

  final PanelController controller;

  const SlidingUpPanelViewFrame(
      {Key? key,
        required this.topTapView, // 悬停头部组件
        required this.contentView, // 拉出显示内容组件
        required this.body, // 主内容组件
        this.topTapMinHeight, // 悬停最小高度
        this.topTapMaxHeight, // 悬停最大高度
        this.rightActions, // 导航栏右侧内容集合
        this.titleSize, // 导航栏标题字体大小
        required this.title, // 导航栏标题
        this.backIconPath, // 导航栏返回按钮图片地址
        this.opactity, // 导航栏背景透明度
        this.radius, // 底部显示圆角
        this.marginH, // 底部水平margin
        required this.controller // PanelController
      })
      : super(key: key);

  @override
  _SlidingUpPanelViewFrameState createState() =>
      _SlidingUpPanelViewFrameState();
}

class _SlidingUpPanelViewFrameState extends State<SlidingUpPanelViewFrame> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: commonTansAppBar(widget.opactity ?? 1, () {
        Navigator.of(context).pop();
      },
          title: widget.title,
          fontSize: widget.titleSize ?? 32.sp,
          showBack: true,
          actions: widget.rightActions ?? [],
          backIconPath: widget.backIconPath),
      body: SlidingUpPanel(
        controller: widget.controller,
        renderPanelSheet: true,
        panel: widget.topTapView,
        collapsed: widget.contentView,
        minHeight: widget.topTapMinHeight ?? 30.h,
        maxHeight:
        widget.topTapMaxHeight ?? MediaQuery.of(context).size.height / 2,
        margin: EdgeInsets.symmetric(horizontal: widget.marginH ?? 8.w),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(widget.radius ?? 5.w),
            topRight: Radius.circular(widget.radius ?? 5.w)),
        body: widget.body,
      ),
    );
  }
}
