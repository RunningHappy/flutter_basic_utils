import 'package:app_assembly/app_assembly.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 悬停 tab 的列表框架
class ScrollStopTableFrame extends StatefulWidget {
  final Widget? appBarTitleWidget;
  final double? expandedHeight;
  final Widget? sliverBannerWidget;
  final PreferredSizeWidget? bottomTabBarWidget;
  final Widget? child;

  const ScrollStopTableFrame(
      {Key? key,
      this.appBarTitleWidget,
      this.expandedHeight,
      this.sliverBannerWidget,
      this.bottomTabBarWidget,
      this.child})
      : super(key: key);

  @override
  _ScrollStopTableFrameState createState() => _ScrollStopTableFrameState();
}

class _ScrollStopTableFrameState extends State<ScrollStopTableFrame> {
  final ScrollController _sliverController = ScrollController();
  var _isPinned = false;

  // 页面销毁回调生命周期
  @override
  void dispose() {
    _sliverController.dispose();
    super.dispose();
  }

  // 页面初始化方法
  @override
  void initState() {
    super.initState();
    _init();
  }

  _init() {
    _sliverController.addListener(() {
      if (!_isPinned &&
          _sliverController.hasClients &&
          _sliverController.offset > 450.h) {
        _isPinned = true;
        setState(() {});
      } else if (_isPinned &&
          _sliverController.hasClients &&
          _sliverController.offset < 450.h) {
        _isPinned = false;
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // 构建页面的主体
    return FormHideKeyboardWidget(
        childWidget: Scaffold(
      body: buildNestedScrollView(),
    ));
  }

  // NestedScrollView 的基本使用
  Widget buildNestedScrollView() {
    // 滑动视图
    return NestedScrollView(
      controller: _sliverController,
      // 配置可折叠的头布局
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return [_buildSliverAppBar()];
      },
      // 页面的主体内容
      body: _buildChildWidget(),
    );
  }

  // SliverAppBar
  // flexibleSpace可折叠的内容区域
  _buildSliverAppBar() {
    return SliverAppBar(
        backgroundColor: Colors.white,
        title: widget.appBarTitleWidget ?? Container(),
        // 标题居中
        centerTitle: true,
        // 当此值为true时 SliverAppBar 会固定在页面顶部
        // 当此值为false时 SliverAppBar 会随着滑动向上滑动
        pinned: true,
        // 当值为true时 SliverAppBar设置的title会随着上滑动隐藏
        // 然后配置的bottom会显示在原AppBar的位置
        // 当值为false时 SliverAppBar设置的title会不会隐藏
        // 然后配置的bottom会显示在原AppBar设置的title下面
        floating: false,
        // 当snap配置为true时，向下滑动页面，SliverAppBar（以及其中配置的flexibleSpace内容）会立即显示出来，
        // 反之当snap配置为false时，向下滑动时，只有当ListView的数据滑动到顶部时，SliverAppBar才会下拉显示出来。
        snap: false,
        elevation: 0.3,
        // 展开的高度
        expandedHeight: widget.expandedHeight ??
            (766 / 1624) * MediaQuery.of(context).size.height,
        // AppBar下的内容区域
        flexibleSpace: FlexibleSpaceBar(
          // 背景
          // 配置的是一个widget也就是说在这里可以使用任意的
          // Widget组合 在这里直接使用的是一个图片
          background: widget.sliverBannerWidget ?? Container(),
        ),
        bottom:
            widget.bottomTabBarWidget ?? Container() as PreferredSizeWidget);
  }

  // 页面的主体内容
  Widget _buildChildWidget() {
    return widget.child ?? Container();
  }
}
