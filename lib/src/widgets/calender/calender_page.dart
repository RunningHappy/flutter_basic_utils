import 'package:app_assembly/app_assembly.dart';
import 'package:flutter/material.dart';
import 'calendar_view_modal.dart';
import 'calender_item.dart';

enum Location { left, mid, right }

typedef SelectDateOnTap = void Function(
    DayModel checkInTimeModel, DayModel leaveTimeModel);

///
/// Location 标记当前选中日期和之前的日期相比，
/// left： 是在之前日期之前
/// mid：  和之前日期相等
/// right：在之前日期之后
///
class CalendarPage extends StatefulWidget {
  final DayModel? startTimeModel; // 外部传入的之前选中的入住日期
  final DayModel? endTimeModel; // 外部传入的之前选中的离开日期
  final SelectDateOnTap? selectDateOnTap; // 确定按钮的callback 给外部传值
  final bool hasInitTime;

  const CalendarPage(
      {Key? key,
      this.startTimeModel,
      this.endTimeModel,
      this.selectDateOnTap,
      this.hasInitTime = false})
      : super(key: key);

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  String _selectCheckInTime = '选择开始时间';
  String _selectLeaveTime = '选择结束时间';
  bool _isSelectCheckInTime = false; // 是否选择入住日期
  bool _isSelectLeaveTime = false; // 是否选择离开日期
  int _checkInDays = 0; // 入住天数

  // 保存当前选中的入住日期和离开日期
  var _selectCheckInTimeModel;
  var _isSelectLeaveTimeModel;

  List<CalendarItemViewModel> _list = [];

  @override
  void initState() {
    super.initState();
    // 加载日历数据源
    _list = CalendarViewModel().getItemList(
        widget.startTimeModel, widget.endTimeModel,
        hasInitTime: widget.hasInitTime);
    // 处理外部传入的选中日期
    if (widget.startTimeModel != null && widget.endTimeModel != null) {
      for (int i = 0; i < _list.length; i++) {
        CalendarItemViewModel model = _list[i];
        if (model.month == widget.startTimeModel!.month) {
          _updateDataSource(widget.startTimeModel!.year,
              widget.startTimeModel!.month, widget.startTimeModel!.dayNum);
        }
        if (model.month == widget.endTimeModel!.month) {
          _updateDataSource(widget.endTimeModel!.year,
              widget.endTimeModel!.month, widget.endTimeModel!.dayNum);
        }
      }
    }
  }

