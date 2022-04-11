import 'dart:async';
import 'package:flutter/material.dart';

enum MarqueeDirection {
  horizontal, // 横向
  vertical // 纵向
}

/// 跑马灯
class Marquee extends StatefulWidget {
  final MarqueeDirection marqueeDirection;
  final double height;
  final int duration; // 轮播时间
  final double stepOffset; // 偏移量
  final double paddingLeft; // 内容之间的间距
  final List<Widget> children; // 内容
  const Marquee(
      {Key? key,
      this.marqueeDirection = MarqueeDirection.horizontal,
      this.height = 100,
      this.paddingLeft = 10,
      this.duration = 2000,
      this.stepOffset = 10.0,
      required this.children})
      : super(key: key);

  @override
  _MarqueeState createState() => _MarqueeState();
}

class _MarqueeState extends State<Marquee> {
  late ScrollController _controller; // 执行动画的controller
  late Timer _timer; // 定时器timer
  double _offset = 0.0; // 执行动画的偏移量

  @override
  void initState() {
    super.initState();

    _controller = ScrollController(initialScrollOffset: _offset);
    _timer = Timer.periodic(Duration(milliseconds: widget.duration), (timer) {
      double newOffset = _controller.offset + widget.stepOffset;
      if (newOffset != _offset) {
        _offset = newOffset;
        _controller.animateTo(_offset,
            duration: Duration(milliseconds: widget.duration),
            curve: Curves.linear); // 线性曲线动画
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _controller.dispose();
    super.dispose();
  }

  Widget _child() {
    return Row(children: _children());
  }

  // 子视图
  List<Widget> _children() {
    return widget.children.map((e) {
      return Container(
        margin: EdgeInsets.only(right: widget.paddingLeft),
        child: e,
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: widget.marqueeDirection == MarqueeDirection.horizontal
            ? Axis.horizontal
            : Axis.vertical, // 横向滚动
        controller: _controller, // 滚动的controller
        itemBuilder: (context, index) {
          return _child();
        },
      ),
    );
  }
}
