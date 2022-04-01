import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///
/// 步骤条
///
class StepBar extends StatefulWidget {
  final List<Map> list;
  final Color iconColor;
  final Widget? lastIcon;
  final double itemSpace;

  const StepBar(this.list, this.iconColor,
      {Key? key, this.lastIcon, this.itemSpace = 133})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => StepBarState();
}

class StepBarState extends State<StepBar> {
  List<Map> _list = [];
  List<Widget> _steps = [];
  List<Widget> _stepLabels = [];

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      setList();
    });
  }

  @override
  void didUpdateWidget(StepBar oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    setState(() {
      setList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.topLeft,
          margin: EdgeInsets.only(top: 12.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: _stepLabels,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _steps,
        )
      ],
    );
  }

  void setList() {
    _steps = [];
    _stepLabels = [];
    _list = widget.list;
    if (_list.isNotEmpty) {
      for (int i = 0; i < _list.length; i++) {
        Widget itemLabel = _widgetItemLabel(i);
        Widget item = _widgetItem(i);
        _stepLabels.add(itemLabel);
        _steps.add(item);
      }
    }
  }

  Widget _widgetItemLabel(currentIndex) {
    return Container(
      margin: EdgeInsets.only(right: 48.w),
      child: Column(
        children: [
          Container(
            child: _widgetDit(currentIndex),
          ),
          currentIndex < _list.length - 1
            ? Container(
                child: _widgetLine(),
              )
            : Container()
        ],
      ),
    );
  }

  Widget _widgetItem(currentIndex) {
    return Container(
      alignment: Alignment.topLeft,
      height: (currentIndex != _list.length - 1 ? widget.itemSpace + 15 : 80).h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              '${_list[currentIndex]['title']}',
              style: TextStyle(
                  fontSize: 28.sp, color: _list[currentIndex]['titleColor']),
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              '${_list[currentIndex]['subTitle']}',
              style: TextStyle(fontSize: 24.sp, color: const Color(0xFF999999)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _widgetDit(currIndex) {
    return currIndex != _list.length - 1 || widget.lastIcon == null
        ? Container(
            width: 15.w,
            height: 15.h,
            decoration: BoxDecoration(
                color: widget.iconColor,
                borderRadius: BorderRadius.all(Radius.circular(7.sp))),
          )
        : Container(
            child: widget.lastIcon,
          );
  }

  Widget _widgetLine() {
    return Container(
      width: 1,
      height: widget.itemSpace.h,
      color: const Color(0xFFDDDDDD),
    );
  }
}
