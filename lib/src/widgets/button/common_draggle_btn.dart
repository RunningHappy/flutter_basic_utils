import 'package:flutter/material.dart';

///悬浮拖拽按钮

class CommonDraggleButton extends StatefulWidget {
  final Widget child;
  final Offset initialOffset;
  final VoidCallback onPressed;
  final GlobalKey globalKey;
  const CommonDraggleButton({Key? key,required this.child,required this.initialOffset,required this.onPressed,required this.globalKey}) : super(key: key);

  @override
  _CommonDraggleButtonState createState() => _CommonDraggleButtonState();
}

class _CommonDraggleButtonState extends State<CommonDraggleButton> {

  final GlobalKey _key = GlobalKey();

  bool isDraggle = false;
  late Offset _offset;
  late Offset _minOffset;
  late Offset _maxOffset;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _offset = widget.initialOffset;
    WidgetsBinding.instance?.addPostFrameCallback(_setBoundary);
  }

  void _setBoundary(_){
    final RenderBox parentRenderBox = widget.globalKey.currentContext?.findRenderObject() as RenderBox;
    final RenderBox renderBox = _key.currentContext?.findRenderObject() as RenderBox;

    try {
      final Size parentSize = parentRenderBox.size;
      final Size size = renderBox.size;

      setState(() {
        _minOffset = const Offset(0, 0);
        _maxOffset = Offset(parentSize.width - size.width, parentSize.height - size.height);
      });
    }catch(e){
      print('catch: $e');
    }
  }

  void _updatePosition(PointerMoveEvent pointerMoveEvent){
    double newOffsetX = _offset.dx + pointerMoveEvent.delta.dx;
    double newOffsetY = _offset.dy + pointerMoveEvent.delta.dy;

    if(newOffsetX < _minOffset.dx){
      newOffsetX = _minOffset.dx;
    }else if(newOffsetX > _maxOffset.dx){
      newOffsetX = _maxOffset.dx;
    }

    if(newOffsetY < _minOffset.dy){
      newOffsetY = _minOffset.dy;
    }else if(newOffsetY > _maxOffset.dy){
      newOffsetY = _maxOffset.dy;
    }

    setState(() {
      _offset = Offset(newOffsetX, newOffsetY);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: _offset.dx,
      top: _offset.dy,
      child: Listener(
        onPointerMove: (PointerMoveEvent pointerMoveEvent){
          _updatePosition(pointerMoveEvent);

          setState(() {
            isDraggle = true;
          });
        },
        onPointerUp: (PointerUpEvent pointerUpEvent){
          if(isDraggle){
            setState(() {
              isDraggle = true;
            });
          }else{
            widget.onPressed();
          }
        },
        child: Container(
          key: _key,
          child: widget.child,
        ),
      )
    );
  }
}
