import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///
/// 逐渐放大的动画显示logo
///
class ZoomInSlowlyLogo extends StatefulWidget {
  final Widget? child;
  const ZoomInSlowlyLogo({Key? key, this.child}) : super(key: key);

  @override
  _ZoomInSlowlyLogoState createState() => _ZoomInSlowlyLogoState();
}

class _ZoomInSlowlyLogoState extends State<ZoomInSlowlyLogo> with SingleTickerProviderStateMixin {
  Animation<double>? _animation;
  AnimationController? _animationController;

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
    _animation = Tween(begin: 0.0, end: 300.0).animate(_animationController!)..addListener(() {
      setState(() {});
    });
    _animationController!.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10.h),
        width: _animation!.value,
        height: _animation!.value,
        child: widget.child ?? const FlutterLogo()
      ),
    );
  }
}
