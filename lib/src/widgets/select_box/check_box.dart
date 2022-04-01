import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///
/// 复选框-含标题
///
class NewCheckBox extends StatefulWidget {
  final double width;
  final String? icon;
  final String title;
  final int index;
  final int selectIndex;
  final Function? tapCallback;

  const NewCheckBox(
      {Key? key,
      required this.width,
      this.icon,
      this.title = "",
      required this.index,
      required this.selectIndex,
      this.tapCallback})
      : super(key: key);

  @override
  _NewCheckBoxState createState() => _NewCheckBoxState();
}

class _NewCheckBoxState extends State<NewCheckBox> {
  bool isSure = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          setState(() {
            isSure = !isSure;
          });
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
                  borderRadius: BorderRadius.circular(8.w),
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
                    fontSize: 28.sp,
                    color: const Color.fromRGBO(96, 105, 114, 1)),
              ),
            )
          ],
        ));
  }
}
