import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum CircleImageType { network, asset }

///
/// 圆角图片
///
class CircleImage extends StatefulWidget {
  final double width;
  final double height;
  final String path;
  final CircleImageType type; // network, asset

  const CircleImage(
      {Key? key,
      required this.width,
      required this.height,
      required this.path,
      required this.type})
      : super(key: key);

  @override
  CircleImageState createState() => CircleImageState();
}

class CircleImageState extends State<CircleImage> {
  @override
  Widget build(BuildContext context) {
    Image img;
    if (widget.type == CircleImageType.network) {
      img = Image.network(widget.path,
          width: widget.width, height: widget.height, fit: BoxFit.cover);
    } else {
      img = Image.asset(widget.path,
          width: widget.width, height: widget.height, fit: BoxFit.cover);
    }
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: ClipOval(child: img),
    );
  }
}
