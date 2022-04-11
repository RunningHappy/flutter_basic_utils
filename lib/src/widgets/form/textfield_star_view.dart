import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

typedef CallBack = Function(String value);

///
/// 单行，含"*"标题+输入框/文本的item
///
class StarTextFieldView extends StatefulWidget {
  final TextEditingController? controller;
  final bool enable;
  final TextInputType keyboardType;
  final bool isHideStar;
  final bool isHideTextField;
  final Widget? rightWidget;
  final Widget? bottomWidget;
  final String? text;
  final String? holdText;
  final TextAlign? textAlign;
  final double? vertical;
  final CallBack? callBack;
  final Function? tapInputCallback;
  final TextStyle? style;
  final List<TextInputFormatter>? inputFormatters;

  const StarTextFieldView(
      {Key? key,
      this.controller,
      this.enable = true,
      this.keyboardType = TextInputType.text,
      this.isHideStar = false,
      this.isHideTextField = false,
      this.rightWidget,
      this.bottomWidget,
      this.text,
      this.holdText,
      this.textAlign,
      this.inputFormatters,
      this.vertical,
      this.style,
      this.callBack,
      this.tapInputCallback})
      : super(key: key);

  @override
  _StarTextFieldViewState createState() => _StarTextFieldViewState();
}

class _StarTextFieldViewState extends State<StarTextFieldView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: 29.w, vertical: widget.vertical ?? 39.h),
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
              Text(
                widget.text!,
                style:
                    TextStyle(fontSize: 32.sp, color: const Color(0xFF1D2023)),
              ),
              SizedBox(
                width: 47.w,
              ),
              widget.isHideTextField
                  ? Container()
                  : Expanded(
                      child: GestureDetector(
                      onTap: () {
                        if (widget.tapInputCallback != null) {
                          widget.tapInputCallback!();
                        }
                      },
                      child: TextField(
                        textAlign: widget.textAlign ?? TextAlign.left,
                        controller: widget.controller,
                        enabled: widget.enable,
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
