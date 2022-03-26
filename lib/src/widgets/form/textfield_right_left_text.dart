import 'package:app_assembly/app_assembly.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 样式：左边文本+右边输入框
class MyTextInputPreLabel extends StatefulWidget {
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final int maxLines;
  final int? maxLength;
  final String? hintText;
  final bool obscureText;
  final String preLabel;
  final bool readOnly;
  final bool enabled;
  final bool? autofocus;
  final List<TextInputFormatter>? inputFormatters;
  final onChange;

  const MyTextInputPreLabel(
      {Key? key,
      this.controller,
      this.keyboardType,
      this.maxLines = 1,
      this.maxLength,
      this.hintText,
      this.obscureText = false,
      this.preLabel = "姓名",
      this.readOnly = false,
      this.enabled = true,
      this.autofocus,
      this.onChange,
      this.inputFormatters})
      : super(key: key);

  @override
  _MyTextInputPreLabelState createState() => _MyTextInputPreLabelState();
}

class _MyTextInputPreLabelState extends State<MyTextInputPreLabel> {
  FocusNode codeFocusNode = FocusNode();
  bool isFocus = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    codeFocusNode.addListener(() {
      if (codeFocusNode.hasFocus) {
        isFocus = true;
      } else {
        isFocus = false;
      }
      setState(() {});
    });
  }

  // 取消倒计时
  @override
  void dispose() {
    codeFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  width: 0.3,
                  color: isFocus
                      ? const Color(0xFF177FF3)
                      : const Color(0xFFDDDDDD)))),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 210.w,
            child: Text(
              widget.preLabel,
              style: TextStyle(fontSize: 28.sp),
            ),
          ),
          SizedBox(width: 15.w),
          Expanded(
            child: MyTextField(
              controller: widget.controller,
              obscureText: widget.obscureText,
              maxLines: widget.maxLines,
              maxLength: widget.maxLength,
              keyboardType: widget.keyboardType,
              hintText: widget.hintText,
              isShowBorder: false,
              focusNode: codeFocusNode,
              readOnly: widget.readOnly,
              enabled: widget.enabled,
              autofocus: widget.autofocus,
              inputFormatters: widget.inputFormatters,
              onChangeCallback: widget.onChange,
            ),
          )
        ],
      ),
    );
  }
}
