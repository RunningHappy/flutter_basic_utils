import 'package:app_assembly/app_assembly.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 同意协议 widget
class AgreeAgreement extends StatefulWidget {
  final double? fontSize;
  final List agreements;
  final bool showButton;
  final Function? tapCallback;

  const AgreeAgreement(
      {Key? key,
      required this.agreements,
      this.fontSize,
      this.showButton = true,
      this.tapCallback})
      : super(key: key);

  @override
  _AgreeAgreementState createState() => _AgreeAgreementState();
}

class _AgreeAgreementState extends State<AgreeAgreement> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  _getAgreementWidget() {
    return widget.agreements
        .map((e) => GestureDetector(
              onTap: () {
                widget.tapCallback!(e["id"]);
              },
              child: Text(
                '《' + e["name"] + '》',
                style: TextStyle(
                    fontSize: widget.fontSize ?? 25.sp,
                    color: const Color.fromRGBO(23, 127, 243, 1)),
              ),
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        widget.showButton
            ? NewRadioBox(
                index: 0,
                selectIndex: 0,
                title: "同意",
                fontSize: widget.fontSize ?? 28.sp,
                width: 34.w,
                tapCallback: (value) {})
            : Container(),
        Row(
          children: _getAgreementWidget(),
        )
      ],
    );
  }
}
