import 'package:app_assembly/app_assembly.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///
/// 通用 input 组件，带点击删除
///
class MyTextField extends StatefulWidget {
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final int maxLines;
  final int? maxLength;
  final String? hintText;
  final bool obscureText;
  final bool isShowBorder;
  final FocusNode? focusNode;
  final bool readOnly;
  final bool enabled;
  final bool? autofocus;
  final double? fontSize;
  final List<TextInputFormatter>? inputFormatters;
  final InputDecoration? decoration;
  final Function(String value)? onChangeCallback;

  const MyTextField(
      {Key? key,
      this.controller,
      this.keyboardType,
      this.maxLines = 1,
      this.maxLength,
      this.hintText,
      this.obscureText = false,
      this.isShowBorder = true,
      this.focusNode,
      this.readOnly = false,
      this.enabled = true,
      this.fontSize,
      this.autofocus,
      this.onChangeCallback,
      this.inputFormatters,
      this.decoration})
      : super(key: key);

  @override
  _MyTextFieldState createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  Widget? _suffixIcon;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _setIcon();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    widget.controller?.dispose();
  }

  // 设置suffixIcon
  void _setIcon() {
    widget.controller?.addListener(() {
      if (widget.controller!.text.isNotEmpty) {
        _suffixIcon = _getIcon();
      } else {
        _suffixIcon = null;
      }
      setState(() {});
    });
  }

  Widget _getIcon() {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        clearInput(widget.controller!);
      },
      child: Icon(
        Icons.cancel,
        color: const Color(0xFF999999),
        size: 32.h,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
          inputDecorationTheme: widget.isShowBorder
              ? Theme.of(context).inputDecorationTheme
              : const InputDecorationTheme(border: InputBorder.none)),
      child: TextField(
          obscureText: widget.obscureText,
          controller: widget.controller,
          keyboardType: widget.keyboardType,
          maxLength: widget.maxLength,
          inputFormatters: widget.inputFormatters,
          autofocus: widget.autofocus ?? false,
          style: TextStyle(
              fontSize: widget.fontSize ?? 28.sp,
//              color: !widget.enabled
//                  ? Color(KColors.enable_text_color)
//                  : Color(KColors.common_text_color_black)),
              color: const Color(0xFF1D2023)),
          focusNode: widget.focusNode,
          readOnly: widget.readOnly,
          enabled: widget.enabled,
          onChanged: (value) {
            if (widget.onChangeCallback != null) {
              widget.onChangeCallback!(value);
            }
          },
          decoration: widget.decoration ??
              InputDecoration(
                isCollapsed: true,
                // 高度包裹
                counterText: "",
                contentPadding: EdgeInsets.symmetric(vertical: 16.h),
                hintText: widget.hintText,
                hintStyle: TextStyle(fontSize: 28.sp),
                suffixIcon: widget.enabled ? _suffixIcon : null,
                enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                  color: Color(0xFFDDDDDD),
                  width: 0.5,
                )),
                focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                  color: Color(0xff177FF3),
                  width: 0.5,
                )),
              )),
    );
  }
}
