import 'dart:math';
import 'package:app_assembly/app_assembly.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum HBPasswordInputTextFieldType { boxes, segmented }
enum MyPasswordInputType {
  normal,
  mathNumShow // 含随机数字展示类型
}

///
/// 支付密码框
///
class PayPasswordTextField extends StatefulWidget {
  final HBPasswordInputTextFieldType type; // 格子样式
  final Function? onChange;
  final int length; // 输入长度
  final TextEditingController? controller; // 输入控制器
  final FocusNode? node; // 焦点
  final double boxWidth; // 格子宽
  final double boxHeight; // 格子高
  final double borderWidth; // 边框宽
  final double borderRadius; // 圆角
  final Color borderColor; // 边框颜色
  final Color fillColor; // 填充颜色
  final Color backgroundColor; // 填充颜色
  final double spacing; // 格子间隔
  final bool obscureText; // 是否密文
  final String obscureTextString; // 密文字符
  final TextStyle? textStyle; // 文本样式
  final MyPasswordInputType myPasswordInputType;
  final String? engineNum;
  final int? showNumLength;
  final Function? onSubmit;

  const PayPasswordTextField({
    Key? key,
    this.onChange,
    this.length = 6,
    this.controller,
    this.node,
    this.boxWidth = 40,
    this.boxHeight = 36,
    this.borderRadius = 5.0,
    this.borderColor = Colors.grey,
    this.spacing = 10,
    this.borderWidth = 1.0,
    this.obscureText = false,
    this.textStyle,
    this.obscureTextString = "●",
    this.type = HBPasswordInputTextFieldType.boxes,
    this.fillColor = Colors.white,
    this.backgroundColor = Colors.white,
    this.myPasswordInputType = MyPasswordInputType.normal,
    this.engineNum,
    this.showNumLength = 2,
    this.onSubmit,
  }) : super(key: key);

  @override
  _PayPasswordTextFieldState createState() => _PayPasswordTextFieldState();
}

class _PayPasswordTextFieldState extends State<PayPasswordTextField> {
  List titles = [];

  Widget box() {
    List<Widget> children = [];
    double itemWidth = widget.boxWidth;
    double itemHeight = widget.boxHeight;
    for (var i = 0; i < widget.length; i++) {
      String title = " ";
      if (titles.length > i) {
        title = widget.obscureText ? widget.obscureTextString : titles[i];
      }
      Border? border;
      BorderRadius? borderRadius;

      if (widget.type == HBPasswordInputTextFieldType.boxes) {
        borderRadius = BorderRadius.circular(widget.borderRadius);
        border =
            Border.all(width: widget.borderWidth, color: widget.borderColor);
      } else if (widget.type == HBPasswordInputTextFieldType.segmented) {
        BorderSide side =
            BorderSide(width: widget.borderWidth, color: widget.borderColor);
        Radius radius = Radius.circular(widget.borderRadius);
        if (i == 0) {
          itemWidth += 5;
          borderRadius = BorderRadius.only(topLeft: radius, bottomLeft: radius);
          border = Border(left: side, bottom: side, top: side, right: side);
        } else if (i == widget.length - 1) {
          itemWidth += 5;
          borderRadius =
              BorderRadius.only(topRight: radius, bottomRight: radius);
          border = Border(left: side, bottom: side, top: side, right: side);
        } else if (i == widget.length - 2) {
          border = Border(bottom: side, top: side);
        } else {
          border = Border(bottom: side, top: side, right: side);
        }
      }

      Widget item = Container(
        height: itemHeight,
        width: itemWidth,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: widget.fillColor,
            borderRadius: borderRadius,
            border: border),
        child: Text(
          title.toUpperCase(),
          style: widget.textStyle,
        ),
      );
      children.add(item);
    }

    if (widget.myPasswordInputType == MyPasswordInputType.mathNumShow) {
      if (widget.engineNum == null) {
        throw ('engineNum is can not null');
      }
      for (var i = 0; i < widget.showNumLength!; i++) {
        Widget item = Container(
          height: itemHeight,
          width: itemWidth,
          alignment: Alignment.center,
          color: Colors.white,
          child: Text(
            widget.engineNum!.substring(resultList[i] - 1, resultList[i]),
            style: TextStyle(
              fontSize: 56.sp,
            ),
          ),
        );
        children.insert(resultList[i] - 1, item);
      }
    }

    BoxDecoration decoration = BoxDecoration(color: widget.backgroundColor);
    return Stack(
      children: <Widget>[
        SizedBox(
            width: double.infinity,
            child: Container(
                width: widget.length * widget.boxWidth,
                decoration: decoration,
                child: widget.type == HBPasswordInputTextFieldType.boxes
                    ? Wrap(
                        alignment: WrapAlignment.center,
                        spacing: widget.spacing,
                        children: children,
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: children,
                      ))),
        Theme(
          data: ThemeData(
              cursorColor: Colors.transparent,
              inputDecorationTheme: const InputDecorationTheme(
                  suffixStyle: TextStyle(
                    color: Colors.transparent,
                  ),
                  enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.transparent, width: 0)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.transparent, width: 0)))),
          child: SizedBox(
            width: double.infinity,
            // alignment: Alignment.center,
            child: TextField(
              controller: widget.controller,
              cursorWidth: 0,
              autofocus: true,
              focusNode: widget.node,
              keyboardType: TextInputType.number,
              maxLength: widget.length,
              maxLines: 1,
              enableInteractiveSelection: false,
              style: const TextStyle(color: Colors.transparent),
              decoration: const InputDecoration(counterText: ""),
              onChanged: (text) {
                if (text.length > widget.length) {
                  widget.controller!.text = text.substring(0, widget.length);
                }
                titles = text.split("");
                if (widget.myPasswordInputType == MyPasswordInputType.normal) {
                  widget.onChange!(widget.controller!.text);
                } else {
                  var tepStr = widget.controller!.text;
                  var tepArry = [];
                  debugPrint(tepStr.length.toString());
                  if (tepStr.length >= widget.length) {
                    tepArry = tepStr.split('');
                    for (var i = 0; i < widget.showNumLength!; i++) {
                      var tepEngineNum = widget.engineNum!
                          .substring(resultList[i] - 1, resultList[i]);
                      tepArry.insert(resultList[i] - 1, tepEngineNum);
                    }
                    if (tepArry.join().toUpperCase() == widget.engineNum) {
                      widget.onChange!(true);
                    } else {
                      widget.onChange!(false);
                    }
                  } else {
                    widget.onChange!(false);
                  }
                }

                setState(() {});
              },
              onSubmitted: (text) {
                widget.onSubmit!(text);
              },
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget box1 = box();
    return Container(
      color: widget.backgroundColor,
      child: box1,
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initMathNum();
    initEvent();
  }

  initEvent() {
    bus.on('clearInput', (arg) {
      setState(() {
        titles.clear();
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement initState
    super.dispose();
    bus.off('clearInput');
  }

  List<int> resultList = [];

  void _initMathNum() {
    titles.clear();
    if (widget.myPasswordInputType == MyPasswordInputType.mathNumShow) {
      if (widget.showNumLength == null) {
        throw ('showNumLength is not null');
      }
      var rng = Random();
      int count = 0;
      while (count < widget.showNumLength!) {
        //生成几个
        int index =
            rng.nextInt(widget.showNumLength! + widget.length) + 1; // 在几之间
        if (!resultList.contains(index)) {
          resultList.add(index);
          count++;
        }
      }
      resultList.sort();
    }
  }
}
