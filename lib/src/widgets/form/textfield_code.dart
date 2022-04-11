import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

///
/// 验证码输入框
///
class CodeTextField extends StatefulWidget {
  final int maxLength;
  final TextEditingController numberController;
  final Function? callBack;
  final Widget rightWidget;
  final bool showClear; // 是否显示清除按钮

  const CodeTextField(
      {Key? key,
      required this.numberController,
      this.maxLength = 6,
      this.callBack,
      required this.rightWidget,
      this.showClear = true})
      : super(key: key);

  @override
  _CodeTextFieldState createState() => _CodeTextFieldState();
}

class _CodeTextFieldState extends State<CodeTextField> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            child: TextField(
          controller: widget.numberController,
          style: TextStyle(fontSize: 33.sp, color: Colors.black),
          keyboardType: TextInputType.number,
          inputFormatters: [
            LengthLimitingTextInputFormatter(widget.maxLength),
            WhitelistingTextInputFormatter.digitsOnly
          ],
          decoration: InputDecoration(
              isCollapsed: true, // 高度包裹
              border: InputBorder.none,
              hintText: '请输入验证码',
              hintStyle: TextStyle(
                fontSize: 32.sp,
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
                    margin: EdgeInsets.only(right: 16.w),
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
        widget.rightWidget
      ],
    );
  }
}
