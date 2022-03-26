import 'dart:math';
import 'package:flutter/material.dart';

/// "孔雀开屏"转场动画
class OpenNextAnimation {
  OpenNextAnimation();

  static popScreen(BuildContext buildContext) {
    Navigator.of(buildContext).pop();
  }

  static pushScreen(BuildContext buildContext, {required Widget nextPage}) {
    Navigator.of(buildContext).push(CirclePageRoute(builder: (context) {
      return nextPage;
    }));
  }
}

class CirclePageRoute extends PageRoute {
  CirclePageRoute({
    required this.builder,
    this.transitionDuration = const Duration(milliseconds: 500),
    this.opaque = true,
    this.barrierDismissible = false,
    this.barrierColor,
    this.barrierLabel,
    this.maintainState = true,
  });

  final WidgetBuilder builder;

  @override
  final Duration transitionDuration;

  @override
  final bool opaque;

  @override
  final bool barrierDismissible;

  @override
  final Color? barrierColor;

  @override
  final String? barrierLabel;

  @override
  final bool maintainState;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return ClipPath(
          clipper: CirclePath(animation.value),
          child: child,
        );
      },
      child: builder(context),
    );
  }
}

/// 裁切的路径
class CirclePath extends CustomClipper<Path> {
  CirclePath(this.value);

  final double value;

  @override
  Path getClip(Size size) {
    var path = Path();
    double radius =
        value * sqrt(size.height * size.height + size.width * size.width);
    path.addOval(Rect.fromLTRB(
        size.width - radius, -radius, size.width + radius, radius));
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
