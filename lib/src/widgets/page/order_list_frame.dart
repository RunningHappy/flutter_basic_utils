import 'package:app_assembly/app_assembly.dart';
import 'package:app_assembly/src/utils/pageview_scroll_utils.dart';
import 'package:app_assembly/src/utils/under_line_tab_indicator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

/// 订单类框架（可左右滑动，不包含筛选）
class OrderListFrame extends StatefulWidget {
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
  final String naviTitle;
  final List barTitles;
  final List<Widget> body;
  final int selectIndex;
  final Function()? backCallback;

  const OrderListFrame(
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
      this.naviTitle = "我的订单",
      required this.barTitles,
      required this.body,
      this.selectIndex = 0,
      this.backCallback})
      : super(key: key);

  @override
  _OrderListFrameState createState() => _OrderListFrameState();
}

class _OrderListFrameState extends State<OrderListFrame>
    with TickerProviderStateMixin {
  List _barTitles = [];
  int _selectIndex = 0;
  late TabController _tabController;
  late PageController _pageController;
  late PageViewScrollUtils _pageViewScrollUtils;

  @override
  void dispose() {
    _tabController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _init();
    super.initState();
  }

  _init() {
    try {
      _barTitles = widget.barTitles;
    } catch (e) {}
    try {
      _selectIndex = widget.selectIndex;
    } catch (e) {}
    debugPrint("选择的itemSelect是$_selectIndex");
    _tabController = TabController(
        vsync: this, initialIndex: _selectIndex, length: _barTitles.length);
    _pageController = PageController(initialPage: _selectIndex);
    _pageViewScrollUtils = PageViewScrollUtils(
        pageController: _pageController, tabController: _tabController);
    _tabController.addListener(() {
      // 解决addListener走两次的问题
      if (_tabController.index == _tabController.animation!.value) {
        debugPrint('onTabChanged......${_tabController.index}');
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
          appBar: HqAppBar(
            widget.naviTitle,
            con: context,
            backImg: "img/public_image/back_icon.png",
            tabBar: TabBar(
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
                labelPadding:
                    widget.labelPadding ?? EdgeInsets.symmetric(vertical: 23.h),
                tabs: _getBarTitleView()),
            isOpenCallBack: true,
            backCallBack: () {
              if (widget.backCallback != null) {
                widget.backCallback!.call();
              }
            },
          ),
          body: NotificationListener<ScrollNotification>(
            child: TabBarView(
                physics: const ClampingScrollPhysics(),
                controller: _tabController,
                children: widget.body),
            onNotification: _pageViewScrollUtils.handleNotification,
          )),
    );
  }

  _getBarTitleView() {
    List<Widget> widgets = [];
    for (String element in _barTitles) {
      double dWidth = element.length * 40.w;
      widgets.add(Container(
        // width: MediaQuery.of(context).size.width / 4,
        width: dWidth,
        margin: EdgeInsets.symmetric(horizontal: element.length > 4 ? 0 : 6.w),
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
