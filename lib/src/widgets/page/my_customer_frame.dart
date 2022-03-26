import 'package:app_assembly/src/utils/under_line_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 我的客户类框架（导航栏多选bar，可左右滑动，不包含筛选）
class MyCustomerFrame extends StatefulWidget {
  // 设置未选中时的字体颜色，tabs里面的字体样式优先级最高
  final Color? unselectedLabelColor;

  // 设置未选中时的字体样式，tabs里面的字体样式优先级最高
  final TextStyle? unselectedLabelStyle;

  // 设置选中时的字体颜色，tabs里面的字体样式优先级最高
  final Color? labelColor;

  // 设置选中时的字体样式，tabs里面的字体样式优先级最高
  final TextStyle? labelStyle;

  // 允许左右滚动
  final bool isScrollable;

  // 选中下划线的颜色
  final Color? indicatorColor;

  // 选中下划线的长度，label时跟文字内容长度一样，tab时跟一个Tab的长度一样
  final TabBarIndicatorSize? indicatorSize;

  // 选中下划线的高度，值越大高度越高，默认为2。0
  final double? indicatorWeight;

  // 用于设定选中状态下的展示样式
  final Decoration? indicator;
  final EdgeInsetsGeometry? labelPadding;
  final List barTitles;
  final Widget body;
  final Function()? backCallback;

  const MyCustomerFrame(
      {Key? key,
      this.unselectedLabelColor,
      this.unselectedLabelStyle,
      this.labelColor,
      this.labelStyle,
      this.isScrollable = true,
      this.indicatorColor,
      this.indicatorSize,
      this.indicatorWeight,
      this.indicator,
      this.labelPadding,
      required this.barTitles,
      required this.body,
      this.backCallback})
      : super(key: key);

  @override
  _MyCustomerFrameState createState() => _MyCustomerFrameState();
}

class _MyCustomerFrameState extends State<MyCustomerFrame>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late PageController _pageController;
  final List _barTitles = [];

  @override
  void initState() {
    _init();
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  _init() async {
    var index = 0;
    _tabController = TabController(
        vsync: this, initialIndex: index, length: _barTitles.length);
    _tabController.addListener(() {
      if (_tabController.index == _tabController.animation!.value) {
        debugPrint('onTabChanged......${_tabController.index}');
        _pageController.jumpToPage(_tabController.index);
      }
    });
  }

  _back() {
    Navigator.pop(context);
    if (widget.backCallback != null) {
      widget.backCallback!.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        _back();
        return Future.value(false);
      },
      child: Scaffold(
          appBar: AppBar(
              title: TabBar(
                  controller: _tabController,
                  onTap: (int index) {},
                  unselectedLabelColor:
                      widget.unselectedLabelColor ?? const Color(0xFF666F83),
                  unselectedLabelStyle:
                      widget.unselectedLabelStyle ?? TextStyle(fontSize: 28.sp),
                  labelColor: widget.labelColor ?? const Color(0xFF111A34),
                  labelStyle: widget.labelStyle ?? TextStyle(fontSize: 28.sp),
                  isScrollable: widget.isScrollable,
                  indicatorColor:
                      widget.indicatorColor ?? const Color(0xFF177FF3),
                  indicatorSize:
                      widget.indicatorSize ?? TabBarIndicatorSize.label,
                  indicatorWeight: widget.indicatorWeight ?? 5.h,
                  indicator: widget.indicator ??
                      MyUnderlineTabIndicator(
                          borderSide: BorderSide(
                              width: 8.h, color: const Color(0xFF5173F2))),
                  labelPadding: widget.labelPadding ??
                      EdgeInsets.symmetric(vertical: 23.h),
                  tabs: _getBarTitleView()),
              backgroundColor: Colors.white,
              leading: GestureDetector(
                onTap: _back,
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 29.w, vertical: 28.w),
                  child: Image.asset("img/public_image/back_icon.png",
                      width: 43.w, height: 43.w, fit: BoxFit.cover),
                ),
              )),
          body: PageView.builder(
            itemBuilder: (context, index) {
              return widget.body;
            },
            itemCount: _barTitles.length,
            controller: _pageController,
            onPageChanged: (idx) {
              debugPrint("onPageChanged");
              if (_barTitles.length > 1) {
                _tabController.animateTo(idx);
              }
            },
          )),
    );
  }

  _getBarTitleView() {
    List<Widget> widgets = [];
    for (var element in _barTitles) {
      widgets.add(Container(
        width: 165.w,
        alignment: Alignment.center,
        child: Text(
          element,
          style: TextStyle(color: const Color(0xFF606972), fontSize: 29.sp),
        ),
      ));
    }
    return widgets;
  }
}
