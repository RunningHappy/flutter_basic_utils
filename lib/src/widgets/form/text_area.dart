import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///
/// 多行输入
///
class TextAreaInput extends StatelessWidget {
  final TextEditingController? controller;
  final int maxLength;
  final int maxLines;
  final int minLines;
  final String hintText;

  const TextAreaInput(
    {@required this.controller,
    this.maxLength = 10,
    this.maxLines = 5,
    this.minLines = 1,
    this.hintText = "请输入内容",
    Key? key})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    RegExp regexp = RegExp("[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]");

    return TextField(
      keyboardType: TextInputType.multiline,
      maxLines: maxLines,
      minLines: minLines,
      controller: controller,
      maxLength: maxLength,
      style: TextStyle(fontSize: 28.sp),
      inputFormatters: [BlacklistingTextInputFormatter(regexp)],
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(top: 24.h, bottom: 0),
        hintText: hintText,
        hintStyle: TextStyle(fontSize: 28.sp),
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none
      )
    );
  }
}
