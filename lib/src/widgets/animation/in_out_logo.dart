import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///
/// 使用AnimatedWidget循环的进行放大和缩小，
/// 现在考虑一下如何再添加一个在透明和不透明之间循环的动画
///
class InOutLogo extends StatefulWidget {
  final Widget? child;
  const InOutLogo({Key? key, this.child}) : super(key: key);

  @override
  _InOutLogoState createState() => _InOutLogoState();
}

class _InOutLogoState extends State<InOutLogo> with TickerProviderStateMixin {
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
    _animation = CurvedAnimation(parent: _animationController!, curve: Curves.easeIn)
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
    return InOutAnimatedLogo(animation: _animation!, child: widget.child);
  }
}


class InOutAnimatedLogo extends AnimatedWidget {
  static final _opacityTween = Tween<double>(begin: 0.1, end: 1.0);
  static final _sizeTween = Tween<double>(begin: 0.0, end: 300.0);
  final Widget? child;
  const InOutAnimatedLogo({Key? key, required Animation<double> animation, this.child}) : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable as Animation<double>;
    return Center(
      child: Opacity(
        opacity: _opacityTween.evaluate(animation),
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 10.h),
          height: _sizeTween.evaluate(animation),
          width: _sizeTween.evaluate(animation),
          child: child ?? const FlutterLogo(),
        ),
      ),
    );
  }
}
