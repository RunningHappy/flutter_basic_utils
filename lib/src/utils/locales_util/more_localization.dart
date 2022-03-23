import 'package:flutter/cupertino.dart';

class MoreLocalization implements CupertinoLocalizations {
  final Locale locale;

  MoreLocalization(this.locale);

  /// 基于Map，根据当前语言的 languageCode： en或zh来获取对应的文案
  static final Map<String, BaseLanguage> _localValue = {
    'en': EnLanguage(),
    'zh': ChLanguage()
  };

  /// 返回当前的内容维护类
  BaseLanguage? get currentLocalized {
    return _localValue[locale.languageCode];
  }

  ///通过 Localizations.of(context,type) 加载当前的 FZLocalizations
  static MoreLocalization? of(BuildContext context) {
    // return CupertinoLocalizations.of(context);
    /// 实现CupertinoLocalizations抽象类后，取不到对象，得换成CupertinoLocalizations.of(context);
    return Localizations.of(context, MoreLocalization);
  }

  @override
  String get selectAllButtonLabel {
    return currentLocalized!.selectAllButtonLabel;
  }

  @override
  String get pasteButtonLabel {
    return currentLocalized!.pasteButtonLabel;
  }

  @override
  String get copyButtonLabel {
    return currentLocalized!.copyButtonLabel;
  }

  @override
  String get cutButtonLabel {
    return currentLocalized!.cutButtonLabel;
  }

  @override
  // TODO: implement alertDialogLabel
  String get alertDialogLabel => throw UnimplementedError();

  @override
  // TODO: implement anteMeridiemAbbreviation
  String get anteMeridiemAbbreviation => throw UnimplementedError();

  @override
  // TODO: implement datePickerDateOrder
  DatePickerDateOrder get datePickerDateOrder => throw UnimplementedError();

  @override
  // TODO: implement datePickerDateTimeOrder
  DatePickerDateTimeOrder get datePickerDateTimeOrder =>
      throw UnimplementedError();

  @override
  String datePickerDayOfMonth(int dayIndex) {
    // TODO: implement datePickerDayOfMonth
    throw UnimplementedError();
  }

  @override
  String datePickerHour(int hour) {
    // TODO: implement datePickerHour
    throw UnimplementedError();
  }

  @override
  String datePickerHourSemanticsLabel(int hour) {
    // TODO: implement datePickerHourSemanticsLabel
    throw UnimplementedError();
  }

  @override
  String datePickerMediumDate(DateTime date) {
    // TODO: implement datePickerMediumDate
    throw UnimplementedError();
  }

  @override
  String datePickerMinute(int minute) {
    // TODO: implement datePickerMinute
    throw UnimplementedError();
  }

  @override
  String datePickerMinuteSemanticsLabel(int minute) {
    // TODO: implement datePickerMinuteSemanticsLabel
    throw UnimplementedError();
  }

  @override
  String datePickerMonth(int monthIndex) {
    // TODO: implement datePickerMonth
    throw UnimplementedError();
  }

  @override
  String datePickerYear(int yearIndex) {
    // TODO: implement datePickerYear
    throw UnimplementedError();
  }

  @override
  // TODO: implement modalBarrierDismissLabel
  String get modalBarrierDismissLabel => throw UnimplementedError();

  @override
  // TODO: implement postMeridiemAbbreviation
  String get postMeridiemAbbreviation => throw UnimplementedError();

  @override
  String tabSemanticsLabel({int? tabIndex, int? tabCount}) {
    // TODO: implement tabSemanticsLabel
    throw UnimplementedError();
  }

  @override
  String timerPickerHour(int hour) {
    // TODO: implement timerPickerHour
    throw UnimplementedError();
  }

  @override
  String timerPickerHourLabel(int hour) {
    // TODO: implement timerPickerHourLabel
    throw UnimplementedError();
  }

  @override
  String timerPickerMinute(int minute) {
    // TODO: implement timerPickerMinute
    throw UnimplementedError();
  }

  @override
  String timerPickerMinuteLabel(int minute) {
    // TODO: implement timerPickerMinuteLabel
    throw UnimplementedError();
  }

  @override
  String timerPickerSecond(int second) {
    // TODO: implement timerPickerSecond
    throw UnimplementedError();
  }

  @override
  String timerPickerSecondLabel(int second) {
    // TODO: implement timerPickerSecondLabel
    throw UnimplementedError();
  }

  @override
  // TODO: implement todayLabel
  String get todayLabel => throw UnimplementedError();

  @override
  // TODO: implement searchTextFieldPlaceholderLabel
  String get searchTextFieldPlaceholderLabel => throw UnimplementedError();

  @override
  // TODO: implement timerPickerHourLabels
  List<String> get timerPickerHourLabels => throw UnimplementedError();

  @override
  // TODO: implement timerPickerMinuteLabels
  List<String> get timerPickerMinuteLabels => throw UnimplementedError();

  @override
  // TODO: implement timerPickerSecondLabels
  List<String> get timerPickerSecondLabels => throw UnimplementedError();
}

/// 这个抽象类和它的实现类可以拉出去新建类
/// 中文和英语 语言内容维护
abstract class BaseLanguage {
  late String name;
  late String selectAllButtonLabel;
  late String pasteButtonLabel;
  late String copyButtonLabel;
  late String cutButtonLabel;
}

class EnLanguage implements BaseLanguage {
  @override
  String name = "This is English";
  @override
  String selectAllButtonLabel = "自定义 全选 英语";
  @override
  String pasteButtonLabel = "自定义 粘贴 英语";
  @override
  String copyButtonLabel = "自定义 复制 英语";
  @override
  String cutButtonLabel = "自定义 剪切 英语";
}

class ChLanguage implements BaseLanguage {
  @override
  String name = "这是中文";
  @override
  String selectAllButtonLabel = "自定义 全选 中文";
  @override
  String pasteButtonLabel = "自定义 粘贴 中文";
  @override
  String copyButtonLabel = "自定义 复制 中文";
  @override
  String cutButtonLabel = "自定义 剪切 中文";
}
