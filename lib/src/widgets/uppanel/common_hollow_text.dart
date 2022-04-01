import 'package:flutter/material.dart';

///空心字体1
class HollowText1 extends StatelessWidget {
  final double strokeWidth; //描边宽度
  final Color strokeColor; //描边颜色
  final Text child; //Text

  const HollowText1({
    Key? key,
    required this.child,
    required this.strokeWidth,
    required this.strokeColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Text(
          child.data??'',
          style: child.style!.copyWith(
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeCap = StrokeCap.round
              ..strokeJoin = StrokeJoin.round
              ..strokeWidth = strokeWidth
              ..color = strokeColor,
          ),
          strutStyle: child.strutStyle,
          textAlign: child.textAlign,
          textDirection: child.textDirection,
          locale: child.locale,
          softWrap: child.softWrap,
          overflow: child.overflow,
          textScaleFactor: child.textScaleFactor,
          maxLines: child.maxLines,
          semanticsLabel: child.semanticsLabel,
          textWidthBasis: child.textWidthBasis,
          textHeightBehavior: child.textHeightBehavior,
        ),
        child,
      ],
    );
  }
}

///空心字体2
class HollowText2 extends StatelessWidget {
  final String text; //内容
  final double size; //字体大小
  final Color hollowColor; //空心颜色
  final double strokeWidth; //描边宽度
  final Color strokeColor; //描边颜色

  const HollowText2({
    Key? key,
    required this.text,
    required this.size,
    required this.hollowColor,
    required this.strokeColor,
    required this.strokeWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Text(
          text,
          style: TextStyle(
            fontSize: size,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = strokeWidth
              ..color = strokeColor,
          ),
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: size,
            color: hollowColor,
          ),
        )
      ],
    );
  }
}