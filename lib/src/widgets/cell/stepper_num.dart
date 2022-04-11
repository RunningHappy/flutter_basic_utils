import 'package:app_assembly/app_assembly.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///
/// +/- 数量
///
class StepperNumber extends StatefulWidget {
  final int num;
  final bool canInput;
  final int? maxNum;
  final int? normalNUm;
  final Function? tapCallback;

  const StepperNumber(
      {Key? key,
      required this.num,
      this.canInput = true,
      this.tapCallback,
      this.maxNum = 0,
      this.normalNUm = 0})
      : super(key: key);

  @override
  _StepperNumberState createState() => _StepperNumberState();
}

class _StepperNumberState extends State<StepperNumber> {
  var count = 0;
  TextEditingController _numberController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.normalNUm! > 0) {
      setState(() {
        count = widget.normalNUm!;
      });
    }
    _numberController = TextEditingController(text: count.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            if (count > 1) {
              setState(() {
                count -= widget.num;
                widget.tapCallback!(count);
                if (widget.canInput) {
                  _numberController.text = count.toString();
                }
              });
            }
          },
          child: Container(
            padding: EdgeInsets.all(5.w),
            width: 51.w,
            height: 51.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(7.w),
                  bottomLeft: Radius.circular(7.w),
                ),
                color: count > 1
                    ? const Color(0xFFE7F2FD)
                    : const Color(0xFFF6F6F6)),
            child: Icon(
              Icons.remove,
              size: 30.sp,
              color:
                  count > 1 ? const Color(0xFF177FF3) : const Color(0xFFD0D0D0),
            ),
          ),
        ),
        Container(
          width: 76.w,
          height: 51.w,
          margin: EdgeInsets.symmetric(horizontal: 3.w),
          alignment: Alignment.center,
          color: const Color(0xFFF6F6F6),
          child: widget.canInput
              ? PhoneTextField(
                  showClear: false,
                  phoneController: _numberController,
                  textAlign: TextAlign.center,
                  callBack: (value) {
                    if (value != null && value != '') {
                      if (widget.maxNum! > 0) {
                        if (int.parse(value) > widget.maxNum!) {
                          _numberController.text = widget.maxNum.toString();
                          EasyLoading.showError('不能超过最大值${widget.maxNum}!');
                        } else {
                          count = int.parse(value);
                          widget.tapCallback!(value);
                          if (count > 1) {
                            setState(() {});
                          }
                        }
                      } else {
                        count = int.parse(value);
                        widget.tapCallback!(value);
                        if (count > 1) {
                          setState(() {});
                        }
                      }
                    } else {
                      widget.tapCallback!('');
                    }
                    // else{
                    //   count = 1;
                    //   _numberController.text = '1';
                    //   widget.tapCallback!(value);
                    //   setState(() {});
                    // }
                  },
                  holdText: "")
              : Text(
                  '$count',
                  style: TextStyle(
                      fontSize: 25.sp,
                      color: const Color(0xFF1D2023),
                      fontWeight: FontWeight.w600),
                ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              if (widget.maxNum! > 0) {
                if (count < widget.maxNum!) {
                  count += widget.num;
                } else {
                  EasyLoading.showError('不能超过最大值${widget.maxNum}!');
                }
              } else {
                count += widget.num;
              }
              widget.tapCallback!(count);
              if (widget.canInput) {
                _numberController.text = count.toString();
              }
            });
          },
          child: Container(
            width: 51.w,
            height: 51.w,
            padding: EdgeInsets.all(5.w),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(7.w),
                  bottomRight: Radius.circular(7.w),
                ),
                color: const Color(0xFFE7F2FD)),
            child: Icon(
              Icons.add_rounded,
              size: 30.sp,
              color: const Color(0xFF177FF3),
            ),
          ),
        )
      ],
    );
  }
}
