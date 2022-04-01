import 'dart:ui';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

const PI = 3.1415926;
const _pieRadius = 110.0;

class CommonPiePainter extends CustomPainter {
  List<Map<String, double>> _listData = [];
  List<Color> colors = [];
  var _rotateAngle = 0.0;
  double _sum = 0.0;
  String _subName = '';

  CommonPiePainter(this._listData, this._rotateAngle,this.colors);

  @override
  void paint(Canvas canvas, Size size) {
    double startAngle = 0.0, sweepAngle = 0.0;
    Rect _circle = Rect.fromCircle(
        center: Offset(size.width * 0.5, size.height * 0.5),
        radius: _pieRadius);
    Paint _paint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 4.0
      ..style = PaintingStyle.fill;
    ParagraphBuilder _pb = ParagraphBuilder(ParagraphStyle(
        textAlign: TextAlign.left,
        fontWeight: FontWeight.w600,
        fontStyle: FontStyle.normal,
        fontSize: 14))
      ..pushStyle(ui.TextStyle(color: Colors.white));
    ParagraphConstraints _paragraph =
    ParagraphConstraints(width: size.width * 0.5);
    _sumData();
    if (_rotateAngle == null) {
      _rotateAngle = 0.0;
    }
    if (_listData != null) {
      for (int i = 0; i < _listData.length; i++) {
        startAngle += sweepAngle;
        sweepAngle = _listData[i].values.first * 2 * PI / _sum;
        canvas.drawArc(_circle, startAngle + _rotateAngle, sweepAngle, true,
            _paint..color = _subPaint(_listData[i].keys.first,i));

        if (sweepAngle >= PI / 6) {
          canvas.translate(size.width * 0.5, size.height * 0.5);
          canvas.rotate(startAngle + sweepAngle * 0.5 + _rotateAngle);
          Paragraph paragraph = (_pb..addText(_subName)).build()
            ..layout(_paragraph);
          canvas.drawParagraph(
              paragraph, Offset(50.0, 0.0 - paragraph.height * 0.5));
          canvas.rotate(-startAngle - sweepAngle * 0.5 - _rotateAngle);
          canvas.translate(-size.width * 0.5, -size.height * 0.5);
        }
      }
    }
    _sum = 0.0;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;

  _sumData() {
    if (_listData != null) {
      for (int i = 0; i < _listData.length; i++) {
        print(
            '----${_listData[i].values}---${_listData[i].values.first}---${_listData[i].keys}---${_listData[i].keys.first}');
        _sum += _listData[i].values.first;
        print('---$_sum---');
      }
    }
  }

  _subPaint(type,index) {
    Color _color;
    _color = colors[index];
    _subName = type;
    return _color;
  }
}
