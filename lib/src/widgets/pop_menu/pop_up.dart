import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Popup extends StatelessWidget {
  final Widget child;
  final Function? onClick; // 点击 click 事件
  final double? left; // 距离左边位置
  final double? top; // 距离上面位置
  const Popup({
    Key? key,
    required this.child,
    this.onClick,
    this.left,
    this.top,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: GestureDetector(
        onTap: () {
          // 点击空白
          Navigator.pop(context);
        },
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.transparent,
            ),
            Positioned(
              left: left,
              top: top,
              child: GestureDetector(
                onTap: () {
                  if (onClick != null) {
                    Navigator.pop(context);
                    onClick!();
                  }
                },
                child: child,
              ),
            )
          ],
        ),
      ),
    );
  }
}
