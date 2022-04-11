import 'package:flutter/material.dart';

class CommonWaterButton extends StatefulWidget {
  final double innerSize;
  final double? outSize;
  final Widget innerIcon;
  final Color color;
  final Duration? duration;

  const CommonWaterButton(this.color,
    {Key? key,
    this.innerSize = 48.0,
    this.outSize = 80.0,
    required this.innerIcon,
    this.duration})
    : super(key: key);

  @override
  _CommonWaterButtonState createState() => _CommonWaterButtonState();
}

class _CommonWaterButtonState extends State<CommonWaterButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: widget.duration ?? const Duration(milliseconds: 2000))..repeat();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Stack(
          children: [
            CustomPaint(
              size: Size(
                widget.outSize ?? widget.innerSize * 2,
                widget.outSize ?? widget.innerSize * 2
              ),
              painter: CommonWaterPainter(
                _controller.value,
                widget.color,
                widget.innerSize,
                widget.outSize
              )
            ),
            Container(
              color: Colors.grey.withOpacity(0.0),
              width: widget.outSize ?? widget.innerSize * 2,
              height: widget.outSize ?? widget.innerSize * 2,
              child: Center(
                child: ClipOval(
                  child: Container(
                    width: widget.innerSize,
                    height: widget.innerSize,
                    color: widget.color,
                    child: widget.innerIcon
                  )
                )
              )
            )
          ]
        );
      }
    );
  }
}

class CommonWaterPainter extends CustomPainter {
  final double progress;
  final Color color;
  final double innerSize;
  final double? outSize;
  final Paint _paint = Paint()..style = PaintingStyle.fill;

  CommonWaterPainter(this.progress, this.color, this.innerSize, this.outSize);

  @override
  void paint(Canvas canvas, Size size) {
    _paint.color = color.withOpacity(1.0 - progress);
    double _radius = ((outSize ?? innerSize * 2) * 0.5 - innerSize * 0.5) * progress + innerSize * 0.5;
    canvas.drawCircle(Offset(size.width / 2, size.height / 2), _radius, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
