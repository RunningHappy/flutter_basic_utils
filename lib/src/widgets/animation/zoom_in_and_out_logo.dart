import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 放大缩小循环的动画显示logo
/// addStatusListener()在开始或结束时反转动画，产生了循环效果
class ZoomInAndOutLogo extends StatefulWidget {
  final Widget? child;
  const ZoomInAndOutLogo({Key? key, this.child}) : super(key: key);

  @override
  _ZoomInAndOutLogoState createState() => _ZoomInAndOutLogoState();
}

class _ZoomInAndOutLogoState extends State<ZoomInAndOutLogo> with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  Animation<double>? _animation;

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
    _animationController = AnimationController(duration: const Duration(milliseconds: 2000), vsync: this);
    _animation = Tween(begin: 0.0, end: 300.0).animate(_animationController!)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _animationController!.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _animationController!.forward();
        }
    });
    _animationController!.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedLogo(animation: _animation!, child: widget.child);
  }
}

class AnimatedLogo extends AnimatedWidget {
  final Widget? child;
  const AnimatedLogo({Key? key, this.child, required Animation<double> animation}) : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable as Animation<double>;
    return Center(
      child: Container(
          margin: EdgeInsets.symmetric(vertical: 10.h),
          width: animation.value,
          height: animation.value,
          child: child ?? const FlutterLogo()
      ),
    );
  }
}
