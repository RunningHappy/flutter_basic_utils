import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///
/// 手机号输入框
///
class PhoneTextField extends StatefulWidget {
  final TextEditingController phoneController;
  final String holdText;
  final Function? callBack;
  final bool showClear; // 是否显示清除按钮
  final TextAlign? textAlign;

  const PhoneTextField(
      {Key? key,
      required this.phoneController,
      this.callBack,
      required this.holdText,
      this.textAlign,
      this.showClear = true})
      : super(key: key);

  @override
  _PhoneTextFieldState createState() => _PhoneTextFieldState();
}

class _PhoneTextFieldState extends State<PhoneTextField> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: TextField(
          controller: widget.phoneController,
          style: TextStyle(fontSize: 33.sp, color: Colors.black),
          textAlign: widget.textAlign ?? TextAlign.left,
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            isCollapsed: true, // 高度包裹
            border: InputBorder.none,
            hintText: widget.holdText,
            hintStyle: TextStyle(
              fontSize: 33.sp,
              color: const Color.fromRGBO(153, 153, 153, 1),
            ),
          ),
          inputFormatters: [
            LengthLimitingTextInputFormatter(11),
            WhitelistingTextInputFormatter.digitsOnly
          ],
          onChanged: (value) {
            setState(() {});
            if (widget.callBack != null) {
              widget.callBack!(value);
            }
          },
        )),
        widget.showClear
            ? Offstage(
                offstage: widget.phoneController.text != '' ? false : true,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.phoneController.text = '';
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
      ],
    );
  }
}
