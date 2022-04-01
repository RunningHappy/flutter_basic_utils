import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///
/// 数字自动增加动画
///
class AnimationText extends StatefulWidget {
  final int number;
  final int? duration;
  final Color? color;
  final double? fontSize;

  const AnimationText(
      {Key? key,
      required this.number,
      this.duration,
      this.color,
      this.fontSize})
      : super(key: key);

  @override
  _AnimationTextState createState() => _AnimationTextState();
}

class _AnimationTextState extends State<AnimationText>
    with TickerProviderStateMixin {
  AnimationController? _animationController;
  Animation? _animation;

  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _init();
    super.initState();
  }

  _init() {
    _animationController = AnimationController(
        duration: Duration(milliseconds: widget.duration ?? 2000), vsync: this);
    CurvedAnimation curve =
        CurvedAnimation(parent: _animationController!, curve: Curves.easeIn);
    _animation = IntTween(begin: 0, end: 300).animate(curve)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
//         controller.reverse();
        }
      });
    _animationController!.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _animation!,
        builder: (context, widget1) {
          return Text(
            _animation!.value.toString(),
            style: TextStyle(
                fontSize: widget.fontSize ?? 26.sp,
                color: widget.color ?? Colors.red),
          );
        });
  }
}
