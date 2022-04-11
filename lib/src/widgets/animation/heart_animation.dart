import 'package:app_assembly/app_assembly.dart';
import 'package:flutter/material.dart';

/// 心跳动画
class ExampleHeartAnimation extends StatelessWidget {
  final Widget? child;

  const ExampleHeartAnimation({Key? key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: newAppBar(context, 'HeartAnimation', ThemeData().primaryColor,
          Colors.white, true, '',
          titleWorld: '', titleColor: Colors.white, iconColor: Colors.white),
      body: HeartAnimation(key: animationKey, child: child),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          if (!animationKey.currentState!._animationController!.isAnimating) {
            animationKey.currentState!._animationController!.forward();
          } else {
            animationKey.currentState!._animationController!.stop();
          }
        },
      ),
    );
  }
}

GlobalKey<_HeartAnimationState> animationKey = GlobalKey();

class HeartAnimation extends StatefulWidget {
  final Widget? child;

  const HeartAnimation({Key? key, this.child}) : super(key: key);

  @override
  _HeartAnimationState createState() => _HeartAnimationState();
}

class _HeartAnimationState extends State<HeartAnimation>
    with SingleTickerProviderStateMixin {
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
    // 1.创建AnimationController
    _animationController =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);
    // 2.动画添加Curve效果
    _animation = CurvedAnimation(
        parent: _animationController!,
        curve: Curves.elasticInOut,
        reverseCurve: Curves.easeOut);
    // 3.监听动画
    _animation!.addListener(() {
      setState(() {});
    });
    // 4.控制动画的翻转
    _animation!.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController!.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _animationController!.forward();
      }
    });
    // 5.设置值的范围
    _animation = Tween(begin: 50.0, end: 120.0).animate(_animationController!);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: widget.child ??
          Icon(Icons.favorite, color: Colors.red, size: _animation!.value),
    );
  }
}
