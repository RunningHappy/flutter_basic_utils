import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///
/// 底部弹窗，选中放大的内容
///
class PopBottomShowBigSheet extends Dialog {
  const PopBottomShowBigSheet({Key? key}) : super(key: key);

  /// 取消弹窗
  static disMissDialog(BuildContext buildContext) {
    Navigator.pop(buildContext);
  }

  /// 展示弹窗
  static showSheet(BuildContext buildContext,
      {int? index, required List pickerChildren, Function? sureCallBack}) {
    showCupertinoModalPopup(
        context: buildContext,
        builder: (BuildContext buildContext) {
          return _BottomContent(
              index: index,
              pickerChildren: pickerChildren,
              sureCallBack: sureCallBack);
        });
  }
}

class _BottomContent extends StatefulWidget {
  final int? index;
  final List? pickerChildren;
  final Function? sureCallBack;

  const _BottomContent(
      {Key? key, this.index, this.pickerChildren, this.sureCallBack})
      : super(key: key);

  @override
  _BottomContentState createState() => _BottomContentState();
}

class _BottomContentState extends State<_BottomContent> {
  FixedExtentScrollController _controller =
      FixedExtentScrollController(initialItem: 0);
  var state = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    for (int i = 0; i < widget.pickerChildren!.length; i++) {
      if (i == widget.index!) {
        _controller = FixedExtentScrollController(initialItem: i);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      color: Colors.white,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 29.w, vertical: 14.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    '取消',
                    style: TextStyle(fontSize: 33.sp, color: Colors.blue),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (widget.sureCallBack == null) return;
                    int idx = 0;
                    for (int i = 0; i < widget.pickerChildren!.length; i++) {
                      var item = widget.pickerChildren![i];
                      if (item['state'] == state) {
                        idx = i;
                      }
                    }
                    Navigator.pop(context);
                    widget.sureCallBack!(idx);
                  },
                  child: Text(
                    '确定',
                    style: TextStyle(fontSize: 33.sp, color: Colors.blue),
                  ),
                )
              ],
            ),
          ),
          Expanded(
              child: CupertinoPicker(
            scrollController: _controller,
            useMagnifier: true,

            /// 使用放大镜
            magnification: 1.1,

            /// 当前选中item放大倍数
            itemExtent: 50,

            /// 行高
            backgroundColor: Colors.white,

            /// 选中器背景色
            onSelectedItemChanged: (value) {
              state = widget.pickerChildren![value]['state'];
            },
            children: widget.pickerChildren!.map((data) {
              return Center(
                child: Text(
                  data['name'],
                  style: TextStyle(fontSize: 33.sp, color: Colors.black),
                ),
              );
            }).toList(),
          ))
        ],
      ),
    );
  }
}
