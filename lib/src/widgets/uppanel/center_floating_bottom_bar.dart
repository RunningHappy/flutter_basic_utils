import 'dart:async';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///
/// 底部悬浮中心按钮的TabBar框架
///
class CenterFloatingBottomBar extends StatefulWidget {
  final List<Widget> pageList;
  final String centerImage;
  final List<String> normalBarImage;
  final List<String> activeBarImage;
  final List<String>? barTitleList;
  final Color? normalTitleColor;
  final Color? activeTitleColor;
  final double? normalTitleSize;
  final double? activeTitleSize;
  final FontWeight? normalFontWeight;
  final FontWeight? activeFontWeight;
  final double barHeight;
  final double? imageTitlePadding;
  final double? imageWidth;
  final Color? barBackColor;
  final Function? centerCallback;

  const CenterFloatingBottomBar(
      {Key? key,
        required this.pageList,
        this.centerImage = "",
        required this.normalBarImage,
        required this.activeBarImage,
        this.barTitleList,
        this.normalTitleColor,
        this.activeTitleColor,
        this.normalTitleSize,
        this.activeFontWeight,
        this.activeTitleSize,
        this.normalFontWeight,
        required this.barHeight,
        this.imageTitlePadding,
        this.imageWidth,
        this.barBackColor,
        this.centerCallback})
      : super(key: key);

  @override
  _CenterFloatingBottomBarState createState() =>
      _CenterFloatingBottomBarState();
}

class _CenterFloatingBottomBarState extends State<CenterFloatingBottomBar> {
  /// 当前页面的索引
  int _currentIndex = 0;
  DateTime? _lastPopTime;
  late final List<Widget> _pageList;

  @override
  void initState() {
    super.initState();
    setState(() {
      _pageList = widget.pageList;
      _currentIndex = 0;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  Future<bool> onWillPop() async {
    if (_lastPopTime == null ||
        DateTime.now().difference(_lastPopTime!) > const Duration(seconds: 2)) {
      _lastPopTime = DateTime.now();
      EasyLoading.showToast('再按一次退出');
    } else {
      _lastPopTime = DateTime.now();
      // 退出 app
      await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    }
    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBody: true,
      resizeToAvoidBottomInset: false,
      body: _pageList[_currentIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: widget.centerImage.isEmpty
            ? const Icon(Icons.add)
            : Image.asset(
          widget.centerImage,
        ),
        onPressed: () {
          if (widget.centerCallback != null) {
            widget.centerCallback!.call();
          }
        },
      ),
      bottomNavigationBar: Container(
        height: widget.barHeight,
        color: Colors.transparent,
        child: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: 6.h,
          color: widget.barBackColor ?? Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: _getBarItemList(),
          ),
        ),
      ),
    );
  }

  _getBarItemList() {
    List<Widget> children = [];
    for (var i = 0; i < widget.normalBarImage.length; i++) {
      children.add(buildBarItem(i, _currentIndex));
      if (i == (widget.normalBarImage.length / 2 - 1)) {
        children.add(buildBarItem(-1, _currentIndex));
      }
    }
    return children;
  }

  buildBarItem(int? index, int? selectIndex) {
    return Expanded(
        child: GestureDetector(
          onTap: () {
            setState(() {
              _currentIndex = index!;
            });
          },
          child: index! == -1
              ? Container()
              : Container(
            color: Colors.transparent,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  selectIndex == index
                      ? widget.activeBarImage[index]
                      : widget.normalBarImage[index],
                  width: widget.imageWidth ?? 30.h,
                  height: widget.imageWidth ?? 30.h,
                ),
                widget.barTitleList != null
                    ? widget.barTitleList!.isNotEmpty
                    ? Column(
                  children: [
                    SizedBox(
                      height: widget.imageTitlePadding ?? 5.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.barTitleList![index],
                          style: TextStyle(
                              fontSize: selectIndex == index
                                  ? widget.activeTitleSize
                                  : widget.normalTitleSize,
                              color: selectIndex == index
                                  ? widget.activeTitleColor
                                  : widget.normalTitleColor,
                              fontWeight: selectIndex == index
                                  ? widget.activeFontWeight
                                  : widget.normalFontWeight),
                        )
                      ],
                    )
                  ],
                )
                    : Container()
                    : Container()
              ],
            ),
          ),
        ));
  }
}
