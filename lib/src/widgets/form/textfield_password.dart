import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

///
/// 密码输入框
///
class PassWordTextField extends StatefulWidget {
  final TextEditingController numberController;
  final String holdText;
  final bool isLogin;
  final String phone;
  final List<TextInputFormatter>? inputFormatters;
  final bool showClear; // 是否显示清除按钮
  final Function? callBack;
  final Function? forgetCallback;

  const PassWordTextField(
      {Key? key,
      required this.numberController,
      this.callBack,
      this.forgetCallback,
      required this.holdText,
      required this.isLogin,
      required this.phone,
      required this.inputFormatters,
      this.showClear = true})
      : super(key: key);

  @override
  _CodeTextFieldState createState() => _CodeTextFieldState();
}

class _CodeTextFieldState extends State<PassWordTextField> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            child: TextField(
          controller: widget.numberController,
          style: TextStyle(fontSize: 33.sp, color: Colors.black),
          obscureText: true,
          obscuringCharacter: '*',
          inputFormatters: widget.inputFormatters,
          // [LengthLimitingTextInputFormatter(20)]
          decoration: InputDecoration(
              isCollapsed: true, // 高度包裹
              border: InputBorder.none,
              hintText: widget.holdText,
              hintStyle: TextStyle(
                fontSize: 33.sp,
                color: const Color.fromRGBO(153, 153, 153, 1),
              )),
          onChanged: (value) {
            setState(() {});
            if (widget.callBack != null) {
              widget.callBack!();
            }
          },
        )),
        widget.showClear
            ? Offstage(
                offstage: widget.numberController.text != '' ? false : true,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.numberController.text = '';
                    });
                    if (widget.callBack != null) {
                      widget.callBack!("");
                    }
                  },
                  child: Container(
                    height: 25.w,
                    width: 25.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: const Color.fromRGBO(161, 165, 169, 1)),
                    child: const Icon(
                      Icons.close_rounded,
                      size: 10,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            : Container(),
        widget.isLogin
            ? GestureDetector(
                onTap: () {
                  if (widget.forgetCallback != null) {
                    widget.forgetCallback!();
                  }
                },
                child: Text(
                  '忘记密码？',
                  style: TextStyle(
                      fontSize: 29.sp,
                      color: const Color.fromRGBO(23, 127, 243, 1)),
                ),
              )
            : Container()
      ],
    );
  }
}
