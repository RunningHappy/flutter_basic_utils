import 'package:app_assembly/app_assembly.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///
/// 多行，含"*"标题+输入框/文本的item
///
class StarTextFieldViewItem extends StatefulWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final bool enable;
  final bool enableInteractiveSelection;
  final TextInputType keyboardType;
  final bool isHideStar;
  final Widget? rightWidget;
  final Widget? bottomWidget;
  final String? text;
  final String? holdText;
  final TextAlign textAlign;
  final Function? noEditCallBack;
  final CallBack? callBack;
  final Function? tapInputCallback;
  final TextStyle? style;
  final List<TextInputFormatter>? inputFormatters;

  const StarTextFieldViewItem(
      {Key? key,
      this.controller,
      this.focusNode,
      this.enable = true,
      this.enableInteractiveSelection = true,
      this.keyboardType = TextInputType.text,
      this.isHideStar = false,
      this.rightWidget,
      this.bottomWidget,
      this.text,
      this.holdText,
      this.textAlign = TextAlign.left,
      this.noEditCallBack,
      this.inputFormatters,
      this.style,
      this.callBack,
      this.tapInputCallback})
      : super(key: key);

  @override
  _StarTextFieldViewItemState createState() => _StarTextFieldViewItemState();
}

class _StarTextFieldViewItemState extends State<StarTextFieldViewItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 29.w, vertical: 39.h),
      decoration: const BoxDecoration(
          color: Colors.white,
          border:
              Border(bottom: BorderSide(width: .5, color: Color(0xFFDDDDDD)))),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                '*',
                style: TextStyle(
                    fontSize: 32.sp,
                    color: widget.isHideStar
                        ? Colors.transparent
                        : const Color(0xFFFF6E6D)),
              ),
              SizedBox(
                width: 160.w,
                child: Text(
                  widget.text!,
                  style: TextStyle(
                      fontSize: 32.sp, color: const Color(0xFF1D2023)),
                ),
              ),
              SizedBox(
                width: 47.w,
              ),
              Expanded(
                  child: GestureDetector(
                onTap: () {
                  if (widget.tapInputCallback != null) {
                    widget.tapInputCallback!();
                  }
                },
                child: TextField(
                  textAlign: widget.textAlign,
                  controller: widget.controller,
                  focusNode: widget.focusNode,
                  enabled: widget.enable,
                  maxLines: null,
                  enableInteractiveSelection: widget.enableInteractiveSelection,
                  inputFormatters: widget.inputFormatters,
                  keyboardType: widget.keyboardType,
                  style: widget.style ??
                      TextStyle(fontSize: 32.sp, color: Colors.black),
                  decoration: InputDecoration(
                      isCollapsed: true, // 高度包裹
                      border: InputBorder.none,
                      hintText: widget.holdText,
                      hintStyle: TextStyle(
                        fontSize: 32.sp,
                        color: const Color(0xFF999999),
                      )),
                  onChanged: (value) {
                    if (widget.callBack != null) {
                      widget.callBack!(value);
                    }
                  },
                  onTap: () {
                    if (!widget.enableInteractiveSelection) {
                      FocusScope.of(context).requestFocus(FocusNode());
                      if (widget.noEditCallBack != null) {
                        widget.noEditCallBack!();
                      }
                    }
                  },
                ),
              )),
              widget.rightWidget != null
                  ? Container(
                      child: widget.rightWidget,
                    )
                  : Container()
            ],
          ),
          widget.bottomWidget != null
              ? Row(
                  children: [
                    Text(
                      '*',
                      style:
                          TextStyle(fontSize: 32.sp, color: Colors.transparent),
                    ),
                    Text(
                      widget.text!,
                      style:
                          TextStyle(fontSize: 32.sp, color: Colors.transparent),
                    ),
                    SizedBox(
                      width: 47.w,
                    ),
                    Expanded(child: widget.bottomWidget!),
                  ],
                )
              : Container(),
        ],
      ),
    );
  }
}
