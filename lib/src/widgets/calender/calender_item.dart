import 'package:app_assembly/app_assembly.dart';
import 'package:flutter/material.dart';
import 'calendar_view_modal.dart';

typedef OnTapDayItem = void Function(int year, int month, int checkInTime);

class CalendarItem extends StatefulWidget {
  final CalendarItemViewModel itemModel;
  final OnTapDayItem dayItemOnTap;

  const CalendarItem(this.dayItemOnTap, this.itemModel, {Key? key})
      : super(key: key);

  @override
  _CalendarItemState createState() => _CalendarItemState();
}

class _CalendarItemState extends State<CalendarItem> {
  // 日历显示几行
  int _rows = 0;
  List<DayModel> _listModel = <DayModel>[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _listModel = widget.itemModel.list!;
  }

  /// 根据当前年月份计算当前月份显示几行
  static int getRowsForMonthYear(
      int year, int month, MaterialLocalizations localizations) {
    int currentMonthDays = DateUtil.getDaysInMonth(year, month);
    // 每个月前面空出来的天数
    int placeholderDays =
        numberOfHeadPlaceholderForMonth(year, month, localizations);
    int rows = (currentMonthDays + placeholderDays) ~/ 7; // 向下取整
    int remainder = (currentMonthDays + placeholderDays) % 7; // 取余（最后一行的天数）
    if (remainder > 0) {
      rows += 1;
    }
    return rows;
  }

  /// 每个月前面空出来的天数
  static int numberOfHeadPlaceholderForMonth(
      int year, int month, MaterialLocalizations localizations) {
    return computeFirstDayOffset(year, month, localizations);
  }

  /// 得到这个月的第一天是星期几（0 是 星期日 1 是 星期一...）
  static int computeFirstDayOffset(
      int year, int month, MaterialLocalizations localizations) {
    // 0-based day of week, with 0 representing Monday.
    final int weekdayFromMonday = DateTime(year, month).weekday - 1;
    // 0-based day of week, with 0 representing Sunday.
    final int firstDayOfWeekFromSunday = localizations.firstDayOfWeekIndex;
    // firstDayOfWeekFromSunday recomputed to be Monday-based
    final int firstDayOfWeekFromMonday = (firstDayOfWeekFromSunday - 1) % 7;
    // Number of days between the first day of week appearing on the calendar,
    // and the day corresponding to the 1-st of the month.
    return (weekdayFromMonday - firstDayOfWeekFromMonday) % 7;
  }

  @override
  Widget build(BuildContext context) {
    // 显示几行
    _rows = getRowsForMonthYear(widget.itemModel.year!, widget.itemModel.month!,
        MaterialLocalizations.of(context));

    return Column(
      children: <Widget>[
        _yearMonthItem(widget.itemModel.year!, widget.itemModel.month!),
        _monthAllDays(widget.itemModel.year!, widget.itemModel.month!, context),
      ],
    );
  }

  /// 显示年月的组件，需要传入年月日期
  _yearMonthItem(int year, int month) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 34.h),
      child: Row(
        children: [
          Text(
            '$year年$month月',
            style: TextStyle(
                color: const Color(0xFF1D2023),
                fontSize: 32.sp,
                fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }

  _monthAllDays(int year, int month, BuildContext context) {
    double screenWith = MediaQuery.of(context).size.width;

    // 当前月前面空的天数
    int emptyDays = numberOfHeadPlaceholderForMonth(
        year, month, MaterialLocalizations.of(context));

    List<Widget> _list = <Widget>[];

    for (int i = 1; i <= emptyDays; i++) {
      _list.add(_dayEmptyTitleItem(context));
    }

    for (int i = 1; i <= _listModel.length; i++) {
      _list.add(_dayTitleItem(_listModel[i - 1], context));
    }

    List<Row> _rowList = <Row>[
      Row(
        children: _list.sublist(0, 7),
      ),
      Row(
        children: _list.sublist(7, 14),
      ),
      Row(
        children: _list.sublist(14, 21),
      ),
    ];

    if (_rows == 4) {
      _rowList.add(
        Row(
          children: _list.sublist(21, _list.length),
        ),
      );
    } else if (_rows == 5) {
      _rowList.add(
        Row(
          children: _list.sublist(21, 28),
        ),
      );
      _rowList.add(
        Row(
          children: _list.sublist(28, _list.length),
        ),
      );
    } else if (_rows == 6) {
      _rowList.add(
        Row(
          children: _list.sublist(21, 28),
        ),
      );
      _rowList.add(
        Row(
          children: _list.sublist(28, 35),
        ),
      );
      _rowList.add(
        Row(
          children: _list.sublist(35, _list.length),
        ),
      );
    }
    return Column(
      children: _rowList,
    );
  }

  /// number 月的几号 isOverdue 是否过期
  _dayTitleItem(DayModel model, BuildContext context) {
    String dayTitle = model.day;
    String subTitle = '';
    if (widget.itemModel.firstSelectModel != null &&
        model.isSelect &&
        model.dayNum == widget.itemModel.firstSelectModel!.dayNum &&
        model.year == widget.itemModel.firstSelectModel!.year &&
        model.month == widget.itemModel.firstSelectModel!.month) {
      subTitle = '开始';
    }
    if (widget.itemModel.lastSelectModel != null &&
        model.isSelect &&
        model.dayNum == widget.itemModel.lastSelectModel!.dayNum &&
        model.year == widget.itemModel.lastSelectModel!.year &&
        model.month == widget.itemModel.lastSelectModel!.month) {
      subTitle = '结束';
    }
    return GestureDetector(
      onTap: () {
        if (model.isOverdue) return;
        _dayTitleItemTap(model);
      },
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            width: 107.w,
            height: 108.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: subTitle == '开始' || subTitle == '结束'
                    ? BorderRadius.circular(8.w)
                    : BorderRadius.circular(0),
                color: subTitle == '开始' || subTitle == '结束'
                    ? const Color(0xFF177FF3)
                    : model.isSelect
                        ? const Color(0x20177FF3)
                        : Colors.white),
            child: Text(
              dayTitle,
              style: TextStyle(
                color: subTitle == '开始' || subTitle == '结束'
                    ? Colors.white
                    : model.isOverdue
                        ? const Color(0xFFDBDDE4)
                        : const Color(0xFF1D2023),
                fontSize: 32.sp,
              ),
            ),
          ),
          Text(
            subTitle,
            style: TextStyle(
              color: subTitle == '开始' || subTitle == '结束'
                  ? Colors.white
                  : const Color(0xFF1D2023),
              fontSize: 24.sp,
            ),
          ),
        ],
      ),
    );
  }

  _dayEmptyTitleItem(BuildContext context) {
    return SizedBox(
      width: 107.w,
      height: 108.h,
    );
  }

  _dayTitleItemTap(DayModel model) {
    widget.dayItemOnTap(
        widget.itemModel.year!, widget.itemModel.month!, model.dayNum);
    setState(() {});
  }
}
