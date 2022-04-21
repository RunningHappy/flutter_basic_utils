import 'package:flutter/material.dart';

///
/// 轮播点
///
class SlideViewIndicator extends StatefulWidget {
  final int count;

  const SlideViewIndicator(this.count, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => SlideViewIndicatorState();
}

class SlideViewIndicatorState extends State<SlideViewIndicator> {
  final double _dotWidth = 8.0;
  int _selectedIndex = 0;

  setSelectedIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> dots = [];
    for (int i = 0; i < widget.count; i++) {
      if (i == _selectedIndex) {
        // 选中的dot
        dots.add(Container(
          width: _dotWidth,
          height: _dotWidth,
          decoration: const BoxDecoration(
              color: Color(0xffffffff), shape: BoxShape.circle),
          margin: const EdgeInsets.all(3.0),
        ));
      } else {
        // 未选中的dot
        dots.add(Container(
          width: _dotWidth,
          height: _dotWidth,
          decoration: const BoxDecoration(
              color: Color(0xff888888), shape: BoxShape.circle),
          margin: const EdgeInsets.all(3.0),
        ));
      }
    }
    return Container(
      height: 30.0,
      color: const Color(0x00000000),
      margin: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 5.0),
      child: Center(
          child: Row(
        children: dots,
        mainAxisAlignment: MainAxisAlignment.center,
      )),
    );
  }
}
