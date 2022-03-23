import 'dart:io';
import 'package:app_assembly/app_assembly.dart';
import 'package:app_assembly/src/widgets/button/line_border_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 弹出底部菜单 sheet
class PopBottomMenuSheet extends Dialog {
  const PopBottomMenuSheet({
    Key? key,
  }) : super(key: key);

  /// 取消对话框
  static disMissDialog(BuildContext context) {
    Navigator.of(context).pop();
  }

  // 显示对话框
  static showBottomSheet(BuildContext context,
      {required List? dataList,
      required List? selectIndexList,
      Function? onTap}) {
    showDialog(
        context: context,
        barrierDismissible: false,
        useSafeArea: false,
        builder: (BuildContext context) {
          return MenuContentView(
              selectIndexList: selectIndexList, tapCallback: onTap);
        });
  }
}

class MenuContentView extends StatefulWidget {
  final List? dataList;
  final List? selectIndexList;
  final Function? tapCallback;

  const MenuContentView(
      {Key? key, this.dataList, this.selectIndexList, this.tapCallback})
      : super(key: key);

  @override
  _MenuContentViewState createState() => _MenuContentViewState();
}

class _MenuContentViewState extends State<MenuContentView> {
  final List<Map> _dataList = [];
  final List<Map> _selects = [];
  List _selectIndexList = [];

  @override
  void initState() {
    _init();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  _updateWidget() {
    if (mounted) {
      setState(() {});
    }
  }

  _init() {
    Future.delayed(Duration.zero, () {
      _goodsTypeList();
    });
    _updateWidget();
  }

  _reset() {
    for (Map e in _dataList) {
      e["select"] = false;
    }
    _selectIndexList = [];
    _updateWidget();
  }

  // 供应类型
  _goodsTypeList() async {
    for (var e in widget.dataList!) {
      _dataList.add({"name": e.gtTypeName, "state": e.gtId, "select": false});
    }
    if (widget.selectIndexList != null) {
      _selectIndexList = widget.selectIndexList!;
      for (var element in _selectIndexList) {
        _dataList[element]["select"] = true;
      }
    }
    _updateWidget();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 32.w * 2 - 24.w;

    return SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          backgroundColor: const Color(0x60000000),
          resizeToAvoidBottomInset: false,
          body: Container(
              alignment: Alignment.bottomCenter,
              color: Colors.transparent,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8.w),
                        topRight: Radius.circular(8.w)),
                    color: Colors.white),
                height: 1233.h,
                width: double.infinity,
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(
                          32.w,
                          48.h,
                          32.w,
                          Platform.isAndroid
                              ? 24.h
                              : 24.h + MediaQuery.of(context).padding.bottom),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '供应类型',
                            style: TextStyle(
                                fontSize: 32.sp,
                                color: const Color(0xFF1D2023),
                                fontWeight: FontWeight.w800),
                          ),
                          SizedBox(
                            height: 40.h,
                          ),
                          Expanded(
                              child: SizedBox(
                                  width: double.infinity, child: _item())),
                          SizedBox(
                            height: 40.h,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: width / 2,
                                height: 100.h,
                                child: LineBorderBtn(
                                    title: "重置",
                                    fontSize: 32.sp,
                                    onTap: _reset),
                              ),
                              SizedBox(width: 24.w),
                              SizedBox(
                                width: width / 2,
                                height: 100.h,
                                child: MoreColorLoginButton(
                                    title: "确定",
                                    type: true,
                                    fontSize: 36.sp,
                                    callBack: () {
                                      if (widget.tapCallback != null) {
                                        for (Map e in _dataList) {
                                          if (e["select"] == true) {
                                            _selects.add(e);
                                          }
                                        }
                                        widget.tapCallback!(
                                            _selects, _selectIndexList);
                                      }
                                      Navigator.pop(context);
                                    }),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 24.h, top: 24.h),
                        color: Colors.white,
                        child: Image.asset(
                          'img/public_image/close_btn.png',
                          width: 48.h,
                          height: 48.h,
                        ),
                      ),
                    )
                  ],
                ),
              )),
        ));
  }

  _item() {
    return GridView.count(
      // 水平子Widget之间间距
      crossAxisSpacing: 32.w,
      // 垂直子Widget之间间距
      mainAxisSpacing: 32.w,
      // GridView内边距
      padding: const EdgeInsets.all(0),
      // 一行的Widget数量
      crossAxisCount: 3,
      // 子Widget宽高比例
      childAspectRatio: 3.0,
      //子Widget列表
      children: _dataList
          .map<Widget>((e) => GestureDetector(
                onTap: () {
                  e["select"] = !e["select"];
                  int index = _dataList.indexOf(e);
                  if (_selectIndexList.contains(index)) {
                    if (!e["select"]) {
                      _selectIndexList.remove(index);
                    }
                  } else {
                    _selectIndexList.add(index);
                  }
                  _updateWidget();
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.h),
                    color: e['select']
                        ? const Color(0x305173F2)
                        : const Color(0xFFF1F2F6),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        _getName(e['name']),
                        style: TextStyle(
                            fontSize: 28.sp,
                            color: e['select']
                                ? const Color(0x50436CEC)
                                : const Color(0xFF666F83)),
                      )
                    ],
                  ),
                ),
              ))
          .toList(),
    );
  }

  _getName(String name) {
    String _name = "";
    if (name.length > 6) {
      _name = name.substring(0, 6) + "...";
    } else {
      _name = name;
    }
    return _name;
  }
}
