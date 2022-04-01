import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///
/// 单选框-含标题
///
class NewRadioBox extends StatefulWidget {
  final double? fontSize;
  final double width;
  final String? icon;
  final String title;
  final int index;
  final int selectIndex;
  final Function? tapCallback;

  const NewRadioBox(
      {Key? key,
      required this.width,
      this.fontSize,
      this.icon,
      this.title = "",
      required this.index,
      required this.selectIndex,
      this.tapCallback})
      : super(key: key);

  @override
  _NewRadioBoxState createState() => _NewRadioBoxState();
}

class _NewRadioBoxState extends State<NewRadioBox> {
  bool isSure = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _init();
  }

  _init() {
    isSure = widget.index == widget.selectIndex;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          setState(() {
            isSure = !isSure;
          });
          widget.tapCallback!(widget.index);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: widget.width,
              height: widget.width,
              decoration: BoxDecoration(
                  border: Border.all(
                      width: 1.w,
                      color: isSure
                          ? const Color(0xFF177FF3)
                          : const Color.fromRGBO(151, 151, 151, 1)),
                  borderRadius: BorderRadius.circular(30),
                  color: isSure ? const Color(0xFF177FF3) : Colors.transparent),
              child: Offstage(
                offstage: isSure ? false : true,
                child: widget.icon == null
                    ? const Icon(
                        Icons.check,
                        size: 10,
                        color: Colors.white,
                      )
                    : Image.asset(widget.icon!,
                        color: Colors.white,
                        width: widget.width,
                        height: widget.width),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 10.w),
              child: Text(
                widget.title,
                style: TextStyle(
                    fontSize: widget.fontSize ?? 28.sp,
                    color: const Color.fromRGBO(96, 105, 114, 1)),
              ),
            )
          ],
        ));
  }
}
