import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///
/// 搜索输入框(含圆角 阴影 '搜索'按钮)
///
class SearchTextField extends StatefulWidget {
  final TextEditingController searchController;
  final double? boxHeight;
  final TextInputType type;
  final String holdText;
  final bool enableInteractiveSelection;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? leftWidget;
  final Widget? rightWidget;
  final String imgPath;
  final Function? searchAction;
  final bool showClear; // 是否显示清除按钮

  const SearchTextField(
      {Key? key,
      required this.searchController,
      this.boxHeight,
      this.type = TextInputType.none,
      this.holdText = "搜索",
      this.inputFormatters,
      this.enableInteractiveSelection = false,
      this.leftWidget,
      this.rightWidget,
      this.imgPath = "",
      this.searchAction,
      this.showClear = true})
      : super(key: key);

  @override
  _SearchTextFieldState createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  String _searchText = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(37.h),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Color(0x20000000),

            /// 底色,阴影颜色
            offset: Offset(0, 2),

            /// 阴影位置,从什么位置开始
            blurRadius: 1,

            /// 阴影模糊层度
            spreadRadius: 0,

            /// 阴影模糊大小
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 22.w,
              ),
              height: widget.boxHeight ?? 63.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32.w),
                color: Colors.white
              ),
              child: Row(
                children: [
                  widget.imgPath.isEmpty ? const Icon(Icons.search, size: 26) : Image.asset(
                    widget.imgPath,
                    width: 29.w,
                    height: 29.w,
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 14.w),
                      child: TextField(
                        controller: widget.searchController,
                        inputFormatters: widget.inputFormatters,
                        keyboardType: widget.type,
                        enableInteractiveSelection: widget.enableInteractiveSelection,
                        style: TextStyle(fontSize: 29.sp, color: Colors.black),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: widget.holdText,
                          hintStyle: TextStyle(
                            fontSize: 29.sp,
                            color: const Color(0xFF999999),
                          ),
                          isDense: true,
                          isCollapsed: true, // 高度包裹
                        ),
                        onChanged: (value) {
                          _searchText = value;
                          if (widget.searchAction != null) {
                            widget.searchAction!(value);
                          }
                          setState(() {});
                        },
                        onSubmitted: (value) {
                          _searchText = value;
                          if (widget.searchAction != null) {
                            widget.searchAction!(value);
                          }
                        },
                      )
                    )
                  )
                ],
              ),
            )
          ),
          widget.showClear ? Offstage(
            offstage: widget.searchController.text != '' ? false : true,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  widget.searchController.text = '';
                });
                if (widget.searchAction != null) {
                  widget.searchAction!("");
                }
              },
              child: Container(
                height: 25.w,
                width: 25.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: const Color.fromRGBO(161, 165, 169, 1)
                ),
                child: const Icon(
                  Icons.close_rounded,
                  size: 10,
                  color: Colors.white,
                ),
              ),
            ),
          ) : Container(),
          widget.rightWidget ??
          GestureDetector(
            onTap: () {
              if (widget.searchAction != null) {
                widget.searchAction!(widget.searchController.text);
              }
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 29.w),
              child: Row(
                children: [
                  Container(
                    width: 1.w,
                    height: 29.h,
                    color: const Color(0xFFD8D8D8),
                  ),
                  SizedBox(width: 14.w),
                  Text(
                    '搜索',
                    style: TextStyle(
                      fontSize: 29.sp, color: const Color(0xFF177FF3)
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      )
    );
  }
}
