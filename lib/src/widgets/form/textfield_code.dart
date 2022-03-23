import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

class CodeTextField extends StatefulWidget {
  final int maxLength;
  final TextEditingController numberController;
  final Function? callBack;
  final Widget rightWidget;

  const CodeTextField(
      {Key? key,
      required this.numberController,
      this.maxLength = 6,
      this.callBack,
      required this.rightWidget})
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
        widget.rightWidget
      ],
    );
  }
}
