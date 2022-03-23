import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 星级评分组件（多星级）
class RateStar extends StatefulWidget {
  final int maxStarCount;
  final String normalIcon;
  final String selectedIcon;
  final int? normal;
  final bool canTap;
  final Function? tapCallback;

  const RateStar(
      {Key? key,
      this.maxStarCount = 5,
      required this.normalIcon,
      required this.selectedIcon,
      this.normal = 0,
      this.canTap = true,
      this.tapCallback})
      : super(key: key);

  @override
  _RateStarState createState() => _RateStarState();
}

class _RateStarState extends State<RateStar> {
  final List<int> _starIndex = [];
  int _maxStarCount = 5;
  int _starValue = 0; // 默认0 选中
  bool _canTap = true;
  bool _isDisable = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initStarIndex();
  }

  void _initStarIndex() {
    setState(() {
      _starValue = widget.normal!;
      _maxStarCount = widget.maxStarCount;
      _canTap = widget.canTap;
    });
    for (var i = 0; i < _maxStarCount; i++) {
      _starIndex.add(i);
    }
  }

  // 获取星级等级
  List<Widget> _getStar() {
    return _starIndex
        .map((i) => GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                if (_canTap) {
                  setStarLevel(i + 1, false);
                  widget.tapCallback!(i + 1);
                }
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: _getImage(i),
              ),
            ))
        .toList();
  }

  // 获取星星图片
  Widget _getImage(int i) {
    String tepImagePath = widget.normalIcon;
    if (i < _starValue) {
      tepImagePath = widget.selectedIcon;
    }
    return Image.asset(
      tepImagePath,
      width: 56.w,
      height: 56.w,
    );
  }

  // 设置等级
  void setStarLevel(int clickIndex, isFirst) {
    if (_starValue != clickIndex) {
      _starValue = clickIndex;
      if (_starValue != 0) {
        _isDisable = true;
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      children: _getStar(),
    );
  }
}
