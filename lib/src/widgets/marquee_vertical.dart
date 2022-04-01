import 'dart:async';
import 'package:flutter/material.dart';

///
/// 跑马灯(纵向)
///
class MarqueeVertical extends StatefulWidget {
  final Duration? duration; // 轮播时间
  final double? stepOffset; // 偏移量
  final double? paddingLeft; // 内容之间的间距
  final List<Widget>? children; // 内容
  const MarqueeVertical(
      {Key? key,
      this.paddingLeft,
      this.duration,
      this.stepOffset,
      this.children})
      : super(key: key);

  @override
  _MarqueeVerticalState createState() => _MarqueeVerticalState();
}

class _MarqueeVerticalState extends State<MarqueeVertical> {
  late ScrollController _controller; // 执行动画的controller
  late Timer _timer; // 定时器timer
  double _offset = 0.0; // 执行动画的偏移量

  @override
  void initState() {
    super.initState();

    _controller = ScrollController(initialScrollOffset: _offset);
    _timer = Timer.periodic(widget.duration!, (timer) {
      double newOffset = _controller.offset + widget.stepOffset!;
      if (newOffset != _offset) {
        _offset = newOffset;
        _controller.animateTo(_offset,
            duration: widget.duration!, curve: Curves.linear); // 线性曲线动画
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
    List<Widget> items = [];
    List list = widget.children!;
    for (var i = 0; i < list.length; i++) {
      Container item = Container(
        margin: EdgeInsets.only(right: widget.paddingLeft!),
        child: list[i],
      );
      items.add(item);
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical, // 纵向滚动
      controller: _controller, // 滚动的controller
      itemBuilder: (context, index) {
        return _child();
      },
    );
  }
}