  /// 显示周的组件，使用了 _weekTitleItem
  _weekItem() {
    List<String> _listS = <String>[
      '日',
      '一',
      '二',
      '三',
      '四',
      '五',
      '六',
    ];
    List<Widget> _listW = [];
    for (var title in _listS) {
      _listW.add(_weekTitleItem(title));
    }
    return Container(
      height: 92.h,
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(width: 1.w, color: const Color(0xFFDBDDE4)))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _listW,
      ),
    );
  }

  /// 周内对应的每天的组件
  _weekTitleItem(String title) {
    return Expanded(
        child: Container(
      alignment: Alignment.center,
      child: Text(
        title,
        style: TextStyle(
          color: title == '六' || title == '日'
              ? const Color(0xFF00C3CE)
              : const Color(0xFF1D2023),
          fontSize: 28.sp,
        ),
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _weekItem(),
        // 月日期的视图
        Expanded(
            child: ListView.builder(
          padding: const EdgeInsets.all(0),
          itemBuilder: (BuildContext context, int index) {
            CalendarItemViewModel itemModel = _list[index];
            return CalendarItem(
              (year, month, checkInTime) {
                _updateCheckInLeaveTime(year, month, checkInTime);
              },
              itemModel,
            );
          },
          itemCount: _list.length,
        )),
        Container(
          padding: EdgeInsets.symmetric(vertical: 32.h),
          decoration: BoxDecoration(
              border: Border(
                  top: BorderSide(width: 1.w, color: const Color(0xFFDBDDE4)))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$_selectCheckInTime  到  $_selectLeaveTime',
                style:
                    TextStyle(fontSize: 32.sp, color: const Color(0xFF41485D)),
              )
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 32.w),
          height: 100.h,
          child: MoreColorLoginButton(
              title: '确定',
              type: true,
              fontSize: 36.sp,
              callBack: () {
                _sureButtonTap();
              }),
        )
      ],
    );
  }

  /// 比较后面的日期是比model日期小（left） 还是相等(mid) 还是大 (right)
  _compareTime(DayModel model, int year, int month, int day) {
    if (year > model.year) {
      return Location.right;
    } else if (year == model.year) {
      if (model.month < month) {
        return Location.right;
      } else if (model.month == month) {
        if (model.dayNum < day) {
          return Location.right;
        } else if (model.dayNum == day) {
          return Location.mid;
        } else {
          return Location.left;
        }
      } else {
        return Location.left;
      }
    } else {
      return Location.left;
    }
  }

  /// 更新日历的数据源
  _updateDataSource(int year, int month, int checkInTime) {
    // 左右指针 用来记录选择的入住日期和离开日期
    var firstModel;
    var lastModel;

    for (int i = 0; i < _list.length; i++) {
      CalendarItemViewModel model = _list[i];
      if (model.firstSelectModel != null) {
        firstModel = model.firstSelectModel!;
      }
      if (model.lastSelectModel != null) {
        lastModel = model.lastSelectModel!;
      }
    }

    if (firstModel != null && lastModel != null) {
      for (int i = 0; i < _list.length; i++) {
        CalendarItemViewModel model = _list[i];
        model.firstSelectModel = null;
        model.lastSelectModel = null;
        firstModel = null;
        lastModel = null;
        for (int i = 0; i < model.list!.length; i++) {
          DayModel dayModel = model.list![i];
          dayModel.isSelect = false;
          if (_compareTime(dayModel, year, month, checkInTime) ==
              Location.mid) {
            dayModel.isSelect = true;
            model.firstSelectModel = dayModel;
            _isSelectCheckInTime = true;
            _isSelectLeaveTime = false;
            _selectCheckInTime = '$year-$month-$checkInTime';
            _selectCheckInTimeModel = dayModel;
          }
        }
      }
      _checkInDays = 0;
      _isSelectLeaveTime = false;
      _selectLeaveTime = '选择结束时间';
      _isSelectLeaveTimeModel = null;
    } else if (firstModel != null && lastModel == null) {
      if (_compareTime(firstModel, year, month, checkInTime) == Location.left) {
        for (int i = 0; i < _list.length; i++) {
          CalendarItemViewModel model = _list[i];
          model.firstSelectModel = null;
          model.lastSelectModel = null;
          firstModel = null;
          lastModel = null;
          for (int i = 0; i < model.list!.length; i++) {
            DayModel dayModel = model.list![i];
            dayModel.isSelect = false;
            if (_compareTime(dayModel, year, month, checkInTime) ==
                Location.mid) {
              dayModel.isSelect = !dayModel.isSelect;
              model.firstSelectModel = dayModel;
              _isSelectCheckInTime = dayModel.isSelect ? true : false;
              _selectCheckInTime = '$year-$month-$checkInTime';
              _selectCheckInTimeModel = dayModel;
            }
          }
        }
        _checkInDays = 0;
        _isSelectLeaveTime = false;
        _selectLeaveTime = '选择开始时间';
        _isSelectLeaveTimeModel = null;
      } else if (_compareTime(firstModel, year, month, checkInTime) ==
          Location.mid) {
        //点击了自己
        for (int i = 0; i < _list.length; i++) {
          CalendarItemViewModel model = _list[i];
          model.lastSelectModel = null;
          if (model.month == month) {
            for (int i = 0; i < model.list!.length; i++) {
              DayModel dayModel = model.list![i];
              if (_compareTime(dayModel, year, month, checkInTime) ==
                  Location.mid) {
                dayModel.isSelect = true;
                if (model.firstSelectModel != null) {
                  _isSelectLeaveTime = true;
                  _selectLeaveTime = '$year-$month-$checkInTime';
                  _isSelectLeaveTimeModel = dayModel;
                } else {
                  model.firstSelectModel = dayModel.isSelect ? dayModel : null;
                  _selectCheckInTimeModel = dayModel.isSelect ? dayModel : null;
                  _isSelectCheckInTime = dayModel.isSelect ? true : false;
                  _selectCheckInTime = dayModel.isSelect
                      ? '$year-$month-$checkInTime'
                      : '选择开始时间';
                  _checkInDays = 0;
                  _isSelectLeaveTime = false;
                  _selectLeaveTime = '选择离开时间';
                  _isSelectLeaveTimeModel = null;
                }
              }
            }
          }
        }
      } else if (_compareTime(firstModel, year, month, checkInTime) ==
          Location.right) {
        if (year > firstModel.year) {
          int _calculateDays = 1;
          for (int i = 0; i < _list.length; i++) {
            CalendarItemViewModel model = _list[i];
            if (model.year! < year) {
              if (model.month! >= firstModel.month) {
                for (int i = 0; i < model.list!.length; i++) {
                  DayModel dayModel = model.list![i];
                  if (model.month == firstModel.month) {
                    if (dayModel.dayNum >= firstModel.dayNum) {
                      dayModel.isSelect = true;
                      _calculateDays++;
                    }
                  } else {
                    dayModel.isSelect = true;
                    _calculateDays++;
                  }
                }
              }
            } else {
              if (model.month! <= month) {
                for (int i = 0; i < model.list!.length; i++) {
                  DayModel dayModel = model.list![i];
                  if (model.month == month) {
                    if (dayModel.dayNum == checkInTime) {
                      dayModel.isSelect = true;
                      model.lastSelectModel = dayModel;
                      _isSelectLeaveTimeModel = dayModel;
                      _isSelectLeaveTime = true;
                      _selectLeaveTime = '$year-$month-$checkInTime';
                    } else if (dayModel.dayNum < checkInTime) {
                      dayModel.isSelect = true;
                      _calculateDays++;
                    }
                  } else {
                    dayModel.isSelect = true;
                    _calculateDays++;
                  }
                }
              }
            }
          }
          _checkInDays = _calculateDays;
        } else {
          int _calculateDays = 1;
          // for(int i=0; i<_list.length; i++) {
          //   CalendarItemViewModel model = _list[i];
          //   if(model.month == firstModel.month){
          //     for(int i=0; i<model.list!.length; i++) {
          //       DayModel dayModel = model.list![i];
          //       if (dayModel.dayNum > firstModel.dayNum){
          //         dayModel.isSelect = true;
          //         _calculateDays++;
          //       }
          //     }
          //   } else if(model.month!>firstModel.month && model.month!<month){
          //     for(int i=0; i<model.list!.length; i++) {
          //       DayModel dayModel = model.list![i];
          //       dayModel.isSelect = true;
          //       _calculateDays++;
          //     }
          //   } else if(month == model.month){
          //     for(int i=0; i<model.list!.length; i++) {
          //       DayModel dayModel = model.list![i];
          //       if(dayModel.dayNum < checkInTime){
          //         dayModel.isSelect = true;
          //         _calculateDays++;
          //       } else if (dayModel.dayNum == checkInTime) {
          //         dayModel.isSelect = true;
          //         model.lastSelectModel = dayModel;
          //         _isSelectLeaveTimeModel = dayModel;
          //         _isSelectLeaveTime = true;
          //         _selectLeaveTime = '$year-$month-$checkInTime';
          //       }
          //     }
          //   }
          // }
          // _checkInDays = _calculateDays;

          for (int i = 0; i < _list.length; i++) {
            CalendarItemViewModel model = _list[i];
            if (model.month! == month) {
              for (int i = 0; i < model.list!.length; i++) {
                DayModel dayModel = model.list![i];
                if (dayModel.dayNum == checkInTime && dayModel.year == year) {
                  dayModel.isSelect = true;
                  model.lastSelectModel = dayModel;
                  _isSelectLeaveTimeModel = dayModel;
                  _isSelectLeaveTime = true;
                  _selectLeaveTime = '$year-$month-$checkInTime';
                } else if (dayModel.dayNum < checkInTime) {
                  if (dayModel.month > firstModel.month) {
                    dayModel.isSelect = true;
                    _calculateDays++;
                  } else {
                    if (dayModel.dayNum >= firstModel.dayNum) {
                      dayModel.isSelect = true;
                      _calculateDays++;
                    } else {
                      dayModel.isSelect = false;
                    }
                  }
                } else {
                  dayModel.isSelect = false;
                }
              }
            } else {
              for (int i = 0; i < model.list!.length; i++) {
                DayModel dayModel = model.list![i];
                if (dayModel.month >= firstModel.month &&
                    dayModel.month < month) {
                  if (dayModel.dayNum > firstModel.dayNum) {
                    dayModel.isSelect = true;
                    _calculateDays++;
                  }
                }
              }
            }
          }
          _checkInDays = _calculateDays;
        }
      }
    } else if (firstModel == null && lastModel == null) {
      for (int i = 0; i < _list.length; i++) {
        CalendarItemViewModel model = _list[i];
        model.firstSelectModel = null;
        model.lastSelectModel = null;
        firstModel = null;
        lastModel = null;
        if (model.year == year) {
          if (model.month! == month) {
            for (int i = 0; i < model.list!.length; i++) {
              DayModel dayModel = model.list![i];
              if (dayModel.dayNum == checkInTime) {
                dayModel.isSelect = true;
                model.firstSelectModel = dayModel;
                _isSelectCheckInTime = true;
                _selectCheckInTimeModel = dayModel;
                _isSelectLeaveTime = false;
                _selectCheckInTime = '$year-$month-$checkInTime';
              }
            }
          }
        }
        // for(int i=0; i<model.list!.length; i++) {
        //   DayModel dayModel = model.list![i];
        //   dayModel.isSelect = false;
        //   if(_comparerTime(dayModel, year, month, checkInTime) == Location.mid){
        //     dayModel.isSelect = true;
        //     model.firstSelectModel = dayModel;
        //     _isSelectCheckInTime = true;
        //     _selectCheckInTimeModel = dayModel;
        //     _isSelectLeaveTime = false;
        //     _selectCheckInTime = '$year-$month-$checkInTime';
        //   }
        // }
      }
    }
  }

  /// 点击日期的回调事件
  _updateCheckInLeaveTime(int year, int month, int checkInTime) {
    // 更新数据源
    _updateDataSource(year, month, checkInTime);
    // 刷新UI
    setState(() {});
  }

  /// 底部确定按钮的点击事件
  _sureButtonTap() {
    if (!_isSelectCheckInTime) {
      EasyLoading.showToast('请选择开始时间');
      return;
    } else if (!_isSelectLeaveTime) {
      EasyLoading.showToast('请选择结束时间');
      return;
    }
    debugPrint(
        '${_selectCheckInTimeModel.year},${_selectCheckInTimeModel.month},${_selectCheckInTimeModel.dayNum}');
    debugPrint(
        '${_isSelectLeaveTimeModel.year},${_isSelectLeaveTimeModel.month},${_isSelectLeaveTimeModel.dayNum}');
    debugPrint(
        '入住日期：$_selectCheckInTime, 离开时间：$_selectLeaveTime, 共$_checkInDays晚');
    // 把日期回调给外部
    widget.selectDateOnTap!(_selectCheckInTimeModel, _isSelectLeaveTimeModel);
  }
}
