import 'package:app_assembly/src/widgets/cell/text_center_bottom_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 弹出底部列表 - 单选
class PopBottomListSheet extends Dialog {
  const PopBottomListSheet({
    Key? key,
  }) : super(key: key);

  /// 取消对话框
  static disMissDialog(BuildContext context) {
    Navigator.of(context).pop();
  }

  /// 显示对话框
  static showBottomSheet(BuildContext context,
      {int? index,
      required List pickerChildren,
      required Function sureCallBack}) {
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context1) {
          return ListContentView(
              index: index,
              pickerChildren: pickerChildren,
              sureCallBack: sureCallBack);
        });
  }
}

class ListContentView extends StatefulWidget {
  final int? index;
  final List? pickerChildren;
  final Function? sureCallBack;

  const ListContentView(
      {Key? key, this.index, this.pickerChildren, this.sureCallBack})
      : super(key: key);

  @override
  _ListContentViewState createState() => _ListContentViewState();
}

class _ListContentViewState extends State<ListContentView> {
  _items() {
    return widget.pickerChildren!.map((e) {
      return TextCenterBottomLineCell(
          title: e["name"],
          tapCallback: () {
            Navigator.pop(context);
            widget.sureCallBack!(e);
          });
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height * 0.55;
    return widget.pickerChildren!.length > 5
        ? Container(
            color: const Color(0xFFF1F3F7),
            height: height,
            child: Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 158.h),
                  child: ListView.builder(
                      padding: const EdgeInsets.all(0),
                      itemCount: widget.pickerChildren!.length,
                      itemBuilder: (context, index) {
                        Map e = widget.pickerChildren![index];
                        return TextCenterBottomLineCell(
                            title: e["name"],
                            tapCallback: () {
                              Navigator.pop(context);
                              widget.sureCallBack!(e);
                            });
                      }),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: TextCenterBottomLineCell(
                      isCancel: true,
                      title: "取消",
                      tapCallback: () {
                        Navigator.pop(context);
                      }),
                )
              ],
            ),
          )
        : Container(
            color: const Color(0xFFF1F3F7),
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 158.h),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: _items(),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: TextCenterBottomLineCell(
                      isCancel: true,
                      title: "取消",
                      tapCallback: () {
                        Navigator.pop(context);
                      }),
                )
              ],
            ),
          );
  }
}
