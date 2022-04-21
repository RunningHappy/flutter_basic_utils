import 'package:flutter/material.dart';

class DialItem {
  /// 刻度标志内容
  String? dialText;

  /// 刻度标志样式
  TextStyle? dialTextStyle;

  /// x、y 轴刻度值。用于刻度在坐标的真实定位
  double value;

  DialItem({this.dialText, this.dialTextStyle, required this.value});
}

class PointData {
  /// x 点的值
  double x;

  /// y 点的值
  double y;

  /// PointData 展示的相对偏移量
  Offset offset;

  /// 点要展示的内容
  String? pointText;

  /// 点展示内容样式
  TextStyle? pointTextStyle;

  /// 折线节点的点击击事件是否可用
  bool isClickable;

  LineTouchData lineTouchData;

  PointData(
      {this.x = 0,
      this.y = 0,
      this.offset = const Offset(0, 0),
      this.pointText,
      this.pointTextStyle,
      this.isClickable = true,
      required this.lineTouchData}) {
    pointText ??= '$y';
    pointTextStyle ??= const TextStyle(
        fontWeight: FontWeight.w500, fontSize: 12, color: Color(0xFF222222));
  }
}

class LineTouchData {
  /// 用于临时存储要展示 tip 内容在坐标的位置
  double? x, y;

  /// 要展示 tip 的相对偏移量
  Offset tipOffset;

  /// 要展示的 tip 的宽高
  Size tipWindowSize;

  /// 点击回调，由于返回 展示内容（String 或 Widget）
  Function()? onTouch;

  LineTouchData({
    required this.tipWindowSize,
    this.tipOffset = const Offset(0, 0),
    this.onTouch,
  });
}

/// 每条线的定义
class PointsLine {
  /// 点集合
  List<PointData> points;

  /// 线宽
  double lineWidth;

  /// Line 渐变色，从曲线到 x 轴从上到下的闭合颜色集
  List<Color>? shaderColors;

  /// 曲线或折线的颜色
  Color lineColor;

  /// 点外圈的颜色
  Color? pointColor;

  /// 点的外半径参数
  double pointRadius;

  /// 点内圈的颜色
  Color? pointInnerColor;

  /// 点内圈的半径
  double? pointInnerRadius;

  /// 是否显示 x 轴的文字，用来处理多个线条绘制的时候，同一 x 轴坐标不需要绘制多次，则只需要将多条线中一个标记绘制即可
  bool isShowXDial;

  /// 标记是否为曲线
  bool isCurve;

  /// 是否绘制折线节点。
  bool isShowPoint;

  ///  是否展示节点的文本
  bool isShowPointText;

  PointsLine(
      {this.isShowXDial = false,
      this.lineWidth = 2,
      this.pointRadius = 0,
      this.pointColor,
      this.pointInnerRadius,
      this.pointInnerColor,
      this.isCurve = false,
      required this.points,
      this.isShowPoint = true,
      this.isShowPointText = false,
      this.shaderColors,
      this.lineColor = Colors.purple}) {
    pointColor ??= lineColor;
    pointInnerColor ??= lineColor;
    pointInnerRadius ??= pointRadius - 1.5;
  }
}
