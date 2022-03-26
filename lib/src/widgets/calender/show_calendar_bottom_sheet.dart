import 'dart:io';
import 'package:app_assembly/app_assembly.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'calendar_view_modal.dart';
import 'calender_page.dart';

/// 日历选择器
class CalendarSelectorBottomSheet extends Dialog {
  const CalendarSelectorBottomSheet({
    Key? key,
  }) : super(key: key);

  /// 取消对话框
  static disMissDialog(BuildContext context) {
    Navigator.of(context).pop();
  }

  // 显示对话框
  static showMyConfirmDialog(BuildContext context,
      {Function? onTap, String? startTime, String? endTime}) {
    showDialog(
        context: context,
        barrierDismissible: false,
        useSafeArea: false,
        builder: (BuildContext context) {
          return CalendarContentView(
            callBack: onTap,
            startTime: startTime,
            endTime: endTime,
          );
        });
  }
}

class CalendarContentView extends StatefulWidget {
  final Function? callBack;
  final String? startTime;
  final String? endTime;
  final bool hasInitTime;

  const CalendarContentView(
      {Key? key,
      this.callBack,
      this.startTime,
      this.endTime,
      this.hasInitTime = false})
      : super(key: key);

  @override
  _CalendarContentViewState createState() => _CalendarContentViewState();
}

class _CalendarContentViewState extends State<CalendarContentView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          backgroundColor: const Color(0x60000000),
          resizeToAvoidBottomInset: false,
          body: Container(
              alignment: Alignment.bottomCenter,
              color: Colors.transparent,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8.w),
                        topRight: Radius.circular(8.w)),
                    color: Colors.white),
                width: double.infinity,
                height: 1298.h,
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(
                          0,
                          0,
                          0,
                          Platform.isAndroid
                              ? 32.h
                              : 32.h + MediaQuery.of(context).padding.bottom),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 32.w, vertical: 48.h),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8.h),
                                    topRight: Radius.circular(8.h)),
                                color: const Color.fromRGBO(249, 250, 251, 1)),
                            child: Row(
                              children: [
                                Text(
                                  '选择时间',
                                  style: TextStyle(
                                      fontSize: 36.sp,
                                      color: const Color(
                                          0xFF1D2023),
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                              child: widget.startTime != null &&
                                      widget.endTime != null &&
                                      widget.startTime != '' &&
                                      widget.endTime != ''
                                  ? CalendarPage(
                                      startTimeModel: DayModel(
                                          int.parse(widget.startTime!
                                              .split('-')
                                              .first),
                                          int.parse(
                                              widget.startTime!.split('-')[1]),
                                          int.parse(widget.startTime!
                                              .split('-')
                                              .last),
                                          widget.startTime!.split('-').last,
                                          false,
                                          false),
                                      endTimeModel: DayModel(
                                          int.parse(
                                              widget.endTime!.split('-').first),
                                          int.parse(
                                              widget.endTime!.split('-')[1]),
                                          int.parse(
                                              widget.endTime!.split('-').last),
                                          widget.endTime!.split('-').last,
                                          false,
                                          false),
                                      hasInitTime: true,
                                      selectDateOnTap: (value1, value2) {
                                        Navigator.pop(context);
                                        widget.callBack!(
                                            "${value1.year}-${value1.month > 10 ? value1.month : '0${value1.month}'}-${value1.dayNum > 9 ? value1.dayNum : '0${value1.dayNum}'}~${value2.year}-${value2.month > 10 ? value2.month : '0${value2.month}'}-${value2.dayNum > 9 ? value2.dayNum : '0${value2.dayNum}'}");
                                      },
                                    )
                                  : CalendarPage(
                                      selectDateOnTap: (value1, value2) {
                                        Navigator.pop(context);
                                        widget.callBack!(
                                            "${value1.year}-${value1.month > 10 ? value1.month : '0${value1.month}'}-${value1.dayNum > 9 ? value1.dayNum : '0${value1.dayNum}'}~${value2.year}-${value2.month > 10 ? value2.month : '0${value2.month}'}-${value2.dayNum > 9 ? value2.dayNum : '0${value2.dayNum}'}");
                                      },
                                    ))
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 32.h, top: 32.h),
                        color: Colors.white,
                        child: Image.asset(
                          'img/bidding_enterprise/salesman/home/bottom_close_icon.png',
                          width: 48.h,
                          height: 48.h,
                        ),
                      ),
                    )
                  ],
                ),
              )),
        ));
  }
}
