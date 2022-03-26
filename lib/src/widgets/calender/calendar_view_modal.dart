import 'package:app_assembly/app_assembly.dart';

class YearMonthModel {
  int year;
  int month;

  YearMonthModel(this.year, this.month);
}

class DayModel {
  int year;
  int month;
  int dayNum; // 数字类型的几号
  String day; // 字符类型的几号
  bool isSelect; // 是否选中
  bool isOverdue; // 是否过期
  DayModel(this.year, this.month, this.dayNum, this.day, this.isSelect,
      this.isOverdue);
}

class CalendarItemViewModel {
  final List<DayModel>? list;
  final int? year;
  final int? month;
  DayModel? firstSelectModel;
  DayModel? lastSelectModel;

  CalendarItemViewModel(
      {this.list,
      this.year,
      this.month,
      this.firstSelectModel,
      this.lastSelectModel});
}

class CalendarViewModel {
  List<CalendarItemViewModel> getItemList(
      DayModel? startModel, DayModel? endModel,
      {bool hasInitTime = false}) {
    List<YearMonthModel> yearMonthList =
        CalendarViewModel.getYearMonthList(startModel, endModel, hasInitTime);
    List<CalendarItemViewModel> _list = [];
    for (var model in yearMonthList) {
      List<DayModel> dayModelList = getDayModelList(model.year, model.month,
          startModel: startModel, endModel: endModel);
      _list.add(CalendarItemViewModel(
        list: dayModelList,
        year: model.year,
        month: model.month,
      ));
    }
    return _list;
  }

  static List<DayModel> getDayModelList(int year, int month,
      {DayModel? startModel, DayModel? endModel}) {
    List<DayModel> _listModel = [];
    if (startModel != null && endModel != null) {
      // 当前月的天数
      int _days = DateUtil.getDaysInMonth(year, month);

      String _day = '';
      bool _isSelect = false;
      bool isOverdue = false;
      int _dayNum = 0;
      for (int i = 1; i <= _days; i++) {
        _dayNum = i;
        if (month == startModel.month) {
          if (i < startModel.dayNum) {
            isOverdue = true;
            _day = '$i';
            _isSelect = false;
          } else if (i == startModel.dayNum) {
            if (month == endModel.month) {
              isOverdue = false;
              _day = '$i';
              _isSelect = true;
            } else {
              isOverdue = false;
              _day = '$i';
              _isSelect = true;
            }
          } else if (i > endModel.dayNum && month == endModel.month) {
            isOverdue = true;
            _day = '$i';
          } else {
            isOverdue = false;
            _day = '$i';
            _isSelect = true;
          }
        } else {
          if (month < endModel.month) {
            isOverdue = false;
            _day = '$i';
            _isSelect = true;
          } else {
            if (i > endModel.dayNum) {
              isOverdue = true;
              _day = '$i';
            } else {
              isOverdue = false;
              _day = '$i';
              _isSelect = true;
            }
          }
        }
        DayModel dayModel =
            DayModel(year, month, _dayNum, _day, _isSelect, isOverdue);
        _listModel.add(dayModel);
      }
    } else {
      // 今天几号
      int _currentYear = DateTime.now().year;
      // 今天几号
      int _currentDay = DateTime.now().day;
      // 今天在几月
      int _currentMonth = DateTime.now().month;
      // 当前月的天数
      int _days = DateUtil.getDaysInMonth(year, month);

      String _day = '';
      bool _isSelect = false;
      bool isOverdue = false;
      int _dayNum = 0;
      for (int i = 1; i <= _days; i++) {
        _dayNum = i;
        if (_currentYear == year) {
          if (_currentMonth == month) {
            //在当前月
            if (i < _currentDay) {
              isOverdue = true;
              _day = '$i';
            } else if (i == _currentDay) {
              _day = '$i';
              isOverdue = false;
            } else {
              _day = '$i';
              isOverdue = false;
            }
          } else {
            _day = '$i';
            isOverdue = false;
          }
        } else {
          _day = '$i';
          isOverdue = false;
        }

        DayModel dayModel =
            DayModel(year, month, _dayNum, _day, _isSelect, isOverdue);
        _listModel.add(dayModel);
      }
    }
    return _listModel;
  }

  /*
  * 根据当前年月份计算 下面6个月的年月
  * */
  static List<YearMonthModel> getYearMonthList(
      DayModel? startModel, DayModel? endModel, bool hasInitTime) {
    int _month = DateTime.now().month;
    int _year = DateTime.now().year;

    List<YearMonthModel> _yearMonthList = <YearMonthModel>[];
    if (hasInitTime) {
      var total = 0;
      _year = startModel!.year;
      if (endModel!.year > startModel.year) {
        total = (endModel.month + 13) - startModel.month;
      } else if (endModel.year == startModel.year) {
        if (startModel.month == endModel.month) {
          total = 1;
        } else {
          total = endModel.month - startModel.month + 1;
        }
      }
      _month = startModel.month;
      for (int i = 0; i < total; i++) {
        YearMonthModel model = YearMonthModel(_year, _month);
        _yearMonthList.add(model);
        if (_month == 12) {
          _month = 1;
          _year++;
        } else {
          _month++;
        }
      }
    } else {
      for (int i = 0; i < 13; i++) {
        YearMonthModel model = YearMonthModel(_year, _month);
        _yearMonthList.add(model);
        if (_month == 12) {
          _month = 1;
          _year++;
        } else {
          _month++;
        }
      }
    }
    return _yearMonthList;
  }
}
